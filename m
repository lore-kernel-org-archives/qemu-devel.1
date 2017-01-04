Received: from eggs.gnu.org ([2001:4830:134:3::10]:37036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cOsql-0001Rp-H5
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cOsqi-0005NC-Bf
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:11:59 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:35793)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cOsqh-0005Mw-T7
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:11:56 -0500
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <87inqavlzj.fsf@mail.parknet.co.jp>
	<feca54b3-9c38-4ce7-4edc-b1f9f88fb7a1@reactos.org>
	<87fuletg61.fsf@mail.parknet.co.jp>
	<f8044f23-52ef-89f8-5ca7-b27de2989cc7@reactos.org>
	<8737h9xidn.fsf@mail.parknet.co.jp>
	<87mvfhw3i0.fsf_-_@mail.parknet.co.jp>
	<1483519820.5670.45.camel@redhat.com>
	<46bcf40d-7c47-733b-44e3-b5a38527524e@reactos.org>
Date: Thu, 05 Jan 2017 06:11:51 +0900
In-Reply-To: <46bcf40d-7c47-733b-44e3-b5a38527524e@reactos.org>
	(=?iso-8859-1?Q?=22Herv=E9?=
	Poussineau"'s message of "Wed, 4 Jan 2017 18:59:31 +0100")
Message-ID: <87y3yqil7s.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] ps2: Fix lost scancodes by recent
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Herv=E9 Poussineau <hpoussin@reactos.org> writes:

> Le 04/01/2017 =E0 09:50, Gerd Hoffmann a =E9crit :
>> On Mi, 2016-12-28 at 04:55 +0900, OGAWA Hirofumi wrote:
>>> With "ps2: use QEMU qcodes instead of scancodes", key handling was
>>> changed to qcode base. But all scancodes are not converted to new one=
.
>>>
>>> This adds some missing qcodes/scancodes what I found in using.
>>
>> Added to ui queue.
>
> Hi Gerd,
>
> Your pull request (patch 01/11) contains v2 of this patch (which is inc=
omplete).
> I've only reviewed v3, which is complete.

Yes, please use v3. Here is copy&paste, FWIW.

----
Subject: [PATCH v3] ps2: Fix lost scancodes by recent changes

With "ps2: use QEMU qcodes instead of scancodes", key handling was
changed to qcode base. But all scancodes are not converted to new one.

This adds some missing qcodes/scancodes what I found in using.

[set1 and set3 are from Herv=E9 Poussineau <hpoussin@reactos.org>]
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>
---

 hw/input/ps2.c    |   10 ++++++++++
 qapi-schema.json  |    6 +++++-
 ui/input-keymap.c |    3 +++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff -puN hw/input/ps2.c~fix-ps2-scancode hw/input/ps2.c
--- qemu/hw/input/ps2.c~fix-ps2-scancode	2016-12-23 23:51:44.324955949 +0=
900
+++ qemu-hirofumi/hw/input/ps2.c	2016-12-28 04:50:05.075057779 +0900
@@ -252,6 +252,9 @@ static const uint16_t qcode_to_keycode_s
     [Q_KEY_CODE_ASTERISK] =3D 0x37,
     [Q_KEY_CODE_LESS] =3D 0x56,
     [Q_KEY_CODE_RO] =3D 0x73,
+    [Q_KEY_CODE_HIRAGANA] =3D 0x70,
+    [Q_KEY_CODE_HENKAN] =3D 0x79,
+    [Q_KEY_CODE_YEN] =3D 0x7d,
     [Q_KEY_CODE_KP_COMMA] =3D 0x7e,
 };
=20
@@ -394,6 +397,9 @@ static const uint16_t qcode_to_keycode_s
     [Q_KEY_CODE_LESS] =3D 0x61,
     [Q_KEY_CODE_SYSRQ] =3D 0x7f,
     [Q_KEY_CODE_RO] =3D 0x51,
+    [Q_KEY_CODE_HIRAGANA] =3D 0x13,
+    [Q_KEY_CODE_HENKAN] =3D 0x64,
+    [Q_KEY_CODE_YEN] =3D 0x6a,
     [Q_KEY_CODE_KP_COMMA] =3D 0x6d,
 };
=20
@@ -504,6 +510,10 @@ static const uint16_t qcode_to_keycode_s
     [Q_KEY_CODE_COMMA] =3D 0x41,
     [Q_KEY_CODE_DOT] =3D 0x49,
     [Q_KEY_CODE_SLASH] =3D 0x4a,
+
+    [Q_KEY_CODE_HIRAGANA] =3D 0x87,
+    [Q_KEY_CODE_HENKAN] =3D 0x86,
+    [Q_KEY_CODE_YEN] =3D 0x5d,
 };
=20
 static uint8_t translate_table[256] =3D {
diff -puN qapi-schema.json~fix-ps2-scancode qapi-schema.json
--- qemu/qapi-schema.json~fix-ps2-scancode	2016-12-23 23:51:44.324955949 =
+0900
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
             'kp_9', 'less', 'f11', 'f12', 'print', 'home', 'pgup', 'pgdn=
', 'end',
             'left', 'up', 'down', 'right', 'insert', 'delete', 'stop', '=
again',
             'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', '=
cut',
-            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause', 'ro',
+            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
+            'ro', 'hiragana', 'henkan', 'yen',
             'kp_comma', 'kp_equals', 'power' ] }
=20
 ##
diff -puN ui/input-keymap.c~fix-ps2-scancode ui/input-keymap.c
--- qemu/ui/input-keymap.c~fix-ps2-scancode	2016-12-23 23:51:44.325955954=
 +0900
+++ qemu-hirofumi/ui/input-keymap.c	2016-12-23 23:51:44.327955966 +0900
@@ -131,6 +131,9 @@ static const int qcode_to_number[] =3D {
     [Q_KEY_CODE_DELETE] =3D 0xd3,
=20
     [Q_KEY_CODE_RO] =3D 0x73,
+    [Q_KEY_CODE_HIRAGANA] =3D 0x70,
+    [Q_KEY_CODE_HENKAN] =3D 0x79,
+    [Q_KEY_CODE_YEN] =3D 0x7d,
     [Q_KEY_CODE_KP_COMMA] =3D 0x7e,
=20
     [Q_KEY_CODE__MAX] =3D 0,
_

--=20
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
