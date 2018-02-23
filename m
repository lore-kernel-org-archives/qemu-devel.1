Received: from eggs.gnu.org ([2001:4830:134:3::10]:37433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ep4Tb-0000pi-G3
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 22:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ep4T0-0000Uo-QM
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 22:56:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33172 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ep4T0-0000SC-9i
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 22:56:14 -0500
Date: Fri, 23 Feb 2018 11:55:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180223035555.GL18962@xz-mi>
References: <CAHyh4xii5y-8=uMJeQGARrHZAETtW4ugmBWUypbQ923vk0P3Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHyh4xii5y-8=uMJeQGARrHZAETtW4ugmBWUypbQ923vk0P3Lw@mail.gmail.com>
Subject: Re: [Qemu-devel] intel-iommu and vhost: Do we need 'device-iotlb'
 and 'ats'?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, jasowang@redhat.com, Eric Auger <eric.auger@redhat.com>

On Tue, Feb 20, 2018 at 11:03:46PM -0500, Jintack Lim wrote:
> Hi,
> 
> I'm using vhost with the virtual intel-iommu, and this page[1] shows
> the QEMU command line example.
> 
> qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split -m 2G \
>                    -device intel-iommu,intremap=on,device-iotlb=on \
>                    -device ioh3420,id=pcie.1,chassis=1 \
>                    -device
> virtio-net-pci,bus=pcie.1,netdev=net0,disable-legacy=on,disable-modern=off,iommu_platform=on,ats=on
> \
>                    -netdev tap,id=net0,vhostforce \
>                    $IMAGE_PATH
> 
> I wonder what's the impact of using device-iotlb and ats options as
> they are described necessary.
> 
> In my understanding, vhost in the kernel only looks at
> VIRTIO_F_IOMMU_PLATFORM, and when it is set, vhost uses a
> device-iotlb. In addition, vhost and QEMU communicate using vhost_msg
> basically to cache mappings correctly in the vhost, so I wonder what's
> the role of ats in this case.

The "ats" as virtio device parameter will add ATS capability to the
PCI device.

The "device-iotlb" as intel-iommu parameter will enable ATS in the
IOMMU device (and also report that in ACPI field).

If both parameters are provided IIUC it means guest will know virtio
device has device-iotlb and it'll treat the device specially (e.g.,
guest will need to send device-iotlb invalidations).

We'd better keep these parameters when running virtio devices with
vIOMMU.  For the rest of vhost/arm specific questions, I'll leave to
others.

PS: Though IIUC the whole ATS thing may not really be necessary for
current VT-d emulation, since even with ATS vhost is registering UNMAP
IOMMU notifiers (see vhost_iommu_region_add()), and IIUC that means
vhost will receive IOTLB invalidations even without ATS support, and
it _might_ still work.  But there can be other differences, like
performance, etc.

> 
> A related question is that if we use SMMU emulation[2] on ARM without
> those options, does vhost cache mappings as if it has a device-iotlb?
> (I guess this is the case.)
> 
> I'm pretty new to QEMU code, so I might be missing something. Can
> somebody shed some light on it?
> 
> [1] https://wiki.qemu.org/Features/VT-d
> [2] http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg04736.html
> 
> Thanks,
> Jintack
> 

-- 
Peter Xu
