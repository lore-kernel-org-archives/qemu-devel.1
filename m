Received: from eggs.gnu.org ([2001:4830:134:3::10]:43427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1cFNhi-0001pL-Jr
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1cFNhg-0007qH-Ty
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:07:22 -0500
References: <20161208175030.12269-1-drjones@redhat.com>
	<20161208175030.12269-10-drjones@redhat.com>
From: Andre Przywara <andre.przywara@arm.com>
Message-ID: <2fc872dd-ee19-f2fb-7444-cf701871fbeb@arm.com>
Date: Fri, 9 Dec 2016 16:08:00 +0000
MIME-Version: 1.0
In-Reply-To: <20161208175030.12269-10-drjones@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH kvm-unit-tests v8 09/10] arm/arm64: gicv3:
 add an IPI test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, marc.zyngier@arm.com, eric.auger@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, christoffer.dall@linaro.org

Hi,

On 08/12/16 17:50, Andrew Jones wrote:
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> 
> ---
> v8:
>  - keep the gic_common_ops concept completely local to
>    lib/arm/gic.c by instead exposing the more useful
>    concept of gic-specific functions
>  - sysreg rebase changes
>  - ordered ICC registers in spec-order (OCD kicked in...)
> v7:
>  - add common ipi_send_single/mask (replacing ipi_send).
>    Note, the arg order irq,cpu got swapped. [Eric]
>  - comment rewording [Eric]
>  - make enable_defaults a common op [Eric]
>  - gic_enable_defaults() will now invoke gic_init if
>    necessary [drew]
>  - split lib/arm/gic.c into gic-v2/3.c [Eric]
> v6: move most gicv2/gicv3 wrappers to common code [Alex]
> v5:
>  - fix copy+paste error in gicv3_write_eoir [drew]
>  - use modern register names [Andre]
> v4:
>  - heavily comment gicv3_ipi_send_tlist() [Eric]
>  - changes needed for gicv2 iar/irqstat fix to other patch
> v2:
>  - use IRM for gicv3 broadcast
> ---
>  arm/unittests.cfg          |  6 ++++
>  lib/arm/asm/arch_gicv3.h   | 21 ++++++++++++
>  lib/arm/asm/gic-v2.h       |  6 ++++
>  lib/arm/asm/gic-v3.h       | 12 +++++++
>  lib/arm/asm/gic.h          | 19 +++++++++++
>  lib/arm64/asm/arch_gicv3.h | 22 ++++++++++++
>  arm/gic.c                  | 81 +++++++++++++++++++++++++++++++++++--------
>  lib/arm/gic-v2.c           | 30 ++++++++++++++++
>  lib/arm/gic-v3.c           | 84 +++++++++++++++++++++++++++++++++++++++++++++
>  lib/arm/gic.c              | 85 ++++++++++++++++++++++++++++++++++++++++++++--
>  10 files changed, 350 insertions(+), 16 deletions(-)

....

> diff --git a/lib/arm/gic-v2.c b/lib/arm/gic-v2.c
> index e80eb8f29488..dc6a97c600ec 100644
> --- a/lib/arm/gic-v2.c
> +++ b/lib/arm/gic-v2.c
> @@ -25,3 +25,33 @@ void gicv2_enable_defaults(void)
>  	writel(GICC_INT_PRI_THRESHOLD, cpu_base + GICC_PMR);
>  	writel(GICC_ENABLE, cpu_base + GICC_CTLR);
>  }
> +
> +u32 gicv2_read_iar(void)
> +{
> +	return readl(gicv2_cpu_base() + GICC_IAR);
> +}
> +
> +u32 gicv2_iar_irqnr(u32 iar)
> +{
> +	return iar & GICC_IAR_INT_ID_MASK;
> +}
> +
> +void gicv2_write_eoir(u32 irqstat)
> +{
> +	writel(irqstat, gicv2_cpu_base() + GICC_EOIR);
> +}
> +
> +void gicv2_ipi_send_single(int irq, int cpu)
> +{
> +	assert(cpu < 8);
> +	assert(irq < 16);
> +	writel(1 << (cpu + 16) | irq, gicv2_dist_base() + GICD_SGIR);
> +}
> +
> +void gicv2_ipi_send_mask(int irq, const cpumask_t *dest)
> +{
> +	u8 tlist = (u8)cpumask_bits(dest)[0];
> +
> +	assert(irq < 16);
> +	writel(tlist << 16 | irq, gicv2_dist_base() + GICD_SGIR);
> +}
> diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
> index c46d16e11782..9682fc96b631 100644
> --- a/lib/arm/gic-v3.c
> +++ b/lib/arm/gic-v3.c
> @@ -59,3 +59,87 @@ void gicv3_enable_defaults(void)
>  	gicv3_write_pmr(GICC_INT_PRI_THRESHOLD);
>  	gicv3_write_grpen1(1);
>  }
> +
> +u32 gicv3_iar_irqnr(u32 iar)
> +{
> +	return iar;

I am probably a bit paranoid here, but the spec says that the interrupt
ID is in bits[23:0] only (at most).

> +}
> +
> +void gicv3_ipi_send_mask(int irq, const cpumask_t *dest)
> +{
> +	u16 tlist;
> +	int cpu;
> +
> +	assert(irq < 16);
> +
> +	/*
> +	 * For each cpu in the mask collect its peers, which are also in
> +	 * the mask, in order to form target lists.
> +	 */
> +	for_each_cpu(cpu, dest) {
> +		u64 mpidr = cpus[cpu], sgi1r;
> +		u64 cluster_id;
> +
> +		/*
> +		 * GICv3 can send IPIs to up 16 peer cpus with a single
> +		 * write to ICC_SGI1R_EL1 (using the target list). Peers
> +		 * are cpus that have nearly identical MPIDRs, the only
> +		 * difference being Aff0. The matching upper affinity
> +		 * levels form the cluster ID.
> +		 */
> +		cluster_id = mpidr & ~0xffUL;
> +		tlist = 0;
> +
> +		/*
> +		 * Sort of open code for_each_cpu in order to have a
> +		 * nested for_each_cpu loop.
> +		 */
> +		while (cpu < nr_cpus) {
> +			if ((mpidr & 0xff) >= 16) {
> +				printf("cpu%d MPIDR:aff0 is %d (>= 16)!\n",
> +					cpu, (int)(mpidr & 0xff));
> +				break;
> +			}
> +
> +			tlist |= 1 << (mpidr & 0xf);
> +
> +			cpu = cpumask_next(cpu, dest);
> +			if (cpu >= nr_cpus)
> +				break;
> +
> +			mpidr = cpus[cpu];
> +
> +			if (cluster_id != (mpidr & ~0xffUL)) {
> +				/*
> +				 * The next cpu isn't in our cluster. Roll
> +				 * back the cpu index allowing the outer
> +				 * for_each_cpu to find it again with
> +				 * cpumask_next
> +				 */
> +				--cpu;
> +				break;
> +			}
> +		}
> +
> +		/* Send the IPIs for the target list of this cluster */
> +		sgi1r = (MPIDR_TO_SGI_AFFINITY(cluster_id, 3)	|
> +			 MPIDR_TO_SGI_AFFINITY(cluster_id, 2)	|
> +			 irq << 24				|
> +			 MPIDR_TO_SGI_AFFINITY(cluster_id, 1)	|
> +			 tlist);
> +
> +		gicv3_write_sgi1r(sgi1r);
> +	}
> +
> +	/* Force the above writes to ICC_SGI1R_EL1 to be executed */
> +	isb();
> +}

Wow, this is really heavy stuff, especially for a Friday afternoon ;-)
But I convinced myself that it's correct. The only issue is that it's
sub-optimal if the MPIDRs of the VCPUs are not in order, say: 0x000,
0x100, 0x001.
In this case we do three register writes instead of the minimal two.
But it's still correct, so it's actually a minor nit just to prove that
I checked the algorithm ;-)

So apart from the minor comment above:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> +
> +void gicv3_ipi_send_single(int irq, int cpu)
> +{
> +	cpumask_t dest;
> +
> +	cpumask_clear(&dest);
> +	cpumask_set_cpu(cpu, &dest);
> +	gicv3_ipi_send_mask(irq, &dest);
> +}
> diff --git a/lib/arm/gic.c b/lib/arm/gic.c
> index 4d3ddd9722b1..3ed539727f8c 100644
> --- a/lib/arm/gic.c
> +++ b/lib/arm/gic.c
> @@ -10,6 +10,38 @@
>  struct gicv2_data gicv2_data;
>  struct gicv3_data gicv3_data;
>  
> +struct gic_common_ops {
> +	int gic_version;
> +	void (*enable_defaults)(void);
> +	u32 (*read_iar)(void);
> +	u32 (*iar_irqnr)(u32 iar);
> +	void (*write_eoir)(u32 irqstat);
> +	void (*ipi_send_single)(int irq, int cpu);
> +	void (*ipi_send_mask)(int irq, const cpumask_t *dest);
> +};
> +
> +static const struct gic_common_ops *gic_common_ops;
> +
> +static const struct gic_common_ops gicv2_common_ops = {
> +	.gic_version = 2,
> +	.enable_defaults = gicv2_enable_defaults,
> +	.read_iar = gicv2_read_iar,
> +	.iar_irqnr = gicv2_iar_irqnr,
> +	.write_eoir = gicv2_write_eoir,
> +	.ipi_send_single = gicv2_ipi_send_single,
> +	.ipi_send_mask = gicv2_ipi_send_mask,
> +};
> +
> +static const struct gic_common_ops gicv3_common_ops = {
> +	.gic_version = 3,
> +	.enable_defaults = gicv3_enable_defaults,
> +	.read_iar = gicv3_read_iar,
> +	.iar_irqnr = gicv3_iar_irqnr,
> +	.write_eoir = gicv3_write_eoir,
> +	.ipi_send_single = gicv3_ipi_send_single,
> +	.ipi_send_mask = gicv3_ipi_send_mask,
> +};
> +
>  /*
>   * Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
>   * Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> @@ -58,9 +90,58 @@ int gicv3_init(void)
>  
>  int gic_init(void)
>  {
> -	if (gicv2_init())
> +	if (gicv2_init()) {
> +		gic_common_ops = &gicv2_common_ops;
>  		return 2;
> -	else if (gicv3_init())
> +	} else if (gicv3_init()) {
> +		gic_common_ops = &gicv3_common_ops;
>  		return 3;
> +	}
>  	return 0;
>  }
> +
> +void gic_enable_defaults(void)
> +{
> +	if (!gic_common_ops) {
> +		int ret = gic_init();
> +		assert(ret != 0);
> +	} else
> +		assert(gic_common_ops->enable_defaults);
> +	gic_common_ops->enable_defaults();
> +}
> +
> +int gic_version(void)
> +{
> +	assert(gic_common_ops);
> +	return gic_common_ops->gic_version;
> +}
> +
> +u32 gic_read_iar(void)
> +{
> +	assert(gic_common_ops && gic_common_ops->read_iar);
> +	return gic_common_ops->read_iar();
> +}
> +
> +u32 gic_iar_irqnr(u32 iar)
> +{
> +	assert(gic_common_ops && gic_common_ops->iar_irqnr);
> +	return gic_common_ops->iar_irqnr(iar);
> +}
> +
> +void gic_write_eoir(u32 irqstat)
> +{
> +	assert(gic_common_ops && gic_common_ops->write_eoir);
> +	gic_common_ops->write_eoir(irqstat);
> +}
> +
> +void gic_ipi_send_single(int irq, int cpu)
> +{
> +	assert(gic_common_ops && gic_common_ops->ipi_send_single);
> +	gic_common_ops->ipi_send_single(irq, cpu);
> +}
> +
> +void gic_ipi_send_mask(int irq, const cpumask_t *dest)
> +{
> +	assert(gic_common_ops && gic_common_ops->ipi_send_mask);
> +	gic_common_ops->ipi_send_mask(irq, dest);
> +}
> 
