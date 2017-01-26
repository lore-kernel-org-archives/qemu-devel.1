Received: from eggs.gnu.org ([2001:4830:134:3::10]:35268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWkFC-0000Zt-JZ
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWkF7-0002A9-N0
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:37:42 -0500
Received: from mail.ispras.ru ([83.149.199.45]:49142)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWkF7-00029F-Bi
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:37:37 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
	<20170126123423.5412.2388.stgit@PASHA-ISP>
	<06b49612-9faf-5933-d8e9-8645a2fcde4d@redhat.com>
In-Reply-To: <06b49612-9faf-5933-d8e9-8645a2fcde4d@redhat.com>
Date: Thu, 26 Jan 2017 16:37:40 +0300
Message-ID: <000e01d277d9$5d80dae0$188290a0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v8 2/9] icount: exit cpu loop on expire
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, kraxel@redhat.com

> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
> On 26/01/2017 13:34, Pavel Dovgalyuk wrote:
> > This patch adds check to break cpu loop when icount expires without
> > setting the TB_EXIT_ICOUNT_EXPIRED flag. It happens when there is no
> > available translated blocks and all instructions were executed.
> > In icount replay mode unnecessary tb_find will be called (which may
> > cause an exception) and execution will be non-deterministic.
> >
> > v8: refactored loop exit code and moved it to separate function
> >
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > ---
> >  cpu-exec.c |   24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/cpu-exec.c b/cpu-exec.c
> > index fa08c73..f9b8ec8 100644
> > --- a/cpu-exec.c
> > +++ b/cpu-exec.c
> > @@ -523,9 +523,25 @@ static inline void cpu_handle_interrupt(CPUState *cpu,
> >              *last_tb = NULL;
> >          }
> >      }
> > -    if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
> > +}
> > +
> > +
> > +static void cpu_check_loop_exit(CPUState *cpu)
> > +{
> > +    if (unlikely(atomic_read(&cpu->exit_request)
> > +        /* icount has expired, we need to break the execution loop.
> > +           This check is needed before tb_find to make execution
> > +           deterministic - tb_find may cause an exception
> > +           while translating the code from non-mapped page. */
> > +        || (use_icount && ((cpu->icount_extra == 0
> > +                        && cpu->icount_decr.u16.low == 0)
> > +                    || (int32_t)cpu->icount_decr.u32 < 0)))) {
> 
> Simpler:
> 
> 	use_icount &&
> 	((int32_t)cpu->icount_decr.u32 < 0 ||
> 	 cpu->icount_decr.low + cpu->icount_extra == 0)

Right.

> But I'm not sure that you need to test u32.  After all you're not

Checking u32 is needed, because sometimes it is less than zero.
Consider the code in cpu_loop_exec_tb:
        int insns_left = cpu->icount_decr.u32;
            if (insns_left > 0) {
It is set to negative in tcg_handle_interrupt.
Ten days ago you also offered setting high bits of u32 in gen_icount:

+    /* Make the next TB exit immediately with TB_EXIT_ICOUNT_EXPIRED.  */
+    tcg_gen_st16_i32(-1, cpu_env,
+                     -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.high));



> testing tcg_exit_req, which is the equivalent when icount is disabled.

Yes, if we want to refactor the whole loop.

> >          atomic_set(&cpu->exit_request, 0);
> > -        cpu->exception_index = EXCP_INTERRUPT;
> > +        /* If there is an exception that wasn't replayed yet,
> > +           don't change exception_index. */
> > +        if (cpu->exception_index == -1) {
> > +            cpu->exception_index = EXCP_INTERRUPT;
> > +        }
> >          cpu_loop_exit(cpu);
> 
> The siglongjmp is effectively the same as exiting the for(;;) loop of
> cpu_exec and going back to cpu_handle_exception.  So I would just merge
> this with cpu_handle_interrupt, which exits a lot with cpu_loop_exit too.

Do you want me to create new version of the patch, which changes the loop this way?

> All cpu_loop_exit() calls in cpu_handle_interrupt become "return true",
> similar to cpu_handle_exception, and then in cpu_exec you have:
> 
>             /* if an exception is pending, we execute it here */
>             while (!cpu_handle_exception(cpu, &ret)) {
>                 /* if an interrupt is pending, inject it and go back
>                  * to cpu_handle_exception.
>                  */
>                 while (!cpu_handle_interrupt(cpu, &last_tb)) {
>                     tb = tb_find(cpu, last_tb, tb_exit);
>                     cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
>                     /* Try to align the host and virtual clocks
>                        if the guest is in advance */
>                     align_clocks(&sc, cpu);
>                 }
>             }
>             break;

It might even work faster without excessive cpu_loop_exit calls.

Pavel Dovgalyuk
