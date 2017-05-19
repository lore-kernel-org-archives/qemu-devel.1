Received: from eggs.gnu.org ([2001:4830:134:3::10]:34979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1dBfI4-00057Y-8o
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1dBfI3-0000vP-6n
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:37:48 -0400
Message-ID: <591EC943.2020603@huawei.com>
Date: Fri, 19 May 2017 18:30:27 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1492173995-14140-1-git-send-email-eric.auger@redhat.com>
	<1492173995-14140-5-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1492173995-14140-5-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v5 4/4] hw/intc/arm_gicv3_its: Allow
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: drjones@redhat.com, vijay.kilari@gmail.com, quintela@redhat.com, dgilbert@redhat.com, Vijaya.Kumar@cavium.com, christoffer.dall@linaro.org



On 2017/4/14 20:46, Eric Auger wrote:
> We change the restoration priority of both the GICv3 and ITS. The
> GICv3 must be restored before the ITS and the ITS needs to be restored
> before PCIe devices since it translates their MSI transactions.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> ---
> v2 -> v3:
> - reword migration blocker message
> - remove unmigratable setting to false
> 
> v1 -> v2:
> - handle case where migrate_add_blocker fails
> - add comments along with ITS and GICv3 migration priorities
> ---
>  hw/intc/arm_gicv3_common.c     |  1 +
>  hw/intc/arm_gicv3_its_common.c |  2 +-
>  hw/intc/arm_gicv3_its_kvm.c    | 24 ++++++++++++------------
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
> index efab8c7..22ce4c4 100644
> --- a/hw/intc/arm_gicv3_its_common.c
> +++ b/hw/intc/arm_gicv3_its_common.c
> @@ -48,7 +48,7 @@ static const VMStateDescription vmstate_its = {
>      .name = "arm_gicv3_its",
>      .pre_save = gicv3_its_pre_save,
>      .post_load = gicv3_its_post_load,
> -    .unmigratable = true,
> +    .priority = MIG_PRI_GICV3_ITS,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(ctlr, GICv3ITSState),
>          VMSTATE_UINT32(iidr, GICv3ITSState),
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 7c5502c..8401d2f 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -77,18 +77,6 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
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
> @@ -105,6 +93,18 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
>  
>      gicv3_its_init_mmio(s, NULL);
>  
> +    if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
> +        GITS_CTLR)) {
> +        error_setg(&s->migration_blocker, "This operating system kernel "
> +                   "does not support vGICv3 migration");
s/vGICv3/vITS
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
> 

Thanks,
-- 
Shannon
