Received: from eggs.gnu.org ([2001:4830:134:3::10]:56367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dO5SM-000416-GT
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dO5SH-0007ws-HE
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:59:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dO5SH-0007va-7g
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:59:41 -0400
Date: Thu, 22 Jun 2017 10:59:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170622105935.2dbd574d@w520.home>
In-Reply-To: <CAB995MvCYo=tWGg-tC5R-GmRqtdiaLaU_rHTprpRJ_hMJK6Rtw@mail.gmail.com>
References: <CAB995MvCYo=tWGg-tC5R-GmRqtdiaLaU_rHTprpRJ_hMJK6Rtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Query on VFIO in Virtual machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nitin Saxena <nitin.lnx@gmail.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

[cc +qemu-devel, +peterx]

On Thu, 22 Jun 2017 22:18:06 +0530
Nitin Saxena <nitin.lnx@gmail.com> wrote:

> Hi,
> 
> I have a PCI device connected as an endpoint to Intel host machine.
> The requirement is to run dpdk like user space data path application
> in VM using PCI PF passthrough (SRIOV disabled). This application
> works fine on host kernel and uses VFIO to get MSIX interrupts from
> PCI device. We are trying to run this existing application in VM using
> PCI passthrough. This application has capability to use
> VFIO_IOMMU_TYPE1 as wells as VFIO_NOIOMMU.
> 
> On Intel host machine VT-d has been enabled and using virt-manager PCI
> device PF is assigned to the VM. This makes virt-manager to implicitly
> binds PCI device PF to vfio with vfio_iommu_type1. The VM LINUX kernel
> was booted with intel_iommu=on as boot parameter.
> 
> My question: Is it possible that vfio can coexist in host (by
> virt-manager) as well as VM (by application)? If yes, does application
> running inside VM needs to configure VFIO with iommu_type=IOMMU or
> iommu_type=no-iommu.
> 
> In VM I tried inserting vfio_iommu_type1.ko kernel module which failed
> with "No such device error". Thats why I am confused whether my
> requirement is legitimate or not. What could be the best solution?

This is really more of a QEMU question.  In order to use
vfio_iommu_type1 in the guest, you need an iommu in the guest.  The
most recent release of QEMU supports this with an emulated VT-d
device.  Therefore if you create a VM with emulated VT-d and a device
assigned through vfio-pci, you can expose it to userspace in the VM with
physical iommu protection.  Without an iommu in the VM, you'd be
limited to no-iommu support for VM userspace, the physical iommu would
only protect the device to the extent of VM memory, no to specific
userspace mappings within the VM.  Thanks,

Alex
