Received: from eggs.gnu.org ([209.51.188.92]:59517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDtw-00051S-SH
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDnm-0003vD-RO
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:25:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hBDC2-0005VH-LW
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:46:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E954F3082B71
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 06:46:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  2 Apr 2019 08:46:37 +0200
Message-Id: <20190402064639.27108-4-kraxel@redhat.com>
In-Reply-To: <20190402064639.27108-1-kraxel@redhat.com>
References: <20190402064639.27108-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] usb-mtp: fix return status of delete
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

Spotted by Coverity: CID 1399414

mtp delete allows the return status of delete succeeded,
partial_delete or readonly - when none of the objects could be
deleted. Give more meaningful names to return values of the
delete function.

Some initiators recurse over the objects themselves. In that case,
only READ_ONLY can be returned.

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-Id: <20190401211712.19012-2-bsd@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 62 ++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 06e376bcd211..91b820baafd8 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1135,11 +1135,19 @@ static MTPData *usb_mtp_get_object_prop_value(MTPState *s, MTPControl *c,
     return d;
 }
 
-/* Return correct return code for a delete event */
+/*
+ * Return values when object @o is deleted.
+ * If at least one of the deletions succeeded,
+ * DELETE_SUCCESS is set and if at least one
+ * of the deletions failed, DELETE_FAILURE is
+ * set. Both bits being set (DELETE_PARTIAL)
+ * signifies a  RES_PARTIAL_DELETE being sent
+ * back to the initiator.
+ */
 enum {
-    ALL_DELETE,
-    PARTIAL_DELETE,
-    READ_ONLY,
+    DELETE_SUCCESS = (1 << 0),
+    DELETE_FAILURE = (1 << 1),
+    DELETE_PARTIAL = (DELETE_FAILURE | DELETE_SUCCESS),
 };
 
 /* Assumes that children, if any, have been already freed */
@@ -1155,8 +1163,7 @@ static void usb_mtp_object_free_one(MTPState *s, MTPObject *o)
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 {
     MTPObject *iter, *iter2;
-    bool partial_delete = false;
-    bool success = false;
+    int ret = 0;
 
     /*
      * TODO: Add support for Protection Status
@@ -1165,34 +1172,28 @@ static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
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
+            ret |= DELETE_FAILURE;
         } else {
             usb_mtp_object_free_one(s, o);
-            success = true;
+            ret |= DELETE_SUCCESS;
         }
     } else if (o->format == FMT_ASSOCIATION) {
         if (rmdir(o->path)) {
-            partial_delete = true;
+            ret |= DELETE_FAILURE;
         } else {
             usb_mtp_object_free_one(s, o);
-            success = true;
+            ret |= DELETE_SUCCESS;
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
@@ -1226,19 +1227,24 @@ static void usb_mtp_object_delete(MTPState *s, uint32_t handle,
     }
 
     ret = usb_mtp_deletefn(s, o, trans);
-    if (ret == PARTIAL_DELETE) {
-        usb_mtp_queue_result(s, RES_PARTIAL_DELETE,
-                             trans, 0, 0, 0, 0);
-        return;
-    } else if (ret == READ_ONLY) {
-        usb_mtp_queue_result(s, RES_STORE_READ_ONLY, trans,
-                             0, 0, 0, 0);
-        return;
-    } else {
+    switch (ret) {
+    case DELETE_SUCCESS:
         usb_mtp_queue_result(s, RES_OK, trans,
                              0, 0, 0, 0);
-        return;
+        break;
+    case DELETE_FAILURE:
+        usb_mtp_queue_result(s, RES_PARTIAL_DELETE,
+                             trans, 0, 0, 0, 0);
+        break;
+    case DELETE_PARTIAL:
+        usb_mtp_queue_result(s, RES_PARTIAL_DELETE,
+                             trans, 0, 0, 0, 0);
+        break;
+    default:
+        g_assert_not_reached();
     }
+
+    return;
 }
 
 static void usb_mtp_command(MTPState *s, MTPControl *c)
-- 
2.18.1
