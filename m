Received: from eggs.gnu.org ([209.51.188.92]:35044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1pjk-0005aK-Qs
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1pjk-0007si-0z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:54:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1pjj-0007s9-NS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:54:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09488C05090A
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 09:54:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 10:54:38 +0100
Message-Id: <20190307095441.31921-2-kraxel@redhat.com>
In-Reply-To: <20190307095441.31921-1-kraxel@redhat.com>
References: <20190307095441.31921-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] usb-mtp: return incomplete transfer on a
 lstat failure
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

MTP writes objects in small chunks and at the end gets the
real file size to update the object metadata. If this fails for
any reason, return an INCOMPLETE_TRANSFER to the initiator

Spotted by Coverity: CID 1398651

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: 20190306210409.14842-2-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 4ee4fc5a893a..4dde14fc7887 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1591,14 +1591,18 @@ done:
         return ret;
 }
 
-static void usb_mtp_update_object(MTPObject *parent, char *name)
+static int usb_mtp_update_object(MTPObject *parent, char *name)
 {
+    int ret = -1;
+
     MTPObject *o =
         usb_mtp_object_lookup_name(parent, name, strlen(name));
 
     if (o) {
-        lstat(o->path, &o->stat);
+        ret = lstat(o->path, &o->stat);
     }
+
+    return ret;
 }
 
 static void usb_mtp_write_data(MTPState *s)
@@ -1655,13 +1659,18 @@ static void usb_mtp_write_data(MTPState *s)
         if (d->write_status != WRITE_END) {
             return;
         } else {
-            /* Only for < 4G file sizes */
-            if (s->dataset.size != 0xFFFFFFFF && d->offset != s->dataset.size) {
+            /*
+             * Return an incomplete transfer if file size doesn't match
+             * for < 4G file or if lstat fails which will result in an incorrect
+             * file size
+             */
+            if ((s->dataset.size != 0xFFFFFFFF &&
+                 d->offset != s->dataset.size) ||
+                usb_mtp_update_object(parent, s->dataset.filename)) {
                 usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->trans,
                                      0, 0, 0, 0);
                 goto done;
             }
-            usb_mtp_update_object(parent, s->dataset.filename);
         }
     }
 
-- 
2.18.1
