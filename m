Received: from eggs.gnu.org ([2001:4830:134:3::10]:36398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eqFoG-0004P2-2g
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eqFoC-0002vt-2p
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:15:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1eqFoB-0002t6-UG
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:15:00 -0500
References: <CAHyh4xii5y-8=uMJeQGARrHZAETtW4ugmBWUypbQ923vk0P3Lw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a69c1fcb-9902-720a-12ed-c8e979163f61@redhat.com>
Date: Mon, 26 Feb 2018 11:14:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAHyh4xii5y-8=uMJeQGARrHZAETtW4ugmBWUypbQ923vk0P3Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Jintack Lim <jintack@cs.columbia.edu>, QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: jasowang@redhat.com, Peter Xu <peterx@redhat.com>

Hi Jintack,

On 21/02/18 05:03, Jintack Lim wrote:
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
> 
> A related question is that if we use SMMU emulation[2] on ARM without
> those options, does vhost cache mappings as if it has a device-iotlb?
> (I guess this is the case.)
vsmmuv3 emulation code does not support ATS at the moment. vhost support
is something different. As Peter explained it comes with the capability
of the virtio device to register unmap notifiers. Those notifiers get
called each time there are TLB invalidation commands. That way the
in-kernel vhost cache can be invalidated. vhost support was there until
vsmmuv3 v7. With latest versions, I removed it to help reviewers
concentrate on the root functionality. However I will send it to you
based on v9.

Thanks

Eric
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
> 
