Received: from eggs.gnu.org ([2001:4830:134:3::10]:53884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Bp4-0000eT-E9
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Bp1-0005xB-AO
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e5Bp1-0005vT-2Q
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D2FED6F14
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:29:18 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 19 Oct 2017 15:28:46 +0100
Message-Id: <20171019142848.572-8-berrange@redhat.com>
In-Reply-To: <20171019142848.572-1-berrange@redhat.com>
References: <20171019142848.572-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 7/9] ps2: fix scancodes sent for Ctrl+Pause
 key combination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The 'Pause' key is special in the AT set 1 / set 2 scancode definitions.

An unmodified 'Pause' key is supposed to send

 AT Set 1:  e1 1d 45 91 9d c5 (Down)  <nothing> (Up)
 AT Set 2:  e1 14 77 e1 f0 14 f0 77 (Down)  <nothing> (Up)

which QEMU gets right. When combined with Ctrl (both left and right variants),
a different sequence is expected

 AT Set 1:  e0 46 e0 c6 (Down)  <nothing> (Up)
 AT Set 2:  e0 7e e0 f0 73 (Down)  <nothing> (Up)

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hw/input/ps2.c | 51 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 133cc2aa64..f388a23c8e 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -641,13 +641,22 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
 
     if (s->scancode_set == 1) {
         if (qcode == Q_KEY_CODE_PAUSE) {
-            if (key->down) {
-                ps2_put_keycode(s, 0xe1);
-                ps2_put_keycode(s, 0x1d);
-                ps2_put_keycode(s, 0x45);
-                ps2_put_keycode(s, 0xe1);
-                ps2_put_keycode(s, 0x9d);
-                ps2_put_keycode(s, 0xc5);
+            if (s->modifiers & (MOD_CTRL_L | MOD_CTRL_R)) {
+                if (key->down) {
+                    ps2_put_keycode(s, 0xe0);
+                    ps2_put_keycode(s, 0x46);
+                    ps2_put_keycode(s, 0xe0);
+                    ps2_put_keycode(s, 0xc6);
+                }
+            } else {
+                if (key->down) {
+                    ps2_put_keycode(s, 0xe1);
+                    ps2_put_keycode(s, 0x1d);
+                    ps2_put_keycode(s, 0x45);
+                    ps2_put_keycode(s, 0xe1);
+                    ps2_put_keycode(s, 0x9d);
+                    ps2_put_keycode(s, 0xc5);
+                }
             }
         } else if (qcode == Q_KEY_CODE_PRINT) {
             if (s->modifiers & MOD_ALT_L) {
@@ -713,15 +722,25 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
         }
     } else if (s->scancode_set == 2) {
         if (qcode == Q_KEY_CODE_PAUSE) {
-            if (key->down) {
-                ps2_put_keycode(s, 0xe1);
-                ps2_put_keycode(s, 0x14);
-                ps2_put_keycode(s, 0x77);
-                ps2_put_keycode(s, 0xe1);
-                ps2_put_keycode(s, 0xf0);
-                ps2_put_keycode(s, 0x14);
-                ps2_put_keycode(s, 0xf0);
-                ps2_put_keycode(s, 0x77);
+            if (s->modifiers & (MOD_CTRL_L | MOD_CTRL_R)) {
+                if (key->down) {
+                    ps2_put_keycode(s, 0xe0);
+                    ps2_put_keycode(s, 0x7e);
+                    ps2_put_keycode(s, 0xe0);
+                    ps2_put_keycode(s, 0xf0);
+                    ps2_put_keycode(s, 0x7e);
+                }
+            } else {
+                if (key->down) {
+                    ps2_put_keycode(s, 0xe1);
+                    ps2_put_keycode(s, 0x14);
+                    ps2_put_keycode(s, 0x77);
+                    ps2_put_keycode(s, 0xe1);
+                    ps2_put_keycode(s, 0xf0);
+                    ps2_put_keycode(s, 0x14);
+                    ps2_put_keycode(s, 0xf0);
+                    ps2_put_keycode(s, 0x77);
+                }
             }
         } else if (qcode == Q_KEY_CODE_PRINT) {
             if (s->modifiers & MOD_ALT_L) {
-- 
2.13.6
