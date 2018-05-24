Received: from eggs.gnu.org ([2001:4830:134:3::10]:46457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLq2M-0005jv-34
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLq2G-0005Q5-VO
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:12:10 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:36579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLq2G-0005Ps-Po
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:12:04 -0400
Received: by mail-ot0-x243.google.com with SMTP id m11-v6so1847316otf.3
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 06:12:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527047633-12368-2-git-send-email-zhaoshenglong@huawei.com>
References: <1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com>
	<1527047633-12368-2-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 14:11:43 +0100
Message-ID: <CAFEAcA_QWFQPi2fndeUqBNVWdgeKpfNoJL_amQC9aqpYoTbW6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V3 2/2] arm_gicv3_kvm: kvm_dist_get/put:
 skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 23 May 2018 at 04:53, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> While we skip the GIC_INTERNAL irqs, we don't change the register offset
> accordingly. This will overlap the GICR registers value and leave the
> last GIC_INTERNAL irq's registers out of update.
>
> Fix this by skipping the registers banked by GICR.
>
> Also for migration compatibility if the migration source (old version
> qemu) doesn't send gicd_no_shift_bug = 1 to destination, then we shift
> the data of PPI to get the right data for SPI.
>
> Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> ---
> Changes in V3: add migration compatibility and fix code style
> ---
>  hw/intc/arm_gicv3_common.c         | 36 ++++++++++++++++++++++++
>  hw/intc/arm_gicv3_kvm.c            | 56 +++++++++++++++++++++++++++++++++++++-
>  include/hw/intc/arm_gicv3_common.h |  1 +
>  3 files changed, 92 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 7b54d52..f93e5d2 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -141,6 +141,38 @@ static const VMStateDescription vmstate_gicv3_cpu = {
>      }
>  };
>
> +static int gicv3_gicd_no_shift_bug_pre_load(void *opaque)
> +{
> +    GICv3State *cs = opaque;
> +
> +   /*
> +    * If the gicd_no_shift_bug subsection is not transferred this
> +    * means gicd_no_shift_bug is 0x0 (which might not be the same as
> +    * our reset value).
> +    */

This comment seems to have been copied from a similar one about
SRE_EL1, and I think it's a bit misleading here. For icc_sre_el1,
that is a guest-visible struct value which we set to something in the
device's reset function. This gicd_no_shift_bug field is
only for the benefit of migration.

This comment is the ideal place to explain the semantics of gicd_no_shift_bug
and why we have to use it.

You should also only set this if KVM is enabled, because the TCG
GIC gets the semantics of the data structure right.

> +    cs->gicd_no_shift_bug = 0x0;
> +    return 0;
> +}
> +
> +static bool gicv3_gicd_no_shift_bug_needed(void *opaque)
> +{
> +    GICv3State *cs = opaque;
> +
> +    return cs->gicd_no_shift_bug;
> +}
> +
> +const VMStateDescription vmstate_gicv3_gicd_no_shift_bug = {
> +    .name = "arm_gicv3/gicd_no_shift_bug",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .pre_load = gicv3_gicd_no_shift_bug_pre_load,
> +    .needed = gicv3_gicd_no_shift_bug_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BOOL(gicd_no_shift_bug, GICv3State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

You also need a post-load function, because that is where you want
to fix up the incoming data (by memcpy'ing it into the right place).

> +
>  static const VMStateDescription vmstate_gicv3 = {
>      .name = "arm_gicv3",
>      .version_id = 1,
> @@ -165,6 +197,10 @@ static const VMStateDescription vmstate_gicv3 = {
>          VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, GICv3State, num_cpu,
>                                               vmstate_gicv3_cpu, GICv3CPUState),
>          VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_gicv3_gicd_no_shift_bug,
> +        NULL
>      }
>  };
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 3536795..bd961f1 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -136,6 +136,12 @@ static void kvm_dist_get_priority(GICv3State *s, uint32_t offset, uint8_t *bmp)
>      int irq;
>
>      field = (uint32_t *)bmp;
> +    /* For the KVM GICv3, affinity routing is always enabled, and the first 8
> +     * GICD_IPRIORITYR<n> registers are always RAZ/WI. The corresponding
> +     * functionality is replaced by GICR_IPRIORITYR<n>. So it doesn't need to
> +     * sync them.
> +     */

This is true, but not why we need to add to the offset. We need
to add to the offset because for_each_dist_irq_reg()'s loop
handles irq numbers starting from GIC_INTERNAL, but the offset
we have is for the start of the GICD_IPRIORITYR<n> register range,
which includes space for the irqs 0..GIC_INTERNAL-1.

> +    offset += (8 * sizeof(uint32_t));

Possibly these offset changes would be clearer written as

     offset += (GIC_INTERNAL * bits-per-irq) / 8;

where bits-per-irq is the same as the last argument to for_each_dist_irq_reg()?

>      for_each_dist_irq_reg(irq, s->num_irq, 8) {
>          kvm_gicd_access(s, offset, &reg, false);
>          *field = reg;
> @@ -149,7 +155,18 @@ static void kvm_dist_put_priority(GICv3State *s, uint32_t offset, uint8_t *bmp)
>      uint32_t reg, *field;
>      int irq;
>
> -    field = (uint32_t *)bmp;
> +    if (!s->gicd_no_shift_bug) {
> +        field = (uint32_t *)(bmp + 8 * sizeof(uint32_t));
> +    } else {
> +        field = (uint32_t *)bmp;
> +    }

As noted above, don't try to fix the migration compat problem up here.
The code for syncing registers should just assume the data structure
is being used correctly.

> @@ -235,6 +274,20 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
>      uint32_t reg;
>      int irq;
>
> +    if (!s->gicd_no_shift_bug) {
> +        bmp += (1 * sizeof(uint32_t));
> +    }

As noted above, don't try to fix the migration compat problem up here.
The code for syncing registers should just assume the data structure
is being used correctly.

> +
> +    /* For the KVM GICv3, affinity routing is always enabled, and the
> +     * GICD_IGROUPR0/GICD_ISENABLER0/GICD_ISPENDR0/GICD_ISACTIVER0 registers
> +     * are always RAZ/WI. The corresponding functionality is replaced by the
> +     * GICR registers. So it doesn't need to sync them.
> +     */
> +    offset += (1 * sizeof(uint32_t));
> +    if (clroffset != 0) {
> +        clroffset += (1 * sizeof(uint32_t));
> +    }
> +
>      for_each_dist_irq_reg(irq, s->num_irq, 1) {
>          /* If this bitmap is a set/clear register pair, first write to the
>           * clear-reg to clear all bits before using the set-reg to write
> @@ -651,6 +704,7 @@ static void kvm_arm_gicv3_reset(DeviceState *dev)
>          return;
>      }
>
> +    s->gicd_no_shift_bug = 1;

This is the wrong place to do this reset, because then it won't
be in effect for the TCG GIC.

>      kvm_arm_gicv3_put(s);
>  }
>
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index bccdfe1..13c28c0 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -217,6 +217,7 @@ struct GICv3State {
>      uint32_t revision;
>      bool security_extn;
>      bool irq_reset_nonsecure;
> +    bool gicd_no_shift_bug;

Probably putting 'migration' in the field name will help to indicate
that it's only a migration compat fixup.

>
>      int dev_fd; /* kvm device fd if backed by kvm vgic support */
>      Error *migration_blocker;
> --
> 2.0.4

thanks
-- PMM
