Received: from eggs.gnu.org ([2001:4830:134:3::10]:50861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIX5r-0005tW-TW
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIX5q-0006Wy-S1
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:17:35 -0400
References: <1496824556-1883-1-git-send-email-eric.auger@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <03f4d3b6-a678-56b8-4320-ac002dfeeb8d@redhat.com>
Date: Wed, 7 Jun 2017 17:17:13 +0800
MIME-Version: 1.0
In-Reply-To: <1496824556-1883-1-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: wei@redhat.com, kevin.tian@intel.com, bharat.bhushan@nxp.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org



On 2017=E5=B9=B406=E6=9C=8807=E6=97=A5 16:35, Eric Auger wrote:
> This series implements the virtio-iommu device. This is a proof
> of concept based on the virtio-iommu specification written by
> Jean-Philippe Brucker [1]. This was tested with a guest using
> the virtio-iommu driver [2] and exposed with a virtio-net-pci
> using dma ops.
>
> The device gets instantiated using the "-device virtio-iommu-device"
> option. It currently works with ARM virt machine only as the machine
> must handle the dt binding between the virtio-mmio "iommu" node and
> the PCI host bridge node. ACPI booting is not yet supported.
>
> This should allow to start some benchmarking activities against
> pure emulated IOMMU (especially ARM SMMU).

Yes, it would be also interesting to compare it with intel IOMMU.=20
Actually the core function is similar to the subset of intel one with CM=20
enabled. Since each map and unmap requires a command, it would be very=20
slow for dynamic mappings. I wonder whether or not we can do any=20
optimization on this.

Thanks

>
> Best Regards
>
> Eric
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/virtio-iommu-rfcv1
>
> References:
> [1] [RFC 0/3] virtio-iommu: a paravirtualized IOMMU,
> [2] [RFC PATCH linux] iommu: Add virtio-iommu driver
> [3] [RFC PATCH kvmtool 00/15] Add virtio-iommu
>
> Eric Auger (8):
>    update-linux-headers: import virtio_iommu.h
>    linux-headers: Update for virtio-iommu
>    virtio_iommu: add skeleton
>    virtio-iommu: Decode the command payload
>    virtio_iommu: Add the iommu regions
>    virtio-iommu: Implement the translation and commands
>    hw/arm/virt: Add 2.10 machine type
>    hw/arm/virt: Add virtio-iommu the virt board
>
>   hw/arm/virt.c                                 | 116 ++++-
>   hw/virtio/Makefile.objs                       |   1 +
>   hw/virtio/trace-events                        |  14 +
>   hw/virtio/virtio-iommu.c                      | 623 +++++++++++++++++=
+++++++++
>   include/hw/arm/virt.h                         |   5 +
>   include/hw/virtio/virtio-iommu.h              |  60 +++
>   include/standard-headers/linux/virtio_ids.h   |   1 +
>   include/standard-headers/linux/virtio_iommu.h | 142 ++++++
>   linux-headers/linux/virtio_iommu.h            |   1 +
>   scripts/update-linux-headers.sh               |   3 +
>   10 files changed, 957 insertions(+), 9 deletions(-)
>   create mode 100644 hw/virtio/virtio-iommu.c
>   create mode 100644 include/hw/virtio/virtio-iommu.h
>   create mode 100644 include/standard-headers/linux/virtio_iommu.h
>   create mode 100644 linux-headers/linux/virtio_iommu.h
>
