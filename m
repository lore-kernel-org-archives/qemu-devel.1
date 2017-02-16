Received: from eggs.gnu.org ([2001:4830:134:3::10]:57672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceLsZ-0001ky-8k
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceLsW-0000Xe-86
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:13:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ceLsW-0000Wi-2P
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:13:44 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BD223E9
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 13:13:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Feb 2017 14:13:38 +0100
Message-Id: <1487250819-23764-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487250819-23764-1-git-send-email-kraxel@redhat.com>
References: <1487250819-23764-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] usb-ccid: move header size check
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

Move up header size check, so we can use header fields in sanity checks
(in followup patches).  Also reword the debug message.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index badcfcb..1acc1fb 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1003,21 +1003,20 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
     if (p->iov.size + s->bulk_out_pos > BULK_OUT_DATA_SIZE) {
         goto err;
     }
-    ccid_header = (CCID_Header *)s->bulk_out_data;
     usb_packet_copy(p, s->bulk_out_data + s->bulk_out_pos, p->iov.size);
     s->bulk_out_pos += p->iov.size;
+    if (s->bulk_out_pos < 10) {
+        DPRINTF(s, 1, "%s: header incomplete\n", __func__);
+        goto err;
+    }
+
+    ccid_header = (CCID_Header *)s->bulk_out_data;
     if (p->iov.size == CCID_MAX_PACKET_SIZE) {
         DPRINTF(s, D_VERBOSE,
             "usb-ccid: bulk_in: expecting more packets (%zd/%d)\n",
             p->iov.size, ccid_header->dwLength);
         return;
     }
-    if (s->bulk_out_pos < 10) {
-        DPRINTF(s, 1,
-                "%s: bad USB_TOKEN_OUT length, should be at least 10 bytes\n",
-                __func__);
-        goto err;
-    }
 
     DPRINTF(s, D_MORE_INFO, "%s %x %s\n", __func__,
             ccid_header->bMessageType,
-- 
1.8.3.1
