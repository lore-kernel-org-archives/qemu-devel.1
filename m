Received: from eggs.gnu.org ([2001:4830:134:3::10]:37249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs2hk-0008Fr-2N
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs2hd-0000dw-3I
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:11:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs2hc-0000cN-Co
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:11:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22F84B5C3
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 09:11:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 11:11:45 +0200
Message-Id: <20180821091148.32220-5-kraxel@redhat.com>
In-Reply-To: <20180821091148.32220-1-kraxel@redhat.com>
References: <20180821091148.32220-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] dev-mtp: fix buffer allocation for writing
 file contents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>

From: Bandan Das <bsd@redhat.com>

usb_mtp_realloc() was being incorrectly used when allocating
buffer for incoming data. Set d->length only after resizing
the buffer.

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: 20180720214020.22897-3-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index c40b0de0bb..1b72603dc5 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1721,6 +1721,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
     MTPData *d = s->data_out;
     uint64_t dlen;
     uint32_t data_len = p->iov.size;
+    uint64_t total_len;
 
     if (!d) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, 0,
@@ -1729,10 +1730,11 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
     }
     if (d->first) {
         /* Total length of incoming data */
-        d->length = cpu_to_le32(container->length) - sizeof(mtp_container);
+        total_len = cpu_to_le32(container->length) - sizeof(mtp_container);
         /* Length of data in this packet */
         data_len -= sizeof(mtp_container);
-        usb_mtp_realloc(d, d->length);
+        usb_mtp_realloc(d, total_len);
+        d->length += total_len;
         d->offset = 0;
         d->first = false;
     }
-- 
2.9.3
