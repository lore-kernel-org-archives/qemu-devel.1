Received: from eggs.gnu.org ([2001:4830:134:3::10]:50022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dz6Bl-0001gZ-6h
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dz6Bk-0000TA-4e
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:15:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dz6Bj-0000Rw-S6
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:15:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01CC37E430
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 19:15:35 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  2 Oct 2017 20:15:21 +0100
Message-Id: <20171002191521.15748-5-dgilbert@redhat.com>
In-Reply-To: <20171002191521.15748-1-dgilbert@redhat.com>
References: <20171002191521.15748-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] libvhost-user: Support
 VHOST_USER_SET_SLAVE_REQ_FD
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com
List-ID: <qemu-devel.nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Allow the qemu to pass us a slave fd.  We don't do anything
with it yet.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 27 ++++++++++++++++++++++++++-
 contrib/libvhost-user/libvhost-user.h |  1 +
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 1901311a70..756b60c4b3 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -703,7 +703,8 @@ vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
 static bool
 vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
-    uint64_t features = 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
+    uint64_t features = 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
+                        1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ;
 
     if (dev->iface->get_protocol_features) {
         features |= dev->iface->get_protocol_features(dev);
@@ -757,6 +758,23 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *vmsg)
 }
 
 static bool
+vu_set_slave_req_fd(VuDev *dev, VhostUserMsg *vmsg)
+{
+    if (vmsg->fd_num != 1) {
+        vu_panic(dev, "Invalid slave_req_fd message (%d fd's)", vmsg->fd_num);
+        return false;
+    }
+
+    if (dev->slave_fd != -1) {
+        close(dev->slave_fd);
+    }
+    dev->slave_fd = vmsg->fds[0];
+    DPRINT("Got slave_fd: %d\n", vmsg->fds[0]);
+
+    return false;
+}
+
+static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
     int do_reply = 0;
@@ -819,6 +837,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_get_queue_num_exec(dev, vmsg);
     case VHOST_USER_SET_VRING_ENABLE:
         return vu_set_vring_enable_exec(dev, vmsg);
+    case VHOST_USER_SET_SLAVE_REQ_FD:
+        return vu_set_slave_req_fd(dev, vmsg);
     case VHOST_USER_NONE:
         break;
     default:
@@ -892,6 +912,10 @@ vu_deinit(VuDev *dev)
 
 
     vu_close_log(dev);
+    if (dev->slave_fd != -1) {
+        close(dev->slave_fd);
+        dev->slave_fd = -1;
+    }
 
     if (dev->sock != -1) {
         close(dev->sock);
@@ -922,6 +946,7 @@ vu_init(VuDev *dev,
     dev->remove_watch = remove_watch;
     dev->iface = iface;
     dev->log_call_fd = -1;
+    dev->slave_fd = -1;
     for (i = 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
         dev->vq[i] = (VuVirtq) {
             .call_fd = -1, .kick_fd = -1, .err_fd = -1,
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index c2fc6da720..7534e97f92 100644
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
-- 
2.13.6
