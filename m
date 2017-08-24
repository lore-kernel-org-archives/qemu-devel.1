Received: from eggs.gnu.org ([2001:4830:134:3::10]:52207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxnk-0002Fk-Dv
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxnj-0004ax-Bp
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxnj-0004aM-3E
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:23 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:08 +0100
Message-Id: <20170824192730.8440-11-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 10/32] vhub: Support sending fds back to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Allow replies with fds (for postcopy)

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 8bbdf5fb40..47884c0a15 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -213,6 +213,30 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
 {
     int rc;
     uint8_t *p = (uint8_t *)vmsg;
+    char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))] = { };
+    struct iovec iov = {
+        .iov_base = (char *)vmsg,
+        .iov_len = VHOST_USER_HDR_SIZE,
+    };
+    struct msghdr msg = {
+        .msg_iov = &iov,
+        .msg_iovlen = 1,
+        .msg_control = control,
+    };
+    struct cmsghdr *cmsg;
+
+    memset(control, 0, sizeof(control));
+    if (vmsg->fds) {
+        size_t fdsize = vmsg->fd_num * sizeof(int);
+        msg.msg_controllen = CMSG_SPACE(fdsize);
+        cmsg = CMSG_FIRSTHDR(&msg);
+        cmsg->cmsg_len = CMSG_LEN(fdsize);
+        cmsg->cmsg_level = SOL_SOCKET;
+        cmsg->cmsg_type = SCM_RIGHTS;
+        memcpy(CMSG_DATA(cmsg), vmsg->fds, fdsize);
+    } else {
+        msg.msg_controllen = 0;
+    }
 
     /* Set the version in the flags when sending the reply */
     vmsg->flags &= ~VHOST_USER_VERSION_MASK;
@@ -220,7 +244,7 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
     vmsg->flags |= VHOST_USER_REPLY_MASK;
 
     do {
-        rc = write(conn_fd, p, VHOST_USER_HDR_SIZE);
+        rc = sendmsg(conn_fd, &msg, 0);
     } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
 
     do {
@@ -313,6 +337,7 @@ vu_get_features_exec(VuDev *dev, VhostUserMsg *vmsg)
     }
 
     vmsg->size = sizeof(vmsg->payload.u64);
+    vmsg->fd_num = 0;
 
     DPRINT("Sending back to guest u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
 
@@ -454,6 +479,7 @@ vu_set_log_base_exec(VuDev *dev, VhostUserMsg *vmsg)
     dev->log_size = log_mmap_size;
 
     vmsg->size = sizeof(vmsg->payload.u64);
+    vmsg->fd_num = 0;
 
     return true;
 }
@@ -698,6 +724,7 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     vmsg->payload.u64 = features;
     vmsg->size = sizeof(vmsg->payload.u64);
+    vmsg->fd_num = 0;
 
     return true;
 }
-- 
2.13.5
