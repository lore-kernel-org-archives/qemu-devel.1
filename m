Received: from eggs.gnu.org ([2001:4830:134:3::10]:56595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ciweE-0005tY-BK
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 00:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ciweC-0003oQ-Ul
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 00:17:58 -0500
Message-ID: <1488345463.20743.1.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 01 Mar 2017 16:17:43 +1100
In-Reply-To: <20170228031912.GP17615@umbus.fritz.box>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
	<034945c1bbc8d4a97e5f568d4d463af2c9a24080.1487829585.git.sam.bobroff@au1.ibm.com>
	<20170228002810.GD17615@umbus.fritz.box>
	<1488248717.2323.11.camel@gmail.com>
	<20170228031912.GP17615@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 08/12] spapr: Only setup HTP if
 necessary.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 2017-02-28 at 14:19 +1100, David Gibson wrote:
> On Tue, Feb 28, 2017 at 01:25:17PM +1100, Suraj Jitindar Singh wrote:
> > 
> > On Tue, 2017-02-28 at 11:28 +1100, David Gibson wrote:
> > > 
> > > s/HTP/HPT/ in subject line.
> > > 
> > > 
> > > On Thu, Feb 23, 2017 at 05:00:01PM +1100, Sam Bobroff wrote:
> > > > 
> > > > 
> > > > If QEMU is using KVM, and KVM is capable of running in radix
> > > > mode,
> > > > guests can be run in real-mode without allocating a HPT
> > > > (because
> > > > KVM
> > > > will use a minimal RPT). So in this case, we avoid creating the
> > > > HPT
> > > > at reset time and later (during CAS) create it if it is
> > > > necessary.
> > > > 
> > > > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > > So, IIRC, we discussed previously that the logical way to do
> > > things
> > > was to, by default, delay HPT allocation until CAS time, and just
> > > do
> > > it at reset time for the case that needs it: hash host with KVM.
> > > 
> > > Did you hit a problem with that approach, or is there still work
> > > to
> > > be
> > > done here?
> > So what we're doing is assuming radix. Allocate hpt if hash host,
> > otherwise delay til CAS time and allocate only if guest chose hash.
> > 
> > > 
> > > 
> > > > 
> > > > 
> > > > ---
> > > > v2:
> > > > 
> > > > * This patch has been mostly rewritten to move the late HPT
> > > > allocation to CAS.
> > > > This allows a guest to start in radix mode (when it's in real
> > > > mode)
> > > > and then
> > > > change to hash, even if it is a legacy guest and will not call
> > > > h_register_process_table().
> > > > * Added an exported function to spapr.c to perform HPT
> > > > allocation
> > > > and adjust
> > > > the vrma if necessary. This makes it possible to allocate the
> > > > HPT
> > > > from
> > > > h_client_architecture_support() in spapr_hcall.c.
> > > > 
> > > >  hw/ppc/spapr.c         | 24 +++++++++++++++---------
> > > >  hw/ppc/spapr_hcall.c   | 10 ++++++++++
> > > >  include/hw/ppc/spapr.h |  1 +
> > > >  3 files changed, 26 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index ca3812555f..dfee0f685f 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -1123,6 +1123,17 @@ static void
> > > > spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
> > > >      }
> > > >  }
> > > >  
> > > > +void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
> > > > +{
> > > > +    spapr_reallocate_hpt(spapr,
> > > > +                     spapr_hpt_shift_for_ramsize(MACHINE(qdev_
> > > > get_
> > > > machine())->maxram_size),
> > > > +                     &error_fatal);
> > > > +    if (spapr->vrma_adjust) {
> > > > +        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(),
> > > > +                                          spapr->htab_shift);
> > > > +    }
> > > > +}
> > > > +
> > > >  static void find_unknown_sysbus_device(SysBusDevice *sbdev,
> > > > void
> > > > *opaque)
> > > >  {
> > > >      bool matched = false;
> > > > @@ -1151,15 +1162,10 @@ static void ppc_spapr_reset(void)
> > > >      /* Check for unknown sysbus devices */
> > > >      foreach_dynamic_sysbus_device(find_unknown_sysbus_device,
> > > > NULL);
> > > >  
> > > > -    /* Allocate and/or reset the hash page table */
> > > > -    spapr_reallocate_hpt(spapr,
> > > > -                         spapr_hpt_shift_for_ramsize(machine-
> > > > > 
> > > > > maxram_size),
> > > > -                         &error_fatal);
> > > > -
> > > > -    /* Update the RMA size if necessary */
> > > > -    if (spapr->vrma_adjust) {
> > > > -        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(),
> > > > -                                          spapr->htab_shift);
> > > > +    /* If using KVM with radix mode available, VCPUs can be
> > > > started
> > > > +     * without a HPT because KVM will start them in radix
> > > > mode. */
> > > > +    if (!(kvm_enabled() && kvmppc_has_cap_mmu_radix())) {
> > > > +        spapr_setup_hpt_and_vrma(spapr);
> > > >      }
> > > >  
> > > >      qemu_devices_reset();
> > > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > > index 42d20e0b92..cea34073aa 100644
> > > > --- a/hw/ppc/spapr_hcall.c
> > > > +++ b/hw/ppc/spapr_hcall.c
> > > > @@ -1002,6 +1002,16 @@ static target_ulong
> > > > h_client_architecture_support(PowerPCCPU *cpu,
> > > >      ov5_updates = spapr_ovec_new();
> > > >      spapr->cas_reboot = spapr_ovec_diff(ov5_updates,
> > > >                                          ov5_cas_old, spapr-
> > > > > 
> > > > > ov5_cas);
> > > > +    if (kvm_enabled()) {
> > > > +        if (kvmppc_has_cap_mmu_radix()) {
> > > > +            /* If the HPT hasn't yet been set up (see
> > > > +             * ppc_spapr_reset()), and it's needed, do it now:
> > > > */
> > > I think it's a bit fragile to have here it explicitly mirror the
> > > logic
> > > which determines whether the HPT is allocated early.  I'd prefer
> > > to
> > > explicitly test here whether we have allocated an HPT - adding a
> > > flag,
> > > if we have to.
> > We can use the MSB of patb_entry as that flag.
> Uh.. only for POWER9..

Well on <POWER9, patb_entry will always be zero, which we're taking to
mean a hpt has been allocated.

We could always just check spapr->htab == NULL...

> 
> > 
> > patb_entry & GUEST_RADIX == GUEST_RADIX -> radix, so assume a hpt
> > hasn't been allocated.
> > 
> > When we do allocate a hpt we know we're not radix, so set
> > patb_entry &= ~GUEST_RADIX;
> > 
> > Where GUEST_RADIX is the msb in patb_entry which indicates that a
> > guest
> > is radix.
> > 
> > Essentially patb_entry & GUEST_RADIX cleared mean hash with hpt
> > allocated, patb_entry & GUEST_RADIX set means radix so assume an
> > hpt
> > hasn't been allocated. On the hpt allocation path we clear
> > GUEST_RADIX
> > in patb_entry and when we set GUEST_RADIX we free the hpt.
> > 
> > > 
> > > 
> > > > 
> > > > 
> > > > +            if (!spapr_ovec_test(ov5_updates, OV5_MMU_RADIX))
> > > > {
> > > > +                /* legacy hash or new hash: */
> > > > +                spapr_setup_hpt_and_vrma(spapr);
> > > > +            }
> > > > +        }
> > > > +    }
> > > >  
> > > >      if (!spapr->cas_reboot) {
> > > >          spapr->cas_reboot =
> > > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > > index f9b17d860a..a30cbc485c 100644
> > > > --- a/include/hw/ppc/spapr.h
> > > > +++ b/include/hw/ppc/spapr.h
> > > > @@ -590,6 +590,7 @@ void spapr_dt_events(sPAPRMachineState *sm,
> > > > void *fdt);
> > > >  int spapr_h_cas_compose_response(sPAPRMachineState *sm,
> > > >                                   target_ulong addr,
> > > > target_ulong
> > > > size,
> > > >                                   sPAPROptionVector
> > > > *ov5_updates);
> > > > +void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr);
> > > >  sPAPRTCETable *spapr_tce_new_table(DeviceState *owner,
> > > > uint32_t
> > > > liobn);
> > > >  void spapr_tce_table_enable(sPAPRTCETable *tcet,
> > > >                              uint32_t page_shift, uint64_t
> > > > bus_offset,
