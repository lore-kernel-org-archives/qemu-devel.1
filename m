Received: from eggs.gnu.org ([2001:4830:134:3::10]:42723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fgd8g-0005DH-Fu
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fgd8d-0005mi-9C
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fgd8d-0005lO-4S
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16CF2FA449
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 21:40:34 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Fri, 20 Jul 2018 17:40:17 -0400
Message-Id: <20180720214020.22897-3-bsd@redhat.com>
In-Reply-To: <20180720214020.22897-1-bsd@redhat.com>
References: <20180720214020.22897-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] dev-mtp: fix buffer allocation for writing
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
Cc: kraxel@redhat.com

usb_mtp_realloc() was being incorrectly used when allocating
buffer for incoming data. Set d->length only after resizing
the buffer.

Signed-off-by: Bandan Das <bsd@redhat.com>
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
2.14.4
