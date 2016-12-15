Received: from eggs.gnu.org ([2001:4830:134:3::10]:54154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHZZ4-0004JD-2V
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:11:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHZZ0-0006nx-Qa
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:11:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHZZ0-0006nA-F8
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:11:26 -0500
Date: Thu, 15 Dec 2016 17:11:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161215171118.GQ2509@work-vm>
References: <1481742422-15969-1-git-send-email-ashijeetacharya@gmail.com>
	<1481742422-15969-4-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481742422-15969-4-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] migration: disallow
 migrate_add_blocker during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

* Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
> If a migration is already in progress and somebody attempts
> to add a migration blocker, this should rightly fail.
> 
> Also, it should fail if the '--only-migratable' option was specified
> and the device in use should not be able to perform the action which
> results in an unmigratable VM.
> 
> Add an errp parameter and a retcode return value to migrate_add_blocker.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---
>  block/qcow.c                  | 11 ++++++++++-
>  block/vdi.c                   | 11 ++++++++++-
>  block/vhdx.c                  | 20 ++++++++++++++------
>  block/vmdk.c                  | 12 +++++++++++-
>  block/vpc.c                   | 15 ++++++++++++---
>  block/vvfat.c                 | 24 ++++++++++++++++--------
>  hw/9pfs/9p.c                  | 22 ++++++++++++++++++----
>  hw/display/virtio-gpu.c       | 35 ++++++++++++++++++++++-------------
>  hw/intc/arm_gic_kvm.c         | 20 ++++++++++++++------
>  hw/intc/arm_gicv3_its_kvm.c   | 21 ++++++++++++++-------
>  hw/intc/arm_gicv3_kvm.c       | 22 +++++++++++++++-------
>  hw/misc/ivshmem.c             | 17 +++++++++++++----
>  hw/scsi/vhost-scsi.c          | 27 +++++++++++++++++++++------
>  hw/virtio/vhost.c             | 11 ++++++++++-
>  include/migration/migration.h |  6 +++++-
>  migration/migration.c         | 42 ++++++++++++++++++++++++++++++++++++++++--
>  stubs/migr-blocker.c          |  3 ++-
>  target-i386/kvm.c             | 19 ++++++++++++++++---
>  18 files changed, 263 insertions(+), 75 deletions(-)
> 
> diff --git a/block/qcow.c b/block/qcow.c
> index 7540f43..7228fc8 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -252,7 +252,16 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>      error_setg(&s->migration_blocker, "The qcow format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    migrate_add_blocker(s->migration_blocker);
> +    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    if (ret) {
> +        if (ret > 0) {
> +            error_setg(errp, "Cannot use a node with qcow format as it does"
> +                       " not support live migration and --only-migratable was "
> +                       "specified");
> +        }
> +
> +        goto fail;
> +    }
>  
>      qemu_co_mutex_init(&s->lock);
>      return 0;
> diff --git a/block/vdi.c b/block/vdi.c
> index 96b78d5..bb25fba 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -471,7 +471,16 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
>      error_setg(&s->migration_blocker, "The vdi format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    migrate_add_blocker(s->migration_blocker);
> +    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    if (ret) {
> +        if (ret > 0) {
> +            error_setg(errp, "Cannot use a node with vdi format as it does"
> +                       " not support live migration and --only-migratable was "
> +                       "specified");
> +        }
> +
> +        goto fail;
> +    }
>  
>      qemu_co_mutex_init(&s->write_lock);
>  
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 0ba2f0a..89c3d54 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -991,6 +991,20 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
>          }
>      }
>  
> +    /* Disable migration when VHDX images are used */
> +    error_setg(&s->migration_blocker, "The vhdx format used by node '%s' "
> +               "does not support live migration",
> +               bdrv_get_device_or_node_name(bs));
> +    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    if (ret) {
> +        if (ret > 0) {
> +            error_setg(errp, "Cannot use a node with vhdx format as it does"
> +                       " not support live migration and --only-migratable was "
> +                       "specified");
> +        }
> +
> +        goto fail;
> +    }
>      if (flags & BDRV_O_RDWR) {
>          ret = vhdx_update_headers(bs, s, false, NULL);
>          if (ret < 0) {
> @@ -1000,12 +1014,6 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
>  
>      /* TODO: differencing files */
>  
> -    /* Disable migration when VHDX images are used */
> -    error_setg(&s->migration_blocker, "The vhdx format used by node '%s' "
> -               "does not support live migration",
> -               bdrv_get_device_or_node_name(bs));
> -    migrate_add_blocker(s->migration_blocker);
> -
>      return 0;
>  fail:
>      vhdx_close(bs);
> diff --git a/block/vmdk.c b/block/vmdk.c
> index a11c27a..ee53aca 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -976,7 +976,17 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
>      error_setg(&s->migration_blocker, "The vmdk format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    migrate_add_blocker(s->migration_blocker);
> +    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    if (ret) {
> +        if (ret > 0) {
> +            error_setg(errp, "Cannot use a node with vmdk format as it does"
> +                       " not support live migration and --only-migratable was "
> +                       "specified");
> +        }
> +
> +        goto fail;
> +    }
> +
>      g_free(buf);
>      return 0;
>  
> diff --git a/block/vpc.c b/block/vpc.c
> index 8d5886f..bb409c3 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -422,13 +422,22 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>  #endif
>      }
>  
> -    qemu_co_mutex_init(&s->lock);
> -
>      /* Disable migration when VHD images are used */
>      error_setg(&s->migration_blocker, "The vpc format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    migrate_add_blocker(s->migration_blocker);
> +    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    if (ret) {
> +        if (ret > 0) {
> +            error_setg(errp, "Cannot use a node with vpc format as it does"
> +                       " not support live migration and --only-migratable was "
> +                       "specified");
> +        }
> +
> +        goto fail;
> +    }
> +
> +    qemu_co_mutex_init(&s->lock);
>  
>      return 0;
>  
> diff --git a/block/vvfat.c b/block/vvfat.c
> index ded2109..9a0b373 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1185,22 +1185,30 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>  
>      s->sector_count = s->faked_sectors + s->sectors_per_cluster*s->cluster_count;
>  
> -    if (s->first_sectors_number == 0x40) {
> -        init_mbr(s, cyls, heads, secs);
> -    }
> -
> -    //    assert(is_consistent(s));
> -    qemu_co_mutex_init(&s->lock);
> -
>      /* Disable migration when vvfat is used rw */
>      if (s->qcow) {
>          error_setg(&s->migration_blocker,
>                     "The vvfat (rw) format used by node '%s' "
>                     "does not support live migration",
>                     bdrv_get_device_or_node_name(bs));
> -        migrate_add_blocker(s->migration_blocker);
> +        ret = migrate_add_blocker(s->migration_blocker, errp);
> +        if (ret) {
> +            if (ret > 0) {
> +                error_setg(errp, "Cannot use a node with vvfat format as it "
> +                           "does not support live migration and "
> +                           "--only-migratable was specified");
> +            }
> +
> +            goto fail;
> +        }
> +    }
> +
> +    if (s->first_sectors_number == 0x40) {
> +        init_mbr(s, cyls, heads, secs);
>      }
>  
> +    qemu_co_mutex_init(&s->lock);
> +
>      ret = 0;
>  fail:
>      qemu_opts_del(opts);
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index faebd91..2cb5d0c 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1013,20 +1013,34 @@ static void coroutine_fn v9fs_attach(void *opaque)
>          goto out;
>      }
>      err += offset;
> -    memcpy(&s->root_qid, &qid, sizeof(qid));
> -    trace_v9fs_attach_return(pdu->tag, pdu->id,
> -                             qid.type, qid.version, qid.path);
> +
>      /*
>       * disable migration if we haven't done already.
>       * attach could get called multiple times for the same export.
>       */
>      if (!s->migration_blocker) {
> +        int ret;
> +        Error *local_err;
>          s->root_fid = fid;
>          error_setg(&s->migration_blocker,
>                     "Migration is disabled when VirtFS export path '%s' is mounted in the guest using mount_tag '%s'",
>                     s->ctx.fs_root ? s->ctx.fs_root : "NULL", s->tag);
> -        migrate_add_blocker(s->migration_blocker);
> +        ret = migrate_add_blocker(s->migration_blocker, &local_err);
> +        if (ret) {
> +            if (ret > 0) {
> +                error_setg(&local_err, "Failed to mount VirtFS as it does not"
> +                           " support live migration and --only-migratable was "
> +                           "specified");
> +            }
> +            err = ret;

I think this is wrong in the case of --only-migratable because it
ends up with err being an invalid errno.

> +            clunk_fid(s, fid);
> +            goto out;
> +        }
>      }
> +
> +    memcpy(&s->root_qid, &qid, sizeof(qid));
> +    trace_v9fs_attach_return(pdu->tag, pdu->id,
> +                             qid.type, qid.version, qid.path);
>  out:
>      put_fid(pdu, fidp);
>  out_nofid:
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5f32e1a..9d0e622 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1102,20 +1102,13 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>      VirtIOGPU *g = VIRTIO_GPU(qdev);
>      bool have_virgl;
>      int i;
> +    int ret;
>  
>      if (g->conf.max_outputs > VIRTIO_GPU_MAX_SCANOUTS) {
>          error_setg(errp, "invalid max_outputs > %d", VIRTIO_GPU_MAX_SCANOUTS);
>          return;
>      }
>  
> -    g->config_size = sizeof(struct virtio_gpu_config);
> -    g->virtio_config.num_scanouts = g->conf.max_outputs;
> -    virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
> -                g->config_size);
> -
> -    g->req_state[0].width = 1024;
> -    g->req_state[0].height = 768;
> -
>      g->use_virgl_renderer = false;
>  #if !defined(CONFIG_VIRGL) || defined(HOST_WORDS_BIGENDIAN)
>      have_virgl = false;
> @@ -1127,6 +1120,27 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>      }
>  
>      if (virtio_gpu_virgl_enabled(g->conf)) {
> +        error_setg(&g->migration_blocker, "virgl is not yet migratable");
> +        ret = migrate_add_blocker(g->migration_blocker, errp);
> +        if (ret) {
> +            if (ret > 0) {
> +                error_setg(errp, "Cannot use virgl as it does not support live"
> +                           " migration yet and --only-migratable was "
> +                           "specified");
> +            }
> +            return;
> +        }
> +    }
> +
> +    g->config_size = sizeof(struct virtio_gpu_config);
> +    g->virtio_config.num_scanouts = g->conf.max_outputs;
> +    virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
> +                g->config_size);
> +
> +    g->req_state[0].width = 1024;
> +    g->req_state[0].height = 768;
> +
> +    if (virtio_gpu_virgl_enabled(g->conf)) {
>          /* use larger control queue in 3d mode */
>          g->ctrl_vq   = virtio_add_queue(vdev, 256, virtio_gpu_handle_ctrl_cb);
>          g->cursor_vq = virtio_add_queue(vdev, 16, virtio_gpu_handle_cursor_cb);
> @@ -1152,11 +1166,6 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>              dpy_gfx_replace_surface(g->scanout[i].con, NULL);
>          }
>      }
> -
> -    if (virtio_gpu_virgl_enabled(g->conf)) {
> -        error_setg(&g->migration_blocker, "virgl is not yet migratable");
> -        migrate_add_blocker(g->migration_blocker);
> -    }
>  }
>  
>  static void virtio_gpu_device_unrealize(DeviceState *qdev, Error **errp)
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index 11729ee..3b9db5a 100644
> --- a/hw/intc/arm_gic_kvm.c
> +++ b/hw/intc/arm_gic_kvm.c
> @@ -510,6 +510,20 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    if (!kvm_arm_gic_can_save_restore(s)) {
> +        error_setg(&s->migration_blocker, "This operating system kernel does "
> +                                          "not support vGICv2 migration");
> +        ret = migrate_add_blocker(s->migration_blocker, errp);
> +        if (ret) {
> +            if (ret > 0) {
> +                error_setg(errp, "Failed to realize vGICv2 as its migration"
> +                           " is not implemented yet and --only-migratable was"
> +                           " specified");
> +        }
> +        return;
> +        }
> +    }
> +
>      gic_init_irqs_and_mmio(s, kvm_arm_gicv2_set_irq, NULL);
>  
>      for (i = 0; i < s->num_irq - GIC_INTERNAL; i++) {
> @@ -558,12 +572,6 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
>                              KVM_VGIC_V2_ADDR_TYPE_CPU,
>                              s->dev_fd);
>  
> -    if (!kvm_arm_gic_can_save_restore(s)) {
> -        error_setg(&s->migration_blocker, "This operating system kernel does "
> -                                          "not support vGICv2 migration");
> -        migrate_add_blocker(s->migration_blocker);
> -    }
> -
>      if (kvm_has_gsi_routing()) {
>          /* set up irq routing */
>          kvm_init_irq_routing(kvm_state);
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index fc246e0..b9ab56b 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -63,6 +63,20 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    /*
> +     * Block migration of a KVM GICv3 ITS device: the API for saving and
> +     * restoring the state in the kernel is not yet available
> +     */
> +    error_setg(&s->migration_blocker, "vITS migration is not implemented");
> +    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    if (ret) {
> +        if (ret > 0) {
> +            error_setg(errp, "Failed to realize vITS as its migration is not "
> +                       "implemented yet and --only-migratable was specified");
> +        }
> +        return;
> +    }
> +
>      /* explicit init of the ITS */
>      kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
>                        KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
> @@ -73,13 +87,6 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
>  
>      gicv3_its_init_mmio(s, NULL);
>  
> -    /*
> -     * Block migration of a KVM GICv3 ITS device: the API for saving and
> -     * restoring the state in the kernel is not yet available
> -     */
> -    error_setg(&s->migration_blocker, "vITS migration is not implemented");
> -    migrate_add_blocker(s->migration_blocker);
> -
>      kvm_msi_use_devid = true;
>      kvm_gsi_direct_mapping = false;
>      kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 199a439..7230015 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -86,6 +86,7 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>      KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
>      Error *local_err = NULL;
>      int i;
> +    int ret;
>  
>      DPRINTF("kvm_arm_gicv3_realize\n");
>  
> @@ -110,6 +111,20 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    /* Block migration of a KVM GICv3 device: the API for saving and restoring
> +     * the state in the kernel is not yet finalised in the kernel or
> +     * implemented in QEMU.
> +     */
> +    error_setg(&s->migration_blocker, "vGICv3 migration is not implemented");
> +    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    if (ret) {
> +        if (ret > 0) {
> +            error_setg(errp, "Failed to realize vGICv3 as its migration is not "
> +                       "implemented yet and --only-migratable was specified");
> +        }
> +        return;
> +    }
> +
>      kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
>                        0, &s->num_irq, true);
>  
> @@ -122,13 +137,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>      kvm_arm_register_device(&s->iomem_redist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
>                              KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd);
>  
> -    /* Block migration of a KVM GICv3 device: the API for saving and restoring
> -     * the state in the kernel is not yet finalised in the kernel or
> -     * implemented in QEMU.
> -     */
> -    error_setg(&s->migration_blocker, "vGICv3 migration is not implemented");
> -    migrate_add_blocker(s->migration_blocker);
> -
>      if (kvm_has_gsi_routing()) {
>          /* set up irq routing */
>          kvm_init_irq_routing(kvm_state);
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index abeaf3d..ab28219 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -837,6 +837,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
>  {
>      IVShmemState *s = IVSHMEM_COMMON(dev);
>      Error *err = NULL;
> +    int ret;
>      uint8_t *pci_conf;
>      uint8_t attr = PCI_BASE_ADDRESS_SPACE_MEMORY |
>          PCI_BASE_ADDRESS_MEM_PREFETCH;
> @@ -903,9 +904,6 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
>          }
>      }
>  
> -    vmstate_register_ram(s->ivshmem_bar2, DEVICE(s));
> -    pci_register_bar(PCI_DEVICE(s), 2, attr, s->ivshmem_bar2);
> -
>      if (s->master == ON_OFF_AUTO_AUTO) {
>          s->master = s->vm_id == 0 ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>      }
> @@ -913,8 +911,19 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
>      if (!ivshmem_is_master(s)) {
>          error_setg(&s->migration_blocker,
>                     "Migration is disabled when using feature 'peer mode' in device 'ivshmem'");
> -        migrate_add_blocker(s->migration_blocker);
> +        ret = migrate_add_blocker(s->migration_blocker, errp);
> +        if (ret) {
> +            if (ret > 0) {
> +                error_setg(errp, "Cannot use the 'peer mode' feature in device"
> +                           " 'ivshmem' since it is not migratable and "
> +                           "--only-migratable was specified");
> +            }
> +            return;
> +        }
>      }
> +
> +    vmstate_register_ram(s->ivshmem_bar2, DEVICE(s));
> +    pci_register_bar(PCI_DEVICE(s), 2, attr, s->ivshmem_bar2);
>  }
>  
>  static void ivshmem_exit(PCIDevice *dev)
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 5b26946..c29a499 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -238,8 +238,18 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>                                 vhost_dummy_handle_output);
>      if (err != NULL) {
>          error_propagate(errp, err);
> -        close(vhostfd);
> -        return;
> +        goto close_fd;
> +    }
> +
> +    error_setg(&s->migration_blocker,
> +               "vhost-scsi does not support migration");
> +    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    if (ret) {
> +        if (ret > 0) {
> +            error_setg(errp, "Cannot use vhost-scsi as it does not support"
> +                       " live migration and --only-migratable was specified");
> +        }
> +        goto close_fd;
>      }
>  
>      s->dev.nvqs = VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
> @@ -252,7 +262,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>      if (ret < 0) {
>          error_setg(errp, "vhost-scsi: vhost initialization failed: %s",
>                     strerror(-ret));
> -        return;
> +        goto free_vqs;
>      }
>  
>      /* At present, channel and lun both are 0 for bootable vhost-scsi disk */
> @@ -261,9 +271,14 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>      /* Note: we can also get the minimum tpgt from kernel */
>      s->target = vs->conf.boot_tpgt;
>  
> -    error_setg(&s->migration_blocker,
> -            "vhost-scsi does not support migration");
> -    migrate_add_blocker(s->migration_blocker);
> +    return;
> +
> + free_vqs:
> +    migrate_del_blocker(s->migration_blocker);
> +    g_free(s->dev.vqs);
> + close_fd:
> +    close(vhostfd);
> +    return;
>  }
>  
>  static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index f7f7023..9eb2e13 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1157,7 +1157,16 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      }
>  
>      if (hdev->migration_blocker != NULL) {
> -        migrate_add_blocker(hdev->migration_blocker);
> +        Error *local_err;
> +        r = migrate_add_blocker(hdev->migration_blocker, &local_err);
> +        if (r) {
> +            if (r > 0) {
> +                error_setg(&local_err, "Cannot use vhost drivers as it does"
> +                           " not support live migration and --only-migratable "
> +                           "was specified");
> +            }
> +            goto fail_busyloop;
> +        }
>      }
>  
>      hdev->mem = g_malloc0(offsetof(struct vhost_memory, regions));
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 40b3697..46a4bb5 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -243,6 +243,7 @@ void remove_migration_state_change_notifier(Notifier *notify);
>  MigrationState *migrate_init(const MigrationParams *params);
>  bool migration_is_blocked(Error **errp);
>  bool migration_in_setup(MigrationState *);
> +bool migration_is_idle(MigrationState *s);
>  bool migration_has_finished(MigrationState *);
>  bool migration_has_failed(MigrationState *);
>  /* True if outgoing migration has entered postcopy phase */
> @@ -287,8 +288,11 @@ int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>   * @migrate_add_blocker - prevent migration from proceeding
>   *
>   * @reason - an error to be returned whenever migration is attempted
> + * @errp - [out] The reason (if any) we cannot block migration right now.
> + *
> + * @returns - 0 on success, -EBUSY on failure, with errp set.
>   */
> -void migrate_add_blocker(Error *reason);
> +int migrate_add_blocker(Error *reason, Error **errp);
>  
>  /**
>   * @migrate_del_blocker - remove a blocking error from migration
> diff --git a/migration/migration.c b/migration/migration.c
> index f498ab8..f5d59e2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1044,6 +1044,31 @@ bool migration_in_postcopy_after_devices(MigrationState *s)
>      return migration_in_postcopy(s) && s->postcopy_after_devices;
>  }
>  
> +bool migration_is_idle(MigrationState *s)
> +{
> +    if (!s) {
> +        s = migrate_get_current();
> +    }
> +
> +    switch (s->state) {
> +    case MIGRATION_STATUS_NONE:
> +    case MIGRATION_STATUS_CANCELLED:
> +    case MIGRATION_STATUS_COMPLETED:
> +    case MIGRATION_STATUS_FAILED:
> +        return true;
> +    case MIGRATION_STATUS_SETUP:
> +    case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_ACTIVE:
> +    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> +    case MIGRATION_STATUS_COLO:
> +        return false;
> +    case MIGRATION_STATUS__MAX:
> +        g_assert_not_reached();
> +    }
> +
> +    return false;
> +}
> +
>  MigrationState *migrate_init(const MigrationParams *params)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -1086,9 +1111,22 @@ MigrationState *migrate_init(const MigrationParams *params)
>  
>  static GSList *migration_blockers;
>  
> -void migrate_add_blocker(Error *reason)
> +int migrate_add_blocker(Error *reason, Error **errp)
>  {
> -    migration_blockers = g_slist_prepend(migration_blockers, reason);
> +    if (migration_is_idle(NULL)) {
> +        migration_blockers = g_slist_prepend(migration_blockers, reason);
> +        error_free(reason);
> +        return 0;
> +    }
> +
> +    if (only_migratable) {
> +        error_setg(errp, "Cannot block migration as --only-migratable was"
> +                   " specified");
> +        return 1;
> +    }
> +
> +    error_setg(errp, "Cannot block a migration already in-progress");
> +    return -EBUSY;
>  }
>  
>  void migrate_del_blocker(Error *reason)
> diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
> index 8ab3604..a5ba18f 100644
> --- a/stubs/migr-blocker.c
> +++ b/stubs/migr-blocker.c
> @@ -2,8 +2,9 @@
>  #include "qemu-common.h"
>  #include "migration/migration.h"
>  
> -void migrate_add_blocker(Error *reason)
> +int migrate_add_blocker(Error *reason, Error **errp)
>  {
> +    return 0;
>  }
>  
>  void migrate_del_blocker(Error *reason)
> diff --git a/target-i386/kvm.c b/target-i386/kvm.c
> index f62264a..134d78c 100644
> --- a/target-i386/kvm.c
> +++ b/target-i386/kvm.c
> @@ -961,7 +961,15 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          error_setg(&invtsc_mig_blocker,
>                     "State blocked by non-migratable CPU device"
>                     " (invtsc flag)");
> -        migrate_add_blocker(invtsc_mig_blocker);
> +        r = migrate_add_blocker(invtsc_mig_blocker, NULL);
> +        if (r) {
> +            if (r > 0) {
> +                fprintf(stderr, "migrate_add_blocker failed because"
> +                        " --only-migratable was specified");
> +            }
> +            fprintf(stderr, "migrate_add_blocker failed\n");

These should be error_report's (and then it should remove the \n off the
second one), and both messages should be similar to the original
error message (i.e. mention non-migratable CPU device).

> +            goto e_fail;
> +        }
>          /* for savevm */
>          vmstate_x86_cpu.unmigratable = 1;
>      }
> @@ -969,12 +977,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      cpuid_data.cpuid.padding = 0;
>      r = kvm_vcpu_ioctl(cs, KVM_SET_CPUID2, &cpuid_data);
>      if (r) {
> -        return r;
> +        goto fail;
>      }
>  
>      r = kvm_arch_set_tsc_khz(cs);
>      if (r < 0) {
> -        return r;
> +        goto fail;
>      }
>  
>      /* vcpu's TSC frequency is either specified by user, or following
> @@ -1001,6 +1009,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      }
>  
>      return 0;
> +
> + fail:
> +    migrate_del_blocker(invtsc_mig_blocker);
> + e_fail:
> +    return r;
>  }
>  
>  void kvm_arch_reset_vcpu(X86CPU *cpu)
> -- 
> 2.6.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
