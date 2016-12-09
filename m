Received: from eggs.gnu.org ([2001:4830:134:3::10]:36951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cFOvx-00018R-Ln
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cFOvv-0001LE-Db
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:26:09 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  9 Dec 2016 12:25:47 -0500
Message-Id: <20161209172547.31550-2-jsnow@redhat.com>
In-Reply-To: <20161209172547.31550-1-jsnow@redhat.com>
References: <20161209172547.31550-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/1] migration: disallow migrate_add_blocker
 during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mst@redhat.com, jcody@redhat.com, quintela@redhat.com, armbru@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, ashijeetacharya@gmail.com, pbonzini@redhat.com, amit.shah@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, John Snow <jsnow@redhat.com>

If a migration is already in progress and somebody attempts
to add a migration blocker, this should rightly fail.

Add an errp parameter and a retcode return value to migrate_add_blocker.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow.c                  |  6 +++++-
 block/vdi.c                   |  6 +++++-
 block/vhdx.c                  | 24 ++++++++++++++----------
 block/vmdk.c                  |  7 ++++++-
 block/vpc.c                   | 10 +++++++---
 block/vvfat.c                 | 20 ++++++++++++--------
 hw/9pfs/9p.c                  | 16 ++++++++++++----
 hw/display/virtio-gpu.c       | 29 ++++++++++++++++-------------
 hw/misc/ivshmem.c             | 11 +++++++----
 hw/scsi/vhost-scsi.c          | 25 +++++++++++++++++++------
 hw/virtio/vhost.c             |  8 +++++++-
 include/migration/migration.h |  6 +++++-
 migration/migration.c         | 35 +++++++++++++++++++++++++++++++++--
 stubs/migr-blocker.c          |  3 ++-
 target-i386/kvm.c             | 16 +++++++++++++---
 15 files changed, 163 insertions(+), 59 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 7540f43..11526a1 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -252,7 +252,11 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The qcow format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    migrate_add_blocker(s->migration_blocker);
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
+        error_free(s->migration_blocker);
+        goto fail;
+    }
 
     qemu_co_mutex_init(&s->lock);
     return 0;
diff --git a/block/vdi.c b/block/vdi.c
index 96b78d5..2b56f52 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -471,7 +471,11 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The vdi format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    migrate_add_blocker(s->migration_blocker);
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
+        error_free(s->migration_blocker);
+        goto fail_free_bmap;
+    }
 
     qemu_co_mutex_init(&s->write_lock);
 
diff --git a/block/vhdx.c b/block/vhdx.c
index 0ba2f0a..d81941b 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -991,20 +991,24 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    if (flags & BDRV_O_RDWR) {
-        ret = vhdx_update_headers(bs, s, false, NULL);
-        if (ret < 0) {
-            goto fail;
-        }
-    }
-
-    /* TODO: differencing files */
-
     /* Disable migration when VHDX images are used */
     error_setg(&s->migration_blocker, "The vhdx format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    migrate_add_blocker(s->migration_blocker);
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
+        error_free(s->migration_blocker);
+        goto fail;
+    }
+
+    if (flags & BDRV_O_RDWR) {
+        ret = vhdx_update_headers(bs, s, false, NULL);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
+    /* TODO: differencing files */
 
     return 0;
 fail:
diff --git a/block/vmdk.c b/block/vmdk.c
index a11c27a..4a45a83 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -976,7 +976,12 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The vmdk format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    migrate_add_blocker(s->migration_blocker);
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
+        error_free(s->migration_blocker);
+        goto fail;
+    }
+
     g_free(buf);
     return 0;
 
diff --git a/block/vpc.c b/block/vpc.c
index 8d5886f..299a8c8 100644
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
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
+        error_free(s->migration_blocker);
+        goto fail;
+    }
+
+    qemu_co_mutex_init(&s->lock);
 
     return 0;
 
diff --git a/block/vvfat.c b/block/vvfat.c
index ded2109..3de3320 100644
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
+        ret = migrate_add_blocker(s->migration_blocker, errp);
+        if (ret < 0) {
+            error_free(s->migration_blocker);
+            goto fail;
+        }
     }
 
+    if (s->first_sectors_number == 0x40) {
+        init_mbr(s, cyls, heads, secs);
+    }
+
+    //    assert(is_consistent(s));
+    qemu_co_mutex_init(&s->lock);
+
     ret = 0;
 fail:
     qemu_opts_del(opts);
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index faebd91..e72ef43 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1013,20 +1013,28 @@ static void coroutine_fn v9fs_attach(void *opaque)
         goto out;
     }
     err += offset;
-    memcpy(&s->root_qid, &qid, sizeof(qid));
-    trace_v9fs_attach_return(pdu->tag, pdu->id,
-                             qid.type, qid.version, qid.path);
+
     /*
      * disable migration if we haven't done already.
      * attach could get called multiple times for the same export.
      */
     if (!s->migration_blocker) {
+        int ret;
         s->root_fid = fid;
         error_setg(&s->migration_blocker,
                    "Migration is disabled when VirtFS export path '%s' is mounted in the guest using mount_tag '%s'",
                    s->ctx.fs_root ? s->ctx.fs_root : "NULL", s->tag);
-        migrate_add_blocker(s->migration_blocker);
+        ret = migrate_add_blocker(s->migration_blocker, NULL);
+        if (ret < 0) {
+            err = ret;
+            clunk_fid(s, fid);
+            goto out;
+        }
     }
+
+    memcpy(&s->root_qid, &qid, sizeof(qid));
+    trace_v9fs_attach_return(pdu->tag, pdu->id,
+                             qid.type, qid.version, qid.path);
 out:
     put_fid(pdu, fidp);
 out_nofid:
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5f32e1a..6e60b8c 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1108,14 +1108,6 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
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
@@ -1127,6 +1119,22 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     }
 
     if (virtio_gpu_virgl_enabled(g->conf)) {
+        error_setg(&g->migration_blocker, "virgl is not yet migratable");
+        if (migrate_add_blocker(g->migration_blocker, errp) < 0) {
+            error_free(g->migration_blocker);
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
@@ -1152,11 +1160,6 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
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
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index abeaf3d..585cc5b 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -903,9 +903,6 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
         }
     }
 
-    vmstate_register_ram(s->ivshmem_bar2, DEVICE(s));
-    pci_register_bar(PCI_DEVICE(s), 2, attr, s->ivshmem_bar2);
-
     if (s->master == ON_OFF_AUTO_AUTO) {
         s->master = s->vm_id == 0 ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
@@ -913,8 +910,14 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
     if (!ivshmem_is_master(s)) {
         error_setg(&s->migration_blocker,
                    "Migration is disabled when using feature 'peer mode' in device 'ivshmem'");
-        migrate_add_blocker(s->migration_blocker);
+        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
+            error_free(s->migration_blocker);
+            return;
+        }
     }
+
+    vmstate_register_ram(s->ivshmem_bar2, DEVICE(s));
+    pci_register_bar(PCI_DEVICE(s), 2, attr, s->ivshmem_bar2);
 }
 
 static void ivshmem_exit(PCIDevice *dev)
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 5b26946..ff503d0 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -238,8 +238,14 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
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
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
+        goto free_blocker;
     }
 
     s->dev.nvqs = VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
@@ -252,7 +258,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     if (ret < 0) {
         error_setg(errp, "vhost-scsi: vhost initialization failed: %s",
                    strerror(-ret));
-        return;
+        goto free_vqs;
     }
 
     /* At present, channel and lun both are 0 for bootable vhost-scsi disk */
@@ -261,9 +267,16 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
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
+ free_blocker:
+    error_free(s->migration_blocker);
+ close_fd:
+    close(vhostfd);
+    return;
 }
 
 static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f7f7023..416fada 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1157,7 +1157,13 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     }
 
     if (hdev->migration_blocker != NULL) {
-        migrate_add_blocker(hdev->migration_blocker);
+        Error *local_err;
+        r = migrate_add_blocker(hdev->migration_blocker, &local_err);
+        if (r < 0) {
+            error_report_err(local_err);
+            error_free(hdev->migration_blocker);
+            goto fail_busyloop;
+        }
     }
 
     hdev->mem = g_malloc0(offsetof(struct vhost_memory, regions));
diff --git a/include/migration/migration.h b/include/migration/migration.h
index c309d23..8a91215 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -240,6 +240,7 @@ void remove_migration_state_change_notifier(Notifier *notify);
 MigrationState *migrate_init(const MigrationParams *params);
 bool migration_is_blocked(Error **errp);
 bool migration_in_setup(MigrationState *);
+bool migration_is_idle(MigrationState *s);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 /* True if outgoing migration has entered postcopy phase */
@@ -284,8 +285,11 @@ int ram_postcopy_incoming_init(MigrationIncomingState *mis);
  * @migrate_add_blocker - prevent migration from proceeding
  *
  * @reason - an error to be returned whenever migration is attempted
+ * @errp - [out] The reason (if any) we cannot block migration right now.
+ *
+ * @returns - 0 on success, -EBUSY on failure, with errp set.
  */
-void migrate_add_blocker(Error *reason);
+int migrate_add_blocker(Error *reason, Error **errp);
 
 /**
  * @migrate_del_blocker - remove a blocking error from migration
diff --git a/migration/migration.c b/migration/migration.c
index f498ab8..713e012 100644
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
@@ -1086,9 +1111,15 @@ MigrationState *migrate_init(const MigrationParams *params)
 
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
+    error_setg(errp, "Cannot block a migration already in-progress");
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
index f62264a..8abb54d 100644
--- a/target-i386/kvm.c
+++ b/target-i386/kvm.c
@@ -961,7 +961,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
         error_setg(&invtsc_mig_blocker,
                    "State blocked by non-migratable CPU device"
                    " (invtsc flag)");
-        migrate_add_blocker(invtsc_mig_blocker);
+        r = migrate_add_blocker(invtsc_mig_blocker, NULL);
+        if (r < 0) {
+            fprintf(stderr, "migrate_add_blocker failed\n");
+            goto efail;
+        }
         /* for savevm */
         vmstate_x86_cpu.unmigratable = 1;
     }
@@ -969,12 +973,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
@@ -1001,6 +1005,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     return 0;
+
+ fail:
+    migrate_del_blocker(invtsc_mig_blocker);
+ efail:
+    error_free(invtsc_mig_blocker);
+    return r;
 }
 
 void kvm_arch_reset_vcpu(X86CPU *cpu)
-- 
2.9.3
