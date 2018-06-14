Received: from eggs.gnu.org ([2001:4830:134:3::10]:56391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fTStK-0003Va-8m
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fTStJ-000297-64
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:06:22 -0400
Date: Thu, 14 Jun 2018 16:06:09 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180614140609.tc6npczkt2fitgnu@kamzik.brq.redhat.com>
References: <1528879723-24675-1-git-send-email-eric.auger@redhat.com>
	<1528879723-24675-4-git-send-email-eric.auger@redhat.com>
	<20180614133215.khbod4vx4w6drh2x@kamzik.brq.redhat.com>
	<38a734ec-e813-03c9-d110-50dd327a60be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38a734ec-e813-03c9-d110-50dd327a60be@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/9] hw/intc/arm_gicv3: Introduce
 redist-region-count array property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: wei@redhat.com, peter.maydell@linaro.org, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, qemu-devel@nongnu.org, christoffer.dall@arm.com, qemu-arm@nongnu.org, zhaoshenglong@huawei.com, lersek@redhat.com, eric.auger.pro@gmail.com

On Thu, Jun 14, 2018 at 03:55:56PM +0200, Auger Eric wrote:
> Hi Drew,
> 
> On 06/14/2018 03:32 PM, Andrew Jones wrote:
> > On Wed, Jun 13, 2018 at 10:48:37AM +0200, Eric Auger wrote:
> >> To prepare for multiple redistributor regions, we introduce
> >> an array of uint32_t properties that stores the redistributor
> >> count of each redistributor region.
> >>
> >> Non accelerated VGICv3 only supports a single redistributor region.
> >> The capacity of all redist regions is checked against the number of
> >> vcpus.
> >>
> >> Machvirt is updated to set those properties, ie. a single
> >> redistributor region with count set to the number of vcpus
> >> capped by 123.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> ---
> >> v2 -> v3:
> >> - add missing return in arm_gic_realize
> >> - in gicv3_init_irqs_and_mmio, compute/check rdist_capacity first
> >> - rdist region 0 size set to MIN(smp_cpus, redist0_capacity)
> >> - add GICV3_REDIST_SIZE
> >> ---
> >>  hw/arm/virt.c                      | 11 ++++++++++-
> >>  hw/intc/arm_gicv3.c                | 12 +++++++++++-
> >>  hw/intc/arm_gicv3_common.c         | 38 +++++++++++++++++++++++++++++++++-----
> >>  hw/intc/arm_gicv3_kvm.c            |  9 +++++++--
> >>  include/hw/intc/arm_gicv3_common.h |  8 ++++++--
> >>  5 files changed, 67 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >> index f0a4fa0..2885d18 100644
> >> --- a/hw/arm/virt.c
> >> +++ b/hw/arm/virt.c
> >> @@ -522,6 +522,15 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
> >>      if (!kvm_irqchip_in_kernel()) {
> >>          qdev_prop_set_bit(gicdev, "has-security-extensions", vms->secure);
> >>      }
> >> +
> >> +    if (type == 3) {
> >> +        uint32_t redist0_capacity =
> >> +                    vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
> >> +        uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
> >> +
> >> +        qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
> > 
> > I don't see where this property is defined or used.
> 
> This is due to the fact we have an array property. nb_redist_regions is
> the storage of this value. len-redist-region-count is the name of the
> field (size of the array) from the user point of view.
> 
> DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_regions,
>                       redist_region_count, qdev_prop_uint32, uint32_t),
> 
> see len-db-voltage property in hw/arm/vexpress.c and
> hw/misc/arm_sysctl.c for a similar usage.

Thanks. I see '#define PROP_ARRAY_LEN_PREFIX "len-"' now too. That's just
the kind of magic that makes us all <blank> QEMU. Fill in <blank> as you
wish. I know what I'd fill it in with...

drew
