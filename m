Received: from eggs.gnu.org ([2001:4830:134:3::10]:40156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eslxU-0004mp-Cp
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eslxR-0002Sm-C8
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:59:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:55510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eslxR-0002SP-2Z
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:58:57 -0500
Date: Mon, 5 Mar 2018 16:42:07 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20180305084207.GE2482@sky-dev>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-9-git-send-email-yi.l.liu@linux.intel.com>
	<f9ee648a-ff93-b57a-4b05-6bd0f40c15bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ee648a-ff93-b57a-4b05-6bd0f40c15bf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/12] hw/pci: introduce
 pci_device_notify_iommu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On Fri, Mar 02, 2018 at 04:12:01PM +0100, Paolo Bonzini wrote:
> On 01/03/2018 11:33, Liu, Yi L wrote:
> > This patch adds pci_device_notify_iommu() for notify virtual IOMMU
> > emulator when assigned device is added. And adds a new notify_func
> > in PCIBus. vIOMMU emulator provides the instance of this notify_func.
> > 
> > Reason:
> > When virtual IOMMU is exposed to guest, vIOMMU emulator needs to
> > programm host IOMMU to setup DMA mapping for assigned devices. This
> > is a per-device operation, to be efficient, vIOMMU emulator needs
> > to record the assigned devices.
> > 
> > Example: devices assigned thru vfio, vfio_realize would call
> > pci_device_notify_iommu() to notify vIOMMU emulator to record necessary
> > info for assigned device.
> 
> I think the notification should not be left to the individual device.
> Instead, the add notification should be done in pci_setup_sva_ops, and
> the delete notification should be done in pci_qdev_unrealize, before
> calling pc->exit, and only if dev->sva_ops is not NULL.

Agreed. I think it works together with your comments against
"[PATCH v3 05/12] hw/pci: introduce PCISVAOps to PCIDevice". Would apply
it in next version.
 
> In general I think it's better to change your names from "assigned_dev"
> to "sva_dev", because the point of the list is to only iterate over
> devices that might be interested in using SVA.

For "assigned_dev", my purpose is to distinguish "assigned devices" from
emulated devices. Only the SVA usage on "assigned devices" is cared here.
But it is true only SVA capable device is interested. So I may need to
rename it as "assigned_sva_dev". How about your opinion?

Thanks,
Yi Liu
