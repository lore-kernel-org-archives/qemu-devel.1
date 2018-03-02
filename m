Received: from eggs.gnu.org ([2001:4830:134:3::10]:54762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermM1-0005cA-L2
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermLx-0002YJ-Kt
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:12:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ermLx-0002YE-FR
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:12:09 -0500
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-9-git-send-email-yi.l.liu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9ee648a-ff93-b57a-4b05-6bd0f40c15bf@redhat.com>
Date: Fri, 2 Mar 2018 16:12:01 +0100
MIME-Version: 1.0
In-Reply-To: <1519900415-30314-9-git-send-email-yi.l.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On 01/03/2018 11:33, Liu, Yi L wrote:
> This patch adds pci_device_notify_iommu() for notify virtual IOMMU
> emulator when assigned device is added. And adds a new notify_func
> in PCIBus. vIOMMU emulator provides the instance of this notify_func.
> 
> Reason:
> When virtual IOMMU is exposed to guest, vIOMMU emulator needs to
> programm host IOMMU to setup DMA mapping for assigned devices. This
> is a per-device operation, to be efficient, vIOMMU emulator needs
> to record the assigned devices.
> 
> Example: devices assigned thru vfio, vfio_realize would call
> pci_device_notify_iommu() to notify vIOMMU emulator to record necessary
> info for assigned device.

I think the notification should not be left to the individual device.
Instead, the add notification should be done in pci_setup_sva_ops, and
the delete notification should be done in pci_qdev_unrealize, before
calling pc->exit, and only if dev->sva_ops is not NULL.

In general I think it's better to change your names from "assigned_dev"
to "sva_dev", because the point of the list is to only iterate over
devices that might be interested in using SVA.

Paolo
