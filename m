Received: from eggs.gnu.org ([209.51.188.92]:35062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1pjl-0005aq-CN
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1pjk-0007tC-I8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:54:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1pjk-0007sW-88
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:54:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8513386679
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 09:54:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 10:54:39 +0100
Message-Id: <20190307095441.31921-3-kraxel@redhat.com>
In-Reply-To: <20190307095441.31921-1-kraxel@redhat.com>
References: <20190307095441.31921-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] usb-mtp: fix some usb_mtp_write_data return
 paths
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

During a write, free up the "path" before getting more data.
Also, while we at it, remove the confusing usage of d->fd for
storing mkdir status

Spotted by Coverity: CID 1398642

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: 20190306210409.14842-3-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 4dde14fc7887..1f22284949df 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1605,7 +1605,7 @@ static int usb_mtp_update_object(MTPObject *parent, char *name)
     return ret;
 }
 
-static void usb_mtp_write_data(MTPState *s)
+static int usb_mtp_write_data(MTPState *s)
 {
     MTPData *d = s->data_out;
     MTPObject *parent =
@@ -1613,6 +1613,7 @@ static void usb_mtp_write_data(MTPState *s)
     char *path = NULL;
     uint64_t rc;
     mode_t mask = 0644;
+    int ret = 0;
 
     assert(d != NULL);
 
@@ -1621,13 +1622,13 @@ static void usb_mtp_write_data(MTPState *s)
         if (!parent || !s->write_pending) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
                 0, 0, 0, 0);
-        return;
+        return 1;
         }
 
         if (s->dataset.filename) {
             path = g_strdup_printf("%s/%s", parent->path, s->dataset.filename);
             if (s->dataset.format == FMT_ASSOCIATION) {
-                d->fd = mkdir(path, mask);
+                ret = mkdir(path, mask);
                 goto free;
             }
             d->fd = open(path, O_CREAT | O_WRONLY |
@@ -1657,7 +1658,8 @@ static void usb_mtp_write_data(MTPState *s)
             goto done;
         }
         if (d->write_status != WRITE_END) {
-            return;
+            g_free(path);
+            return ret;
         } else {
             /*
              * Return an incomplete transfer if file size doesn't match
@@ -1685,12 +1687,14 @@ done:
      */
     if (d->fd != -1) {
         close(d->fd);
+        d->fd = -1;
     }
 free:
     g_free(s->dataset.filename);
     s->dataset.size = 0;
     g_free(path);
     s->write_pending = false;
+    return ret;
 }
 
 static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
@@ -1727,14 +1731,12 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
     s->write_pending = true;
 
     if (s->dataset.format == FMT_ASSOCIATION) {
-        usb_mtp_write_data(s);
-        /* next_handle will be allocated to the newly created dir */
-        if (d->fd == -1) {
+        if (usb_mtp_write_data(s)) {
+            /* next_handle will be allocated to the newly created dir */
             usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                  0, 0, 0, 0);
             return;
         }
-        d->fd = -1;
     }
 
     usb_mtp_queue_result(s, RES_OK, d->trans, 3, QEMU_STORAGE_ID,
-- 
2.18.1
