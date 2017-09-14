Received: from eggs.gnu.org ([2001:4830:134:3::10]:48002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1dsMl2-0002tE-LP
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1dsMl0-0006QN-0E
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1dsMkz-0006Mt-O4
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF97DC04B303
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 05:32:08 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Thu, 14 Sep 2017 01:31:46 -0400
Message-Id: <20170914053148.2512-4-bsd@redhat.com>
In-Reply-To: <20170914053148.2512-1-bsd@redhat.com>
References: <20170914053148.2512-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] usb-mtp: Support delete of mtp objects
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

From: Bandan Das <bsd@makefile.in>

This is required because write of existing objects by the
initiator is acheived by making a temporary buffer with the
new changes, deleting the old file and then writing a new file
with the same name.

Note that this operation will fail as of this patch
since the store is advertised RO

Signed-off-by: Bandan Das <bsd@makefile.in>
---
 hw/usb/dev-mtp.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 63f8f3b..76494f3 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -46,6 +46,7 @@ enum mtp_code {
     CMD_GET_OBJECT_HANDLES         = 0x1007,
     CMD_GET_OBJECT_INFO            = 0x1008,
     CMD_GET_OBJECT                 = 0x1009,
+    CMD_DELETE_OBJECT              = 0x100b,
     CMD_GET_PARTIAL_OBJECT         = 0x101b,
     CMD_GET_OBJECT_PROPS_SUPPORTED = 0x9801,
     CMD_GET_OBJECT_PROP_DESC       = 0x9802,
@@ -62,6 +63,8 @@ enum mtp_code {
     RES_INVALID_STORAGE_ID         = 0x2008,
     RES_INVALID_OBJECT_HANDLE      = 0x2009,
     RES_INVALID_OBJECT_FORMAT_CODE = 0x200b,
+    RES_STORE_READ_ONLY            = 0x200e,
+    RES_PARTIAL_DELETE             = 0x2012,
     RES_SPEC_BY_FORMAT_UNSUPPORTED = 0x2014,
     RES_INVALID_PARENT_OBJECT      = 0x201a,
     RES_INVALID_PARAMETER          = 0x201d,
@@ -799,6 +802,7 @@ static MTPData *usb_mtp_get_device_info(MTPState *s, MTPControl *c)
         CMD_GET_NUM_OBJECTS,
         CMD_GET_OBJECT_HANDLES,
         CMD_GET_OBJECT_INFO,
+        CMD_DELETE_OBJECT,
         CMD_GET_OBJECT,
         CMD_GET_PARTIAL_OBJECT,
         CMD_GET_OBJECT_PROPS_SUPPORTED,
@@ -1113,6 +1117,120 @@ static MTPData *usb_mtp_get_object_prop_value(MTPState *s, MTPControl *c,
     return d;
 }
 
+/* Return correct return code for a delete event */
+enum {
+    ALL_DELETE,
+    PARTIAL_DELETE,
+    READ_ONLY,
+};
+
+#ifndef CONFIG_INOTIFY1
+/* Assumes that children, if any, have been already freed */
+static void usb_mtp_object_free_one(MTPState *s, MTPObject *o)
+{
+    assert(o->nchildren == 0);
+    QTAILQ_REMOVE(&s->objects, o, next);
+    g_free(o->name);
+    g_free(o->path);
+    g_free(o);
+}
+#endif
+
+static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
+{
+    MTPObject *iter, *iter2;
+    bool partial_delete = false;
+    bool success = false;
+
+    /*
+     * TODO: Add support for Protection Status
+     */
+
+    QLIST_FOREACH(iter, &o->children, list) {
+        if (iter->format == FMT_ASSOCIATION) {
+            QLIST_FOREACH(iter2, &iter->children, list) {
+                usb_mtp_deletefn(s, iter2, trans);
+            }
+        }
+    }
+
+    if (o->format == FMT_UNDEFINED_OBJECT) {
+        if (remove(o->path)) {
+            partial_delete = true;
+        } else {
+#ifndef CONFIG_INOTIFY1
+            usb_mtp_object_free_one(s, o);
+#endif
+            success = true;
+        }
+    }
+
+    if (o->format == FMT_ASSOCIATION) {
+        if (rmdir(o->path)) {
+            partial_delete = true;
+        } else {
+#ifndef CONFIG_INOTIFY1
+            usb_mtp_object_free_one(s, o);
+#endif
+            success = true;
+        }
+    }
+
+    if (success && partial_delete) {
+        return PARTIAL_DELETE;
+    }
+    if (!success && partial_delete) {
+        return READ_ONLY;
+    }
+    return ALL_DELETE;
+}
+
+static void usb_mtp_object_delete(MTPState *s, uint32_t handle,
+                                  uint32_t format_code, uint32_t trans)
+{
+    MTPObject *o;
+    int ret;
+
+    /* Return error if store is read-only */
+    if (!FLAG_SET(s, MTP_FLAG_WRITABLE)) {
+        usb_mtp_queue_result(s, RES_STORE_READ_ONLY,
+                             trans, 0, 0, 0, 0);
+        return;
+    }
+
+    if (format_code != 0) {
+        usb_mtp_queue_result(s, RES_SPEC_BY_FORMAT_UNSUPPORTED,
+                             trans, 0, 0, 0, 0);
+        return;
+    }
+
+    if (handle == 0xFFFFFFF) {
+        o = QTAILQ_FIRST(&s->objects);
+    } else {
+        o = usb_mtp_object_lookup(s, handle);
+    }
+    if (o == NULL) {
+        usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
+                             trans, 0, 0, 0, 0);
+        return;
+    }
+
+    ret = usb_mtp_deletefn(s, o, trans);
+    if (ret == PARTIAL_DELETE) {
+        usb_mtp_queue_result(s, RES_PARTIAL_DELETE,
+                             trans, 0, 0, 0, 0);
+        return;
+    } else if (ret == READ_ONLY) {
+        usb_mtp_queue_result(s, RES_STORE_READ_ONLY, trans,
+                             0, 0, 0, 0);
+        return;
+    } else {
+        usb_mtp_queue_result(s, RES_OK, trans,
+                             0, 0, 0, 0);
+        return;
+    }
+}
+
 static void usb_mtp_command(MTPState *s, MTPControl *c)
 {
     MTPData *data_in = NULL;
@@ -1239,6 +1357,9 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
             return;
         }
         break;
+    case CMD_DELETE_OBJECT:
+        usb_mtp_object_delete(s, c->argv[0], c->argv[1], c->trans);
+        return;
     case CMD_GET_PARTIAL_OBJECT:
         o = usb_mtp_object_lookup(s, c->argv[0]);
         if (o == NULL) {
-- 
2.9.4
