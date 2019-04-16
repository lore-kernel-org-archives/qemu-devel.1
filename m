Received: from eggs.gnu.org ([209.51.188.92]:35817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNic-0007pQ-Og
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNia-0003WY-Tq
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:01:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hGNiY-0003VZ-Vh
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:01:43 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Tue, 16 Apr 2019 15:59:12 +0300
Message-Id: <20190416125912.44001-4-liran.alon@oracle.com>
In-Reply-To: <20190416125912.44001-1-liran.alon@oracle.com>
References: <20190416125912.44001-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/3] vhost-scsi: Allow user to enable
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, stefanha@gmail.com, nir.weiner@oracle.com, bijan.mottahedeh@oracle.com, Liran Alon <liran.alon@oracle.com>

In order to perform a valid migration of a vhost-scsi device,
the following requirements must be met:
(1) The virtio-scsi device state needs to be saved & loaded.
(2) The vhost backend must be stopped before virtio-scsi device state
is saved:
  (2.1) Sync vhost backend state to virtio-scsi device state.
  (2.2) No further I/O requests are made by vhost backend to target
        SCSI device.
  (2.3) No further guest memory access takes place after VM is stopped.
(3) Requests in-flight to target SCSI device are completed before
    migration handover.
(4) Target SCSI device state needs to be saved & loaded into the
    destination host target SCSI device.

Previous commit ("vhost-scsi: Add VMState descriptor")
add support to save & load the device state using VMState.
This meets requirement (1).

When VM is stopped by migration thread (On Pre-Copy complete), the
following code path is executed:
migration_completion() -> vm_stop_force_state() -> vm_stop() ->
do_vm_stop().

do_vm_stop() calls first pause_all_vcpus() which pause all guest
vCPUs and then call vm_state_notify().
In case of vhost-scsi device, this will lead to the following code path
to be executed:
vm_state_notify() -> virtio_vmstate_change() ->
virtio_set_status() -> vhost_scsi_set_status() -> vhost_scsi_stop().
vhost_scsi_stop() then calls vhost_scsi_clear_endpoint() and
vhost_scsi_common_stop().

vhost_scsi_clear_endpoint() sends VHOST_SCSI_CLEAR_ENDPOINT ioctl to
vhost backend which will reach kernel's vhost_scsi_clear_endpoint()
which process all pending I/O requests and wait for them to complete
(vhost_scsi_flush()). This meets requirement (3).

vhost_scsi_common_stop() will stop the vhost backend.
As part of this stop, dirty-bitmap is synced and vhost backend state is
synced with virtio-scsi device state. As at this point guest vCPUs are
already paused, this meets requirement (2).

At this point we are left with requirement (4) which is target SCSI
device specific and therefore cannot be done by QEMU. Which is the main
reason why vhost-scsi adds a migration blocker.
However, as this can be handled either by an external orchestrator or
by using shared-storage (i.e. iSCSI), there is no reason to limit the
orchestrator from being able to explictly specify it wish to enable
migration even when VM have a vhost-scsi device.

Considering all the above, this commit allows orchestrator to explictly
specify that it is responsbile for taking care of requirement (4) and
therefore vhost-scsi should not add a migration blocker.

Reviewed-by: Nir Weiner <nir.weiner@oracle.com>
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/scsi/vhost-scsi.c                  | 30 ++++++++++++++++++---------
 include/hw/virtio/vhost-scsi-common.h |  1 +
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index eb0cf9e1312f..6b01accf61ad 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -199,13 +199,18 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         goto close_fd;
     }
 
-    error_setg(&vsc->migration_blocker,
-               "vhost-scsi does not support migration");
-    migrate_add_blocker(vsc->migration_blocker, &err);
-    if (err) {
-        error_propagate(errp, err);
-        error_free(vsc->migration_blocker);
-        goto close_fd;
+    if (!vsc->migratable) {
+        error_setg(&vsc->migration_blocker,
+                "vhost-scsi does not support migration in all cases. "
+                "When external environment supports it (Orchestrator migrates "
+                "target SCSI device state or use shared storage over network), "
+                "set 'migratable' property to true to enable migration.");
+        migrate_add_blocker(vsc->migration_blocker, &err);
+        if (err) {
+            error_propagate(errp, err);
+            error_free(vsc->migration_blocker);
+            goto close_fd;
+        }
     }
 
     vsc->dev.nvqs = VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
@@ -230,7 +235,9 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     return;
 
  free_vqs:
-    migrate_del_blocker(vsc->migration_blocker);
+    if (!vsc->migratable) {
+        migrate_del_blocker(vsc->migration_blocker);
+    }
     g_free(vsc->dev.vqs);
  close_fd:
     close(vhostfd);
@@ -243,8 +250,10 @@ static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(dev);
     struct vhost_virtqueue *vqs = vsc->dev.vqs;
 
-    migrate_del_blocker(vsc->migration_blocker);
-    error_free(vsc->migration_blocker);
+    if (!vsc->migratable) {
+        migrate_del_blocker(vsc->migration_blocker);
+        error_free(vsc->migration_blocker);
+    }
 
     /* This will stop vhost backend. */
     vhost_scsi_set_status(vdev, 0);
@@ -268,6 +277,7 @@ static Property vhost_scsi_properties[] = {
     DEFINE_PROP_BIT64("t10_pi", VHostSCSICommon, host_features,
                                                  VIRTIO_SCSI_F_T10_PI,
                                                  false),
+    DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
index 57fb1d87b51d..4eab767ee89f 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -36,6 +36,7 @@ typedef struct VHostSCSICommon {
     int target;
     int lun;
     uint64_t host_features;
+    bool migratable;
 } VHostSCSICommon;
 
 int vhost_scsi_common_start(VHostSCSICommon *vsc);
-- 
2.20.1
