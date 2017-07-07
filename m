Received: from eggs.gnu.org ([2001:4830:134:3::10]:34721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dTUvi-0006pW-Gc
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dTUvh-0000k5-Ar
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:12:26 -0400
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<AM5PR0401MB2545AFD256A96420ACC44CD89ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<14c83c14-1e7e-f142-77b0-fa8c873e2d41@redhat.com>
	<AM5PR0401MB2545C0E76C4BE6F82FE376D09ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<6f22079e-4b4b-6476-77be-51ec83104c0d@redhat.com>
	<AM5PR0401MB25459FDAA8C9AFA52503AAE99AC40@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<589f1642-775c-4805-74ac-bf67eb504733@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D25AEB@SHSMSX101.ccr.corp.intel.com>
	<19a85866-1e72-58b9-d120-8b5e5b809e90@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D2B865@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <1c78deea-a1c9-2ef7-113a-f6be93888560@arm.com>
Date: Fri, 7 Jul 2017 16:15:05 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D2B865@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Auger Eric <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "wei@redhat.com" <wei@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On 07/07/17 07:21, Tian, Kevin wrote:
> sorry I didn't quite get this part, and here is my understanding:
> 
> Guest programs vIOMMU to map a gIOVA (used by MSI to a GPA 
> of doorbell register of virtual irqchip. vIOMMU then 
> triggers VFIO map/unmap to update physical IOMMU page
> table for gIOVA -> HPA of real doorbell of physical irqchip

At the moment (non-SVM), physical and virtual MSI doorbell are completely
dissociated. VFIO itself maps the doorbell GPA->HPA during container
initialization. The GPA, chosen arbitrarily by the host, is then removed
from the guest GPA space.

When the guest programs the vIOMMU to map a gIOVA to the virtual irqchip
doorbell, I suppose Qemu will notice that the GPA doesn't correspond to
RAM and will withhold sending a VFIO_IOMMU_MAP_DMA request.

(For SVM I don't want to go into the details just now, but we will
probably need a separate VFIO mechanism to update the physical MSI-X
tables with whatever gIOVA the guest mapped in its private stage-1 page
tables.)

> (assume your irqchip will provide multiple doorbells so each
> device can have its own channel).

In existing irqchips the doorbell is shared by endpoints, which are
differentiated by their device ID (generally the BDF). I'm not sure why
this matters here?

> then once this update is
> done, later MSI interrupts from assigned device will go 
> through physical IOMMU (gIOVA->HPA) then reach irqchip 
> for irq remapping. vIOMMU is involved only in configuration
> path instead of actual interrupt path.

Yes the vIOMMU is used to correlate the IOVA written by the guest in its
virtual MSI-X table with the MAP request received by the vIOMMU. That is
probably used to setup IRQFD routes with KVM. But the vIOMMU is not
involved further than that in MSIs.

> If my understanding is correct, above will be the natural flow then
> why is additional virtio-iommu change required? :-)

The change is not *required* for ARM systems, I only proposed removing the
doorbell address translation stage to make host implementation simpler
(and since virtio-iommu on x86 won't translate the doorbell anyway, we
have to add support for this to virtio-iommu). But for Qemu, since vSMMU
needs to implement the natural flow anyway, it might not be a lot of
effort to also do it for virtio-iommu. Other implementations (e.g.
kvmtool) might piggy-back on the x86 way and declare the irqchip doorbell
as untranslated.

My proposal also breaks when confronted to virtual SVM in a physical ARM
system, where the guest owns stage-1 page tables and *has* to map the
doorbell if it wants MSIs to work, so you can disregard it :)

Thanks,
Jean
