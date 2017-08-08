Received: from eggs.gnu.org ([2001:4830:134:3::10]:36147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfBQd-0006xw-8x
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfBQc-0007RF-7K
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:48:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dfBQc-0007QK-10
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:48:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3C03A723
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 20:39:42 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Tue,  8 Aug 2017 22:38:58 +0200
Message-Id: <20170808203900.7661-4-jfreimann@redhat.com>
In-Reply-To: <20170808203900.7661-1-jfreimann@redhat.com>
References: <20170808203900.7661-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/5] libvhost-user: quit when no more data
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
Cc: marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com, jasowang@redhat.com, stefanha@redhat.com

From: Jens Freimann <jfreiman@redhat.com>

End processing of messages when VHOST_USER_NONE
is received.

Without this we run into a vubr_panic() call and get
"PANIC: Unhandled request: 0"

Signed-off-by: Jens Freimann <jfreiman@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 9efb9dac0e..35fa0c5e56 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -161,7 +161,7 @@ vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         rc = recvmsg(conn_fd, &msg, 0);
     } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
 
-    if (rc <= 0) {
+    if (rc < 0) {
         vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
         return false;
     }
@@ -806,6 +806,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_get_queue_num_exec(dev, vmsg);
     case VHOST_USER_SET_VRING_ENABLE:
         return vu_set_vring_enable_exec(dev, vmsg);
+    case VHOST_USER_NONE:
+        break;
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
-- 
2.13.3
