Received: from eggs.gnu.org ([208.118.235.92]:51899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfPND-0000lc-OS
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfPNA-0005Dm-Kv
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:18:51 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1gfPNA-0005DY-D9
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:18:48 -0500
Received: by mail-lj1-x241.google.com with SMTP id v1-v6so32462472ljd.0
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 05:18:48 -0800 (PST)
Date: Fri, 4 Jan 2019 14:18:45 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20190104131845.GQ1148@toto>
References: <20181210175630.30643-1-peter.maydell@linaro.org>
	<CAFEAcA8eFk79oTXmwMd0s8gVBQjf8XSaUptRkYJrgGgvdZJBcA@mail.gmail.com>
	<CAFEAcA8n1g4CFkOYt9+L9CmgVeE7V7BhD+K8hR0X0tQ4GJoLOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8n1g4CFkOYt9+L9CmgVeE7V7BhD+K8hR0X0tQ4GJoLOg@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC] target/microblaze: Switch to
 transaction_failed hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On Mon, Dec 10, 2018 at 06:32:49PM +0000, Peter Maydell wrote:
> On Mon, 10 Dec 2018 at 18:31, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Mon, 10 Dec 2018 at 17:57, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > Switch the microblaze target from the old unassigned_access hook
> > > to the transaction_failed hook.
> > >
> > > The notable difference is that rather than it being called
> > > for all physical memory accesses which fail (including
> > > those made by DMA devices or by the gdbstub), it is only
> > > called for those made by the CPU via its MMU. For
> > > microblaze this makes no difference because none of the
> > > target CPU code needs to make loads or stores by physical
> > > address.

Hi again,

I just noticed a small typo



> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > A straightforward conversion, but tagged RFC because I don't have
> > > any microblaze test images and have tested only with "make check".
> > >
> > >  target/microblaze/cpu.h       |  7 ++++---
> > >  target/microblaze/cpu.c       |  2 +-
> > >  target/microblaze/op_helper.c | 20 ++++++++++----------
> > >  3 files changed, 15 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> > > index 3c4e0ba80ac..03ca91007d5 100644
> > > --- a/target/microblaze/cpu.h
> > > +++ b/target/microblaze/cpu.h
> > > @@ -388,9 +388,10 @@ static inline void cpu_get_tb_cpu_state(CPUMBState *env, target_ulong *pc,
> > >  }
> > >
> > >  #if !defined(CONFIG_USER_ONLY)
> > > -void mb_cpu_unassigned_access(CPUState *cpu, hwaddr addr,
> > > -                              bool is_write, bool is_exec, int is_asi,
> > > -                              unsigned size);
> > > +void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
> > > +                               unsigned size, MMUAccessType access_type,
> > > +                               int mmu_idx, MemTxAttrs attrs,
> > > +                               MemTxResult response, uintptr_t retaddr);
> > >  #endif
> > >
> > >  #endif
> > > diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> > > index 9b546a2c18e..49876b19b38 100644
> > > --- a/target/microblaze/cpu.c
> > > +++ b/target/microblaze/cpu.c
> > > @@ -297,7 +297,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
> > >  #ifdef CONFIG_USER_ONLY
> > >      cc->handle_mmu_fault = mb_cpu_handle_mmu_fault;
> > >  #else
> > > -    cc->do_unassigned_access = mb_cpu_unassigned_access;
> > > +    cc->do_transaction_failed = mb_cpu_transaction_failed;
> > >      cc->get_phys_page_debug = mb_cpu_get_phys_page_debug;
> > >  #endif
> > >      dc->vmsd = &vmstate_mb_cpu;
> > > diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> > > index 7cdbbcccaef..d25d3b626c8 100644
> > > --- a/target/microblaze/op_helper.c
> > > +++ b/target/microblaze/op_helper.c
> > > @@ -486,18 +486,18 @@ void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
> > >      mmu_write(env, ext, rn, v);
> > >  }
> > >
> > > -void mb_cpu_unassigned_access(CPUState *cs, hwaddr addr,
> > > -                              bool is_write, bool is_exec, int is_asi,
> > > -                              unsigned size)
> > > +void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
> > > +                               unsigned size, MMUAccessType access_type,
> > > +                               int mmu_idx, MemTxAttrs attrs,
> > > +                               MemTxResult response, uintptr_t retaddr)
> > >  {
> > >      MicroBlazeCPU *cpu;
> > >      CPUMBState *env;
> > > -
> > > -    qemu_log_mask(CPU_LOG_INT, "Unassigned " TARGET_FMT_plx " wr=%d exe=%d\n",
> > > -             addr, is_write ? 1 : 0, is_exec ? 1 : 0);
> > > -    if (cs == NULL) {
> > > -        return;
> > > -    }
> > > +    qemu_log_mask(CPU_LOG_INT, "Transaction failed: vaddr 0x%" VADDR_PRIx
> > > +                  " physaddr 0x" TARGET_FMT_plx "size %d access type %s\n",
                                                       ^^^

We'd want a space before size here.

Cheers,
Edgar



> > > +                  addr, physaddr, size,
> > > +                  access_type == MMU_INST_FETCH ? "INST_FETCH" :
> > > +                  (access_type == MMU_DATA_LOAD ? "DATA_LOAD" : "DATA_STORE"));
> > >      cpu = MICROBLAZE_CPU(cs);
> > >      env = &cpu->env;
> 
> Oops. Here there should be
> 
>     cpu_restore_state(cs, retaddr, true);
> 
> > >      if (!(env->sregs[SR_MSR] & MSR_EE)) {
> > > @@ -505,7 +505,7 @@ void mb_cpu_unassigned_access(CPUState *cs, hwaddr addr,
> > >      }
> > >
> > >      env->sregs[SR_EAR] = addr;
> > > -    if (is_exec) {
> > > +    if (access_type == MMU_INST_FETCH) {
> > >          if ((env->pvr.regs[2] & PVR2_IOPB_BUS_EXC_MASK)) {
> > >              env->sregs[SR_ESR] = ESR_EC_INSN_BUS;
> > >              helper_raise_exception(env, EXCP_HW_EXCP);
> > > --
> > > 2.19.2
> 
> thanks
> -- PMM
