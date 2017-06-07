Received: from eggs.gnu.org ([2001:4830:134:3::10]:37255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dIY07-0008Nk-I7
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dIY06-0002oC-EE
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:15:43 -0400
References: <1496824556-1883-1-git-send-email-eric.auger@redhat.com>
	<03f4d3b6-a678-56b8-4320-ac002dfeeb8d@redhat.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <8bd10202-75a2-2dee-1d75-9070217f65e0@arm.com>
Date: Wed, 7 Jun 2017 11:19:50 +0100
MIME-Version: 1.0
In-Reply-To: <03f4d3b6-a678-56b8-4320-ac002dfeeb8d@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Jason Wang <jasowang@redhat.com>, Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: wei@redhat.com, kevin.tian@intel.com, bharat.bhushan@nxp.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org

Hi Jason,

On 07/06/17 10:17, Jason Wang wrote:
> On 2017=E5=B9=B406=E6=9C=8807=E6=97=A5 16:35, Eric Auger wrote:
>> This series implements the virtio-iommu device. This is a proof
>> of concept based on the virtio-iommu specification written by
>> Jean-Philippe Brucker [1]. This was tested with a guest using
>> the virtio-iommu driver [2] and exposed with a virtio-net-pci
>> using dma ops.
>>
>> The device gets instantiated using the "-device virtio-iommu-device"
>> option. It currently works with ARM virt machine only as the machine
>> must handle the dt binding between the virtio-mmio "iommu" node and
>> the PCI host bridge node. ACPI booting is not yet supported.
>>
>> This should allow to start some benchmarking activities against
>> pure emulated IOMMU (especially ARM SMMU).
>=20
> Yes, it would be also interesting to compare it with intel IOMMU. Actua=
lly
> the core function is similar to the subset of intel one with CM enabled=
.
> Since each map and unmap requires a command, it would be very slow for
> dynamic mappings. I wonder whether or not we can do any optimization on=
 this.

In general we will have to send the same number of map/unmap requests tha=
n
the number of invalidations needed for an emulated IOMMU such as the Inte=
l
one (if I understand correctly with CM there are invalidations both on ma=
p
and unmap, to avoid trapping the page tables). Using virtio allows to
reduce the number of round-trips to the host, by batching map/unmap
requests where possible. Adding vhost-iommu in the host could further
reduce the latency of map/unmap requests.

To actually reduce the number of requests, I see two possible
optimizations (loosely described in [1]), both requiring invasive changes=
.

* Relaxed (insecure) mode, where the guest batches unmap request or
doesn't send them at all. Map will override existing mappings if
necessary. You end up sending far less unmap requests, but there is a
vulnerability window where devices can access stale mappings, so you have
to trust your peripherals. I believe the x86 IOMMU drivers in Linux
already allow this.

* Page table handover, which is a new mode orthogonal to map/unmap. This
uses nested translation - the guest has one set of page tables for
gva->gpa and the host has one set for gpa->hpa. After setup, the guest
populates the page tables and only sends invalidation requests, no map. I
think that with the Intel IOMMU this would only be possible with PASID
traffic. But nested translation will inherently be slower than "classic"
mode, so it might end up being overall slower than map/unmap, if there is
a lot of TLB invalidation and trashing. This mode is mostly useful for SV=
M
virtualization.

Thanks,
Jean
