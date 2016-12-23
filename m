Received: from eggs.gnu.org ([2001:4830:134:3::10]:38923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cKWvW-0005L3-OK
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 15:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cKWvR-0006O1-Td
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 15:58:54 -0500
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11]:31162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1cKWvR-0006N6-MA
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 15:58:49 -0500
References: <87inqavlzj.fsf@mail.parknet.co.jp>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <feca54b3-9c38-4ce7-4edc-b1f9f88fb7a1@reactos.org>
Date: Fri, 23 Dec 2016 21:58:35 +0100
MIME-Version: 1.0
In-Reply-To: <87inqavlzj.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ps2: Fix lost scancodes by recent changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Le 23/12/2016 =E0 14:00, OGAWA Hirofumi a =E9crit :
>
> With "ps2: use QEMU qcodes instead of scancodes", key handling was
> changed to qcode base. But all scancodes are not converted to new one.
>
> This adds some missing qcodes what I found in using.
>
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> ---
>
>  hw/input/ps2.c    |    3 +++
>  qapi-schema.json  |    3 ++-
>  ui/input-keymap.c |    3 +++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff -puN hw/input/ps2.c~fix-ps2-scancode hw/input/ps2.c
> --- qemu/hw/input/ps2.c~fix-ps2-scancode	2016-12-23 21:14:59.837729450 =
+0900
> +++ qemu-hirofumi/hw/input/ps2.c	2016-12-23 21:14:59.840729469 +0900
> @@ -394,6 +394,9 @@ static const uint16_t qcode_to_keycode_s
>      [Q_KEY_CODE_LESS] =3D 0x61,
>      [Q_KEY_CODE_SYSRQ] =3D 0x7f,
>      [Q_KEY_CODE_RO] =3D 0x51,
> +    [Q_KEY_CODE_HIRAGANA] =3D 0x13,
> +    [Q_KEY_CODE_HENKAN] =3D 0x64,
> +    [Q_KEY_CODE_YEN] =3D 0x6a,
>      [Q_KEY_CODE_KP_COMMA] =3D 0x6d,
>  };
>
> diff -puN qapi-schema.json~fix-ps2-scancode qapi-schema.json
> --- qemu/qapi-schema.json~fix-ps2-scancode	2016-12-23 21:14:59.83872945=
6 +0900
> +++ qemu-hirofumi/qapi-schema.json	2016-12-23 21:14:59.840729469 +0900
> @@ -3642,7 +3642,8 @@
>              'kp_9', 'less', 'f11', 'f12', 'print', 'home', 'pgup', 'pg=
dn', 'end',
>              'left', 'up', 'down', 'right', 'insert', 'delete', 'stop',=
 'again',
>              'props', 'undo', 'front', 'copy', 'open', 'paste', 'find',=
 'cut',
> -            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause', 'ro'=
,
> +            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
> +            'ro', 'hiragana', 'henkan', 'yen',
>              'kp_comma', 'kp_equals', 'power' ] }
>
>  ##
> diff -puN ui/input-keymap.c~fix-ps2-scancode ui/input-keymap.c
> --- qemu/ui/input-keymap.c~fix-ps2-scancode	2016-12-23 21:14:59.8397294=
63 +0900
> +++ qemu-hirofumi/ui/input-keymap.c	2016-12-23 21:14:59.840729469 +0900
> @@ -131,6 +131,9 @@ static const int qcode_to_number[] =3D {
>      [Q_KEY_CODE_DELETE] =3D 0xd3,
>
>      [Q_KEY_CODE_RO] =3D 0x73,
> +    [Q_KEY_CODE_HIRAGANA] =3D 0x70,
> +    [Q_KEY_CODE_HENKAN] =3D 0x79,
> +    [Q_KEY_CODE_YEN] =3D 0x7d,
>      [Q_KEY_CODE_KP_COMMA] =3D 0x7e,
>
>      [Q_KEY_CODE__MAX] =3D 0,

Can you also add the keycodes for scancode set 1:
+    [Q_KEY_CODE_HIRAGANA] =3D 0x70,
+    [Q_KEY_CODE_HENKAN] =3D 0x79,
+    [Q_KEY_CODE_YEN] =3D 0x7d,

and scancode set 3:
+    [Q_KEY_CODE_HIRAGANA] =3D 0x87,
+    [Q_KEY_CODE_HENKAN] =3D 0x86,
+    [Q_KEY_CODE_YEN] =3D 0x51,

Herv=E9
