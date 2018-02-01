Received: from eggs.gnu.org ([208.118.235.92]:52719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehKqn-0000cf-BG
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:49:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehKhE-0004QM-3n
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:43:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ehKhD-0004Pi-NW
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:38:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E48334E4D0
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 19:38:54 +0000 (UTC)
Date: Thu, 1 Feb 2018 19:38:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180201193838.GM2457@work-vm>
References: <20180201112028.23552-1-peterx@redhat.com>
	<90b4bc63-94cd-ec0f-32c8-c16df8ee84cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90b4bc63-94cd-ec0f-32c8-c16df8ee84cf@redhat.com>
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
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

* Marcel Apfelbaum (marcel@redhat.com) wrote:
> Hi Peter,
> 
> On 01/02/2018 13:20, Peter Xu wrote:
> > In the past, we prioritized IOMMU migration so that we have such a
> > priority order:
> > 
> >     IOMMU > PCI Devices
> > 
> > When migrating a guest with both vIOMMU and pcie-root-port, we'll always
> > migrate vIOMMU first, since pcie-root-port will be seen to have the same
> > priority of general PCI devices.
> > 
> > That's problematic.
> > 
> > The thing is that PCI bus number information is stored in the root port,
> > and that is needed by vIOMMU during post_load(), e.g., to figure out
> > context entry for a device.  If we don't have correct bus numbers for
> > devices, we won't be able to recover device state of the DMAR memory
> > regions, and things will be messed up.
> > 
> > So let's boost the PCIe root ports to be even with higher priority:
> > 
> >    PCIe Root Port > IOMMU > PCI Devices
> > 
> > A smoke test shows that this patch fixes bug 1538953.
> > 
> > CC: Alex Williamson <alex.williamson@redhat.com>
> > CC: Marcel Apfelbaum <marcel@redhat.com>
> > CC: Michael S. Tsirkin <mst@redhat.com>
> > CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > CC: Juan Quintela <quintela@redhat.com>
> > CC: Laurent Vivier <lvivier@redhat.com>
> > Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1538953
> > Reported-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > Marcel & all,
> > 
> > I think it's possible that we need similar thing for other bridge-like
> > devices, but I'm not that familiar.  Would you help confirm?  Thanks,
> 
> Is a pity we don't have a way to mark the migration priority
> in a base class. Dave, maybe we do have a way?

Not that I'm aware of; the 'priority' field is associated with the VMSD
and it's not really connected to the class hierarchy at all.

Dave

> In the meantime you would need to add it also to:
> - ioh3420 (Intel root port)
> - xio3130_downstream (Intel switch downstream port)
> - xio3130_upstream (The counterpart of the above, you want the whole
>   switch to be migrated before loading the IOMMU device state)
> - pcie_pci_bridge (for pci devices)
> - pci-pci bridge (if for some reason you have one attached to the pcie_pci_brdge)
> - i82801b11 (dmi-pci bridge, we want to deprecate it bu is there for now)
> 
> Thanks,
> Marcel
> 
> >  hw/pci-bridge/gen_pcie_root_port.c | 1 +
> >  include/migration/vmstate.h        | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> > index 0e2f2e8bf1..e6ff1effd8 100644
> > --- a/hw/pci-bridge/gen_pcie_root_port.c
> > +++ b/hw/pci-bridge/gen_pcie_root_port.c
> > @@ -101,6 +101,7 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
> >  
> >  static const VMStateDescription vmstate_rp_dev = {
> >      .name = "pcie-root-port",
> > +    .priority = MIG_PRI_PCIE_ROOT_PORT,
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> >      .post_load = pcie_cap_slot_post_load,
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 8c3889433c..491449db9f 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -148,6 +148,7 @@ enum VMStateFlags {
> >  typedef enum {
> >      MIG_PRI_DEFAULT = 0,
> >      MIG_PRI_IOMMU,              /* Must happen before PCI devices */
> > +    MIG_PRI_PCIE_ROOT_PORT,     /* Must happen before IOMMU */
> >      MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
> >      MIG_PRI_GICV3,              /* Must happen before the ITS */
> >      MIG_PRI_MAX,
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
