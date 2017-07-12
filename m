Received: from eggs.gnu.org ([2001:4830:134:3::10]:43770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dVEAE-0000fV-7E
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dVEAD-0002y7-F7
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:42:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dVEAD-0002xr-8V
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:42:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30E8AC0587C0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 09:42:32 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Wed, 12 Jul 2017 11:41:49 +0200
Message-Id: <20170712094149.23069-4-jfreimann@redhat.com>
In-Reply-To: <20170712094149.23069-1-jfreimann@redhat.com>
References: <20170712094149.23069-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 3/3] libvhost-user: quit when no more data
 received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com

From: Jens Freimann <jfreiman@redhat.com>

When recvmsg() returns a message size of zero and
errno is ENOENT end processing of vhost-user messages.

Without this we run into a vubr_panic() call and get
     PANIC: Error while recvmsg: No such file or directory
     Error while dispatching.

Add a switch "quit" to the vhost user device and set true to stop
processing messages.

Signed-off-by: Jens Freimann <jfreiman@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 12 +++++++++++-
 contrib/libvhost-user/libvhost-user.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 9efb9da..5538859 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -161,7 +161,10 @@ vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         rc = recvmsg(conn_fd, &msg, 0);
     } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
 
-    if (rc <= 0) {
+    if (rc == 0 && (errno == ENOENT)) {
+        vmsg->size = 0;
+        dev->quit = true;
+    } else if (rc < 0) {
         vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
         return false;
     }
@@ -755,6 +758,10 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
     DPRINT("Flags:   0x%x\n", vmsg->flags);
     DPRINT("Size:    %d\n", vmsg->size);
 
+    if (dev->quit) {
+        return true;
+    }
+
     if (vmsg->fd_num) {
         int i;
         DPRINT("Fds:");
@@ -822,6 +829,9 @@ vu_dispatch(VuDev *dev)
     bool success = false;
 
     if (!vu_message_read(dev, dev->sock, &vmsg)) {
+        if (vmsg.size == 0) {
+            success = true;
+        }
         goto end;
     }
 
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 53ef222..c02215a 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -217,6 +217,7 @@ struct VuDev {
     uint64_t features;
     uint64_t protocol_features;
     bool broken;
+    bool quit;
 
     /* @set_watch: add or update the given fd to the watch set,
      * call cb when condition is met */
-- 
2.9.4
