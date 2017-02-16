Received: from eggs.gnu.org ([2001:4830:134:3::10]:57674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceLsZ-0001l0-8m
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceLsW-0000Xj-8q
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:13:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ceLsW-0000Wk-2X
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:13:44 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53D38C04B321
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 13:13:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Feb 2017 14:13:39 +0100
Message-Id: <1487250819-23764-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487250819-23764-1-git-send-email-kraxel@redhat.com>
References: <1487250819-23764-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] usb-ccid: add check message size checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Check message size too when figuring whenever we should expect more data.
Fix debug message to show useful data, p->iov.size is fixed anyway if we
land there, print how much we got meanwhile instead.

Also check announced message size against actual message size.  That
is a more general fix for CVE-2017-5898 than commit "c7dfbf3 usb: ccid:
check ccid apdu length".

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 1acc1fb..7cd4ed0 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1011,12 +1011,19 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
     }
 
     ccid_header = (CCID_Header *)s->bulk_out_data;
-    if (p->iov.size == CCID_MAX_PACKET_SIZE) {
+    if ((s->bulk_out_pos - 10 < ccid_header->dwLength) &&
+        (p->iov.size == CCID_MAX_PACKET_SIZE)) {
         DPRINTF(s, D_VERBOSE,
-            "usb-ccid: bulk_in: expecting more packets (%zd/%d)\n",
-            p->iov.size, ccid_header->dwLength);
+                "usb-ccid: bulk_in: expecting more packets (%d/%d)\n",
+                s->bulk_out_pos - 10, ccid_header->dwLength);
         return;
     }
+    if (s->bulk_out_pos - 10 != ccid_header->dwLength) {
+        DPRINTF(s, 1,
+                "usb-ccid: bulk_in: message size mismatch (got %d, expected %d)\n",
+                s->bulk_out_pos - 10, ccid_header->dwLength);
+        goto err;
+    }
 
     DPRINTF(s, D_MORE_INFO, "%s %x %s\n", __func__,
             ccid_header->bMessageType,
-- 
1.8.3.1
