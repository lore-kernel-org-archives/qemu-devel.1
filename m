Received: from eggs.gnu.org ([2001:4830:134:3::10]:41052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Ql-0001jv-RC
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qg-0004zB-EV
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51920
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qg-0004xy-6P
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8dCp108670
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:33 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29aeabyxmf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:33 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:32 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:07 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-44-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 43/81] ui/vnc: Fix problem with sending too
 many bytes as server name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Thomas Huth <thuth@redhat.com>

If the buffer is not big enough, snprintf() does not return the number
of bytes that have been written to the buffer, but the number of bytes
that would be needed for writing the whole string. By using this value
for the following vnc_write() calls, we send some junk at the end of
the name in case the qemu_name is longer than 1017 bytes, which could
confuse the VNC clients. Fix this by adding an additional size check
here.

Buglink: https://bugs.launchpad.net/qemu/+bug/1637447
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 1479749115-21932-1-git-send-email-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 97efe4f961dcf5a0126baa75e8a6bff66d33186f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 ui/vnc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 2c28a59..29aa9c4 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2459,10 +2459,14 @@ static int protocol_client_init(VncState *vs, uint8_t *data, size_t len)
 
     pixel_format_message(vs);
 
-    if (qemu_name)
+    if (qemu_name) {
         size = snprintf(buf, sizeof(buf), "QEMU (%s)", qemu_name);
-    else
+        if (size > sizeof(buf)) {
+            size = sizeof(buf);
+        }
+    } else {
         size = snprintf(buf, sizeof(buf), "QEMU");
+    }
 
     vnc_write_u32(vs, size);
     vnc_write(vs, buf, size);
-- 
2.7.4
