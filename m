Received: from eggs.gnu.org ([2001:4830:134:3::10]:60100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfG9F-0003Br-Kl
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfG9E-00068Q-HB
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:51:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dfG9E-000686-Ag
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:51:00 -0400
Date: Wed, 9 Aug 2017 04:50:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1502241852-6302-5-git-send-email-mst@redhat.com>
References: <1502241852-6302-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502241852-6302-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] libvhost-user: quit when no more data
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jens Freimann <jfreiman@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Jens Freimann <jfreiman@redhat.com>

End processing of messages when VHOST_USER_NONE
is received.

Without this we run into a vubr_panic() call and get
"PANIC: Unhandled request: 0"

Signed-off-by: Jens Freimann <jfreiman@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 9efb9da..35fa0c5 100644
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
MST
