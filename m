Received: from eggs.gnu.org ([2001:4830:134:3::10]:45302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1dfJDd-0003Qe-MK
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1dfJDY-0001eV-Mk
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:07:45 -0400
Date: Wed, 9 Aug 2017 15:07:19 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20170809150719.3d0a9cae@roar.ozlabs.ibm.com>
In-Reply-To: <20170809040546.GF13670@umbus.fritz.box>
References: <20170808175936.28793-1-npiggin@gmail.com>
	<20170809040546.GF13670@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ppc/spapr: fix unicast H_SIGNAL_SYS_RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Wed, 9 Aug 2017 14:05:46 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Aug 09, 2017 at 03:59:36AM +1000, Nicholas Piggin wrote:
> > Unicast H_SIGNAL_SYS_RESET does not find the target CPU if it
> > is not the current CPU.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > 
> > Unfortunately this slipped through without my noticing because the
> > Linux driver for NMI IPIs has a fallback to using regular IPIs, and
> > because Linux did not make much use of unicasts. A new watchdog
> > has started using them. After this patch, this function works
> > properly:  
> 
> In fact this bug was already fixed in the for-2.11 branch.  If you've
> hit this for real, I guess it's more important than I realized, so
> I'll pull it into 2.10 instead.

Oh sorry I didn't notice the 2.11 branch fix. Yes please pull it
into 2.10 if possible.

Thanks,
Nick

> 
> > 
> > Watchdog CPU:0 detected Hard LOCKUP other CPUS:3
> > *** Unicast NMI IPI is sent here ***
> > Watchdog CPU:3 Hard LOCKUP
> > Modules linked in:
> > CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc3-00305-ge84cf82ae73a-dirty #1191
> > task: c00000001e440000 task.stack: c00000001e480000
> > NIP: c000000000023800 LR: c00000000000da28 CTR: c000000000626db0
> > REGS: c00000001ff97d80 TRAP: 0100   Not tainted  (4.13.0-rc3-00305-ge84cf82ae73a-dirty)
> > MSR: 8000000002001033 <SF,VEC,ME,IR,DR,RI,LE>
> >   CR: 48000224  XER: 20000000
> > CFAR: c00000000002380c SOFTE: 0 
> > GPR00: c00000000000d9cc c00000001e483dc0 c000000000ebd900 000000000007d000 
> > GPR04: f000000000078680 c00000001e1a0048 c00000001e1a0048 0000000000000001 
> > GPR08: 0000000000000000 0000000000075036 00000003d5f633c2 0000000000000020 
> > GPR12: 0000000000000000 c00000000fd80f00 c00000000000d988 0000000000000000 
> > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> > GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> > GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000b60 
> > NIP [c000000000023800] udelay+0x40/0x60
> > LR [c00000000000da28] kernel_init+0xa8/0x1b0
> > Call Trace:
> > [c00000001e483dc0] [c00000000000d9cc] kernel_init+0x4c/0x1b0 (unreliable)
> > [c00000001e483e30] [c00000000000bb1c] ret_from_kernel_thread+0x5c/0xc0
> > Instruction dump:
> > 7c6349d2 7c210b78 7d4c42a6 7d2c42a6 7d2a4850 7fa34840 409d0028 48000014 
> > 60000000 60000000 60000000 60420000 <7d2c42a6> 7d2a4850 7fa34840 419dfff4 
> > 
> >  hw/ppc/spapr_hcall.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 72ea5a8247..f50e979b43 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1432,7 +1432,9 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
> >      } else {
> >          /* Unicast */
> >          CPU_FOREACH(cs) {
> > -            if (cpu->cpu_dt_id == target) {
> > +            PowerPCCPU *c = POWERPC_CPU(cs);
> > +
> > +            if (c->cpu_dt_id == target) {
> >                  run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
> >                  return H_SUCCESS;
> >              }  
> 
