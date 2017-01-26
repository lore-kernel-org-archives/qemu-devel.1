Received: from eggs.gnu.org ([2001:4830:134:3::10]:43135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWgxI-0003B4-T4
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:07:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWgxH-0001ng-VY
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:07:00 -0500
Date: Thu, 26 Jan 2017 10:06:44 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170126100643.GD2083@work-vm>
References: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
	<1485422381-29019-5-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485422381-29019-5-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [RFC 4/4] hw/intc/arm_gicv3_its: Allow save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, shannon.zhao@linaro.org, christoffer.dall@linaro.org, drjones@redhat.com, vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, peterx@redhat.com, quintela@redhat.com

* Eric Auger (eric.auger@redhat.com) wrote:
> We change the restoration priority of both the GICv3 and ITS. The
> GICv3 must be restored before the ITS and the ITS needs to be restored
> before PCIe devices since it translates their MSI transactions.
> 
> We typically observe the virtio-pci-net device sending MSI transactions
> very early (even before the first vcpu run) which looks weird. It
> appears that not servicing those transactions cause the virtio-pci-net
> to stall.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

<snip>

> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 3f8017d..7f81d33 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -95,8 +95,12 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
>       * Block migration of a KVM GICv3 ITS device: the API for saving and
>       * restoring the state in the kernel is not yet available
>       */
> -    error_setg(&s->migration_blocker, "vITS migration is not implemented");
> -    migrate_add_blocker(s->migration_blocker);
> +    if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
> +                               GITS_CTLR)) {
> +        error_setg(&s->migration_blocker, "This operating system kernel does "
> +                                          "not support vITS migration");
> +        migrate_add_blocker(s->migration_blocker);
> +    }

Watch out, a change went in to the parameters/return value of migrate_add_blocker
earlier in the week - it can now fail.

>      kvm_msi_use_devid = true;
>      kvm_gsi_direct_mapping = false;
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1a22887..ebd755c 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -188,6 +188,8 @@ enum VMStateFlags {
>  
>  typedef enum {
>      MIG_PRI_DEFAULT = 0,
> +    MIG_PRI_GICV3_ITS,
> +    MIG_PRI_GICV3,
>      MIG_PRI_MAX,

Can we keep this commented so it's trivially easy to see the order, something like:

 typedef enum {
     MIG_PRI_DEFAULT = 0,
+    MIG_PRI_GICV3_ITS,    /* Needs to be before PCI devices */
+    MIG_PRI_GICV3,        /* Must be before ITS */
     MIG_PRI_MAX,
 } MigrationPriority;

Dave

>  
> -- 
> 2.5.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
