Received: from eggs.gnu.org ([2001:4830:134:3::10]:36900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cRhgg-00014M-7r
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cRhgZ-0001RX-KV
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:53:14 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cRhgZ-0001RK-B9
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:53:07 -0500
Received: by mail-pf0-x243.google.com with SMTP id f144so4072287pfa.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 07:53:07 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 12 Jan 2017 21:22:33 +0530
Message-Id: <1484236354-9640-4-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1484236354-9640-1-git-send-email-ashijeetacharya@gmail.com>
References: <1484236354-9640-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v5 3/4] migration: disallow migrate_add_blocker
 during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

If a migration is already in progress and somebody attempts
to add a migration blocker, this should rightly fail.

Add an errp parameter and a retcode return value to migrate_add_blocker.

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/qcow.c                  |  7 ++++++-
 block/vdi.c                   |  7 ++++++-
 block/vhdx.c                  | 16 ++++++++++------
 block/vmdk.c                  |  8 +++++++-
 block/vpc.c                   | 10 +++++++---
 block/vvfat.c                 | 20 ++++++++++++--------
 hw/9pfs/9p.c                  | 31 ++++++++++++++++++++-----------
 hw/display/virtio-gpu.c       | 31 ++++++++++++++++++-------------
 hw/intc/arm_gic_kvm.c         | 16 ++++++++++------
 hw/intc/arm_gicv3_its_kvm.c   | 19 ++++++++++++-------
 hw/intc/arm_gicv3_kvm.c       | 18 +++++++++++-------
 hw/misc/ivshmem.c             | 13 +++++++++----
 hw/scsi/vhost-scsi.c          | 24 ++++++++++++++++++------
 hw/virtio/vhost.c             |  7 ++++++-
 include/migration/migration.h |  7 ++++++-
 migration/migration.c         | 38 ++++++++++++++++++++++++++++++++++++--
 stubs/migr-blocker.c          |  3 ++-
 target-i386/kvm.c             | 15 ++++++++++++---
 18 files changed, 208 insertions(+), 82 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 7540f43..90ebe78 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -104,6 +104,7 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     unsigned int len, i, shift;
     int ret;
     QCowHeader header;
+    Error *local_err = NULL;
 
     ret = bdrv_pread(bs->file, 0, &header, sizeof(header));
     if (ret < 0) {
@@ -252,7 +253,11 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The qcow format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    migrate_add_blocker(s->migration_blocker);
+    ret = migrate_add_blocker(s->migration_blocker, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto fail;
+    }
 
     qemu_co_mutex_init(&s->lock);
     return 0;
diff --git a/block/vdi.c b/block/vdi.c
index 96b78d5..2cb8ef0 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -361,6 +361,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     VdiHeader header;
     size_t bmap_size;
     int ret;
+    Error *local_err = NULL;
 
     logout("\n");
 
@@ -471,7 +472,11 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The vdi format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    migrate_add_blocker(s->migration_blocker);
+    ret = migrate_add_blocker(s->migration_blocker, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto fail_free_bmap;
+    }
 
     qemu_co_mutex_init(&s->write_lock);
 
diff --git a/block/vhdx.c b/block/vhdx.c
index 0ba2f0a..77ced7c 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -991,6 +991,16 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
+    /* Disable migration when VHDX images are used */
+    error_setg(&s->migration_blocker, "The vhdx format used by node '%s' "
+               "does not support live migration",
+               bdrv_get_device_or_node_name(bs));
+    ret = migrate_add_blocker(s->migration_blocker, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+
     if (flags & BDRV_O_RDWR) {
         ret = vhdx_update_headers(bs, s, false, NULL);
         if (ret < 0) {
@@ -1000,12 +1010,6 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* TODO: differencing files */
 
-    /* Disable migration when VHDX images are used */
-    error_setg(&s->migration_blocker, "The vhdx format used by node '%s' "
-               "does not support live migration",
-               bdrv_get_device_or_node_name(bs));
-    migrate_add_blocker(s->migration_blocker);
-
     return 0;
 fail:
     vhdx_close(bs);
diff --git a/block/vmdk.c b/block/vmdk.c
index a11c27a..f1d75ae 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -941,6 +941,7 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
     BDRVVmdkState *s = bs->opaque;
     uint32_t magic;
+    Error *local_err = NULL;
 
     buf = vmdk_read_desc(bs->file, 0, errp);
     if (!buf) {
@@ -976,7 +977,12 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The vmdk format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    migrate_add_blocker(s->migration_blocker);
+    ret = migrate_add_blocker(s->migration_blocker, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+
     g_free(buf);
     return 0;
 
diff --git a/block/vpc.c b/block/vpc.c
index 8d5886f..37031fa 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -422,13 +422,17 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
 #endif
     }
 
-    qemu_co_mutex_init(&s->lock);
-
     /* Disable migration when VHD images are used */
     error_setg(&s->migration_blocker, "The vpc format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    migrate_add_blocker(s->migration_blocker);
+    ret = migrate_add_blocker(s->migration_blocker, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+
+    qemu_co_mutex_init(&s->lock);
 
     return 0;
 
diff --git a/block/vvfat.c b/block/vvfat.c
index ded2109..d061d25 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1185,22 +1185,26 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->sector_count = s->faked_sectors + s->sectors_per_cluster*s->cluster_count;
 
-    if (s->first_sectors_number == 0x40) {
-        init_mbr(s, cyls, heads, secs);
-    }
-
-    //    assert(is_consistent(s));
-    qemu_co_mutex_init(&s->lock);
-
     /* Disable migration when vvfat is used rw */
     if (s->qcow) {
         error_setg(&s->migration_blocker,
                    "The vvfat (rw) format used by node '%s' "
                    "does not support live migration",
                    bdrv_get_device_or_node_name(bs));
-        migrate_add_blocker(s->migration_blocker);
+        ret = migrate_add_blocker(s->migration_blocker, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            goto fail;
+        }
+    }
+
+    if (s->first_sectors_number == 0x40) {
+        init_mbr(s, cyls, heads, secs);
     }
 
+    //    assert(is_consistent(s));
+    qemu_co_mutex_init(&s->lock);
+
     ret = 0;
 fail:
     qemu_opts_del(opts);
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index faebd91..9bb749c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -979,6 +979,7 @@ static void coroutine_fn v9fs_attach(void *opaque)
     size_t offset = 7;
     V9fsQID qid;
     ssize_t err;
+    Error *local_err;
 
     v9fs_string_init(&uname);
     v9fs_string_init(&aname);
@@ -1007,26 +1008,34 @@ static void coroutine_fn v9fs_attach(void *opaque)
         clunk_fid(s, fid);
         goto out;
     }
-    err = pdu_marshal(pdu, offset, "Q", &qid);
-    if (err < 0) {
-        clunk_fid(s, fid);
-        goto out;
-    }
-    err += offset;
-    memcpy(&s->root_qid, &qid, sizeof(qid));
-    trace_v9fs_attach_return(pdu->tag, pdu->id,
-                             qid.type, qid.version, qid.path);
+
     /*
      * disable migration if we haven't done already.
      * attach could get called multiple times for the same export.
      */
     if (!s->migration_blocker) {
-        s->root_fid = fid;
         error_setg(&s->migration_blocker,
                    "Migration is disabled when VirtFS export path '%s' is mounted in the guest using mount_tag '%s'",
                    s->ctx.fs_root ? s->ctx.fs_root : "NULL", s->tag);
-        migrate_add_blocker(s->migration_blocker);
+        err = migrate_add_blocker(s->migration_blocker, &local_err);
+        if (local_err) {
+            s->migration_blocker = NULL;
+            clunk_fid(s, fid);
+            goto out;
+        }
+        s->root_fid = fid;
+    }
+
+    err = pdu_marshal(pdu, offset, "Q", &qid);
+    if (err < 0) {
+        clunk_fid(s, fid);
+        goto out;
     }
+    err += offset;
+
+    memcpy(&s->root_qid, &qid, sizeof(qid));
+    trace_v9fs_attach_return(pdu->tag, pdu->id,
+                             qid.type, qid.version, qid.path);
 out:
     put_fid(pdu, fidp);
 out_nofid:
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5f32e1a..503b23e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1101,6 +1101,7 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(qdev);
     VirtIOGPU *g = VIRTIO_GPU(qdev);
     bool have_virgl;
+    Error *local_err = NULL;
     int i;
 
     if (g->conf.max_outputs > VIRTIO_GPU_MAX_SCANOUTS) {
@@ -1108,14 +1109,6 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
         return;
     }
 
-    g->config_size = sizeof(struct virtio_gpu_config);
-    g->virtio_config.num_scanouts = g->conf.max_outputs;
-    virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
-                g->config_size);
-
-    g->req_state[0].width = 1024;
-    g->req_state[0].height = 768;
-
     g->use_virgl_renderer = false;
 #if !defined(CONFIG_VIRGL) || defined(HOST_WORDS_BIGENDIAN)
     have_virgl = false;
@@ -1127,6 +1120,23 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     }
 
     if (virtio_gpu_virgl_enabled(g->conf)) {
+        error_setg(&g->migration_blocker, "virgl is not yet migratable");
+        migrate_add_blocker(g->migration_blocker, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
+    g->config_size = sizeof(struct virtio_gpu_config);
+    g->virtio_config.num_scanouts = g->conf.max_outputs;
+    virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
+                g->config_size);
+
+    g->req_state[0].width = 1024;
+    g->req_state[0].height = 768;
+
+    if (virtio_gpu_virgl_enabled(g->conf)) {
         /* use larger control queue in 3d mode */
         g->ctrl_vq   = virtio_add_queue(vdev, 256, virtio_gpu_handle_ctrl_cb);
         g->cursor_vq = virtio_add_queue(vdev, 16, virtio_gpu_handle_cursor_cb);
@@ -1152,11 +1162,6 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
             dpy_gfx_replace_surface(g->scanout[i].con, NULL);
         }
     }
-
-    if (virtio_gpu_virgl_enabled(g->conf)) {
-        error_setg(&g->migration_blocker, "virgl is not yet migratable");
-        migrate_add_blocker(g->migration_blocker);
-    }
 }
 
 static void virtio_gpu_device_unrealize(DeviceState *qdev, Error **errp)
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index 11729ee..9c33af9 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -510,6 +510,16 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!kvm_arm_gic_can_save_restore(s)) {
+        error_setg(&s->migration_blocker, "This operating system kernel does "
+                                          "not support vGICv2 migration");
+        migrate_add_blocker(s->migration_blocker, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
     gic_init_irqs_and_mmio(s, kvm_arm_gicv2_set_irq, NULL);
 
     for (i = 0; i < s->num_irq - GIC_INTERNAL; i++) {
@@ -558,12 +568,6 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
                             KVM_VGIC_V2_ADDR_TYPE_CPU,
                             s->dev_fd);
 
-    if (!kvm_arm_gic_can_save_restore(s)) {
-        error_setg(&s->migration_blocker, "This operating system kernel does "
-                                          "not support vGICv2 migration");
-        migrate_add_blocker(s->migration_blocker);
-    }
-
     if (kvm_has_gsi_routing()) {
         /* set up irq routing */
         kvm_init_irq_routing(kvm_state);
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index fc246e0..a20cace 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -56,6 +56,18 @@ static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t devid)
 static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 {
     GICv3ITSState *s = ARM_GICV3_ITS_COMMON(dev);
+    Error *local_err;
+
+    /*
+     * Block migration of a KVM GICv3 ITS device: the API for saving and
+     * restoring the state in the kernel is not yet available
+     */
+    error_setg(&s->migration_blocker, "vITS migration is not implemented");
+    migrate_add_blocker(s->migration_blocker, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     s->dev_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_ARM_VGIC_ITS, false);
     if (s->dev_fd < 0) {
@@ -73,13 +85,6 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 
     gicv3_its_init_mmio(s, NULL);
 
-    /*
-     * Block migration of a KVM GICv3 ITS device: the API for saving and
-     * restoring the state in the kernel is not yet available
-     */
-    error_setg(&s->migration_blocker, "vITS migration is not implemented");
-    migrate_add_blocker(s->migration_blocker);
-
     kvm_msi_use_devid = true;
     kvm_gsi_direct_mapping = false;
     kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 199a439..a4cfebb 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -103,6 +103,17 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 
     gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
 
+    /* Block migration of a KVM GICv3 device: the API for saving and restoring
+     * the state in the kernel is not yet finalised in the kernel or
+     * implemented in QEMU.
+     */
+    error_setg(&s->migration_blocker, "vGICv3 migration is not implemented");
+    migrate_add_blocker(s->migration_blocker, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     /* Try to create the device via the device control API */
     s->dev_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_ARM_VGIC_V3, false);
     if (s->dev_fd < 0) {
@@ -122,13 +133,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     kvm_arm_register_device(&s->iomem_redist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
                             KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd);
 
-    /* Block migration of a KVM GICv3 device: the API for saving and restoring
-     * the state in the kernel is not yet finalised in the kernel or
-     * implemented in QEMU.
-     */
-    error_setg(&s->migration_blocker, "vGICv3 migration is not implemented");
-    migrate_add_blocker(s->migration_blocker);
-
     if (kvm_has_gsi_routing()) {
         /* set up irq routing */
         kvm_init_irq_routing(kvm_state);
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index abeaf3d..64283da 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -840,6 +840,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
     uint8_t *pci_conf;
     uint8_t attr = PCI_BASE_ADDRESS_SPACE_MEMORY |
         PCI_BASE_ADDRESS_MEM_PREFETCH;
+    Error *local_err = NULL;
 
     /* IRQFD requires MSI */
     if (ivshmem_has_feature(s, IVSHMEM_IOEVENTFD) &&
@@ -903,9 +904,6 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
         }
     }
 
-    vmstate_register_ram(s->ivshmem_bar2, DEVICE(s));
-    pci_register_bar(PCI_DEVICE(s), 2, attr, s->ivshmem_bar2);
-
     if (s->master == ON_OFF_AUTO_AUTO) {
         s->master = s->vm_id == 0 ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
@@ -913,8 +911,15 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
     if (!ivshmem_is_master(s)) {
         error_setg(&s->migration_blocker,
                    "Migration is disabled when using feature 'peer mode' in device 'ivshmem'");
-        migrate_add_blocker(s->migration_blocker);
+        migrate_add_blocker(s->migration_blocker, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
+
+    vmstate_register_ram(s->ivshmem_bar2, DEVICE(s));
+    pci_register_bar(PCI_DEVICE(s), 2, attr, s->ivshmem_bar2);
 }
 
 static void ivshmem_exit(PCIDevice *dev)
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 5b26946..0d3ad47 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -238,8 +238,15 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
                                vhost_dummy_handle_output);
     if (err != NULL) {
         error_propagate(errp, err);
-        close(vhostfd);
-        return;
+        goto close_fd;
+    }
+
+    error_setg(&s->migration_blocker,
+               "vhost-scsi does not support migration");
+    migrate_add_blocker(s->migration_blocker, &err);
+    if (err) {
+        error_propagate(errp, err);
+        goto close_fd;
     }
 
     s->dev.nvqs = VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
@@ -252,7 +259,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     if (ret < 0) {
         error_setg(errp, "vhost-scsi: vhost initialization failed: %s",
                    strerror(-ret));
-        return;
+        goto free_vqs;
     }
 
     /* At present, channel and lun both are 0 for bootable vhost-scsi disk */
@@ -261,9 +268,14 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     /* Note: we can also get the minimum tpgt from kernel */
     s->target = vs->conf.boot_tpgt;
 
-    error_setg(&s->migration_blocker,
-            "vhost-scsi does not support migration");
-    migrate_add_blocker(s->migration_blocker);
+    return;
+
+ free_vqs:
+    migrate_del_blocker(s->migration_blocker);
+    g_free(s->dev.vqs);
+ close_fd:
+    close(vhostfd);
+    return;
 }
 
 static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f7f7023..6ad0e02 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1081,6 +1081,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 {
     uint64_t features;
     int i, r, n_initialized_vqs = 0;
+    Error *local_err = NULL;
 
     hdev->migration_blocker = NULL;
 
@@ -1157,7 +1158,11 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     }
 
     if (hdev->migration_blocker != NULL) {
-        migrate_add_blocker(hdev->migration_blocker);
+        r = migrate_add_blocker(hdev->migration_blocker, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            goto fail_busyloop;
+        }
     }
 
     hdev->mem = g_malloc0(offsetof(struct vhost_memory, regions));
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 40b3697..bcbdb03 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -243,6 +243,7 @@ void remove_migration_state_change_notifier(Notifier *notify);
 MigrationState *migrate_init(const MigrationParams *params);
 bool migration_is_blocked(Error **errp);
 bool migration_in_setup(MigrationState *);
+bool migration_is_idle(MigrationState *s);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 /* True if outgoing migration has entered postcopy phase */
@@ -287,8 +288,12 @@ int ram_postcopy_incoming_init(MigrationIncomingState *mis);
  * @migrate_add_blocker - prevent migration from proceeding
  *
  * @reason - an error to be returned whenever migration is attempted
+ *
+ * @errp - [out] The reason (if any) we cannot block migration right now.
+ *
+ * @returns - 0 on success, -EBUSY on failure, with errp set.
  */
-void migrate_add_blocker(Error *reason);
+int migrate_add_blocker(Error *reason, Error **errp);
 
 /**
  * @migrate_del_blocker - remove a blocking error from migration
diff --git a/migration/migration.c b/migration/migration.c
index f498ab8..cca820e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1044,6 +1044,31 @@ bool migration_in_postcopy_after_devices(MigrationState *s)
     return migration_in_postcopy(s) && s->postcopy_after_devices;
 }
 
+bool migration_is_idle(MigrationState *s)
+{
+    if (!s) {
+        s = migrate_get_current();
+    }
+
+    switch (s->state) {
+    case MIGRATION_STATUS_NONE:
+    case MIGRATION_STATUS_CANCELLED:
+    case MIGRATION_STATUS_COMPLETED:
+    case MIGRATION_STATUS_FAILED:
+        return true;
+    case MIGRATION_STATUS_SETUP:
+    case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_COLO:
+        return false;
+    case MIGRATION_STATUS__MAX:
+        g_assert_not_reached();
+    }
+
+    return false;
+}
+
 MigrationState *migrate_init(const MigrationParams *params)
 {
     MigrationState *s = migrate_get_current();
@@ -1086,9 +1111,18 @@ MigrationState *migrate_init(const MigrationParams *params)
 
 static GSList *migration_blockers;
 
-void migrate_add_blocker(Error *reason)
+int migrate_add_blocker(Error *reason, Error **errp)
 {
-    migration_blockers = g_slist_prepend(migration_blockers, reason);
+    if (migration_is_idle(NULL)) {
+        migration_blockers = g_slist_prepend(migration_blockers, reason);
+        return 0;
+    }
+
+    error_propagate(errp, reason);
+    error_prepend(errp, "disallowing migration blocker (migration in "
+                      "progress) for: ");
+    error_free(reason);
+    return -EBUSY;
 }
 
 void migrate_del_blocker(Error *reason)
diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
index 8ab3604..a5ba18f 100644
--- a/stubs/migr-blocker.c
+++ b/stubs/migr-blocker.c
@@ -2,8 +2,9 @@
 #include "qemu-common.h"
 #include "migration/migration.h"
 
-void migrate_add_blocker(Error *reason)
+int migrate_add_blocker(Error *reason, Error **errp)
 {
+    return 0;
 }
 
 void migrate_del_blocker(Error *reason)
diff --git a/target-i386/kvm.c b/target-i386/kvm.c
index f62264a..b55092d 100644
--- a/target-i386/kvm.c
+++ b/target-i386/kvm.c
@@ -702,6 +702,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     uint32_t signature[3];
     int kvm_base = KVM_CPUID_SIGNATURE;
     int r;
+    Error *local_err;
 
     memset(&cpuid_data, 0, sizeof(cpuid_data));
 
@@ -961,7 +962,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
         error_setg(&invtsc_mig_blocker,
                    "State blocked by non-migratable CPU device"
                    " (invtsc flag)");
-        migrate_add_blocker(invtsc_mig_blocker);
+        r = migrate_add_blocker(invtsc_mig_blocker, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            goto fail;
+        }
         /* for savevm */
         vmstate_x86_cpu.unmigratable = 1;
     }
@@ -969,12 +974,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
     cpuid_data.cpuid.padding = 0;
     r = kvm_vcpu_ioctl(cs, KVM_SET_CPUID2, &cpuid_data);
     if (r) {
-        return r;
+        goto fail;
     }
 
     r = kvm_arch_set_tsc_khz(cs);
     if (r < 0) {
-        return r;
+        goto fail;
     }
 
     /* vcpu's TSC frequency is either specified by user, or following
@@ -1001,6 +1006,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     return 0;
+
+ fail:
+    migrate_del_blocker(invtsc_mig_blocker);
+    return r;
 }
 
 void kvm_arch_reset_vcpu(X86CPU *cpu)
-- 
2.6.2
