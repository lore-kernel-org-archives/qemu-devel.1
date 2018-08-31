Received: from eggs.gnu.org ([2001:4830:134:3::10]:38430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fvouK-0006Bt-T9
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 15:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fvouG-0003ZN-MY
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 15:16:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fvouG-0003Yx-Gd
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 15:16:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42A712636D
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 19:16:31 +0000 (UTC)
From: Bandan <bsd@redhat.com>
Date: Fri, 31 Aug 2018 15:16:18 -0400
Message-Id: <20180831191619.20275-2-bsd@redhat.com>
In-Reply-To: <20180831191619.20275-1-bsd@redhat.com>
References: <20180831191619.20275-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] usb-mtp: fix error conditions for write
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
Cc: kraxel@redhat.com

Return STORE_FULL if we can't write all the bytes but
return incomplete transfer if data received is less then
what was specified in the metadata. Also, use d->offset
as the file size which is valid for all file sizes.

Signed-off-by: Bandan <bsd@redhat.com>
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
2.11.0
