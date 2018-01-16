Received: from eggs.gnu.org ([2001:4830:134:3::10]:47653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJ97-0007SU-JB
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJ94-0004cr-Gc
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:46:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebJ94-0004ce-5s
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:46:46 -0500
Date: Tue, 16 Jan 2018 06:46:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516077852-7974-5-git-send-email-mst@redhat.com>
References: <1516077852-7974-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516077852-7974-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/33] contrib/libvhost-user: enable virtio
 config space messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Changpeng Liu <changpeng.liu@intel.com>

Enable VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages in
libvhost-user library, users can implement their own I/O target
based on the library. This enable the virtio config space delivered
between QEMU host device and the I/O target.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h | 33 +++++++++++++++++++++++++++
 contrib/libvhost-user/libvhost-user.c | 42 +++++++++++++++++++++++++++++=
++++++
 2 files changed, 75 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 2f5864b..f8a730b 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -30,6 +30,16 @@
=20
 #define VHOST_MEMORY_MAX_NREGIONS 8
=20
+typedef enum VhostSetConfigType {
+    VHOST_SET_CONFIG_TYPE_MASTER =3D 0,
+    VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,
+} VhostSetConfigType;
+
+/*
+ * Maximum size of virtio device config space
+ */
+#define VHOST_USER_MAX_CONFIG_SIZE 256
+
 enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_MQ =3D 0,
     VHOST_USER_PROTOCOL_F_LOG_SHMFD =3D 1,
@@ -69,6 +79,8 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_SLAVE_REQ_FD =3D 21,
     VHOST_USER_IOTLB_MSG =3D 22,
     VHOST_USER_SET_VRING_ENDIAN =3D 23,
+    VHOST_USER_GET_CONFIG =3D 24,
+    VHOST_USER_SET_CONFIG =3D 25,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -90,6 +102,18 @@ typedef struct VhostUserLog {
     uint64_t mmap_offset;
 } VhostUserLog;
=20
+typedef struct VhostUserConfig {
+    uint32_t offset;
+    uint32_t size;
+    uint32_t flags;
+    uint8_t region[VHOST_USER_MAX_CONFIG_SIZE];
+} VhostUserConfig;
+
+static VhostUserConfig c __attribute__ ((unused));
+#define VHOST_USER_CONFIG_HDR_SIZE (sizeof(c.offset) \
+                                   + sizeof(c.size) \
+                                   + sizeof(c.flags))
+
 #if defined(_WIN32)
 # define VU_PACKED __attribute__((gcc_struct, packed))
 #else
@@ -112,6 +136,7 @@ typedef struct VhostUserMsg {
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
         VhostUserLog log;
+        VhostUserConfig config;
     } payload;
=20
     int fds[VHOST_MEMORY_MAX_NREGIONS];
@@ -140,6 +165,10 @@ typedef int (*vu_process_msg_cb) (VuDev *dev, VhostU=
serMsg *vmsg,
                                   int *do_reply);
 typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool star=
ted);
 typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx)=
;
+typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t l=
en);
+typedef int (*vu_set_config_cb) (VuDev *dev, const uint8_t *data,
+                                 uint32_t offset, uint32_t size,
+                                 uint32_t flags);
=20
 typedef struct VuDevIface {
     /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
@@ -162,6 +191,10 @@ typedef struct VuDevIface {
      * on unmanaged exit/crash.
      */
     vu_queue_is_processed_in_order_cb queue_is_processed_in_order;
+    /* get the config space of the device */
+    vu_get_config_cb get_config;
+    /* set the config space of the device */
+    vu_set_config_cb set_config;
 } VuDevIface;
=20
 typedef void (*vu_queue_handler_cb) (VuDev *dev, int qidx);
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index f409bd3..27cc597 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -84,6 +84,8 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_SET_SLAVE_REQ_FD),
         REQ(VHOST_USER_IOTLB_MSG),
         REQ(VHOST_USER_SET_VRING_ENDIAN),
+        REQ(VHOST_USER_GET_CONFIG),
+        REQ(VHOST_USER_SET_CONFIG),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -798,6 +800,42 @@ vu_set_slave_req_fd(VuDev *dev, VhostUserMsg *vmsg)
 }
=20
 static bool
+vu_get_config(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int ret =3D -1;
+
+    if (dev->iface->get_config) {
+        ret =3D dev->iface->get_config(dev, vmsg->payload.config.region,
+                                     vmsg->payload.config.size);
+    }
+
+    if (ret) {
+        /* resize to zero to indicate an error to master */
+        vmsg->size =3D 0;
+    }
+
+    return true;
+}
+
+static bool
+vu_set_config(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int ret =3D -1;
+
+    if (dev->iface->set_config) {
+        ret =3D dev->iface->set_config(dev, vmsg->payload.config.region,
+                                     vmsg->payload.config.offset,
+                                     vmsg->payload.config.size,
+                                     vmsg->payload.config.flags);
+        if (ret) {
+            vu_panic(dev, "Set virtio configuration space failed");
+        }
+    }
+
+    return false;
+}
+
+static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
     int do_reply =3D 0;
@@ -862,6 +900,10 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_set_vring_enable_exec(dev, vmsg);
     case VHOST_USER_SET_SLAVE_REQ_FD:
         return vu_set_slave_req_fd(dev, vmsg);
+    case VHOST_USER_GET_CONFIG:
+        return vu_get_config(dev, vmsg);
+    case VHOST_USER_SET_CONFIG:
+        return vu_set_config(dev, vmsg);
     case VHOST_USER_NONE:
         break;
     default:
--=20
MST
