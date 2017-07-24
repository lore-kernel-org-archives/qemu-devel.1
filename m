Received: from eggs.gnu.org ([2001:4830:134:3::10]:50433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6D-0000V9-E5
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6C-0004zz-I6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:57 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6C-0004zi-Dl
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:56 -0400
Received: by mail-qk0-x241.google.com with SMTP id q130so10664360qka.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:28:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:32 -0300
Message-Id: <20170724182751.18261-17-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 16/35] usb/dev-mtp: fix use of
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

hw/usb/dev-mtp.c:1212:13: warning: 2nd function call argument is an uninitialized value
        o = usb_mtp_object_lookup(s, c->argv[0]);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/dev-mtp.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 94c2e94f10..6dfece9ea9 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1209,7 +1209,9 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         }
         break;
     case CMD_GET_OBJECT_INFO:
-        o = usb_mtp_object_lookup(s, c->argv[0]);
+        if (c->argc > 0) {
+            o = usb_mtp_object_lookup(s, c->argv[0]);
+        }
         if (o == NULL) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
                                  c->trans, 0, 0, 0);
@@ -1218,7 +1220,9 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         data_in = usb_mtp_get_object_info(s, c, o);
         break;
     case CMD_GET_OBJECT:
-        o = usb_mtp_object_lookup(s, c->argv[0]);
+        if (c->argc > 0) {
+            o = usb_mtp_object_lookup(s, c->argv[0]);
+        }
         if (o == NULL) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
                                  c->trans, 0, 0, 0);
@@ -1237,7 +1241,9 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         }
         break;
     case CMD_GET_PARTIAL_OBJECT:
-        o = usb_mtp_object_lookup(s, c->argv[0]);
+        if (c->argc > 0) {
+            o = usb_mtp_object_lookup(s, c->argv[0]);
+        }
         if (o == NULL) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
                                  c->trans, 0, 0, 0);
@@ -1281,7 +1287,9 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         }
         break;
     case CMD_GET_OBJECT_PROP_VALUE:
-        o = usb_mtp_object_lookup(s, c->argv[0]);
+        if (c->argc > 0) {
+            o = usb_mtp_object_lookup(s, c->argv[0]);
+        }
         if (o == NULL) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE,
                                  c->trans, 0, 0, 0);
-- 
2.13.3
