Received: from eggs.gnu.org ([2001:4830:134:3::10]:41771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R3-00026A-TO
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qt-0005E8-Uu
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qt-0005Cp-LT
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:47 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8jXT025524
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:46 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ae098une-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:46 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:45 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:28 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-65-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 64/81] vnc: do not disconnect on EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

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
(cherry picked from commit 537848ee62195fc06c328b1cd64f4218f404a7f1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 ui/vnc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 29aa9c4..552f1da 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1258,12 +1258,13 @@ ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
     if (ret <= 0) {
         if (ret == 0) {
             VNC_DEBUG("Closing down client sock: EOF\n");
+            vnc_disconnect_start(vs);
         } else if (ret != QIO_CHANNEL_ERR_BLOCK) {
             VNC_DEBUG("Closing down client sock: ret %d (%s)\n",
                       ret, errp ? error_get_pretty(*errp) : "Unknown");
+            vnc_disconnect_start(vs);
         }
 
-        vnc_disconnect_start(vs);
         if (errp) {
             error_free(*errp);
             *errp = NULL;
-- 
2.7.4
