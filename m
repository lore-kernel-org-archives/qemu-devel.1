Received: from eggs.gnu.org ([2001:4830:134:3::10]:49286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1g9rnB-0004Hg-Ro
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1g9rn0-0000VH-1o
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:11:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1g9rmz-0000Un-PV
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:11:05 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Tue,  9 Oct 2018 15:10:51 +0200
Message-Id: <20181009131052.18500-2-lhrazky@redhat.com>
In-Reply-To: <20181009131052.18500-1-lhrazky@redhat.com>
References: <20181009131052.18500-1-lhrazky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH spice 1/2] QXL interface: add functions to
 identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Adds two functions to let QEMU provide information to identify graphics
devices and their monitors in the guest:

* device path - The path identifying the device on the system (e.g. PCI
  path):
  spice_qxl_device_set_path(...)

* device display ID - The index of the monitor on the graphics device:
  spice_qxl_device_monitor_add_display_id(...)

Signed-off-by: Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD <lhrazky@redhat.com>
---
 server/red-qxl.c         | 67 ++++++++++++++++++++++++++++++++++++++++
 server/spice-qxl.h       |  3 ++
 server/spice-server.syms |  6 ++++
 3 files changed, 76 insertions(+)

diff --git a/server/red-qxl.c b/server/red-qxl.c
index 97940611..143228ca 100644
--- a/server/red-qxl.c
+++ b/server/red-qxl.c
@@ -41,6 +41,9 @@
 #include "red-qxl.h"
=20
=20
+#define MAX_PATH_LEN 256
+#define MAX_MONITORS_COUNT 16
+
 struct QXLState {
     QXLWorker qxl_worker;
     QXLInstance *qxl;
@@ -53,6 +56,9 @@ struct QXLState {
     unsigned int max_monitors;
     RedsState *reds;
     RedWorker *worker;
+    char device_path[MAX_PATH_LEN];
+    uint32_t device_display_ids[MAX_MONITORS_COUNT];
+    size_t monitors_count;  // length of ^^^
=20
     pthread_mutex_t scanout_mutex;
     SpiceMsgDisplayGlScanoutUnix scanout;
@@ -846,6 +852,67 @@ void red_qxl_gl_draw_async_complete(QXLInstance *qxl=
)
     red_qxl_async_complete(qxl, cookie);
 }
=20
+/**
+ * spice_qxl_device_set_path:
+ * @instance the QXL instance to set the path to
+ * @device_path the path of the device this QXL instance belongs to
+ *
+ * Sets the hardware (e.g. PCI) path of the graphics device represented =
by this QXL interface instance.
+ *
+ */
+SPICE_GNUC_VISIBLE
+void spice_qxl_device_set_path(QXLInstance *instance, const char *device=
_path)
+{
+    g_return_if_fail(device_path !=3D NULL);
+
+    size_t dp_len =3D strnlen(device_path, MAX_PATH_LEN);
+    if (dp_len >=3D MAX_PATH_LEN) {
+        spice_error("PCI device path too long: %lu > %u", dp_len, MAX_PA=
TH_LEN);
+        return;
+    }
+
+    strncpy(instance->st->device_path, device_path, MAX_PATH_LEN);
+
+    g_debug("QXL Instance %d setting device PCI path \"%s\"", instance->=
id, device_path);
+}
+
+/**
+ * spice_qxl_device_monitor_add_display_id:
+ * @instance the QXL instance to add the display ID to
+ * @device_display_id the display ID to add to the QXL instance
+ *
+ * Adds a #device_display_id to this QXL interface instance. The
+ * #device_display_id is an index (a sequence starting from 0) into the =
list of
+ * all the displays on the graphics device. This function should be call=
ed in
+ * sequence for all possible displays of the device. The ID of the first=
 call
+ * will belong to #monitor_id 0, and so forth in the sequence.
+ *
+ * Since for some graphics devices (e.g. virtio-gpu) a QXL interface ins=
tance
+ * is created per each display of a single device, you can get e.g. the =
single
+ * following call on the third QXL interface instance for this device:
+ *
+ * spice_qxl_device_monitor_add_display_id(instance, 2);
+ *
+ * This tells you that the single monitor of this QXL interface actually
+ * belongs to the 3rd display of the underlying device.
+ *
+ * Returns: The actual SPICE server monitor_id associated with the displ=
ay
+ */
+SPICE_GNUC_VISIBLE
+int spice_qxl_device_monitor_add_display_id(QXLInstance *instance, uint3=
2_t device_display_id)
+{
+    if (instance->st->monitors_count >=3D MAX_MONITORS_COUNT) {
+        spice_error("Cannot register more than %u monitors per QXL inter=
face", MAX_MONITORS_COUNT);
+        return -1;
+    }
+
+    instance->st->device_display_ids[instance->st->monitors_count] =3D d=
evice_display_id;
+
+    g_debug("QXL Instance %d adding device display ID %u", instance->id,=
 device_display_id);
+
+    return instance->st->monitors_count++;
+}
+
 void red_qxl_init(RedsState *reds, QXLInstance *qxl)
 {
     QXLState *qxl_state;
diff --git a/server/spice-qxl.h b/server/spice-qxl.h
index 0c4e75fc..ae2d5975 100644
--- a/server/spice-qxl.h
+++ b/server/spice-qxl.h
@@ -114,6 +114,9 @@ void spice_qxl_gl_draw_async(QXLInstance *instance,
                              uint32_t x, uint32_t y,
                              uint32_t w, uint32_t h,
                              uint64_t cookie);
+/* since spice 0.14.2 */
+void spice_qxl_device_set_path(QXLInstance *instance, const char *device=
_path);
+int spice_qxl_device_monitor_add_display_id(QXLInstance *instance, uint3=
2_t device_display_id);
=20
 typedef struct QXLDevInitInfo {
     uint32_t num_memslots_groups;
diff --git a/server/spice-server.syms b/server/spice-server.syms
index edf04a42..fdeafd23 100644
--- a/server/spice-server.syms
+++ b/server/spice-server.syms
@@ -173,3 +173,9 @@ SPICE_SERVER_0.13.2 {
 global:
     spice_server_set_video_codecs;
 } SPICE_SERVER_0.13.1;
+
+SPICE_SERVER_0.14.2 {
+global:
+    spice_qxl_device_set_path;
+    spice_qxl_device_monitor_add_display_id;
+} SPICE_SERVER_0.13.2;
--=20
2.19.1
