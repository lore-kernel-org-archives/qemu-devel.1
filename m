Received: from eggs.gnu.org ([2001:4830:134:3::10]:35266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cLxkO-0005tW-4V
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cLxkK-0006gj-8Q
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:49:20 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:39936)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cLxkJ-0006d2-VS
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:49:16 -0500
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <87inqavlzj.fsf@mail.parknet.co.jp>
	<feca54b3-9c38-4ce7-4edc-b1f9f88fb7a1@reactos.org>
	<87fuletg61.fsf@mail.parknet.co.jp>
	<f8044f23-52ef-89f8-5ca7-b27de2989cc7@reactos.org>
Date: Wed, 28 Dec 2016 04:49:08 +0900
In-Reply-To: <f8044f23-52ef-89f8-5ca7-b27de2989cc7@reactos.org>
	(=?iso-8859-1?Q?=22Herv=E9?=
	Poussineau"'s message of "Tue, 27 Dec 2016 15:27:27 +0100")
Message-ID: <8737h9xidn.fsf@mail.parknet.co.jp>
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

Herv=E9 Poussineau <hpoussin@reactos.org> writes:

> [from hw/input/ps2.c]
>>> Can you also add the keycodes for scancode set 1:
>>> +    [Q_KEY_CODE_HIRAGANA] =3D 0x70,
>>> +    [Q_KEY_CODE_HENKAN] =3D 0x79,
>>> +    [Q_KEY_CODE_YEN] =3D 0x7d,
>>
>> Current linux can't use set1, so untested.
>
> Note that those are the same as those added in input-keymap.c

I see.

>> [... on qemu monitor "sendkey yen" ...]
>> 06:49:58.893893: EV_MSC MSC_SCAN 81
> -> 81 =3D 0x51
>> 06:49:58.893893: EV_KEY KEY_VOLUMEDOWN (0x72) pressed
>> 06:49:58.893893: EV_SYN code=3D0 value=3D0
>> 06:49:58.973841: EV_MSC MSC_SCAN 81
>> 06:49:58.973841: EV_KEY KEY_VOLUMEDOWN (0x72) released
>> 06:49:58.973841: EV_SYN code=3D0 value=3D0
>> timeout, quitting
>
> So, Linux is describing 0x51 make scancode as VOLUMEDOWN.
>
> Indeed, according to http://www.quadibloc.com/comp/scan.htm
>                  Set 1  Set 2  Set 3
> HENKAN           79     64     86    (kanji)
> HIRAGANA         70     13     87    (katakana)
> YEN              7d     6a     5d    (INT 4)
>
> So correct values for hw/input/ps2.c seem to be:

[...]

> Set 3:
> +    [Q_KEY_CODE_HIRAGANA] =3D 0x87, // already verified
> +    [Q_KEY_CODE_HENKAN] =3D 0x86, // already verified
> +    [Q_KEY_CODE_YEN] =3D 0x5d,  // not 0x51,  as I said in a previous =
email
>
> Can you check those values?

04:32:33.111316: EV_MSC MSC_SCAN 93
04:32:33.111316: EV_KEY KEY_BACKSLASH (0x2b) pressed
04:32:33.111316: EV_SYN code=3D0 value=3D0

Sent 93=3D=3D0x5d as expected, but keycode is BACKSLASH. Of course, linux
driver is using BACKSLASH(43) keycode for 0x5d. But linux driver has
several BACKSLASH entries for multiple scancodes in set3.

And qemu doesn't have 0x5d entry in set3.  Also

	http://hp.vector.co.jp/authors/VA003720/lpproj/others/kbdjpn.htm

yet another site says 0x5d.

Some sites says about buggy keyboards using wrong scancode in set3, and
microsoft seems to removed set3 from specification. So linux translation
table for 43=3D>0x5d, maybe result of workarounds.

So looks like 0x5d is right value for set3.

Thanks.
--=20
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
