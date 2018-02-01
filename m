Received: from eggs.gnu.org ([208.118.235.92]:39136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehLF2-00007S-7K
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehLDy-0001Cc-2W
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:13:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ehLDx-0001Bx-KE
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:12:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C80A6C0223
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 20:12:44 +0000 (UTC)
Date: Thu, 1 Feb 2018 20:10:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180201201032.GR2457@work-vm>
References: <20180201112028.23552-1-peterx@redhat.com>
	<90b4bc63-94cd-ec0f-32c8-c16df8ee84cf@redhat.com>
	<20180201211652-mutt-send-email-mst@kernel.org>
	<20180201194845.GN2457@work-vm>
	<33142d67-92b6-e1b1-b906-716a06efb1fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33142d67-92b6-e1b1-b906-716a06efb1fa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pcie-root-port: let it has higher migrate
 priority
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

* Marcel Apfelbaum (marcel@redhat.com) wrote:
> On 01/02/2018 21:48, Dr. David Alan Gilbert wrote:
> > * Michael S. Tsirkin (mst@redhat.com) wrote:
> >> On Thu, Feb 01, 2018 at 02:24:15PM +0200, Marcel Apfelbaum wrote:
> >>> Hi Peter,
> >>>
> >>> On 01/02/2018 13:20, Peter Xu wrote:
> >>>> In the past, we prioritized IOMMU migration so that we have such a
> >>>> priority order:
> >>>>
> >>>>     IOMMU > PCI Devices
> >>>>
> >>>> When migrating a guest with both vIOMMU and pcie-root-port, we'll always
> >>>> migrate vIOMMU first, since pcie-root-port will be seen to have the same
> >>>> priority of general PCI devices.
> >>>>
> >>>> That's problematic.
> >>>>
> >>>> The thing is that PCI bus number information is stored in the root port,
> >>>> and that is needed by vIOMMU during post_load(), e.g., to figure out
> >>>> context entry for a device.  If we don't have correct bus numbers for
> >>>> devices, we won't be able to recover device state of the DMAR memory
> >>>> regions, and things will be messed up.
> >>>>
> >>>> So let's boost the PCIe root ports to be even with higher priority:
> >>>>
> >>>>    PCIe Root Port > IOMMU > PCI Devices
> >>>>
> >>>> A smoke test shows that this patch fixes bug 1538953.
> >>>>
> >>>> CC: Alex Williamson <alex.williamson@redhat.com>
> >>>> CC: Marcel Apfelbaum <marcel@redhat.com>
> >>>> CC: Michael S. Tsirkin <mst@redhat.com>
> >>>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >>>> CC: Juan Quintela <quintela@redhat.com>
> >>>> CC: Laurent Vivier <lvivier@redhat.com>
> >>>> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1538953
> >>>> Reported-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> >>>> Signed-off-by: Peter Xu <peterx@redhat.com>
> >>>> ---
> >>>> Marcel & all,
> >>>>
> >>>> I think it's possible that we need similar thing for other bridge-like
> >>>> devices, but I'm not that familiar.  Would you help confirm?  Thanks,
> >>>
> >>> Is a pity we don't have a way to mark the migration priority
> >>> in a base class. Dave, maybe we do have a way?
> >>>
> >>> In the meantime you would need to add it also to:
> >>> - ioh3420 (Intel root port)
> >>> - xio3130_downstream (Intel switch downstream port)
> >>> - xio3130_upstream (The counterpart of the above, you want the whole
> >>>   switch to be migrated before loading the IOMMU device state)
> >>> - pcie_pci_bridge (for pci devices)
> >>> - pci-pci bridge (if for some reason you have one attached to the pcie_pci_brdge)
> >>> - i82801b11 (dmi-pci bridge, we want to deprecate it bu is there for now)
> >>>
> >>> Thanks,
> >>> Marcel
> >>
> >> It's kind of strange that we need to set the priority manually.
> >> Can't migration figure it out itself?
> > 
> >> I think bus
> >> must always be migrated before the devices behind it ...
> > 
> > I think that's true; but:
> >   a) Is the iommu a child of any of the PCI busses?
> 
> No, is a sysbus device.

OK, so even if we were arguing about whether PCI busses got migrated in
order, that doesn't help Peter's case, because there's nothing that
orders the iommu relative to the PCI.

> >   b) does anything ensure that the bridge that's a parent of a bus
> >      gets migrated before the bus it provides?
> 
> I think this was Michael's question :)
> 
> >   c) What happens with more htan one root port?
> > 
> 
> Root ports can't be nested, anyway, I suppose the migration should
> follow the bus numbering order.
> 
> The question now is what happens if the migration is happening before
> the guest firmware finishes assigning numbers to buses...
> 
> Still, QEMU has enough information to decide the right ordering,
> the question is if the current migration mechanism has some ordering
> or the only one is the "VMStateFlags".

It's ordered on two things:
  a) The priority field that Peter is using
  b) The order of registration of the device.

(b) is of course dangerously unstable.

Dave

> Thanks,
> Marcel
> 
> > Dave
> > 
> > 
> >>>>  hw/pci-bridge/gen_pcie_root_port.c | 1 +
> >>>>  include/migration/vmstate.h        | 1 +
> >>>>  2 files changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> >>>> index 0e2f2e8bf1..e6ff1effd8 100644
> >>>> --- a/hw/pci-bridge/gen_pcie_root_port.c
> >>>> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> >>>> @@ -101,6 +101,7 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
> >>>>  
> >>>>  static const VMStateDescription vmstate_rp_dev = {
> >>>>      .name = "pcie-root-port",
> >>>> +    .priority = MIG_PRI_PCIE_ROOT_PORT,
> >>>>      .version_id = 1,
> >>>>      .minimum_version_id = 1,
> >>>>      .post_load = pcie_cap_slot_post_load,
> >>>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> >>>> index 8c3889433c..491449db9f 100644
> >>>> --- a/include/migration/vmstate.h
> >>>> +++ b/include/migration/vmstate.h
> >>>> @@ -148,6 +148,7 @@ enum VMStateFlags {
> >>>>  typedef enum {
> >>>>      MIG_PRI_DEFAULT = 0,
> >>>>      MIG_PRI_IOMMU,              /* Must happen before PCI devices */
> >>>> +    MIG_PRI_PCIE_ROOT_PORT,     /* Must happen before IOMMU */
> >>>>      MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
> >>>>      MIG_PRI_GICV3,              /* Must happen before the ITS */
> >>>>      MIG_PRI_MAX,
> >>>>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
