Received: from eggs.gnu.org ([2001:4830:134:3::10]:40976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEt-0005c4-7P
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEs-0000Gc-Cf
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIEs-0000GE-4D
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:58 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:44 +0100
Message-Id: <20170628190047.26159-27-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 26/29] vhost: Add VHOST_USER_POSTCOPY_END message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This message is sent just before the end of postcopy to get the
client to stop using userfault since we wont respond to any more
requests.  It should close userfaultfd so that any other pages
get mapped to the backing file automatically by the kernel, since
at this point we know we've received everything.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 23 +++++++++++++++++++++++
 contrib/libvhost-user/libvhost-user.h |  1 +
 hw/virtio/vhost-user.c                |  1 +
 3 files changed, 25 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index d37052b7b0..c1716d1a62 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -68,6 +68,7 @@ vu_request_to_string(int req)
         REQ(VHOST_USER_INPUT_GET_CONFIG),
         REQ(VHOST_USER_POSTCOPY_ADVISE),
         REQ(VHOST_USER_POSTCOPY_LISTEN),
+        REQ(VHOST_USER_POSTCOPY_END),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -889,6 +890,26 @@ vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *vmsg)
 
     return false;
 }
+
+static bool
+vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vmsg)
+{
+    fprintf(stderr, "%s: Entry\n", __func__);
+    dev->postcopy_listening = false;
+    if (dev->postcopy_ufd > 0) {
+        close(dev->postcopy_ufd);
+        dev->postcopy_ufd = -1;
+        fprintf(stderr, "%s: Done close\n", __func__);
+    }
+
+    vmsg->fd_num = 0;
+    vmsg->payload.u64 = 0;
+    vmsg->size = sizeof(vmsg->payload.u64);
+    vmsg->flags = VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
+    fprintf(stderr, "%s: exit\n", __func__);
+    return true;
+}
+
 static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -956,6 +977,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_set_postcopy_advise(dev, vmsg);
     case VHOST_USER_POSTCOPY_LISTEN:
         return vu_set_postcopy_listen(dev, vmsg);
+    case VHOST_USER_POSTCOPY_END:
+        return vu_set_postcopy_end(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 86e1934ddb..1665c729f0 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -65,6 +65,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_INPUT_GET_CONFIG = 20,
     VHOST_USER_POSTCOPY_ADVISE  = 23,
     VHOST_USER_POSTCOPY_LISTEN  = 24,
+    VHOST_USER_POSTCOPY_END     = 25,
     VHOST_USER_MAX
 } VhostUserRequest;
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 74e4313782..b29a141703 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -69,6 +69,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_IOTLB_MSG = 22,
     VHOST_USER_POSTCOPY_ADVISE  = 23,
     VHOST_USER_POSTCOPY_LISTEN  = 24,
+    VHOST_USER_POSTCOPY_END     = 25,
     VHOST_USER_MAX
 } VhostUserRequest;
 
-- 
2.13.0
