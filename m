Received: from eggs.gnu.org ([2001:4830:134:3::10]:42110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnUKD-0002s6-1U
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnUKB-0000Vp-Ug
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:04:05 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnUKB-0000V4-Mj
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:04:03 -0400
Received: by mail-wr0-x234.google.com with SMTP id u48so109131784wrc.0
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 11:04:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1488800894-22421-4-git-send-email-eric.auger@redhat.com>
References: <1488800894-22421-1-git-send-email-eric.auger@redhat.com>
	<1488800894-22421-4-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Mar 2017 19:03:41 +0100
Message-ID: <CAFEAcA97hCS-bbKDV+w2G3yRunUm=QpsA+8Bqp9YNaa_VtMP-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC v2 3/3] hw/intc/arm_gicv3_its: Allow
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Vijay Kilari <vijay.kilari@gmail.com>, "Kumar, Vijaya" <Vijaya.Kumar@cavium.com>, Andrew Jones <drjones@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

On 6 March 2017 at 12:48, Eric Auger <eric.auger@redhat.com> wrote:
> We change the restoration priority of both the GICv3 and ITS. The
> GICv3 must be restored before the ITS and the ITS needs to be restored
> before PCIe devices since it translates their MSI transactions.

> We typically observe the virtio-pci-net device sending MSI transactions
> very early (even before the first vcpu run) which looks weird. It
> appears that not servicing those transactions cause the virtio-pci-net
> to stall.

This does seem rather weird and worth closer investigation.
A stopped VM ought IMHO to be completely stopped, not still
doing things...

> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v1 -> v2:
> - handle case where migrate_add_blocker fails
> - add comments along with ITS and GICv3 migration priorities
> ---
>  hw/intc/arm_gicv3_common.c     |  1 +
>  hw/intc/arm_gicv3_its_common.c |  3 ++-
>  hw/intc/arm_gicv3_its_kvm.c    | 23 +++++++++++------------
>  include/migration/vmstate.h    |  2 ++
>  4 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index c6493d6..4228b7c 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -145,6 +145,7 @@ static const VMStateDescription vmstate_gicv3 = {
>      .minimum_version_id = 1,
>      .pre_save = gicv3_pre_save,
>      .post_load = gicv3_post_load,
> +    .priority = MIG_PRI_GICV3,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(gicd_ctlr, GICv3State),
>          VMSTATE_UINT32_ARRAY(gicd_statusr, GICv3State, 2),
> diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
> index 75b9f04..854709f 100644
> --- a/hw/intc/arm_gicv3_its_common.c
> +++ b/hw/intc/arm_gicv3_its_common.c
> @@ -48,7 +48,8 @@ static const VMStateDescription vmstate_its = {
>      .name = "arm_gicv3_its",
>      .pre_save = gicv3_its_pre_save,
>      .post_load = gicv3_its_post_load,
> -    .unmigratable = true,
> +    .unmigratable = false,

unmigratable = false is the default, so we can just delete the line.

> +    .priority = MIG_PRI_GICV3_ITS,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(ctlr, GICv3ITSState),
>          VMSTATE_UINT64(cbaser, GICv3ITSState),
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 45e57d6..3bd2873 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -76,18 +76,6 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
>      GICv3ITSState *s = ARM_GICV3_ITS_COMMON(dev);
>      Error *local_err = NULL;
>
> -    /*
> -     * Block migration of a KVM GICv3 ITS device: the API for saving and
> -     * restoring the state in the kernel is not yet available
> -     */
> -    error_setg(&s->migration_blocker, "vITS migration is not implemented");
> -    migrate_add_blocker(s->migration_blocker, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        error_free(s->migration_blocker);
> -        return;
> -    }
> -
>      s->dev_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_ARM_VGIC_ITS, false);
>      if (s->dev_fd < 0) {
>          error_setg_errno(errp, -s->dev_fd, "error creating in-kernel ITS");
> @@ -104,6 +92,17 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
>
>      gicv3_its_init_mmio(s, NULL);
>
> +    if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
> +        GITS_CTLR)) {
> +        error_setg(&s->migration_blocker, "vITS migration is not implemented");

I think we should specifically say that it's the host kernel
that doesn't support ITS migration (ie not QEMU that's missing
support).

The GICv3 uses the message
 "This operating system kernel does not support vGICv3 migration"
which is slightly odd phrasing but I guess we should follow that.

> +        migrate_add_blocker(s->migration_blocker, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            error_free(s->migration_blocker);
> +            return;
> +        }
> +    }
> +
>      kvm_msi_use_devid = true;
>      kvm_gsi_direct_mapping = false;
>      kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index f2dbf84..8dab9c7 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -198,6 +198,8 @@ enum VMStateFlags {
>  typedef enum {
>      MIG_PRI_DEFAULT = 0,
>      MIG_PRI_IOMMU,              /* Must happen before PCI devices */
> +    MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
> +    MIG_PRI_GICV3,              /* Must happen before the ITS */
>      MIG_PRI_MAX,
>  } MigrationPriority;
>
> --
> 2.5.5
>

thanks
-- PMM
