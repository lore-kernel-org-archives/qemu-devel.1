Received: from eggs.gnu.org ([2001:4830:134:3::10]:55717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cLsjD-0001QW-Eo
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 09:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cLsjB-0003Pn-Vf
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 09:27:47 -0500
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11]:47597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1cLsjB-0003Or-Md
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 09:27:45 -0500
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <87inqavlzj.fsf@mail.parknet.co.jp>
	<feca54b3-9c38-4ce7-4edc-b1f9f88fb7a1@reactos.org>
	<87fuletg61.fsf@mail.parknet.co.jp>
Message-ID: <f8044f23-52ef-89f8-5ca7-b27de2989cc7@reactos.org>
Date: Tue, 27 Dec 2016 15:27:27 +0100
MIME-Version: 1.0
In-Reply-To: <87fuletg61.fsf@mail.parknet.co.jp>
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
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Le 23/12/2016 =E0 23:49, OGAWA Hirofumi a =E9crit :
> Hi,
>
> Herv=E9 Poussineau <hpoussin@reactos.org> writes:
>
[from ui/input-keymap.c]
>>>      [Q_KEY_CODE_RO] =3D 0x73,
>>> +    [Q_KEY_CODE_HIRAGANA] =3D 0x70,
>>> +    [Q_KEY_CODE_HENKAN] =3D 0x79,
>>> +    [Q_KEY_CODE_YEN] =3D 0x7d,
>>>      [Q_KEY_CODE_KP_COMMA] =3D 0x7e,
>>>
>>>      [Q_KEY_CODE__MAX] =3D 0,
>>

[from hw/input/ps2.c]
>> Can you also add the keycodes for scancode set 1:
>> +    [Q_KEY_CODE_HIRAGANA] =3D 0x70,
>> +    [Q_KEY_CODE_HENKAN] =3D 0x79,
>> +    [Q_KEY_CODE_YEN] =3D 0x7d,
>
> Current linux can't use set1, so untested.

Note that those are the same as those added in input-keymap.c

>
>> and scancode set 3:
>> +    [Q_KEY_CODE_HIRAGANA] =3D 0x87,
>> +    [Q_KEY_CODE_HENKAN] =3D 0x86,
>> +    [Q_KEY_CODE_YEN] =3D 0x51,
>
> Boot with "i8042.direct=3D1", then set set3.
>
> # echo 3 > /sys/devices/platform/i8042/serio0/set
> # cat /sys/devices/platform/i8042/serio0/set
> 3
>
> HENKAN, HIRAGANA seems to be working, but YEN is not working.  I'm not
> sure if it is your patch, testing, or kernel problem.
>
> Can you point what is problem?
>
> # lsinput
>
> [...]
>
> /dev/input/event4
>    bustype : BUS_I8042
>    vendor  : 0x1
>    product : 0x3
>    version : 43907
>    name    : "AT Raw Set 3 keyboard"
>    phys    : "isa0060/serio0/input0"
>    bits ev : EV_SYN EV_KEY EV_MSC EV_LED EV_REP
>
> # input-event
> /dev/input/event4
>    bustype : BUS_I8042
>    vendor  : 0x1
>    product : 0x3
>    version : 43907
>    name    : "AT Raw Set 3 keyboard"
>    phys    : "isa0060/serio0/input0"
>    bits ev : EV_SYN EV_KEY EV_MSC EV_LED EV_REP
>
> waiting for events
> [... on qemu monitor "sendkey henkan" ...]
> 06:49:58.061932: EV_KEY KEY_HENKAN (0x5c) pressed
> 06:49:58.061932: EV_SYN code=3D0 value=3D0
> 06:49:58.149812: EV_MSC MSC_SCAN 134
-> 134 =3D 0x86, as expected ([Q_KEY_CODE_HENKAN] =3D 0x86)

> 06:49:58.149812: EV_KEY KEY_HENKAN (0x5c) released
> 06:49:58.149812: EV_SYN code=3D0 value=3D0

> [... on qemu monitor "sendkey hiragana" ...]
> 06:49:58.333876: EV_MSC MSC_SCAN 135
-> 135 =3D 0x87, as expected ([Q_KEY_CODE_HIRAGANA] =3D 0x87)

> 06:49:58.333876: EV_KEY KEY_KATAKANAHIRAGANA (0x5d) pressed
> 06:49:58.333876: EV_SYN code=3D0 value=3D0
> 06:49:58.421889: EV_MSC MSC_SCAN 135
> 06:49:58.421889: EV_KEY KEY_KATAKANAHIRAGANA (0x5d) released
> 06:49:58.421889: EV_SYN code=3D0 value=3D0

> [... on qemu monitor "sendkey yen" ...]
> 06:49:58.893893: EV_MSC MSC_SCAN 81
-> 81 =3D 0x51
> 06:49:58.893893: EV_KEY KEY_VOLUMEDOWN (0x72) pressed
> 06:49:58.893893: EV_SYN code=3D0 value=3D0
> 06:49:58.973841: EV_MSC MSC_SCAN 81
> 06:49:58.973841: EV_KEY KEY_VOLUMEDOWN (0x72) released
> 06:49:58.973841: EV_SYN code=3D0 value=3D0
> timeout, quitting

So, Linux is describing 0x51 make scancode as VOLUMEDOWN.

Indeed, according to http://www.quadibloc.com/comp/scan.htm
                 Set 1  Set 2  Set 3
HENKAN           79     64     86    (kanji)
HIRAGANA         70     13     87    (katakana)
YEN              7d     6a     5d    (INT 4)

So correct values for hw/input/ps2.c seem to be:

Set 1 (same values as in ui/input-keymap.c)
+    [Q_KEY_CODE_HIRAGANA] =3D 0x70,
+    [Q_KEY_CODE_HENKAN] =3D 0x79,
+    [Q_KEY_CODE_YEN] =3D 0x7d,

Set 2 (your initial patch)
+    [Q_KEY_CODE_HIRAGANA] =3D 0x13,
+    [Q_KEY_CODE_HENKAN] =3D 0x64,
+    [Q_KEY_CODE_YEN] =3D 0x6a,

Set 3:
+    [Q_KEY_CODE_HIRAGANA] =3D 0x87, // already verified
+    [Q_KEY_CODE_HENKAN] =3D 0x86, // already verified
+    [Q_KEY_CODE_YEN] =3D 0x5d,  // not 0x51,  as I said in a previous em=
ail

Can you check those values?

Regards,

Herv=E9
