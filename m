Received: from eggs.gnu.org ([2001:4830:134:3::10]:50447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6F-0000Xh-TR
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6E-00054w-SP
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:59 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6E-000546-Og
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:58 -0400
Received: by mail-qk0-x244.google.com with SMTP id d136so10666863qkg.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:28:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:33 -0300
Message-Id: <20170724182751.18261-18-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 17/35] usb/dev-mtp: fix use of
 uninitialized values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/dev-mtp.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 6dfece9ea9..ad64495f05 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1134,7 +1134,7 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
                                  c->trans, 1, s->session, 0);
             return;
         }
-        if (c->argv[0] == 0) {
+        if (c->argc == 0 || c->argv[0] == 0) {
             usb_mtp_queue_result(s, RES_INVALID_PARAMETER,
                                  c->trans, 0, 0, 0);
             return;
@@ -1162,8 +1162,9 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         data_in = usb_mtp_get_storage_ids(s, c);
         break;
     case CMD_GET_STORAGE_INFO:
-        if (c->argv[0] != QEMU_STORAGE_ID &&
-            c->argv[0] != 0xffffffff) {
+        if (c->argc == 0 ||
+           (c->argv[0] != QEMU_STORAGE_ID &&
+            c->argv[0] != 0xffffffff)) {
             usb_mtp_queue_result(s, RES_INVALID_STORAGE_ID,
                                  c->trans, 0, 0, 0);
             return;
@@ -1172,22 +1173,25 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         break;
     case CMD_GET_NUM_OBJECTS:
     case CMD_GET_OBJECT_HANDLES:
-        if (c->argv[0] != QEMU_STORAGE_ID &&
-            c->argv[0] != 0xffffffff) {
+        if (c->argc == 0 ||
+           (c->argv[0] != QEMU_STORAGE_ID &&
+            c->argv[0] != 0xffffffff)) {
             usb_mtp_queue_result(s, RES_INVALID_STORAGE_ID,
                                  c->trans, 0, 0, 0);
             return;
         }
-        if (c->argv[1] != 0x00000000) {
+        if (c->argc > 1 && c->argv[1] != 0x00000000) {
             usb_mtp_queue_result(s, RES_SPEC_BY_FORMAT_UNSUPPORTED,
                                  c->trans, 0, 0, 0);
             return;
         }
-        if (c->argv[2] == 0x00000000 ||
-            c->argv[2] == 0xffffffff) {
-            o = QTAILQ_FIRST(&s->objects);
-        } else {
-            o = usb_mtp_object_lookup(s, c->argv[2]);
+        if (c->argc > 2) {
+            if (c->argv[2] == 0x00000000 ||
+                c->argv[2] == 0xffffffff) {
+                o = QTAILQ_FIRST(&s->objects);
+            } else {
+                o = usb_mtp_object_lookup(s, c->argv[2]);
+            }
         }
         if (o == NULL) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
@@ -1264,8 +1268,9 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         res0 = data_in->length;
         break;
     case CMD_GET_OBJECT_PROPS_SUPPORTED:
-        if (c->argv[0] != FMT_UNDEFINED_OBJECT &&
-            c->argv[0] != FMT_ASSOCIATION) {
+        if (c->argc == 0 ||
+           (c->argv[0] != FMT_UNDEFINED_OBJECT &&
+            c->argv[0] != FMT_ASSOCIATION)) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_FORMAT_CODE,
                                  c->trans, 0, 0, 0);
             return;
@@ -1273,8 +1278,9 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         data_in = usb_mtp_get_object_props_supported(s, c);
         break;
     case CMD_GET_OBJECT_PROP_DESC:
-        if (c->argv[1] != FMT_UNDEFINED_OBJECT &&
-            c->argv[1] != FMT_ASSOCIATION) {
+        if (c->argc > 1 &&
+           (c->argv[1] != FMT_UNDEFINED_OBJECT &&
+            c->argv[1] != FMT_ASSOCIATION)) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_FORMAT_CODE,
                                  c->trans, 0, 0, 0);
             return;
-- 
2.13.3
