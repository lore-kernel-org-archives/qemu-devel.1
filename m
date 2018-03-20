Received: from eggs.gnu.org ([2001:4830:134:3::10]:51027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mS-0006nl-7d
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mQ-0008Gb-Qf
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7mQ-0008GW-JC
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:42 -0400
Date: Tue, 20 Mar 2018 05:17:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-28-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 27/50] vhost-user: Add
 'VHOST_USER_POSTCOPY_ADVISE' message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Wire up a notifier to send a VHOST_USER_POSTCOPY_ADVISE
message on an incoming advise.

Later patches will fill in the behaviour/contents of the
message.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.txt           | 10 ++++++++
 contrib/libvhost-user/libvhost-user.h |  3 +++
 migration/postcopy-ram.h              |  1 +
 contrib/libvhost-user/libvhost-user.c | 11 ++++++++
 hw/virtio/vhost-user.c                | 48 +++++++++++++++++++++++++++++=
++++++
 migration/savevm.c                    |  6 +++++
 6 files changed, 79 insertions(+)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 91a572d..7854e50 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -699,6 +699,16 @@ Master message types
      feature has been successfully negotiated.
      It's a required feature for crypto devices.
=20
+ * VHOST_USER_POSTCOPY_ADVISE
+      Id: 28
+      Master payload: N/A
+      Slave payload: userfault fd
+
+      When VHOST_USER_PROTOCOL_F_PAGEFAULT is supported, the
+      master advises slave that a migration with postcopy enabled is und=
erway,
+      the slave must open a userfaultfd for later use.
+      Note that at this stage the migration is still in precopy mode.
+
 Slave message types
 -------------------
=20
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 96db29c..00d78a8 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -83,6 +83,9 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_VRING_ENDIAN =3D 23,
     VHOST_USER_GET_CONFIG =3D 24,
     VHOST_USER_SET_CONFIG =3D 25,
+    VHOST_USER_CREATE_CRYPTO_SESSION =3D 26,
+    VHOST_USER_CLOSE_CRYPTO_SESSION =3D 27,
+    VHOST_USER_POSTCOPY_ADVISE  =3D 28,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 2e879bb..0421c98 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -130,6 +130,7 @@ void postcopy_infrastructure_init(void);
  */
 enum PostcopyNotifyReason {
     POSTCOPY_NOTIFY_PROBE =3D 0,
+    POSTCOPY_NOTIFY_INBOUND_ADVISE,
 };
=20
 struct PostcopyNotifyData {
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 2e358b5..37d4228 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -86,6 +86,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_SET_VRING_ENDIAN),
         REQ(VHOST_USER_GET_CONFIG),
         REQ(VHOST_USER_SET_CONFIG),
+        REQ(VHOST_USER_POSTCOPY_ADVISE),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -857,6 +858,14 @@ vu_set_config(VuDev *dev, VhostUserMsg *vmsg)
 }
=20
 static bool
+vu_set_postcopy_advise(VuDev *dev, VhostUserMsg *vmsg)
+{
+    /* TODO: Open ufd, pass it back in the request */
+    vmsg->size =3D 0;
+    return true; /* =3D send a reply */
+}
+
+static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
     int do_reply =3D 0;
@@ -927,6 +936,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_set_config(dev, vmsg);
     case VHOST_USER_NONE:
         break;
+    case VHOST_USER_POSTCOPY_ADVISE:
+        return vu_set_postcopy_advise(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index aab35c4..ceb17b0 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -78,6 +78,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_CONFIG =3D 25,
     VHOST_USER_CREATE_CRYPTO_SESSION =3D 26,
     VHOST_USER_CLOSE_CRYPTO_SESSION =3D 27,
+    VHOST_USER_POSTCOPY_ADVISE  =3D 28,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -795,6 +796,50 @@ out:
     return ret;
 }
=20
+/*
+ * Called at the start of an inbound postcopy on reception of the
+ * 'advise' command.
+ */
+static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **err=
p)
+{
+    struct vhost_user *u =3D dev->opaque;
+    CharBackend *chr =3D u->chr;
+    int ufd;
+    VhostUserMsg msg =3D {
+        .hdr.request =3D VHOST_USER_POSTCOPY_ADVISE,
+        .hdr.flags =3D VHOST_USER_VERSION,
+    };
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        error_setg(errp, "Failed to send postcopy_advise to vhost");
+        return -1;
+    }
+
+    if (vhost_user_read(dev, &msg) < 0) {
+        error_setg(errp, "Failed to get postcopy_advise reply from vhost=
");
+        return -1;
+    }
+
+    if (msg.hdr.request !=3D VHOST_USER_POSTCOPY_ADVISE) {
+        error_setg(errp, "Unexpected msg type. Expected %d received %d",
+                     VHOST_USER_POSTCOPY_ADVISE, msg.hdr.request);
+        return -1;
+    }
+
+    if (msg.hdr.size) {
+        error_setg(errp, "Received bad msg size.");
+        return -1;
+    }
+    ufd =3D qemu_chr_fe_get_msgfd(chr);
+    if (ufd < 0) {
+        error_setg(errp, "%s: Failed to get ufd", __func__);
+        return -1;
+    }
+
+    /* TODO: register ufd with userfault thread */
+    return 0;
+}
+
 static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
                                         void *opaque)
 {
@@ -814,6 +859,9 @@ static int vhost_user_postcopy_notifier(NotifierWithR=
eturn *notifier,
         }
         break;
=20
+    case POSTCOPY_NOTIFY_INBOUND_ADVISE:
+        return vhost_user_postcopy_advise(dev, pnd->errp);
+
     default:
         /* We ignore notifications we don't know */
         break;
diff --git a/migration/savevm.c b/migration/savevm.c
index 358c5b5..1f2bf12 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1386,6 +1386,7 @@ static int loadvm_postcopy_handle_advise(MigrationI=
ncomingState *mis,
 {
     PostcopyState ps =3D postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
     uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps=
;
+    Error *local_err =3D NULL;
=20
     trace_loadvm_postcopy_handle_advise();
     if (ps !=3D POSTCOPY_INCOMING_NONE) {
@@ -1451,6 +1452,11 @@ static int loadvm_postcopy_handle_advise(Migration=
IncomingState *mis,
         return -1;
     }
=20
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, &local_err)) {
+        error_report_err(local_err);
+        return -1;
+    }
+
     if (ram_postcopy_incoming_init(mis)) {
         return -1;
     }
--=20
MST
