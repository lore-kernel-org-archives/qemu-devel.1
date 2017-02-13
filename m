Received: from eggs.gnu.org ([2001:4830:134:3::10]:42604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cd7Ux-0004Nf-4N
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 22:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cd7Uv-0006vl-Fd
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 22:40:19 -0500
Message-ID: <1486957204.2288.3.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 13 Feb 2017 14:40:04 +1100
In-Reply-To: <20170213021710.GP25381@umbus>
References: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
	<1486704360-27361-6-git-send-email-sjitindarsingh@gmail.com>
	<20170213021710.GP25381@umbus>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 05/10] target/ppc: Add
 patb_entry to sPAPRMachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com

On Mon, 2017-02-13 at 13:17 +1100, David Gibson wrote:
> On Fri, Feb 10, 2017 at 04:25:55PM +1100, Suraj Jitindar Singh wrote:
> > 
> > ISA v3.00 adds the idea of a partition table which is used to store
> > the
> > address translation details for all partitions on the system. The
> > partition
> > table consists of double word entries indexed by partition id where
> > the second
> > double word contains the location of the process table in guest
> > memory. The
> > process table is registered by the guest via a h-call.
> > 
> > We need somewhere to store the address of the process table so we
> > add an entry
> > to the sPAPRMachineState struct called patb_entry to represent the
> > second
> > doubleword of a single partition table entry corresponding to the
> > current
> > guest. We need to store this value so we know if the guest is using
> > radix or
> > hash translation and the location of the corresponding process
> > table in guest
> > memory. Since we only have a single guest per qemu instance, we
> > only need one
> > entry.
> > 
> > Since the partition table is technically a hypervisor resource we
> > require that
> > access to it is abstracted by the virtual hypervisor through the
> > calls
> > [set/get]_patbe(). Currently the value of the entry is never set
> > (and thus
> > defaults to 0 indicating hash), but it will be required to both
> > implement
> > POWER9 kvm support and tcg radix support.
> > 
> > We also add this field to be migrated as part of the
> > sPAPRMachineState as we
> > will need it on the receiving side as the guest will never tell us
> > this
> > information again and we need it to perform translation.
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  hw/ppc/spapr.c         | 19 +++++++++++++++++++
> >  include/hw/ppc/spapr.h |  1 +
> >  target/ppc/cpu.h       |  2 ++
> >  3 files changed, 22 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index e465d7a..057adae 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1018,6 +1018,20 @@ static void
> > emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
> >      }
> >  }
> >  
> > +static void spapr_set_patbe(PPCVirtualHypervisor *vhyp, uint64_t
> > val)
> > +{
> > +    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> > +
> > +    spapr->patb_entry = val;
> > +}
> > +
> > +static uint64_t spapr_get_patbe(PPCVirtualHypervisor *vhyp)
> > +{
> > +    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> So, it'll amount to the same thing of course, but using
> SPAPR_MACHINE(vhyp) here is a little more logically correct.
Ok, will fix that up
> 
> > 
> > +
> > +    return spapr->patb_entry;
> > +}
> > +
> >  #define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i)
> > * 2))
> >  #define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) &
> > HPTE64_V_VALID)
> >  #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) &
> > HPTE64_V_HPTE_DIRTY)
> > @@ -1141,6 +1155,8 @@ static void ppc_spapr_reset(void)
> >      /* Check for unknown sysbus devices */
> >      foreach_dynamic_sysbus_device(find_unknown_sysbus_device,
> > NULL);
> >  
> > +    spapr->patb_entry = 0;
> I'm assuming that the patb_entry has some control bits making this
> distinguishable from a process table at GPA 0?
Yeah, so process table size is also contained here which must be >= 24,
so this is technically an invalid entry, which is what we want for a
default value.
> 
> > 
> >      /* Allocate and/or reset the hash page table */
> >      spapr_reallocate_hpt(spapr,
> >                           spapr_hpt_shift_for_ramsize(machine-
> > >maxram_size),
> > @@ -1340,6 +1356,7 @@ static const VMStateDescription vmstate_spapr
> > = {
> >          VMSTATE_UINT64_TEST(rtc_offset, sPAPRMachineState,
> > version_before_3),
> >  
> >          VMSTATE_PPC_TIMEBASE_V(tb, sPAPRMachineState, 2),
> > +        VMSTATE_UINT64(patb_entry, sPAPRMachineState),
> Ah.. yeah, you can't just add things to the VMStateDescription,
> because that'll break parsing of existing migration streams.  You
> could bump the version, but that breaks backwards migration.
> 
> So, the usual approach here is to add a new optional subsection - see
> vmstate_spapr_ov5_cas for an example.  In this case you could have
> the
> .needed function return true only if pathb_entry != 0 - so it won't
> be
> transmitted for either POWER7/8 or for POWER9 in legacy mode, which
> seems to make sense.
Sounds like a good way of doing it which will behave how we want. I'll
do it like you suggest.
> 
> > 
> >          VMSTATE_END_OF_LIST()
> >      },
> >      .subsections = (const VMStateDescription*[]) {
> > @@ -2733,6 +2750,8 @@ static void
> > spapr_machine_class_init(ObjectClass *oc, void *data)
> >      nc->nmi_monitor_handler = spapr_nmi;
> >      smc->phb_placement = spapr_phb_placement;
> >      vhc->hypercall = emulate_spapr_hypercall;
> > +    vhc->set_patbe = spapr_set_patbe;
> > +    vhc->get_patbe = spapr_get_patbe;
> >  }
> >  
> >  static const TypeInfo spapr_machine_info = {
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index a2d8964..c6a929a 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -63,6 +63,7 @@ struct sPAPRMachineState {
> >  
> >      void *htab;
> >      uint32_t htab_shift;
> > +    uint64_t patb_entry; /* Process tbl registed in
> > H_REGISTER_PROCESS_TABLE */
> >      hwaddr rma_size;
> >      int vrma_adjust;
> >      ssize_t rtas_size;
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 425e79d..a148729 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1218,6 +1218,8 @@ struct PPCVirtualHypervisor {
> >  struct PPCVirtualHypervisorClass {
> >      InterfaceClass parent;
> >      void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU
> > *cpu);
> > +    void (*set_patbe)(PPCVirtualHypervisor *vhyp, uint64_t val);
> So.. I don't actually see any situation that would require set_patbe.
> We need get_patbe for the CPU code to get the process table addr from
> the machine.  But the hypercall to set it is already in the machine,
> so we don't need to go the other way.
Good point, I wasn't thinking. I'll remove this.
> 
> > 
> > +    uint64_t (*get_patbe)(PPCVirtualHypervisor *vhyp);
> >  };
> >  
> >  #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
