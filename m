Received: from eggs.gnu.org ([2001:4830:134:3::10]:55347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d8nHn-0002jx-G7
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d8nHm-0004wu-5X
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:33:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1d8nHl-0004wR-T2
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:33:38 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 11 May 2017 14:32:45 +0200
Message-Id: <20170511123246.31308-6-maxime.coquelin@redhat.com>
In-Reply-To: <20170511123246.31308-1-maxime.coquelin@redhat.com>
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/6] vhost-user: add slave-req-fd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Learn to give a socket to the slave to let him make requests to the
master.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 docs/specs/vhost-user.txt |  32 +++++++++++-
 hw/virtio/vhost-user.c    | 127 ++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 157 insertions(+), 2 deletions(-)

diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
index 036890f..5fa7016 100644
--- a/docs/specs/vhost-user.txt
+++ b/docs/specs/vhost-user.txt
@@ -139,6 +139,7 @@ in the ancillary data:
  * VHOST_USER_SET_VRING_KICK
  * VHOST_USER_SET_VRING_CALL
  * VHOST_USER_SET_VRING_ERR
+ * VHOST_USER_SET_SLAVE_REQ_FD
=20
 If Master is unable to send the full message or receives a wrong reply i=
t will
 close the connection. An optional reconnection mechanism can be implemen=
ted.
@@ -252,6 +253,18 @@ Once the source has finished migration, rings will b=
e stopped by
 the source. No further update must be done before rings are
 restarted.
=20
+Slave communication
+-------------------
+
+An optional communication channel is provided if the slave declares
+VHOST_USER_PROTOCOL_F_SLAVE_REQ protocol feature, to allow the slave to =
make
+requests to the master.
+
+The fd is provided via VHOST_USER_SET_SLAVE_REQ_FD ancillary data.
+
+A slave may then send VHOST_USER_SLAVE_* messages to the master
+using this fd communication channel.
+
 Protocol features
 -----------------
=20
@@ -260,9 +273,10 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_RARP           2
 #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
 #define VHOST_USER_PROTOCOL_F_MTU            4
+#define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
=20
-Message types
--------------
+Master message types
+--------------------
=20
  * VHOST_USER_GET_FEATURES
=20
@@ -486,6 +500,20 @@ Message types
       If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, slave must respo=
nd
       with zero in case the specified MTU is valid, or non-zero otherwis=
e.
=20
+ * VHOST_USER_SET_SLAVE_REQ_FD
+
+      Id: 21
+      Equivalent ioctl: N/A
+      Master payload: N/A
+
+      Set the socket file descriptor for slave initiated requests. It is=
 passed
+      in the ancillary data.
+      This request should be sent only when VHOST_USER_F_PROTOCOL_FEATUR=
ES
+      has been negotiated, and protocol feature bit VHOST_USER_PROTOCOL_=
F_SLAVE_REQ
+      bit is present in VHOST_USER_GET_PROTOCOL_FEATURES.
+      If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, slave must respo=
nd
+      with zero for success, non-zero otherwise.
+
 VHOST_USER_PROTOCOL_F_REPLY_ACK:
 -------------------------------
 The original vhost-user specification only demands replies for certain
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f0e10d0..fbc09fa 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -33,6 +33,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_RARP =3D 2,
     VHOST_USER_PROTOCOL_F_REPLY_ACK =3D 3,
     VHOST_USER_PROTOCOL_F_NET_MTU =3D 4,
+    VHOST_USER_PROTOCOL_F_SLAVE_REQ =3D 5,
=20
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -61,9 +62,15 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_VRING_ENABLE =3D 18,
     VHOST_USER_SEND_RARP =3D 19,
     VHOST_USER_NET_SET_MTU =3D 20,
+    VHOST_USER_SET_SLAVE_REQ_FD =3D 21,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
+typedef enum VhostUserSlaveRequest {
+    VHOST_USER_SLAVE_NONE =3D 0,
+    VHOST_USER_SLAVE_MAX
+}  VhostUserSlaveRequest;
+
 typedef struct VhostUserMemoryRegion {
     uint64_t guest_phys_addr;
     uint64_t memory_size;
@@ -113,6 +120,7 @@ static VhostUserMsg m __attribute__ ((unused));
=20
 struct vhost_user {
     CharBackend *chr;
+    int slave_fd;
 };
=20
 static bool ioeventfd_enabled(void)
@@ -574,6 +582,115 @@ static int vhost_user_reset_device(struct vhost_dev=
 *dev)
     return 0;
 }
=20
+static void slave_read(void *opaque)
+{
+    struct vhost_dev *dev =3D opaque;
+    struct vhost_user *u =3D dev->opaque;
+    VhostUserMsg msg =3D { 0, };
+    int size, ret =3D 0;
+
+    /* Read header */
+    size =3D read(u->slave_fd, &msg, VHOST_USER_HDR_SIZE);
+    if (size !=3D VHOST_USER_HDR_SIZE) {
+        error_report("Failed to read from slave.");
+        goto err;
+    }
+
+    if (msg.size > VHOST_USER_PAYLOAD_SIZE) {
+        error_report("Failed to read msg header."
+                " Size %d exceeds the maximum %zu.", msg.size,
+                VHOST_USER_PAYLOAD_SIZE);
+        goto err;
+    }
+
+    /* Read payload */
+    size =3D read(u->slave_fd, &msg.payload, msg.size);
+    if (size !=3D msg.size) {
+        error_report("Failed to read payload from slave.");
+        goto err;
+    }
+
+    switch (msg.request) {
+    default:
+        error_report("Received unexpected msg type.");
+        ret =3D -EINVAL;
+    }
+
+    /*
+     * REPLY_ACK feature handling. Other reply types has to be managed
+     * directly in their request handlers.
+     */
+    if (msg.flags & VHOST_USER_NEED_REPLY_MASK) {
+        msg.flags &=3D ~VHOST_USER_NEED_REPLY_MASK;
+        msg.flags |=3D VHOST_USER_REPLY_MASK;
+
+        msg.payload.u64 =3D !!ret;
+        msg.size =3D sizeof(msg.payload.u64);
+
+        size =3D write(u->slave_fd, &msg, VHOST_USER_HDR_SIZE + msg.size=
);
+        if (size !=3D VHOST_USER_HDR_SIZE + msg.size) {
+            error_report("Failed to send msg reply to slave.");
+            goto err;
+        }
+    }
+
+    return;
+
+err:
+    qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
+    close(u->slave_fd);
+    u->slave_fd =3D -1;
+    return;
+}
+
+static int vhost_setup_slave_channel(struct vhost_dev *dev)
+{
+    VhostUserMsg msg =3D {
+        .request =3D VHOST_USER_SET_SLAVE_REQ_FD,
+        .flags =3D VHOST_USER_VERSION,
+    };
+    struct vhost_user *u =3D dev->opaque;
+    int sv[2], ret =3D 0;
+    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
+                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_SLAVE_REQ)) {
+        return 0;
+    }
+
+    if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) =3D=3D -1) {
+        error_report("socketpair() failed");
+        return -1;
+    }
+
+    u->slave_fd =3D sv[0];
+    qemu_set_fd_handler(u->slave_fd, slave_read, NULL, dev);
+
+    if (reply_supported) {
+        msg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    ret =3D vhost_user_write(dev, &msg, &sv[1], 1);
+    if (ret) {
+        goto out;
+    }
+
+    if (reply_supported) {
+        ret =3D process_message_reply(dev, msg.request);
+    }
+
+out:
+    close(sv[1]);
+    if (ret) {
+        qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
+        close(u->slave_fd);
+        u->slave_fd =3D -1;
+    }
+
+    return ret;
+}
+
 static int vhost_user_init(struct vhost_dev *dev, void *opaque)
 {
     uint64_t features;
@@ -584,6 +701,7 @@ static int vhost_user_init(struct vhost_dev *dev, voi=
d *opaque)
=20
     u =3D g_new0(struct vhost_user, 1);
     u->chr =3D opaque;
+    u->slave_fd =3D -1;
     dev->opaque =3D u;
=20
     err =3D vhost_user_get_features(dev, &features);
@@ -624,6 +742,11 @@ static int vhost_user_init(struct vhost_dev *dev, vo=
id *opaque)
                    "VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.");
     }
=20
+    err =3D vhost_setup_slave_channel(dev);
+    if (err < 0) {
+        return err;
+    }
+
     return 0;
 }
=20
@@ -634,6 +757,10 @@ static int vhost_user_cleanup(struct vhost_dev *dev)
     assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
=20
     u =3D dev->opaque;
+    if (u->slave_fd >=3D 0) {
+        close(u->slave_fd);
+        u->slave_fd =3D -1;
+    }
     g_free(u);
     dev->opaque =3D 0;
=20
--=20
2.9.3
