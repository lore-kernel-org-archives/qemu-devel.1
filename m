Received: from eggs.gnu.org ([2001:4830:134:3::10]:48003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1dsMl2-0002tF-LO
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1dsMkz-0006Ow-Jq
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1dsMkz-0006JE-BH
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFCC581DE3
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 05:32:07 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Thu, 14 Sep 2017 01:31:44 -0400
Message-Id: <20170914053148.2512-2-bsd@redhat.com>
In-Reply-To: <20170914053148.2512-1-bsd@redhat.com>
References: <20170914053148.2512-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] usb-mtp: Add one more argument when
 building results
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

The response to a SendObjectInfo consists of the storageid,
parent obejct handle anad the handle reserved for the new
incoming object

Signed-off-by: Bandan Das <bsd@makefile.in>
---
 hw/usb/dev-mtp.c | 50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 94c2e94..b55aa82 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -765,7 +765,8 @@ static void usb_mtp_add_time(MTPData *data, time_t time)
 /* ----------------------------------------------------------------------- */
 
 static void usb_mtp_queue_result(MTPState *s, uint16_t code, uint32_t trans,
-                                 int argc, uint32_t arg0, uint32_t arg1)
+                                 int argc, uint32_t arg0, uint32_t arg1,
+                                 uint32_t arg2)
 {
     MTPControl *c = g_new0(MTPControl, 1);
 
@@ -778,6 +779,9 @@ static void usb_mtp_queue_result(MTPState *s, uint16_t code, uint32_t trans,
     if (argc > 1) {
         c->argv[1] = arg1;
     }
+    if (argc > 2) {
+        c->argv[2] = arg2;
+    }
 
     assert(s->result == NULL);
     s->result = c;
@@ -1119,7 +1123,7 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
     /* sanity checks */
     if (c->code >= CMD_CLOSE_SESSION && s->session == 0) {
         usb_mtp_queue_result(s, RES_SESSION_NOT_OPEN,
-                             c->trans, 0, 0, 0);
+                             c->trans, 0, 0, 0, 0);
         return;
     }
 
@@ -1131,12 +1135,12 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
     case CMD_OPEN_SESSION:
         if (s->session) {
             usb_mtp_queue_result(s, RES_SESSION_ALREADY_OPEN,
-                                 c->trans, 1, s->session, 0);
+                                 c->trans, 1, s->session, 0, 0);
             return;
         }
         if (c->argv[0] == 0) {
             usb_mtp_queue_result(s, RES_INVALID_PARAMETER,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         trace_usb_mtp_op_open_session(s->dev.addr);
@@ -1165,7 +1169,7 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         if (c->argv[0] != QEMU_STORAGE_ID &&
             c->argv[0] != 0xffffffff) {
             usb_mtp_queue_result(s, RES_INVALID_STORAGE_ID,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         data_in = usb_mtp_get_storage_info(s, c);
@@ -1175,12 +1179,12 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         if (c->argv[0] != QEMU_STORAGE_ID &&
             c->argv[0] != 0xffffffff) {
             usb_mtp_queue_result(s, RES_INVALID_STORAGE_ID,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         if (c->argv[1] != 0x00000000) {
             usb_mtp_queue_result(s, RES_SPEC_BY_FORMAT_UNSUPPORTED,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         if (c->argv[2] == 0x00000000 ||
@@ -1191,12 +1195,12 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         }
         if (o == NULL) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         if (o->format != FMT_ASSOCIATION) {
             usb_mtp_queue_result(s, RES_INVALID_PARENT_OBJECT,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         usb_mtp_object_readdir(s, o);
@@ -1212,7 +1216,7 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         o = usb_mtp_object_lookup(s, c->argv[0]);
         if (o == NULL) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         data_in = usb_mtp_get_object_info(s, c, o);
@@ -1221,18 +1225,18 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         o = usb_mtp_object_lookup(s, c->argv[0]);
         if (o == NULL) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         if (o->format == FMT_ASSOCIATION) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         data_in = usb_mtp_get_object(s, c, o);
         if (data_in == NULL) {
             usb_mtp_queue_result(s, RES_GENERAL_ERROR,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         break;
@@ -1240,18 +1244,18 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         o = usb_mtp_object_lookup(s, c->argv[0]);
         if (o == NULL) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         if (o->format == FMT_ASSOCIATION) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         data_in = usb_mtp_get_partial_object(s, c, o);
         if (data_in == NULL) {
             usb_mtp_queue_result(s, RES_GENERAL_ERROR,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         nres = 1;
@@ -1261,7 +1265,7 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         if (c->argv[0] != FMT_UNDEFINED_OBJECT &&
             c->argv[0] != FMT_ASSOCIATION) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_FORMAT_CODE,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         data_in = usb_mtp_get_object_props_supported(s, c);
@@ -1270,13 +1274,13 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         if (c->argv[1] != FMT_UNDEFINED_OBJECT &&
             c->argv[1] != FMT_ASSOCIATION) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_FORMAT_CODE,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         data_in = usb_mtp_get_object_prop_desc(s, c);
         if (data_in == NULL) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_PROP_CODE,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         break;
@@ -1284,20 +1288,20 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         o = usb_mtp_object_lookup(s, c->argv[0]);
         if (o == NULL) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         data_in = usb_mtp_get_object_prop_value(s, c, o);
         if (data_in == NULL) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_PROP_CODE,
-                                 c->trans, 0, 0, 0);
+                                 c->trans, 0, 0, 0, 0);
             return;
         }
         break;
     default:
         trace_usb_mtp_op_unknown(s->dev.addr, c->code);
         usb_mtp_queue_result(s, RES_OPERATION_NOT_SUPPORTED,
-                             c->trans, 0, 0, 0);
+                             c->trans, 0, 0, 0, 0);
         return;
     }
 
@@ -1306,7 +1310,7 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         assert(s->data_in == NULL);
         s->data_in = data_in;
     }
-    usb_mtp_queue_result(s, RES_OK, c->trans, nres, res0, 0);
+    usb_mtp_queue_result(s, RES_OK, c->trans, nres, res0, 0, 0);
 }
 
 /* ----------------------------------------------------------------------- */
-- 
2.9.4
