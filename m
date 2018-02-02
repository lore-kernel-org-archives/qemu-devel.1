Received: from eggs.gnu.org ([2001:4830:134:3::10]:54465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ehe4t-0001UM-7O
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ehe3o-0003dr-Ac
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:20:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ehe3n-0003cS-Ub
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:19:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B890481DEC
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 10:19:46 +0000 (UTC)
Date: Fri, 2 Feb 2018 18:19:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180202101936.GD4666@xz-mi>
References: <20180201112028.23552-1-peterx@redhat.com>
	<90b4bc63-94cd-ec0f-32c8-c16df8ee84cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Thu, Feb 01, 2018 at 02:24:15PM +0200, Marcel Apfelbaum wrote:
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
> 
> In the meantime you would need to add it also to:
> - ioh3420 (Intel root port)
> - xio3130_downstream (Intel switch downstream port)
> - xio3130_upstream (The counterpart of the above, you want the whole
>   switch to be migrated before loading the IOMMU device state)
> - pcie_pci_bridge (for pci devices)
> - pci-pci bridge (if for some reason you have one attached to the pcie_pci_brdge)
> - i82801b11 (dmi-pci bridge, we want to deprecate it bu is there for now)

I'll see whether there is any better way to do this instead of
duplicating, but I'm not really sure about it.

Anyway, this list is helpful.  Thanks Marcel.

-- 
Peter Xu
