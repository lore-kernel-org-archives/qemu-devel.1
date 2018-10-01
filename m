Received: from eggs.gnu.org ([2001:4830:134:3::10]:44240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6uVe-0004Yw-MN
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6uVd-0000ZW-PG
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:28:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g6uVd-0000Z8-I1
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:28:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D84B0C025D20
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 09:28:56 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  1 Oct 2018 11:28:44 +0200
Message-Id: <20181001092848.11082-2-kraxel@redhat.com>
In-Reply-To: <20181001092848.11082-1-kraxel@redhat.com>
References: <20181001092848.11082-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] usb-mtp: fix error conditions for write
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Bandan <bsd@redhat.com>

From: Bandan <bsd@redhat.com>

Return STORE_FULL if we can't write all the bytes but
return incomplete transfer if data received is less then
what was specified in the metadata. Also, use d->offset
as the file size which is valid for all file sizes.

Signed-off-by: Bandan <bsd@redhat.com>
Message-id: 20180907220851.9658-2-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 3fdc4b0da1..15edf3bb82 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1665,13 +1665,14 @@ static void usb_mtp_write_data(MTPState *s)
             goto success;
         }
 
-        rc = write_retry(d->fd, d->data, s->dataset.size);
-        if (!rc) {
+        rc = write_retry(d->fd, d->data, d->offset);
+        if (rc != d->offset) {
             usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                  0, 0, 0, 0);
             goto done;
             }
-        if (rc != s->dataset.size) {
+        /* Only for < 4G file sizes */
+        if (s->dataset.size != 0xFFFFFFFF && rc != s->dataset.size) {
             usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->trans,
                                  0, 0, 0, 0);
             goto done;
-- 
2.9.3
