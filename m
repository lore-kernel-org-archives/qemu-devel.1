Received: from eggs.gnu.org ([2001:4830:134:3::10]:40804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fdHwc-0006vW-CL
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fdHwZ-0002O0-6y
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:26:22 -0400
Received: from mail-eopbgr10127.outbound.protection.outlook.com
	([40.107.1.127]:57876
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fdHwY-0002NF-8p
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:26:19 -0400
Date: Wed, 11 Jul 2018 19:26:09 +0300
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Message-ID: <20180711192609.70582657@vp-pc>
In-Reply-To: <20180711160025.GU7451@localhost.localdomain>
References: <1531236069-7500-1-git-send-email-viktor.prutyanov@virtuozzo.com>
	<20180711160025.GU7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dump: add kernel_gs_base to QEMU CPU state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, rkagan@virtuozzo.com

On Wed, 11 Jul 2018 13:00:25 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Jul 10, 2018 at 06:21:09PM +0300, Viktor Prutyanov wrote:
> > This patch adds field with content of KERNEL_GS_BASE MSR to QEMU
> > note in ELF dump.
> > 
> > On Windows, if all vCPUs are running usermode tasks at the time the
> > dump is created, this can be helpful in the discovery of guest
> > system structures during conversion ELF dump to MEMORY.DMP dump.
> > 
> > Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
> > ---
> >  target/i386/arch_dump.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
> > index 35b55fc..a702138 100644
> > --- a/target/i386/arch_dump.c
> > +++ b/target/i386/arch_dump.c
> > @@ -237,7 +237,7 @@ int
> > x86_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> >   * please count up QEMUCPUSTATE_VERSION if you have changed
> > definition of
> >   * QEMUCPUState, and modify the tools using this information
> > accordingly.  
> 
> Where are the tools using this information, that need to be
> updated?  Won't this break existing versions of those tools?
> 
> Is the dump format and pointers to available tools documented
> somewhere?

I hope that someone from community knows about those tools because I
can't find such tools.

> 
> >   */
> > -#define QEMUCPUSTATE_VERSION (1)
> > +#define QEMUCPUSTATE_VERSION (2)
> >  
> >  struct QEMUCPUSegment {
> >      uint32_t selector;
> > @@ -258,6 +258,7 @@ struct QEMUCPUState {
> >      QEMUCPUSegment cs, ds, es, fs, gs, ss;
> >      QEMUCPUSegment ldt, tr, gdt, idt;
> >      uint64_t cr[5];
> > +    uint64_t kernel_gs_base;
> >  };
> >  
> >  typedef struct QEMUCPUState QEMUCPUState;
> > @@ -315,6 +316,8 @@ static void qemu_get_cpustate(QEMUCPUState *s,
> > CPUX86State *env) s->cr[2] = env->cr[2];
> >      s->cr[3] = env->cr[3];
> >      s->cr[4] = env->cr[4];
> > +
> > +    s->kernel_gs_base = env->kernelgsbase;
> >  }
> >  
> >  static inline int cpu_write_qemu_note(WriteCoreDumpFunction f,
> > -- 
> > 2.7.4
> >   
> 
