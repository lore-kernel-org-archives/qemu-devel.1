Received: from eggs.gnu.org ([2001:4830:134:3::10]:39718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxCqh-00017Z-Ct
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxCqd-0002fL-Gk
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:58:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dxCqd-0002di-8w
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:59 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 27 Sep 2017 14:57:42 +0100
Message-Id: <20170927135742.19724-8-dgilbert@redhat.com>
In-Reply-To: <20170927135742.19724-1-dgilbert@redhat.com>
References: <20170927135742.19724-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] migration: Route more error paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pl@kamp.de, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

vmstate_save_state is called in lots of places.
Route error returns from the easier cases back up;  there are lots
of more complex cases where their own error paths need fixing.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170925112917.21340-7-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Commit message fix up as Peter's review
---
 hw/display/virtio-gpu.c    |  4 +---
 hw/virtio/virtio.c         | 13 +++++++------
 include/hw/virtio/virtio.h |  2 +-
 migration/vmstate-types.c  | 11 ++++++++---
 tests/test-vmstate.c       |  9 ++++++---
 5 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6b5f119d96..43bbe09ea0 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1050,9 +1050,7 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     }
     qemu_put_be32(f, 0); /* end of list */
 
-    vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
-
-    return 0;
+    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
 }
 
 static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3129d25c00..311929e9df 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1897,7 +1897,7 @@ static const VMStateDescription vmstate_virtio = {
     }
 };
 
-void virtio_save(VirtIODevice *vdev, QEMUFile *f)
+int virtio_save(VirtIODevice *vdev, QEMUFile *f)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
@@ -1947,20 +1947,21 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
     }
 
     if (vdc->vmsd) {
-        vmstate_save_state(f, vdc->vmsd, vdev, NULL);
+        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL);
+        if (ret) {
+            return ret;
+        }
     }
 
     /* Subsections */
-    vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
+    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
 }
 
 /* A wrapper for use as a VMState .put function */
 static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
                               VMStateField *field, QJSON *vmdesc)
 {
-    virtio_save(VIRTIO_DEVICE(opaque), f);
-
-    return 0;
+    return virtio_save(VIRTIO_DEVICE(opaque), f);
 }
 
 /* A wrapper for use as a VMState .get function */
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 80c45c321e..5abada6966 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -188,7 +188,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq);
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
-void virtio_save(VirtIODevice *vdev, QEMUFile *f);
+int virtio_save(VirtIODevice *vdev, QEMUFile *f);
 
 extern const VMStateInfo virtio_vmstate_info;
 
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index c056c98bdb..48184c380d 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -550,13 +550,14 @@ static int put_tmp(QEMUFile *f, void *pv, size_t size, VMStateField *field,
 {
     const VMStateDescription *vmsd = field->vmsd;
     void *tmp = g_malloc(size);
+    int ret;
 
     /* Writes the parent field which is at the start of the tmp */
     *(void **)tmp = pv;
-    vmstate_save_state(f, vmsd, tmp, vmdesc);
+    ret = vmstate_save_state(f, vmsd, tmp, vmdesc);
     g_free(tmp);
 
-    return 0;
+    return ret;
 }
 
 const VMStateInfo vmstate_info_tmp = {
@@ -657,12 +658,16 @@ static int put_qtailq(QEMUFile *f, void *pv, size_t unused_size,
     /* offset of the QTAILQ entry in a QTAILQ element*/
     size_t entry_offset = field->start;
     void *elm;
+    int ret;
 
     trace_put_qtailq(vmsd->name, vmsd->version_id);
 
     QTAILQ_RAW_FOREACH(elm, pv, entry_offset) {
         qemu_put_byte(f, true);
-        vmstate_save_state(f, vmsd, elm, vmdesc);
+        ret = vmstate_save_state(f, vmsd, elm, vmdesc);
+        if (ret) {
+            return ret;
+        }
     }
     qemu_put_byte(f, false);
 
diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index e643ac662b..087844b6c8 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -70,7 +70,8 @@ static void save_vmstate(const VMStateDescription *desc, void *obj)
     QEMUFile *f = open_test_file(true);
 
     /* Save file with vmstate */
-    vmstate_save_state(f, desc, obj, NULL);
+    int ret = vmstate_save_state(f, desc, obj, NULL);
+    g_assert(!ret);
     qemu_put_byte(f, QEMU_VM_EOF);
     g_assert(!qemu_file_get_error(f));
     qemu_fclose(f);
@@ -381,7 +382,8 @@ static void test_save_noskip(void)
     QEMUFile *fsave = open_test_file(true);
     TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
                        .skip_c_e = false };
-    vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
+    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
+    g_assert(!ret);
     g_assert(!qemu_file_get_error(fsave));
 
     uint8_t expected[] = {
@@ -402,7 +404,8 @@ static void test_save_skip(void)
     QEMUFile *fsave = open_test_file(true);
     TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
                        .skip_c_e = true };
-    vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
+    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
+    g_assert(!ret);
     g_assert(!qemu_file_get_error(fsave));
 
     uint8_t expected[] = {
-- 
2.13.5
