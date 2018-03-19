Received: from eggs.gnu.org ([2001:4830:134:3::10]:60849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1exp2x-0002hS-E5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1exp2u-0008Sh-MY
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:17:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:42870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1exp2u-0008Rg-EN
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:17:28 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Mon, 19 Mar 2018 15:15:32 +0800
Message-Id: <20180319071537.28649-2-tiwei.bie@intel.com>
In-Reply-To: <20180319071537.28649-1-tiwei.bie@intel.com>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH v2 1/6] vhost-user: support receiving file
 descriptors in slave_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 hw/virtio/vhost-user.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 41ff5cff41..1ad6caa6a3 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -674,14 +674,44 @@ static void slave_read(void *opaque)
     VhostUserHeader hdr = { 0, };
     VhostUserPayload payload = { 0, };
     int size, ret = 0;
+    struct iovec iov;
+    struct msghdr msgh;
+    int fd = -1;
+    size_t fdsize = sizeof(fd);
+    char control[CMSG_SPACE(fdsize)];
+    struct cmsghdr *cmsg;
+
+    memset(&msgh, 0, sizeof(msgh));
+    msgh.msg_iov = &iov;
+    msgh.msg_iovlen = 1;
+    msgh.msg_control = control;
+    msgh.msg_controllen = sizeof(control);
 
     /* Read header */
-    size = read(u->slave_fd, &hdr, VHOST_USER_HDR_SIZE);
+    iov.iov_base = &hdr;
+    iov.iov_len = VHOST_USER_HDR_SIZE;
+
+    size = recvmsg(u->slave_fd, &msgh, 0);
     if (size != VHOST_USER_HDR_SIZE) {
         error_report("Failed to read from slave.");
         goto err;
     }
 
+    if (msgh.msg_flags & MSG_CTRUNC) {
+        error_report("Truncated message.");
+        goto err;
+    }
+
+    for (cmsg = CMSG_FIRSTHDR(&msgh); cmsg != NULL;
+         cmsg = CMSG_NXTHDR(&msgh, cmsg)) {
+            if (cmsg->cmsg_level == SOL_SOCKET &&
+                cmsg->cmsg_type == SCM_RIGHTS) {
+                    fdsize = cmsg->cmsg_len - CMSG_LEN(0);
+                    memcpy(&fd, CMSG_DATA(cmsg), fdsize);
+                    break;
+            }
+    }
+
     if (hdr.size > VHOST_USER_PAYLOAD_SIZE) {
         error_report("Failed to read msg header."
                 " Size %d exceeds the maximum %zu.", hdr.size,
@@ -705,9 +735,15 @@ static void slave_read(void *opaque)
         break;
     default:
         error_report("Received unexpected msg type.");
+        if (fd != -1) {
+            close(fd);
+        }
         ret = -EINVAL;
     }
 
+    /* Message handlers need to make sure that fd will be consumed. */
+    fd = -1;
+
     /*
      * REPLY_ACK feature handling. Other reply types has to be managed
      * directly in their request handlers.
@@ -740,6 +776,9 @@ err:
     qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
     close(u->slave_fd);
     u->slave_fd = -1;
+    if (fd != -1) {
+        close(fd);
+    }
     return;
 }
 
-- 
2.11.0
