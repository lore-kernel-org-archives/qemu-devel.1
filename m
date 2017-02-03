Received: from eggs.gnu.org ([2001:4830:134:3::10]:48744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cZXxk-0001lc-Bb
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cZXxg-0004YI-BY
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:07:16 -0500
Received: from mail.ispras.ru ([83.149.199.45]:39138)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cZXxg-0004Xg-3i
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:07:12 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170129210910.6333-1-pbonzini@redhat.com>
	<000601d27ba1$1f009a50$5d01cef0$@ru>
	<cf88e926-78b5-7d74-a1eb-4f13b3955496@redhat.com>
In-Reply-To: <cf88e926-78b5-7d74-a1eb-4f13b3955496@redhat.com>
Date: Fri, 3 Feb 2017 10:07:12 +0300
Message-ID: <000301d27dec$2488e1b0$6d9aa510$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC/RFT PATCH 0/7] cpu-exec: simplify cpu_exec
 and remove some icount special cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: serge.fdrv@gmail.com, pavel.dovgaluk@ispras.ru, peter.maydell@linaro.org

> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
> On 31/01/2017 01:05, Pavel Dovgalyuk wrote:
> > Hi, Paolo!
> >
> > Thanks for refactoring.
> > I tested these patches with icount record/replay on i386 machine.
> > It works, but the following changes should be applied.
> > I also removed call to replay_has_interrupt, because now it is not needed here.
> > It seems, that this call is an artifact of an older record/replay revision.
> >
> > diff --git a/cpu-exec.c b/cpu-exec.c
> > index 3838eb8..5cef8bc 100644
> > --- a/cpu-exec.c
> > +++ b/cpu-exec.c
> > @@ -519,7 +519,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
> >      }
> >
> >      /* Finally, check if we need to exit to the main loop.  */
> > -    if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
> > +    if (unlikely(atomic_read(&cpu->exit_request)
> > +        || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) {
> >          atomic_set(&cpu->exit_request, 0);
> >          cpu->exception_index = EXCP_INTERRUPT;
> >          return true;
> 
> So is this needed to avoid exceptions in tb_find?  Please add a comment
> about this 

This code comes from my last patch, that was not applied.
Here is the comment:

It adds check to break cpu loop when icount expires without
setting the TB_EXIT_ICOUNT_EXPIRED flag. It happens when there is no
available translated blocks and all instructions were executed.
In icount replay mode unnecessary tb_find will be called (which may
cause an exception) and execution will be non-deterministic.

> and check if you can also replace:
> 
> 	atomic_set(&cpu->exit_request, 1);
> 
> in cpu_loop_exec_tb with
> 
> 	cpu->icount_decr.u16.low = 0;
> 
> ?
> 

This line is not needed at all, because the following code decrements
icount automatically.

        if (insns_left > 0) {
            cpu_exec_nocache(cpu, insns_left, tb, false);
        }

Pavel Dovgalyuk
