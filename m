Received: from eggs.gnu.org ([2001:4830:134:3::10]:60254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nitin.lnx@gmail.com>) id 1dO5eZ-0008Cq-6h
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nitin.lnx@gmail.com>) id 1dO5eY-0005Fu-5b
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:12:23 -0400
Received: from mail-yw0-x22b.google.com ([2607:f8b0:4002:c05::22b]:33389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nitin.lnx@gmail.com>) id 1dO5eY-0005FW-1E
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:12:22 -0400
Received: by mail-yw0-x22b.google.com with SMTP id 63so8478937ywr.0
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 10:12:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170622105935.2dbd574d@w520.home>
References: <CAB995MvCYo=tWGg-tC5R-GmRqtdiaLaU_rHTprpRJ_hMJK6Rtw@mail.gmail.com>
	<20170622105935.2dbd574d@w520.home>
From: Nitin Saxena <nitin.lnx@gmail.com>
Date: Thu, 22 Jun 2017 22:42:19 +0530
Message-ID: <CAB995Mv3naMDu1e2zvzDn77GGNqwPXWUoJOrO0ZMs8B5YooRAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Query on VFIO in Virtual machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Thanks Alex.

>> Without an iommu in the VM, you'd be limited to no-iommu support for VM userspace,
So are you trying to say VFIO NO-IOMMU should work inside VM. Does
that mean VFIO NO-IOMMU in VM and VFIO IOMMU in host for same device
is a legitimate configuration? I did tried this configuration and the
application (in VM) seems to get container_fd, group_fd, device_fd
successfully but after VFIO_DEVICE_RESET ioctl the PCI link breaks
from VM as well as from host. This could be specific to PCI endpoint
device which I can dig.

I will be happy if VFIO NO-IOMMU in VM and IOMMU in host for same
device is legitimate configuration.

Thanks
Nitin

On Thu, Jun 22, 2017 at 10:29 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> [cc +qemu-devel, +peterx]
>
> On Thu, 22 Jun 2017 22:18:06 +0530
> Nitin Saxena <nitin.lnx@gmail.com> wrote:
>
>> Hi,
>>
>> I have a PCI device connected as an endpoint to Intel host machine.
>> The requirement is to run dpdk like user space data path application
>> in VM using PCI PF passthrough (SRIOV disabled). This application
>> works fine on host kernel and uses VFIO to get MSIX interrupts from
>> PCI device. We are trying to run this existing application in VM using
>> PCI passthrough. This application has capability to use
>> VFIO_IOMMU_TYPE1 as wells as VFIO_NOIOMMU.
>>
>> On Intel host machine VT-d has been enabled and using virt-manager PCI
>> device PF is assigned to the VM. This makes virt-manager to implicitly
>> binds PCI device PF to vfio with vfio_iommu_type1. The VM LINUX kernel
>> was booted with intel_iommu=on as boot parameter.
>>
>> My question: Is it possible that vfio can coexist in host (by
>> virt-manager) as well as VM (by application)? If yes, does application
>> running inside VM needs to configure VFIO with iommu_type=IOMMU or
>> iommu_type=no-iommu.
>>
>> In VM I tried inserting vfio_iommu_type1.ko kernel module which failed
>> with "No such device error". Thats why I am confused whether my
>> requirement is legitimate or not. What could be the best solution?
>
> This is really more of a QEMU question.  In order to use
> vfio_iommu_type1 in the guest, you need an iommu in the guest.  The
> most recent release of QEMU supports this with an emulated VT-d
> device.  Therefore if you create a VM with emulated VT-d and a device
> assigned through vfio-pci, you can expose it to userspace in the VM with
> physical iommu protection.  Without an iommu in the VM, you'd be
> limited to no-iommu support for VM userspace, the physical iommu would
> only protect the device to the extent of VM memory, no to specific
> userspace mappings within the VM.  Thanks,
>
> Alex
