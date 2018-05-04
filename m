Received: from eggs.gnu.org ([2001:4830:134:3::10]:50356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fEXPb-0000Ol-QC
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fEXPW-0003p3-VV
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:53:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fEXPW-0003oB-RB
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:53:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE25240858CD
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 09:53:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  4 May 2018 10:53:46 +0100
Message-Id: <20180504095346.14159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] libvhost-user: Send messages with no data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The response to a VHOST_USER_POSTCOPY_ADVISE contains a fd but doesn't
actually contain any data.   FIx vu_message_write so that it doesn't
do a 0-byte write() call, since this was ending up with rc=0
that was confusing the error handling code.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index beeed0c43f..54e643d871 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -323,13 +323,15 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         rc = sendmsg(conn_fd, &msg, 0);
     } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
 
-    do {
-        if (vmsg->data) {
-            rc = write(conn_fd, vmsg->data, vmsg->size);
-        } else {
-            rc = write(conn_fd, p + VHOST_USER_HDR_SIZE, vmsg->size);
-        }
-    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+    if (vmsg->size) {
+        do {
+            if (vmsg->data) {
+                rc = write(conn_fd, vmsg->data, vmsg->size);
+            } else {
+                rc = write(conn_fd, p + VHOST_USER_HDR_SIZE, vmsg->size);
+            }
+        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+    }
 
     if (rc <= 0) {
         vu_panic(dev, "Error while writing: %s", strerror(errno));
-- 
2.17.0
