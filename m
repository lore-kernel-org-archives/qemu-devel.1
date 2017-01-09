Received: from eggs.gnu.org ([2001:4830:134:3::10]:54566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQZi2-00055L-9c
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQZhv-0008Su-T0
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQZhv-0008S5-Nn
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:51 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF53B3B706
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 13:09:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  9 Jan 2017 14:09:43 +0100
Message-Id: <1483967385-12891-10-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v2 09/11] ui/vnc: Fix problem with sending too
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
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

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
1.8.3.1
