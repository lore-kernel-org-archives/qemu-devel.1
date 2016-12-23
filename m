Received: from eggs.gnu.org ([2001:4830:134:3::10]:38728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKPSo-0004eq-C8
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 08:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKPSj-0002z9-Ho
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 08:00:46 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:38945)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKPSj-0002xi-9K
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 08:00:41 -0500
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 23 Dec 2016 22:00:32 +0900
Message-ID: <87inqavlzj.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] ps2: Fix lost scancodes by recent changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>


With "ps2: use QEMU qcodes instead of scancodes", key handling was
changed to qcode base. But all scancodes are not converted to new one.

This adds some missing qcodes what I found in using.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 hw/input/ps2.c    |    3 +++
 qapi-schema.json  |    3 ++-
 ui/input-keymap.c |    3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff -puN hw/input/ps2.c~fix-ps2-scancode hw/input/ps2.c
--- qemu/hw/input/ps2.c~fix-ps2-scancode	2016-12-23 21:14:59.837729450 +0900
+++ qemu-hirofumi/hw/input/ps2.c	2016-12-23 21:14:59.840729469 +0900
@@ -394,6 +394,9 @@ static const uint16_t qcode_to_keycode_s
     [Q_KEY_CODE_LESS] = 0x61,
     [Q_KEY_CODE_SYSRQ] = 0x7f,
     [Q_KEY_CODE_RO] = 0x51,
+    [Q_KEY_CODE_HIRAGANA] = 0x13,
+    [Q_KEY_CODE_HENKAN] = 0x64,
+    [Q_KEY_CODE_YEN] = 0x6a,
     [Q_KEY_CODE_KP_COMMA] = 0x6d,
 };
 
diff -puN qapi-schema.json~fix-ps2-scancode qapi-schema.json
--- qemu/qapi-schema.json~fix-ps2-scancode	2016-12-23 21:14:59.838729456 +0900
+++ qemu-hirofumi/qapi-schema.json	2016-12-23 21:14:59.840729469 +0900
@@ -3642,7 +3642,8 @@
             'kp_9', 'less', 'f11', 'f12', 'print', 'home', 'pgup', 'pgdn', 'end',
             'left', 'up', 'down', 'right', 'insert', 'delete', 'stop', 'again',
             'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', 'cut',
-            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause', 'ro',
+            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
+            'ro', 'hiragana', 'henkan', 'yen',
             'kp_comma', 'kp_equals', 'power' ] }
 
 ##
diff -puN ui/input-keymap.c~fix-ps2-scancode ui/input-keymap.c
--- qemu/ui/input-keymap.c~fix-ps2-scancode	2016-12-23 21:14:59.839729463 +0900
+++ qemu-hirofumi/ui/input-keymap.c	2016-12-23 21:14:59.840729469 +0900
@@ -131,6 +131,9 @@ static const int qcode_to_number[] = {
     [Q_KEY_CODE_DELETE] = 0xd3,
 
     [Q_KEY_CODE_RO] = 0x73,
+    [Q_KEY_CODE_HIRAGANA] = 0x70,
+    [Q_KEY_CODE_HENKAN] = 0x79,
+    [Q_KEY_CODE_YEN] = 0x7d,
     [Q_KEY_CODE_KP_COMMA] = 0x7e,
 
     [Q_KEY_CODE__MAX] = 0,
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
