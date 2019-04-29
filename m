Received: from eggs.gnu.org ([209.51.188.92]:57386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL6Af-0000Js-KT
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL6Ae-0004uB-AB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:18:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hL6Ae-0004tR-1x
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:18:12 -0400
References: <20190424140643.62457-1-liq3ea@163.com>
	<2b623811-1be2-159c-0fa6-c548aa9eea82@redhat.com>
	<CAKXe6SLXrthYFrQGVQNT4hK1-22wrteMNyygZgx_j=jtDfYC6g@mail.gmail.com>
	<CAKXe6SL8XWMg1x8qztepjypgqdmXpZDj0G0AHU+BLV8OsbRjOg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b1d3be69-a315-d990-45bc-daa02036b887@redhat.com>
Date: Mon, 29 Apr 2019 15:18:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAKXe6SL8XWMg1x8qztepjypgqdmXpZDj0G0AHU+BLV8OsbRjOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] fw_cfg_test refactor and add two
 test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Li Qiang <liq3ea@163.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

On 29/04/2019 07.09, Li Qiang wrote:
>=20
>=20
> Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>> =E4=BA=8E2019=E5=B9=
=B44=E6=9C=8825=E6=97=A5=E5=91=A8
> =E5=9B=9B =E4=B8=8B=E5=8D=8810:29=E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
>     Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>> =E4=BA=8E2=
019=E5=B9=B44=E6=9C=88
>     25=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:57=E5=86=99=E9=81=
=93=EF=BC=9A
>=20
>         On 24/04/2019 16.06, Li Qiang wrote:
>         > In the disscuss of adding reboot timeout test case:
>         >
>         https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03304.=
html
>         >
>         > Philippe suggested we should uses the only related option for=
 one
>         > specific test. However currently we uses one QTestState for
>         all the
>         > test cases. In order to achieve Philippe's idea, I split the
>         test case
>         > for its own QTestState. As this patchset has changed a lot, I
>         don't bump
>         > the version.
>         >
>         > Change since v1:
>         > Add a patch to store the reboot_timeout as little endian
>         > Fix the endian issue per Thomas's review
>=20
>         The test still aborts on a big endian host:
>=20
>         $ QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
>         tests/fw_cfg-test
>         /x86_64/fw_cfg/signature: OK
>         /x86_64/fw_cfg/id: OK
>         /x86_64/fw_cfg/uuid: OK
>         /x86_64/fw_cfg/ram_size: OK
>         /x86_64/fw_cfg/nographic: OK
>         /x86_64/fw_cfg/nb_cpus: OK
>         /x86_64/fw_cfg/max_cpus: OK
>         /x86_64/fw_cfg/numa: OK
>         /x86_64/fw_cfg/boot_menu: OK
>         /x86_64/fw_cfg/reboot_timeout: **
>         ERROR:/home/thuth/devel/qemu/tests/fw_cfg-test.c:190:test_fw_cf=
g_reboot_timeout:
>         assertion failed (reboot_timeout =3D=3D 15): (251658240 =3D=3D =
15)
>         Aborted
>=20
>         251658240 is 0x0F000000, i.e. a byte-swapped 0xf =3D 15 ... i.e=
.
>         you still
>         got an endianess issue somewhere in the code.
>=20
>=20
>=20
>     Hmmmm,
>=20
>     I have thought a long time, still can't point where is wrong.
>=20
>     Let's from the result:=C2=A0
>     0x0f000000 in the big endian laid as this:
>     low ---> high
>     0x0f 00 00 00
>=20
>     As I have swapped before the compare so it is read as this:
>     low ---> high
>     00 00 00 0x0f
>=20
>     However from the store side:
>     the 15 in big endian is:
>     low ---> high
>     00 00 00 0x0f
>=20
>     But Before I store it, I convert it to little endian, so following
>     should be stored:
>     low ---> high
>     0x0f 00 00 00
>=20
>     Do you apply the patch 3 and recompile the qemu binary?
>=20
>=20
>=20
> Hello Thomas,=C2=A0
> I have tested again this and just store it as big endian(so that the
> store/load has different endianness),=C2=A0
> I don't see any error.=C2=A0

Uh, now this is embarrassing... I just tried again to see whether I
could find the issue, but now the test passes without problems!
I guess I simply only did a "make tests/fw_cfg-test" before and forgot
to recompile qemu itself. Big sorry for this!

Anyway, patch series works fine for me, so for the series:

Tested-by: Thomas Huth <thuth@redhat.com>

> Also, can we add these test=C2=A0sceneries(big-endian host) in our CI? =
so
> that the bot can report for every commit.

Patchew only runs on x86, but Peter has some big endian hosts for his
acceptance tests - so problems should be found during PULL requests at
least.

 Thomas
