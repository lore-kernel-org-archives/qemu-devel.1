Received: from eggs.gnu.org ([2001:4830:134:3::10]:53403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gCmvn-0001Oy-MZ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gCmvl-0007uo-In
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:36:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gCmvl-0007uJ-6g
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:36:13 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Wed, 17 Oct 2018 16:36:03 +0200
Message-Id: <20181017143604.5194-2-lhrazky@redhat.com>
In-Reply-To: <20181017143604.5194-1-lhrazky@redhat.com>
References: <20181017143604.5194-1-lhrazky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH spice v2 1/2] QXL interface: add functions
 to identify monitors in the guest
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

* device address - The path identifying the device on the system (e.g. PC=
I
  path):
  spice_qxl_set_device_address(...)

* device display ID - The index of the monitor on the graphics device:
  spice_qxl_monitor_set_device_display_id(...)

Signed-off-by: Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD <lhrazky@redhat.com>
---
 server/red-qxl.c         | 89 ++++++++++++++++++++++++++++++++++++++++
 server/spice-qxl.h       |  5 +++
 server/spice-server.syms |  6 +++
 3 files changed, 100 insertions(+)

diff --git a/server/red-qxl.c b/server/red-qxl.c
index 97940611..0b2043e1 100644
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
+    char device_address[MAX_PATH_LEN];
+    uint32_t device_display_ids[MAX_MONITORS_COUNT];
+    size_t monitors_count;  // length of ^^^
=20
     pthread_mutex_t scanout_mutex;
     SpiceMsgDisplayGlScanoutUnix scanout;
@@ -846,6 +852,89 @@ void red_qxl_gl_draw_async_complete(QXLInstance *qxl=
)
     red_qxl_async_complete(qxl, cookie);
 }
=20
+/**
+ * spice_qxl_set_device_address:
+ * @instance the QXL instance to set the path to
+ * @device_address the path of the device this QXL instance belongs to
+ *
+ * Sets the hardware address (e.g. PCI) of the graphics device represent=
ed by
+ * this QXL interface instance.
+ *
+ * The supported format is:
+ * "pci/<DOMAIN>/<SLOT>.<FUNCTION>/.../<SLOT>.<FUNCTION>"
+ *
+ * The "pci" identifies the rest of the string as a PCI adress. It is th=
e only
+ * supported address at the moment, other identifiers can be introduced =
later.
+ * <DOMAIN> is the PCI domain, followed by <SLOT>.<FUNCTION> of any PCI =
bridges
+ * in the chain leading to the device. The last <SLOT>.<FUNCTION> is the
+ * graphics device.
+ */
+SPICE_GNUC_VISIBLE
+void spice_qxl_set_device_address(QXLInstance *instance, const char *dev=
ice_address)
+{
+    g_return_if_fail(device_address !=3D NULL);
+
+    size_t dp_len =3D strnlen(device_address, MAX_PATH_LEN);
+    if (dp_len >=3D MAX_PATH_LEN) {
+        spice_error("PCI device path too long: %lu > %u", dp_len, MAX_PA=
TH_LEN);
+        return;
+    }
+
+    strncpy(instance->st->device_address, device_address, MAX_PATH_LEN);
+
+    g_debug("QXL Instance %d setting device address \"%s\"", instance->i=
d, device_address);
+}
+
+/**
+ * spice_qxl_monitor_set_device_display_id:
+ * @instance the QXL instance to set the device display ID to
+ * @monitor_id the SPICE monitor ID to set the device display ID to
+ * @device_display_id the actual ID of the display (output) on the graph=
ics device
+ *
+ * Sets the device display ID for a given monitor ID in a QXL instance. =
The
+ * monitor IDs are expected and required to be a consecutive sequence st=
arting
+ * at 0. The function requires the calls to be made in the sequence to p=
revent
+ * holes.
+ *
+ * The requirement for the monitor ID to be a sequence starting from 0 c=
omes
+ * from the mechanism of generating a single display_id from channel_id =
and
+ * monitor_id on the client:
+ *
+ * display_id =3D channel_id + monitor_id
+ *
+ * This is unambiguous either if there is only a single channel with mul=
tiple
+ * monitors ("legacy" QXL on linux case) or multiple channels with only =
a
+ * single monitor. Also both channel_id and monitor_id need to be a sequ=
ence
+ * starting from 0, otherwise there is still a possibility of collisions=
.
+ */
+SPICE_GNUC_VISIBLE
+void spice_qxl_monitor_set_device_display_id(QXLInstance *instance,
+                                             uint32_t monitor_id,
+                                             uint32_t device_display_id)
+{
+    if (instance->st->monitors_count >=3D MAX_MONITORS_COUNT) {
+        spice_error("Cannot register more than %u monitors per QXL inter=
face", MAX_MONITORS_COUNT);
+        return;
+    }
+
+    if (monitor_id > instance->st->monitors_count) {
+        spice_error("Monitor ID %u is not inside a consecutive sequence =
of monitor IDs "
+                    "starting from zero. Needs to be lower than or equal=
 to %lu.",
+                    monitor_id, instance->st->monitors_count);
+        return;
+    }
+
+    instance->st->device_display_ids[monitor_id] =3D device_display_id;
+
+    g_debug("QXL Instance %d setting device display ID %u for monitor ID=
 %u",
+        instance->id, device_display_id, monitor_id);
+
+    // if we're adding a new ID (and not resetting an existing one), inc=
rement the array length
+    if (monitor_id =3D=3D instance->st->monitors_count) {
+        instance->st->monitors_count++;
+    }
+}
+
 void red_qxl_init(RedsState *reds, QXLInstance *qxl)
 {
     QXLState *qxl_state;
diff --git a/server/spice-qxl.h b/server/spice-qxl.h
index 0c4e75fc..c9ea6564 100644
--- a/server/spice-qxl.h
+++ b/server/spice-qxl.h
@@ -114,6 +114,11 @@ void spice_qxl_gl_draw_async(QXLInstance *instance,
                              uint32_t x, uint32_t y,
                              uint32_t w, uint32_t h,
                              uint64_t cookie);
+/* since spice 0.14.2 */
+void spice_qxl_set_device_address(QXLInstance *instance, const char *dev=
ice_path);
+void spice_qxl_monitor_set_device_display_id(QXLInstance *instance,
+                                             uint32_t monitor_id,
+                                             uint32_t device_display_id)=
;
=20
 typedef struct QXLDevInitInfo {
     uint32_t num_memslots_groups;
diff --git a/server/spice-server.syms b/server/spice-server.syms
index edf04a42..6e9ffa93 100644
--- a/server/spice-server.syms
+++ b/server/spice-server.syms
@@ -173,3 +173,9 @@ SPICE_SERVER_0.13.2 {
 global:
     spice_server_set_video_codecs;
 } SPICE_SERVER_0.13.1;
+
+SPICE_SERVER_0.14.2 {
+global:
+    spice_qxl_set_device_address;
+    spice_qxl_monitor_set_device_display_id;
+} SPICE_SERVER_0.13.2;
--=20
2.19.1
