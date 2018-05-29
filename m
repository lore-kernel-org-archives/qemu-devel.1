Received: from eggs.gnu.org ([2001:4830:134:3::10]:40606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNfrR-0000uE-2a
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNfrP-00046A-7Y
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:44:29 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNfrP-00045S-1o
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:44:27 -0400
Received: by mail-oi0-x243.google.com with SMTP id l22-v6so5533292oib.4
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 07:44:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527247371-10592-3-git-send-email-zhaoshenglong@huawei.com>
References: <1527247371-10592-1-git-send-email-zhaoshenglong@huawei.com>
	<1527247371-10592-3-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 15:44:05 +0100
Message-ID: <CAFEAcA_ZqgGTxLM0BiUX2LOhszFs1z8t4jGF=wCj6ceh06r2nQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 2/2] arm_gicv3_kvm:
 kvm_dist_get/put: skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 25 May 2018 at 12:22, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> While we skip the GIC_INTERNAL irqs, we don't change the register offset
> accordingly. This will overlap the GICR registers value and leave the
> last GIC_INTERNAL irq's registers out of update.
>
> Fix this by skipping the registers banked by GICR.
>
> Also for migration compatibility if the migration source (old version
> qemu) doesn't send gicd_no_migration_shift_bug = 1 to destination, then
> we shift the data of PPI to get the right data for SPI.
>
> Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> ---
>  hw/intc/arm_gicv3_common.c         | 66 ++++++++++++++++++++++++++++++++++++++
>  hw/intc/arm_gicv3_kvm.c            | 30 +++++++++++++++++
>  include/hw/intc/arm_gicv3_common.h |  1 +
>  3 files changed, 97 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 7b54d52..f72a6f7 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -27,6 +27,7 @@
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "gicv3_internal.h"
>  #include "hw/arm/linux-boot-if.h"
> +#include "sysemu/kvm.h"
>
>  static int gicv3_pre_save(void *opaque)
>  {
> @@ -141,6 +142,66 @@ static const VMStateDescription vmstate_gicv3_cpu = {
>      }
>  };
>
> +static int gicv3_gicd_no_migration_shift_bug_pre_load(void *opaque)
> +{
> +    GICv3State *cs = opaque;
> +
> +   /*
> +    * The gicd_no_migration_shift_bug flag is used for migration compatibilty
> +    * for old version QEMU which may have the GICD bmp shift bug under KVM mode.

You can add here:

    * Strictly, what we want to know is whether the migration source is
    * using KVM. Since we don't have any way to determine that, we look
    * at whether the destination is using KVM; this is close enough
    * because for the older QEMU versions with this bug KVM -> TCG
    * migration didn't work anyway.
    * If the source is a newer QEMU without this bug it will transmit the
    * migration subsection which sets the flag to true; otherwise it will
    * remain set to the value we select here.

> +    */
> +    if (kvm_enabled()) {
> +        cs->gicd_no_migration_shift_bug = false;
> +    }
> +
> +    return 0;
> +}
> +
> +static int gicv3_gicd_no_migration_shift_bug_post_load(void *opaque,
> +                                                       int version_id)
> +{
> +    GICv3State *cs = opaque;
> +
> +    if (gicd_no_migration_shift_bug) {
> +        return 0;
> +    }

This is where we should have a comment explaining the bug and
what the migration data from the old broken QEMU looks like; something
like:

    /* Older versions of QEMU had a bug in the handling of state save/restore
     * to the KVM GICv3: they got the offset in the bitmap arrays wrong,
     * so that instead of the data for external interrupts 32 and up
     * starting at bit position 32 in the bitmap, it started at bit
     * position 0. If we're receiving data from a QEMU with that bug,
     * we must move the data back into the right place.
     */

> +
> +    memcpy(cs->group, (uint8_t *)cs->group + GIC_INTERNAL / 8,
> +           sizeof(cs->group) - GIC_INTERNAL / 8);

These are overlapping copies, so we need to use memmove().

Also you have the source and destination pointers the wrong way
around, I think. We want to copy data that's in the bitmap starting
at bit position 0 up to bit position 32, not the other way around.
(You should check that I'm right about this; don't just trust me :-))

You could write the 'dest' argument as
    gic_bmp_ptr32(cs->group, GIC_INTERNAL)
though that then breaks the symmetry between the src argument
and the size argument, so I'm not sure it's an improvement.

> +    memcpy(cs->grpmod, (uint8_t *)cs->grpmod + GIC_INTERNAL / 8,
> +           sizeof(cs->grpmod) - GIC_INTERNAL / 8);
> +    memcpy(cs->enabled, (uint8_t *)cs->enabled + GIC_INTERNAL / 8,
> +           sizeof(cs->enabled) - GIC_INTERNAL / 8);
> +    memcpy(cs->pending, (uint8_t *)cs->pending + GIC_INTERNAL / 8,
> +           sizeof(cs->pending) - GIC_INTERNAL / 8);
> +    memcpy(cs->active, (uint8_t *)cs->active + GIC_INTERNAL / 8,
> +           sizeof(cs->active) - GIC_INTERNAL / 8);
> +    memcpy(cs->edge_trigger, (uint8_t *)cs->edge_trigger + GIC_INTERNAL / 8,
> +           sizeof(cs->edge_trigger) - GIC_INTERNAL / 8);
> +
> +    return 0;
> +}
> +
> +static bool gicv3_gicd_no_migration_shift_bug_needed(void *opaque)
> +{
> +    GICv3State *cs = opaque;
> +
> +    return cs->gicd_no_migration_shift_bug;
> +}

We don't need to have a 'needed' function, because we always need
the subsection. (The code you have here will always return 'true',
which is the same as not specifying a 'needed' function at all.)

> +
> +const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
> +    .name = "arm_gicv3/gicd_no_migration_shift_bug",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .pre_load = gicv3_gicd_no_migration_shift_bug_pre_load,
> +    .post_load = gicv3_gicd_no_migration_shift_bug_post_load,
> +    .needed = gicv3_gicd_no_migration_shift_bug_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BOOL(gicd_no_migration_shift_bug, GICv3State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_gicv3 = {
>      .name = "arm_gicv3",
>      .version_id = 1,
> @@ -165,6 +226,10 @@ static const VMStateDescription vmstate_gicv3 = {
>          VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, GICv3State, num_cpu,
>                                               vmstate_gicv3_cpu, GICv3CPUState),
>          VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_gicv3_gicd_no_migration_shift_bug,
> +        NULL
>      }
>  };
>
> @@ -364,6 +429,7 @@ static void arm_gicv3_common_reset(DeviceState *dev)
>              gicv3_gicd_group_set(s, i);
>          }
>      }
> +    s->gicd_no_migration_shift_bug = true;
>  }
>
>  static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 147e691..1068444 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -178,6 +178,12 @@ static void kvm_dist_get_edge_trigger(GICv3State *s, uint32_t offset,
>      uint32_t reg;
>      int irq;
>
> +    /* For the KVM GICv3, affinity routing is always enabled, and the first 2
> +     * GICD_ICFGR<n> registers are always RAZ/WI. The corresponding
> +     * functionality is replaced by GICR_ICFGR<n>. It doesn't need to sync
> +     * them. So it should increase the offset to skip GIC_INTERNAL irqs.

    * This matches the for_each_dist_irq_reg() macro which also skips the
    * first GIC_INTERNAL irqs.

> +     */
> +    offset += (GIC_INTERNAL * 2) / 8;
>      for_each_dist_irq_reg(irq, s->num_irq, 2) {
>          kvm_gicd_access(s, offset, &reg, false);
>          reg = half_unshuffle32(reg >> 1);
> @@ -195,6 +201,12 @@ static void kvm_dist_put_edge_trigger(GICv3State *s, uint32_t offset,
>      uint32_t reg;
>      int irq;
>
> +    /* For the KVM GICv3, affinity routing is always enabled, and the first 2
> +     * GICD_ICFGR<n> registers are always RAZ/WI. The corresponding
> +     * functionality is replaced by GICR_ICFGR<n>. It doesn't need to sync
> +     * them. So it should increase the offset to skip GIC_INTERNAL irqs.
> +     */
> +    offset += (GIC_INTERNAL * 2) / 8;
>      for_each_dist_irq_reg(irq, s->num_irq, 2) {
>          reg = *gic_bmp_ptr32(bmp, irq);
>          if (irq % 32 != 0) {
> @@ -236,6 +248,13 @@ static void kvm_dist_getbmp(GICv3State *s, uint32_t offset, uint32_t *bmp)
>      uint32_t reg;
>      int irq;
>
> +    /* For the KVM GICv3, affinity routing is always enabled, and the
> +     * GICD_IGROUPR0/GICD_IGRPMODR0/GICD_ISENABLER0/GICD_ISPENDR0/
> +     * GICD_ISACTIVER0 registers are always RAZ/WI. The corresponding
> +     * functionality is replaced by the GICR registers. It doesn't need to sync
> +     * them. So it should increase the offset to skip GIC_INTERNAL irqs.
> +     */
> +    offset += (GIC_INTERNAL * 1) / 8;
>      for_each_dist_irq_reg(irq, s->num_irq, 1) {
>          kvm_gicd_access(s, offset, &reg, false);
>          *gic_bmp_ptr32(bmp, irq) = reg;
> @@ -249,6 +268,17 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
>      uint32_t reg;
>      int irq;
>
> +    /* For the KVM GICv3, affinity routing is always enabled, and the
> +     * GICD_IGROUPR0/GICD_IGRPMODR0/GICD_ISENABLER0/GICD_ISPENDR0/
> +     * GICD_ISACTIVER0 registers are always RAZ/WI. The corresponding
> +     * functionality is replaced by the GICR registers. It doesn't need to sync
> +     * them. So it should increase the offset to skip GIC_INTERNAL irqs.
> +     */
> +    offset += (GIC_INTERNAL * 1) / 8;
> +    if (clroffset != 0) {
> +        clroffset += (1 * sizeof(uint32_t));
> +    }
> +
>      for_each_dist_irq_reg(irq, s->num_irq, 1) {
>          /* If this bitmap is a set/clear register pair, first write to the
>           * clear-reg to clear all bits before using the set-reg to write
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index bccdfe1..d75b49d 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -217,6 +217,7 @@ struct GICv3State {
>      uint32_t revision;
>      bool security_extn;
>      bool irq_reset_nonsecure;
> +    bool gicd_no_migration_shift_bug;
>
>      int dev_fd; /* kvm device fd if backed by kvm vgic support */
>      Error *migration_blocker;
> --

thanks
-- PMM
