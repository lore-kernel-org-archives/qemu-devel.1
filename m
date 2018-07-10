Received: from eggs.gnu.org ([2001:4830:134:3::10]:51210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fctDr-0006vx-I9
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fctDl-00070W-IX
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:02:31 -0400
MIME-Version: 1.0
In-Reply-To: <20180710132000.GI5852@localhost.localdomain>
References: <20180703213556.20619-1-armbru@redhat.com>
	<20180703213556.20619-19-armbru@redhat.com>
	<20180710132000.GI5852@localhost.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Jul 2018 16:02:23 +0200
Message-ID: <CAJ+F1CK4h-5-_UagKFJE8Ev4yAELqQM4LYDq94XYJF2fyus7Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 18/32] qmp: Don't let JSON errors jump
 the queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>

Hi

On Tue, Jul 10, 2018 at 3:20 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 03.07.2018 um 23:35 hat Markus Armbruster geschrieben:
>> handle_qmp_command() reports JSON syntax errors right away.  This is
>> wrong when OOB is enabled, because the errors can "jump the queue"
>> then.
>>
>> The previous commit fixed the same bug for semantic errors, by
>> delaying the checking until dispatch.  We can't delay the checking, so
>> delay the reporting.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Message-Id: <20180703085358.13941-19-armbru@redhat.com>
>
> I'm observing a qemu crash in qemu-iotests 153 (which does however not
> seem to make the test case fail). git bisect points me to this patch.
>
> I'm getting output like this:
>
> *** Error in `/home/kwolf/source/qemu/tests/qemu-iotests/qemu': free(): i=
nvalid pointer: 0x0000555f7870f7e0 ***
> =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
> /lib64/libc.so.6(+0x7cbac)[0x7fa9b29a2bac]
> /lib64/libc.so.6(+0x87a59)[0x7fa9b29ada59]
> /lib64/libc.so.6(cfree+0x16e)[0x7fa9b29b33be]
> /lib64/libglib-2.0.so.0(g_free+0xe)[0x7fa9ce462b4e]
> /home/kwolf/source/qemu/tests/qemu-iotests/qemu(+0x6eb9dc)[0x555f76f489dc=
]
> /home/kwolf/source/qemu/tests/qemu-iotests/qemu(+0x30ae4b)[0x555f76b67e4b=
]
> /home/kwolf/source/qemu/tests/qemu-iotests/qemu(+0x311558)[0x555f76b6e558=
]
> /home/kwolf/source/qemu/tests/qemu-iotests/qemu(+0x6e2d4e)[0x555f76f3fd4e=
]
> /home/kwolf/source/qemu/tests/qemu-iotests/qemu(+0x6e5fa0)[0x555f76f42fa0=
]
> /home/kwolf/source/qemu/tests/qemu-iotests/qemu(+0x6e2c2e)[0x555f76f3fc2e=
]
> /lib64/libglib-2.0.so.0(g_main_context_dispatch+0x157)[0x7fa9ce45d257]
> /home/kwolf/source/qemu/tests/qemu-iotests/qemu(+0x6e526e)[0x555f76f4226e=
]
> /home/kwolf/source/qemu/tests/qemu-iotests/qemu(+0x42349e)[0x555f76c8049e=
]
> /home/kwolf/source/qemu/tests/qemu-iotests/qemu(+0x2c27ef)[0x555f76b1f7ef=
]
> /lib64/libc.so.6(__libc_start_main+0xea)[0x7fa9b294688a]
> /home/kwolf/source/qemu/tests/qemu-iotests/qemu(+0x2c5b8a)[0x555f76b22b8a=
]
>
> Interestingly, this doesn't want to produce a core dump for me, so no
> backtrace with usable function names here. But I assume that you can
> easily reproduce this yourself.
>

Looks like the double-free regression, you could try: "[PATCH]
monitor: fix double-free of request error"

thanks



--=20
Marc-Andr=C3=A9 Lureau
