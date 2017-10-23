Received: from eggs.gnu.org ([2001:4830:134:3::10]:36900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6Ytr-0005yx-3o
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6Ytq-0005ak-5r
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6Ytp-0005aE-Qf
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EED8A85A05
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 09:19:56 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 11:19:43 +0200
Message-Id: <20171023091947.20771-6-kraxel@redhat.com>
In-Reply-To: <20171023091947.20771-1-kraxel@redhat.com>
References: <20171023091947.20771-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] ps2: fix scancodes sent for
 Shift/Ctrl+Print key combination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The 'Print' key is special in the AT set 1 / set 2 scancode definitions.

An unmodified 'Print' key is supposed to send

 AT Set 1:  e0 2a e0 37 (Down)  e0 b7 e0 aa (Up)
 AT Set 2:  e0 12 e0 7c (Down)  e0 f0 7c e0 f0 12 (Up)

which QEMU gets right. When combined with Shift/Ctrl (both left and right
variants), the leading two bytes should be dropped, resulting in

 AT Set 1:  e0 37 (Down)  e0 b7 (Up)
 AT Set 2:  e0 7c (Down)  e0 f0 7c (Up)

This difference is pretty benign, since of all the operating systems I have
checked (Linux, FreeBSD and OpenStack), none bother to check the leading two
bytes anyway. This change none the less makes the ps2 device better follow real
hardware behaviour.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20171019142848.572-6-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/ps2.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 1e6f6ae9b6..c35b410e4d 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -674,6 +674,15 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                     ps2_put_keycode(s, 0xe0);
                     ps2_put_keycode(s, 0x38);
                 }
+            } else if (s->modifiers & (MOD_SHIFT_L | MOD_CTRL_L |
+                                       MOD_SHIFT_R | MOD_CTRL_R)) {
+                if (key->down) {
+                    ps2_put_keycode(s, 0xe0);
+                    ps2_put_keycode(s, 0x37);
+                } else {
+                    ps2_put_keycode(s, 0xe0);
+                    ps2_put_keycode(s, 0xb7);
+                }
             } else {
                 if (key->down) {
                     ps2_put_keycode(s, 0xe0);
@@ -745,6 +754,16 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                     ps2_put_keycode(s, 0xe0);
                     ps2_put_keycode(s, 0x11);
                 }
+            } else if (s->modifiers & (MOD_SHIFT_L | MOD_CTRL_L |
+                                       MOD_SHIFT_R | MOD_CTRL_R)) {
+                if (key->down) {
+                    ps2_put_keycode(s, 0xe0);
+                    ps2_put_keycode(s, 0x7c);
+                } else {
+                    ps2_put_keycode(s, 0xe0);
+                    ps2_put_keycode(s, 0xf0);
+                    ps2_put_keycode(s, 0x7c);
+                }
             } else {
                 if (key->down) {
                     ps2_put_keycode(s, 0xe0);
-- 
2.9.3
