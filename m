Received: from eggs.gnu.org ([209.51.188.92]:48670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hB4O5-0004r8-RX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hB4O4-00086f-OX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:22:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hB4O4-000866-ED
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:22:36 -0400
From: Bandan Das <bsd@redhat.com>
Date: Mon,  1 Apr 2019 17:17:10 -0400
Message-Id: <20190401211712.19012-2-bsd@redhat.com>
In-Reply-To: <20190401211712.19012-1-bsd@redhat.com>
References: <20190401211712.19012-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/3] usb-mtp: fix return status of delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, peter.maydell@linaro.org

Spotted by Coverity: CID 1399414

mtp delete allows the return status of delete succeeded,
partial_delete or readonly - when none of the objects could be
deleted. Give more meaningful names to return values of the
delete function.

Some initiators recurse over the objects themselves. In that case,
only READ_ONLY can be returned.

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 62 ++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 06e376bcd2..91b820baaf 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1135,11 +1135,19 @@ static MTPData *usb_mtp_get_object_prop_value(MTP=
State *s, MTPControl *c,
     return d;
 }
=20
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
+    DELETE_SUCCESS =3D (1 << 0),
+    DELETE_FAILURE =3D (1 << 1),
+    DELETE_PARTIAL =3D (DELETE_FAILURE | DELETE_SUCCESS),
 };
=20
 /* Assumes that children, if any, have been already freed */
@@ -1155,8 +1163,7 @@ static void usb_mtp_object_free_one(MTPState *s, MT=
PObject *o)
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 {
     MTPObject *iter, *iter2;
-    bool partial_delete =3D false;
-    bool success =3D false;
+    int ret =3D 0;
=20
     /*
      * TODO: Add support for Protection Status
@@ -1165,34 +1172,28 @@ static int usb_mtp_deletefn(MTPState *s, MTPObjec=
t *o, uint32_t trans)
     QLIST_FOREACH(iter, &o->children, list) {
         if (iter->format =3D=3D FMT_ASSOCIATION) {
             QLIST_FOREACH(iter2, &iter->children, list) {
-                usb_mtp_deletefn(s, iter2, trans);
+                ret |=3D usb_mtp_deletefn(s, iter2, trans);
             }
         }
     }
=20
     if (o->format =3D=3D FMT_UNDEFINED_OBJECT) {
         if (remove(o->path)) {
-            partial_delete =3D true;
+            ret |=3D DELETE_FAILURE;
         } else {
             usb_mtp_object_free_one(s, o);
-            success =3D true;
+            ret |=3D DELETE_SUCCESS;
         }
     } else if (o->format =3D=3D FMT_ASSOCIATION) {
         if (rmdir(o->path)) {
-            partial_delete =3D true;
+            ret |=3D DELETE_FAILURE;
         } else {
             usb_mtp_object_free_one(s, o);
-            success =3D true;
+            ret |=3D DELETE_SUCCESS;
         }
     }
=20
-    if (success && partial_delete) {
-        return PARTIAL_DELETE;
-    }
-    if (!success && partial_delete) {
-        return READ_ONLY;
-    }
-    return ALL_DELETE;
+    return ret;
 }
=20
 static void usb_mtp_object_delete(MTPState *s, uint32_t handle,
@@ -1226,19 +1227,24 @@ static void usb_mtp_object_delete(MTPState *s, ui=
nt32_t handle,
     }
=20
     ret =3D usb_mtp_deletefn(s, o, trans);
-    if (ret =3D=3D PARTIAL_DELETE) {
-        usb_mtp_queue_result(s, RES_PARTIAL_DELETE,
-                             trans, 0, 0, 0, 0);
-        return;
-    } else if (ret =3D=3D READ_ONLY) {
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
=20
 static void usb_mtp_command(MTPState *s, MTPControl *c)
--=20
2.19.2
