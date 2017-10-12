Received: from eggs.gnu.org ([2001:4830:134:3::10]:42645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e2kUK-0001h7-Hc
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e2kUF-0000fK-Mc
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e2kUF-0000e4-EQ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DC7117FD
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 20:53:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 12 Oct 2017 22:53:30 +0200
Message-Id: <20171012205330.29942-5-marcandre.lureau@redhat.com>
In-Reply-To: <20171012205330.29942-1-marcandre.lureau@redhat.com>
References: <20171012205330.29942-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] libvhost-user: Support
 VHOST_USER_SET_SLAVE_REQ_FD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Allow the qemu to pass us a slave fd.  We don't do anything
with it yet.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20171002191521.15748-5-dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  1 +
 contrib/libvhost-user/libvhost-user.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index d54683feeb..2f5864b5c4 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -226,6 +226,7 @@ struct VuDev {
     VuDevRegion regions[VHOST_MEMORY_MAX_NREGIONS];
     VuVirtq vq[VHOST_MAX_NR_VIRTQUEUE];
     int log_call_fd;
+    int slave_fd;
     uint64_t log_size;
     uint8_t *log_table;
     uint64_t features;
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index e36aed72d0..f409bd3d41 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -726,7 +726,8 @@ vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
 static bool
 vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
-    uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
+    uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
+                        1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ;
=20
     if (dev->iface->get_protocol_features) {
         features |=3D dev->iface->get_protocol_features(dev);
@@ -779,6 +780,23 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *v=
msg)
     return false;
 }
=20
+static bool
+vu_set_slave_req_fd(VuDev *dev, VhostUserMsg *vmsg)
+{
+    if (vmsg->fd_num !=3D 1) {
+        vu_panic(dev, "Invalid slave_req_fd message (%d fd's)", vmsg->fd=
_num);
+        return false;
+    }
+
+    if (dev->slave_fd !=3D -1) {
+        close(dev->slave_fd);
+    }
+    dev->slave_fd =3D vmsg->fds[0];
+    DPRINT("Got slave_fd: %d\n", vmsg->fds[0]);
+
+    return false;
+}
+
 static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -842,6 +860,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_get_queue_num_exec(dev, vmsg);
     case VHOST_USER_SET_VRING_ENABLE:
         return vu_set_vring_enable_exec(dev, vmsg);
+    case VHOST_USER_SET_SLAVE_REQ_FD:
+        return vu_set_slave_req_fd(dev, vmsg);
     case VHOST_USER_NONE:
         break;
     default:
@@ -915,6 +935,10 @@ vu_deinit(VuDev *dev)
=20
=20
     vu_close_log(dev);
+    if (dev->slave_fd !=3D -1) {
+        close(dev->slave_fd);
+        dev->slave_fd =3D -1;
+    }
=20
     if (dev->sock !=3D -1) {
         close(dev->sock);
@@ -945,6 +969,7 @@ vu_init(VuDev *dev,
     dev->remove_watch =3D remove_watch;
     dev->iface =3D iface;
     dev->log_call_fd =3D -1;
+    dev->slave_fd =3D -1;
     for (i =3D 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
         dev->vq[i] =3D (VuVirtq) {
             .call_fd =3D -1, .kick_fd =3D -1, .err_fd =3D -1,
--=20
2.15.0.rc0.40.gaefcc5f6f
