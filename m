Received: from eggs.gnu.org ([2001:4830:134:3::10]:48884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyr-0001ly-Jw
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyq-0000nl-MG
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyq-0000nf-Gb
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:08 -0400
Date: Wed, 23 May 2018 17:43:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-14-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 13/28] vhost-user: support receiving file
 descriptors in slave_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Tiwei Bie <tiwei.bie@intel.com>

From: Tiwei Bie <tiwei.bie@intel.com>

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 38da869..85d8fd2 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -852,14 +852,44 @@ static void slave_read(void *opaque)
     VhostUserHeader hdr = { 0, };
     VhostUserPayload payload = { 0, };
     int size, ret = 0;
+    struct iovec iov;
+    struct msghdr msgh;
+    int fd = -1;
+    char control[CMSG_SPACE(sizeof(fd))];
+    struct cmsghdr *cmsg;
+    size_t fdsize;
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
@@ -883,9 +913,15 @@ static void slave_read(void *opaque)
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
@@ -918,6 +954,9 @@ err:
     qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
     close(u->slave_fd);
     u->slave_fd = -1;
+    if (fd != -1) {
+        close(fd);
+    }
     return;
 }
 
-- 
MST
