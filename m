Received: from eggs.gnu.org ([2001:4830:134:3::10]:35950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYdf9-0007Oo-MN
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 14:00:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYdf6-000605-FH
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 14:00:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYdf6-0005zh-74
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 14:00:16 -0500
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
	<CAFEAcA9jzxGZXXoFWxrDztb4or=0LaqpeNa3YH9rpZePa2mFdA@mail.gmail.com>
	<CAJ+F1CJzchr6f9nfCsHyOUFmz-08e4R-8BLi4QWc3q0h0+9Quw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3fdd19c5-2017-7c5d-22ad-a44bd15414d6@redhat.com>
Date: Tue, 31 Jan 2017 13:00:11 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJzchr6f9nfCsHyOUFmz-08e4R-8BLi4QWc3q0h0+9Quw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pPMSRIQnFTPDusIOu4K51KHwvBvrkWVpx"
Subject: Re: [Qemu-devel] [PULL 00/41] Chr split patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pPMSRIQnFTPDusIOu4K51KHwvBvrkWVpx
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <3fdd19c5-2017-7c5d-22ad-a44bd15414d6@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/41] Chr split patches
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
 <CAFEAcA9jzxGZXXoFWxrDztb4or=0LaqpeNa3YH9rpZePa2mFdA@mail.gmail.com>
 <CAJ+F1CJzchr6f9nfCsHyOUFmz-08e4R-8BLi4QWc3q0h0+9Quw@mail.gmail.com>
In-Reply-To: <CAJ+F1CJzchr6f9nfCsHyOUFmz-08e4R-8BLi4QWc3q0h0+9Quw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 12:55 PM, Marc-Andr=C3=A9 Lureau wrote:

>> 'make check' fails on a linux-user-targets-only build:
>>
>> tests/test-char.o: In function `char_stdio_test_subprocess':
>> /home/petmay01/linaro/qemu-for-merges/tests/test-char.c:47: undefined
>> reference to `qemu_chr_new'
>> /home/petmay01/linaro/qemu-for-merges/tests/test-char.c:50: undefined
>> reference to `qemu_chr_fe_init'
>> /home/petmay01/linaro/qemu-for-merges/tests/test-char.c:51: undefined
>> reference to `qemu_chr_fe_set_open'
>> /home/petmay01/linaro/qemu-for-merges/tests/test-char.c:52: undefined
>> reference to `qemu_chr_fe_write'
>> [etc etc etc]
>>
>>
> Oh good catch. We want to have chardev-obj-y defined globally, but only=

> linked with -softmmu target.
>=20
> A possible fix to squash with chardev-obj-j patch is:
>=20
> Eric, do you want me to resend the patch for review or is that enough f=
or
> you to ack?
>=20

I'm okay ack'ing the interdiff (that is, squash this in, and you can
keep the R-b you already have).

> diff --git a/Makefile.objs b/Makefile.objs
> index 91a4794f28..b09a9588fc 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -4,6 +4,8 @@ stub-obj-y =3D stubs/ crypto/
>  util-obj-y =3D util/ qobject/ qapi/
>  util-obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.=
o
>=20
> +chardev-obj-y =3D chardev/
> +
>  ######################################################################=
#
>  # block-obj-y is code used by both qemu system emulation and qemu-img
>=20
> @@ -78,8 +80,6 @@ common-obj-$(CONFIG_SECCOMP) +=3D qemu-seccomp.o
>=20
>  common-obj-$(CONFIG_FDT) +=3D device_tree.o
>=20
> -chardev-obj-y =3D chardev/
> -
>  ######################################################################=

>  # qapi
>=20
> diff --git a/Makefile.target b/Makefile.target
> index 5a487b5187..054db85e9e 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -188,10 +188,9 @@ dummy :=3D $(call unnest-vars,.., \
>                 common-obj-m)
>  target-obj-y :=3D $(target-obj-y-save)
>  all-obj-y +=3D $(common-obj-y)
> -all-obj-y +=3D $(chardev-obj-y)
>  all-obj-y +=3D $(target-obj-y)
>  all-obj-y +=3D $(qom-obj-y)
> -all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y)
> +all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chardev-obj-y)
>  all-obj-$(CONFIG_USER_ONLY) +=3D $(crypto-aes-obj-y)
>  all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
>  all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--pPMSRIQnFTPDusIOu4K51KHwvBvrkWVpx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkN67AAoJEKeha0olJ0Nq+rQH/3ANNY9HAtMcHh498GQV/vHu
TTaVdAcY0RN+bxH2lzgVFIlH//DtIE20LPwnHm7a/srKcgd/Ukt6OD6AAZ5kSoB5
fP0bZ0LDIYgdt/zTUpRU7q9iK1T/sFskrK29jNSD4wF+vk8W4X0sWEi+RuEWMse/
6y1U1eH2A4bakMXXh7BRUEX/LJs/n7x9vQexk6BmfrGQyB2RoK38N9pUCJyubVdJ
56icsY5hcOZx7ea24mQ2CVrw0FvkhNxUIH/E0YO0fzsofNMkZK96YZxTWuL2+L6q
9uhGVSgbQb1uq9xK9AQb62Pev1S7+qrIGNE0vNkM8AEKgaZgjzH32RI6BWOgHUg=
=RY/U
-----END PGP SIGNATURE-----

--pPMSRIQnFTPDusIOu4K51KHwvBvrkWVpx--
