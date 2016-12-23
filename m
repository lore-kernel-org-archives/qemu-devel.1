Received: from eggs.gnu.org ([2001:4830:134:3::10]:58726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKZNg-0002mL-Tq
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 18:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKZNd-0003De-Q1
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 18:36:08 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:39045)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKZNd-0003CU-8v
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 18:36:05 -0500
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <87inqavlzj.fsf@mail.parknet.co.jp>
	<8eb87c0e-ba00-e748-8cec-fa089403e13c@redhat.com>
	<8737heb4ps.fsf@mail.parknet.co.jp>
Date: Sat, 24 Dec 2016 08:36:03 +0900
In-Reply-To: <8737heb4ps.fsf@mail.parknet.co.jp> (OGAWA Hirofumi's message of
	"Sat, 24 Dec 2016 08:33:51 +0900")
Message-ID: <87y3z69q1o.fsf_-_@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] ps2: Fix lost scancodes by recent changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>


With "ps2: use QEMU qcodes instead of scancodes", key handling was
changed to qcode base. But all scancodes are not converted to new one.

This adds some missing qcodes/scancodes what I found in using.

[set1 and set2 are still missing, but I'm not sure what is right values yet.]

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 hw/input/ps2.c    |    3 +++
 qapi-schema.json  |    6 +++++-
 ui/input-keymap.c |    3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff -puN hw/input/ps2.c~fix-ps2-scancode hw/input/ps2.c
--- qemu/hw/input/ps2.c~fix-ps2-scancode	2016-12-23 23:51:44.324955949 +0900
+++ qemu-hirofumi/hw/input/ps2.c	2016-12-24 08:30:12.426540795 +0900
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
--- qemu/qapi-schema.json~fix-ps2-scancode	2016-12-23 23:51:44.324955949 +0900
+++ qemu-hirofumi/qapi-schema.json	2016-12-24 08:32:46.658549598 +0900
@@ -3618,6 +3618,9 @@
 # @kp_comma: since 2.4
 # @kp_equals: since 2.6
 # @power: since 2.6
+# @hiragana: since 2.9
+# @henkan: since 2.9
+# @yen: since 2.9
 #
 # An enumeration of key name.
 #
@@ -3642,7 +3645,8 @@
             'kp_9', 'less', 'f11', 'f12', 'print', 'home', 'pgup', 'pgdn', 'end',
             'left', 'up', 'down', 'right', 'insert', 'delete', 'stop', 'again',
             'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', 'cut',
-            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause', 'ro',
+            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
+            'ro', 'hiragana', 'henkan', 'yen',
             'kp_comma', 'kp_equals', 'power' ] }
 
 ##
diff -puN ui/input-keymap.c~fix-ps2-scancode ui/input-keymap.c
--- qemu/ui/input-keymap.c~fix-ps2-scancode	2016-12-23 23:51:44.325955954 +0900
+++ qemu-hirofumi/ui/input-keymap.c	2016-12-23 23:51:44.327955966 +0900
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
