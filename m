Received: from eggs.gnu.org ([2001:4830:134:3::10]:38389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLnYl-0003Sb-US
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLnYj-00053a-Oy
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:33:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:6492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fLnYj-00052U-Fy
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:33:25 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 24 May 2018 18:33:32 +0800
Message-Id: <20180524103336.21233-3-tiwei.bie@intel.com>
In-Reply-To: <20180524103336.21233-1-tiwei.bie@intel.com>
References: <20180524103336.21233-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH 2/6] vhost-user: allow slave to send fds via
 slave channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: tiwei.bie@intel.com

Introduce VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD protocol
feature to allow slave to send at most 8 descriptors
in each message to master via ancillary data using the
slave channel.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 docs/interop/vhost-user.txt |  5 +++++
 hw/virtio/vhost-user.c      | 27 +++++++++++++++++----------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 534caab18a..682a683eb4 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -367,6 +367,10 @@ The fd is provided via VHOST_USER_SET_SLAVE_REQ_FD ancillary data.
 A slave may then send VHOST_USER_SLAVE_* messages to the master
 using this fd communication channel.
 
+If VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD protocol feature is negotiated,
+slave can send file descriptors (at most 8 descriptors in each message)
+to master via ancillary data using this fd communication channel.
+
 Protocol features
 -----------------
 
@@ -380,6 +384,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
 #define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
 #define VHOST_USER_PROTOCOL_F_CONFIG         9
+#define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
 
 Master message types
 --------------------
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index da0756effe..75a3faef2a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -30,6 +30,7 @@
 
 #define VHOST_MEMORY_MAX_NREGIONS    8
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
+#define VHOST_USER_SLAVE_MAX_FDS     8
 
 /*
  * Maximum size of virtio device config space
@@ -47,6 +48,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
     VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
     VHOST_USER_PROTOCOL_F_CONFIG = 9,
+    VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -854,10 +856,10 @@ static void slave_read(void *opaque)
     int size, ret = 0;
     struct iovec iov;
     struct msghdr msgh;
-    int fd = -1;
+    int fd[VHOST_USER_SLAVE_MAX_FDS];
     char control[CMSG_SPACE(sizeof(fd))];
     struct cmsghdr *cmsg;
-    size_t fdsize;
+    int i, fdsize = 0;
 
     memset(&msgh, 0, sizeof(msgh));
     msgh.msg_iov = &iov;
@@ -865,6 +867,8 @@ static void slave_read(void *opaque)
     msgh.msg_control = control;
     msgh.msg_controllen = sizeof(control);
 
+    memset(fd, -1, sizeof(fd));
+
     /* Read header */
     iov.iov_base = &hdr;
     iov.iov_len = VHOST_USER_HDR_SIZE;
@@ -885,7 +889,7 @@ static void slave_read(void *opaque)
             if (cmsg->cmsg_level == SOL_SOCKET &&
                 cmsg->cmsg_type == SCM_RIGHTS) {
                     fdsize = cmsg->cmsg_len - CMSG_LEN(0);
-                    memcpy(&fd, CMSG_DATA(cmsg), fdsize);
+                    memcpy(fd, CMSG_DATA(cmsg), fdsize);
                     break;
             }
     }
@@ -913,14 +917,15 @@ static void slave_read(void *opaque)
         break;
     default:
         error_report("Received unexpected msg type.");
-        if (fd != -1) {
-            close(fd);
-        }
         ret = -EINVAL;
     }
 
-    /* Message handlers need to make sure that fd will be consumed. */
-    fd = -1;
+    /* Close the remaining file descriptors. */
+    for (i = 0; i < fdsize; i++) {
+        if (fd[i] != -1) {
+            close(fd[i]);
+        }
+    }
 
     /*
      * REPLY_ACK feature handling. Other reply types has to be managed
@@ -954,8 +959,10 @@ err:
     qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
     close(u->slave_fd);
     u->slave_fd = -1;
-    if (fd != -1) {
-        close(fd);
+    for (i = 0; i < fdsize; i++) {
+        if (fd[i] != -1) {
+            close(fd[i]);
+        }
     }
     return;
 }
-- 
2.17.0
