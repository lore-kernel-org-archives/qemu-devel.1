Received: from eggs.gnu.org ([209.51.188.92]:35468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h2NlG-0002nu-Vn
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:14:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h2NlG-0005AS-7n
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:14:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1h2NlG-0005A7-1H
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:14:38 -0500
From: Bandan Das <bsd@redhat.com>
References: <20190307095441.31921-1-kraxel@redhat.com>
	<20190307095441.31921-4-kraxel@redhat.com>
	<CAFEAcA_HzSj7sQ+aKEwHmJXkJcG8yLmn5ZsZKM5xxYUrBxO2rQ@mail.gmail.com>
	<jpg36nxf8ta.fsf@linux.bootlegged.copy>
Date: Fri, 08 Mar 2019 17:14:33 -0500
In-Reply-To: <jpg36nxf8ta.fsf@linux.bootlegged.copy> (Bandan Das's message of
	"Fri, 08 Mar 2019 14:46:41 -0500")
Message-ID: <jpg8sxpypx2.fsf_-_@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] usb-mtp: fix return status of delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


Spotted by Coverity: CID 1399414

mtp delete allows the a return status of delete succeeded,
partial_delete or readonly - when none of the objects could be
deleted.

Some initiators recurse over the objects themselves. In that case,
only READ_ONLY can be returned.

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 06e376bcd2..e3401aad75 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1137,9 +1137,9 @@ static MTPData *usb_mtp_get_object_prop_value(MTPState *s, MTPControl *c,
 
 /* Return correct return code for a delete event */
 enum {
-    ALL_DELETE,
-    PARTIAL_DELETE,
+    ALL_DELETE = 1,
     READ_ONLY,
+    PARTIAL_DELETE,
 };
 
 /* Assumes that children, if any, have been already freed */
@@ -1155,8 +1155,7 @@ static void usb_mtp_object_free_one(MTPState *s, MTPObject *o)
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 {
     MTPObject *iter, *iter2;
-    bool partial_delete = false;
-    bool success = false;
+    int ret = 0;
 
     /*
      * TODO: Add support for Protection Status
@@ -1165,34 +1164,28 @@ static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
     QLIST_FOREACH(iter, &o->children, list) {
         if (iter->format == FMT_ASSOCIATION) {
             QLIST_FOREACH(iter2, &iter->children, list) {
-                usb_mtp_deletefn(s, iter2, trans);
+                ret |= usb_mtp_deletefn(s, iter2, trans);
             }
         }
     }
 
     if (o->format == FMT_UNDEFINED_OBJECT) {
         if (remove(o->path)) {
-            partial_delete = true;
+            ret |= READ_ONLY;
         } else {
             usb_mtp_object_free_one(s, o);
-            success = true;
+            ret |= ALL_DELETE;
         }
     } else if (o->format == FMT_ASSOCIATION) {
         if (rmdir(o->path)) {
-            partial_delete = true;
+            ret |= READ_ONLY;
         } else {
             usb_mtp_object_free_one(s, o);
-            success = true;
+            ret |= ALL_DELETE;
         }
     }
 
-    if (success && partial_delete) {
-        return PARTIAL_DELETE;
-    }
-    if (!success && partial_delete) {
-        return READ_ONLY;
-    }
-    return ALL_DELETE;
+    return ret;
 }
 
 static void usb_mtp_object_delete(MTPState *s, uint32_t handle,
-- 
2.19.2
