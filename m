Received: from eggs.gnu.org ([209.51.188.92]:59252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDtl-0004px-O2
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDfY-0007UY-9p
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:17:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hBDC2-0005Sq-4B
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:46:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63030307D973
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 06:46:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  2 Apr 2019 08:46:38 +0200
Message-Id: <20190402064639.27108-5-kraxel@redhat.com>
In-Reply-To: <20190402064639.27108-1-kraxel@redhat.com>
References: <20190402064639.27108-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] usb-mtp: remove usb_mtp_object_free_one
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

This function is used in the delete path only and can
be replaced by a call to usb_mtp_object_free.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bandan Das <bsd@redhat.com>
Message-Id: <20190401211712.19012-3-bsd@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 91b820baafd8..4dc1317e2e49 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1150,16 +1150,6 @@ enum {
     DELETE_PARTIAL = (DELETE_FAILURE | DELETE_SUCCESS),
 };
 
-/* Assumes that children, if any, have been already freed */
-static void usb_mtp_object_free_one(MTPState *s, MTPObject *o)
-{
-    assert(o->nchildren == 0);
-    QTAILQ_REMOVE(&s->objects, o, next);
-    g_free(o->name);
-    g_free(o->path);
-    g_free(o);
-}
-
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 {
     MTPObject *iter, *iter2;
@@ -1181,14 +1171,14 @@ static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
         if (remove(o->path)) {
             ret |= DELETE_FAILURE;
         } else {
-            usb_mtp_object_free_one(s, o);
+            usb_mtp_object_free(s, o);
             ret |= DELETE_SUCCESS;
         }
     } else if (o->format == FMT_ASSOCIATION) {
         if (rmdir(o->path)) {
             ret |= DELETE_FAILURE;
         } else {
-            usb_mtp_object_free_one(s, o);
+            usb_mtp_object_free(s, o);
             ret |= DELETE_SUCCESS;
         }
     }
-- 
2.18.1
