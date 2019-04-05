Received: from eggs.gnu.org ([209.51.188.92]:56602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCNCp-0000x1-UE
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCN0t-0001xN-Ru
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:28:05 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::3]:27492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCN0s-0001e0-1T
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:28:03 -0400
Date: Fri, 5 Apr 2019 13:27:53 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20190405132753.6c5f2f88.olaf@aepfle.de>
In-Reply-To: <7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
	<7fded1f3-7539-45b5-17c7-39fe7193dbc9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_//xrNmntm2G9FQWJNWZ43hwF";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>

--Sig_//xrNmntm2G9FQWJNWZ43hwF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri, 5 Apr 2019 13:14:35 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> On 4/5/19 12:59 PM, Olaf Hering wrote:
> > Am Fri, 5 Apr 2019 12:49:15 +0200
> > schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
> >  =20
> >> The EDK2 submodule was added for UEFI testing, you don't need to compi=
le
> >> it to build/use QEMU.
> >>
> >> How did you end up compiling it? =20
> >=20
> > The qemu.spec file has this since a very long time:
> > make -C roms efirom ${unrelated_settings} =20
> I don't have any qemu.spec, is it a SUSE file?

Yes, it is part of the qemu package.

https://build.opensuse.org/package/show/Virtualization/qemu

> > This used to work still in January with c9d18c1c150c84e7a976df989ad04dd=
f01083f46. =20
> Before f590a812c210 the EfiRom tool was not available, now we compile it
> inconditionally.

I wonder why it must be compiled unconditionally.
This is my workaround:

sed -i 's@EFIROM@KAPUTT@g' roms/Makefile
efirom=3D
test -x "$(type -P EfiRom)" && KAPUTT=3D"$_" efirom=3Defirom
make -C roms ${efirom} KAPUTT=3D${KAPUTT}

> So I assume your distribution already provides the EfiRom tool. Can you
> point me at the package which provides it? I wonder if your distribution
> use a non-upstreamed patch that change the EDK2 BaseTools PIE/PIC flags.

It is in ovmf-tools.rpm, which comes from ovmf. And looking at this package,
they also had to workaround the fact that edk2 does not cope with PIE.

https://build.opensuse.org/package/show/Virtualization/ovmf

Olaf

--Sig_//xrNmntm2G9FQWJNWZ43hwF
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKc7uQAKCRBdQqD6ppg2
fgMzAKDMEdZ5NGbn7CUZAUgOjvq0JgGlwwCggxo1upLeZMc3Z2pxx95QZxoKiCA=
=Sd/W
-----END PGP SIGNATURE-----

--Sig_//xrNmntm2G9FQWJNWZ43hwF--
