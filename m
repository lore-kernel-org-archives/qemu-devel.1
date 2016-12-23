Received: from eggs.gnu.org ([2001:4830:134:3::10]:54283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKYeN-0001Bu-US
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 17:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKYeK-0003ck-RD
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 17:49:19 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:39038)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKYeK-0003ba-HA
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 17:49:16 -0500
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <87inqavlzj.fsf@mail.parknet.co.jp>
	<feca54b3-9c38-4ce7-4edc-b1f9f88fb7a1@reactos.org>
Date: Sat, 24 Dec 2016 07:49:10 +0900
In-Reply-To: <feca54b3-9c38-4ce7-4edc-b1f9f88fb7a1@reactos.org>
	(=?iso-8859-1?Q?=22Herv=E9?=
	Poussineau"'s message of "Fri, 23 Dec 2016 21:58:35 +0100")
Message-ID: <87fuletg61.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Hi,

Herv=E9 Poussineau <hpoussin@reactos.org> writes:

>>      [Q_KEY_CODE_RO] =3D 0x73,
>> +    [Q_KEY_CODE_HIRAGANA] =3D 0x70,
>> +    [Q_KEY_CODE_HENKAN] =3D 0x79,
>> +    [Q_KEY_CODE_YEN] =3D 0x7d,
>>      [Q_KEY_CODE_KP_COMMA] =3D 0x7e,
>>
>>      [Q_KEY_CODE__MAX] =3D 0,
>
> Can you also add the keycodes for scancode set 1:
> +    [Q_KEY_CODE_HIRAGANA] =3D 0x70,
> +    [Q_KEY_CODE_HENKAN] =3D 0x79,
> +    [Q_KEY_CODE_YEN] =3D 0x7d,

Current linux can't use set1, so untested.

> and scancode set 3:
> +    [Q_KEY_CODE_HIRAGANA] =3D 0x87,
> +    [Q_KEY_CODE_HENKAN] =3D 0x86,
> +    [Q_KEY_CODE_YEN] =3D 0x51,

Boot with "i8042.direct=3D1", then set set3.

# echo 3 > /sys/devices/platform/i8042/serio0/set
# cat /sys/devices/platform/i8042/serio0/set
3

HENKAN, HIRAGANA seems to be working, but YEN is not working.  I'm not
sure if it is your patch, testing, or kernel problem.

Can you point what is problem?

# lsinput

[...]

/dev/input/event4
   bustype : BUS_I8042
   vendor  : 0x1
   product : 0x3
   version : 43907
   name    : "AT Raw Set 3 keyboard"
   phys    : "isa0060/serio0/input0"
   bits ev : EV_SYN EV_KEY EV_MSC EV_LED EV_REP

# input-event
/dev/input/event4
   bustype : BUS_I8042
   vendor  : 0x1
   product : 0x3
   version : 43907
   name    : "AT Raw Set 3 keyboard"
   phys    : "isa0060/serio0/input0"
   bits ev : EV_SYN EV_KEY EV_MSC EV_LED EV_REP

waiting for events
[... on qemu monitor "sendkey henkan" ...]
06:49:58.061932: EV_KEY KEY_HENKAN (0x5c) pressed
06:49:58.061932: EV_SYN code=3D0 value=3D0
06:49:58.149812: EV_MSC MSC_SCAN 134
06:49:58.149812: EV_KEY KEY_HENKAN (0x5c) released
06:49:58.149812: EV_SYN code=3D0 value=3D0
06:49:58.333876: EV_MSC MSC_SCAN 135
[... on qemu monitor "sendkey hiragana" ...]
06:49:58.333876: EV_KEY KEY_KATAKANAHIRAGANA (0x5d) pressed
06:49:58.333876: EV_SYN code=3D0 value=3D0
06:49:58.421889: EV_MSC MSC_SCAN 135
06:49:58.421889: EV_KEY KEY_KATAKANAHIRAGANA (0x5d) released
06:49:58.421889: EV_SYN code=3D0 value=3D0
06:49:58.893893: EV_MSC MSC_SCAN 81
[... on qemu monitor "sendkey yen" ...]
06:49:58.893893: EV_KEY KEY_VOLUMEDOWN (0x72) pressed
06:49:58.893893: EV_SYN code=3D0 value=3D0
06:49:58.973841: EV_MSC MSC_SCAN 81
06:49:58.973841: EV_KEY KEY_VOLUMEDOWN (0x72) released
06:49:58.973841: EV_SYN code=3D0 value=3D0
timeout, quitting
 =20
--=20
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
