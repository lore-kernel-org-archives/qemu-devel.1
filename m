Received: from eggs.gnu.org ([2001:4830:134:3::10]:34067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cboMF-0000Pf-G3
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cboME-00029l-Hu
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:55 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Feb 2017 14:01:09 +0100
Message-Id: <1486645277-4724-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486645277-4724-1-git-send-email-kraxel@redhat.com>
References: <1486645277-4724-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 02/10] vnc: do not disconnect on EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org

From: Michael Tokarev <mjt@tls.msk.ru>

When qemu vnc server is trying to send large update to clients,
there might be a situation when system responds with something
like EAGAIN, indicating that there's no system memory to send
that much data (depending on the network speed, client and server
and what is happening).  In this case, something like this happens
on qemu side (from strace):

sendmsg(16, {msg_name(0)=NULL,
        msg_iov(1)=[{"\244\"..., 729186}],
        msg_controllen=0, msg_flags=0}, 0) = 103950
sendmsg(16, {msg_name(0)=NULL,
        msg_iov(1)=[{"lz\346"..., 1559618}],
        msg_controllen=0, msg_flags=0}, 0) = -1 EAGAIN
sendmsg(-1, {msg_name(0)=NULL,
        msg_iov(1)=[{"lz\346"..., 1559618}],
        msg_controllen=0, msg_flags=0}, 0) = -1 EBADF

qemu closes the socket before the retry, and obviously it gets EBADF
when trying to send to -1.

This is because there WAS a special handling for EAGAIN, but now it doesn't
work anymore, after commit 04d2529da27db512dcbd5e99d0e26d333f16efcc, because
now in all error-like cases we initiate vnc disconnect.

This change were introduced in qemu 2.6, and caused numerous grief for many
people, resulting in their vnc clients reporting sporadic random disconnects
from vnc server.

Fix that by doing the disconnect only when necessary, i.e. omitting this
very case of EAGAIN.

Hopefully the existing condition (comparing with QIO_CHANNEL_ERR_BLOCK)
is sufficient, as the original code (before the above commit) were
checking for other errno values too.

Apparently there's another (semi?)bug exist somewhere here, since the
code tries to write to fd# -1, it probably should check if the connection
is open before. But this isn't important.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 1486115549-9398-1-git-send-email-mjt@msgid.tls.msk.ru
Fixes: 04d2529da27db512dcbd5e99d0e26d333f16efcc
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index cdeb79c..f2701e5 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1256,12 +1256,13 @@ ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
     if (ret <= 0) {
         if (ret == 0) {
             VNC_DEBUG("Closing down client sock: EOF\n");
+            vnc_disconnect_start(vs);
         } else if (ret != QIO_CHANNEL_ERR_BLOCK) {
             VNC_DEBUG("Closing down client sock: ret %zd (%s)\n",
                       ret, errp ? error_get_pretty(*errp) : "Unknown");
+            vnc_disconnect_start(vs);
         }
 
-        vnc_disconnect_start(vs);
         if (errp) {
             error_free(*errp);
             *errp = NULL;
-- 
1.8.3.1
