Received: from eggs.gnu.org ([2001:4830:134:3::10]:37219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fQ4VR-0006ib-4F
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 01:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fQ4VN-0005c7-74
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 01:27:41 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56278)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fQ4VM-0005ai-Vk
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 01:27:37 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180528071332.9424.27343.stgit@pasha-VirtualBox>
	<b2f04223-f52d-44e6-95a6-6ed91d021dad@ispras.ru>
	<87in6yd146.fsf@linaro.org>
In-Reply-To: <87in6yd146.fsf@linaro.org>
Date: Tue, 5 Jun 2018 08:27:33 +0300
Message-ID: <001201d3fc8d$e8a06390$b9e12ab0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v4 00/19] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru> writes:
>=20
> > Ping?
>=20
> I started having a look but I ran into this straight away. First I
> recorded a boot of the kernel:
>=20
>   ./aarch64-softmmu/qemu-system-aarch64 -machine =
virt,graphics=3Don,gic-
> version=3D3,virtualization=3Don -cpu cortex-a53 --serial mon:stdio =
-display none -kernel
> ../images/aarch64-current-linux-initrd-guest.img -icount =
shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin
>=20
> Then played back:
>=20
>   ./aarch64-softmmu/qemu-system-aarch64 -machine =
virt,graphics=3Don,gic-
> version=3D3,virtualization=3Don -cpu cortex-a53 --serial mon:stdio =
-display none -kernel
> ../images/aarch64-current-linux-initrd-guest.img -icount =
shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin -
> s -S

This looks ok, but...

> And did the following on gdb:
>=20
> (gdb) i
> 0x0000000040000004 in ?? ()
> =3D> 0x40000004:  mov     x1, xzr
>    0x40000008:  mov     x2, xzr
>    0x4000000c:  mov     x3, xzr
> (gdb)
> 0x0000000040000008 in ?? ()
> =3D> 0x40000008:  mov     x2, xzr
>    0x4000000c:  mov     x3, xzr
>    0x40000010:  ldr     x4, 0x40000020
> (gdb)
> 0x000000004000000c in ?? ()
> =3D> 0x4000000c:  mov     x3, xzr
>    0x40000010:  ldr     x4, 0x40000020
>    0x40000014:  br      x4
> (gdb)
> 0x0000000040000010 in ?? ()
> =3D> 0x40000010:  ldr     x4, 0x40000020
>    0x40000014:  br      x4
>    0x40000018:  .inst   0x44000000 ; undefined
> (gdb)
> 0x0000000040000014 in ?? ()
> =3D> 0x40000014:  br      x4
>    0x40000018:  .inst   0x44000000 ; undefined
>    0x4000001c:  .inst   0x00000000 ; undefined
> (gdb) p/x $x4
> $1 =3D 0x40080000
> (gdb) reverse-stepi
> warning: Remote failure reply: E14
>=20
> Surely this is the simple case and doesn't require any snapshots for
> block devices as there are none. Am I missing something?

Reverse debugging requires the snapshotting. QEMU can't revert the VM =
state without the snapshots.
You can try adding an empty qcow2 image to allow snapshotting there.

Pavel Dovgalyuk
