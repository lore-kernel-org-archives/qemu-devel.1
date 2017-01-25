Received: from eggs.gnu.org ([2001:4830:134:3::10]:33820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWM5V-00030f-OG
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWM5Q-0003QC-SA
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:50:05 -0500
Received: from mail.ispras.ru ([83.149.199.45]:42264)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWM5Q-0003Q2-Ka
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:50:00 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
	<20170124071719.4572.92155.stgit@PASHA-ISP>
	<db455af4-4d66-d81f-4f4f-1ad47100dffe@redhat.com>
In-Reply-To: <db455af4-4d66-d81f-4f4f-1ad47100dffe@redhat.com>
Date: Wed, 25 Jan 2017 14:50:02 +0300
Message-ID: <000701d27701$2a0aa8e0$7e1ffaa0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v7 04/14] icount: exit cpu loop on expire
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 24/01/2017 08:17, Pavel Dovgalyuk wrote:
> > This patch adds check to break cpu loop when icount expires without
> > setting the TB_EXIT_ICOUNT_EXPIRED flag. It happens when there is no
> > available translated blocks and all instructions were executed.
> > In icount replay mode unnecessary tb_find will be called (which may
> > cause an exception) and execution will be non-deterministic.
> >
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > ---
> >  cpu-exec.c |   15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/cpu-exec.c b/cpu-exec.c
> > index 79a2167..e603da4 100644
> > --- a/cpu-exec.c
> > +++ b/cpu-exec.c
> > @@ -582,9 +582,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
> >                  cpu_exec_nocache(cpu, insns_left, *last_tb, false);
> >                  align_clocks(sc, cpu);
> >              }
> > -            cpu->exception_index = EXCP_INTERRUPT;
> > -            *last_tb = NULL;
> > -            cpu_loop_exit(cpu);
> >          }
> >          break;
> >  #endif
> > @@ -638,6 +635,18 @@ int cpu_exec(CPUState *cpu)
> >
> >              for(;;) {
> >                  cpu_handle_interrupt(cpu, &last_tb);
> > +                /* icount has expired, we need to break the execution loop.
> > +                   This check is needed before tb_find to make execution
> > +                   deterministic - tb_find may cause an exception
> > +                   while translating the code from non-mapped page. */
> > +                if (use_icount && ((cpu->icount_extra == 0
> > +                                    && cpu->icount_decr.u16.low == 0)
> > +                                || (int32_t)cpu->icount_decr.u32 < 0)) {
> > +                    if (cpu->exception_index == -1) {
> > +                        cpu->exception_index = EXCP_INTERRUPT;
> > +                    }
> > +                    cpu_loop_exit(cpu);
> > +                }
> 
> Can this can be placed in cpu_handle_interrupt itself?  

I guess it could. I placed it here because it doesn't related to interrupts.

> Also, can the cpu->exception_index != -1 case happen?

This branch is executed where there are no instructions to replay.
It may happen due to an exception (which is already set) or because
execution loop has to break. In the first case exception_index != -1.

> We really should add assertions on cpu->exception_index, maybe after
> cpu_handle_exception and cc->cpu_exec_interrupt returns true.  Without
> some idea of the invariants, I'm not competent enough to review this patch.

Pavel Dovgalyuk
