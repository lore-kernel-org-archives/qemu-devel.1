Received: from eggs.gnu.org ([209.51.188.92]:41402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJn1-0005w5-Jc
	for qemu-devel@nongnu.org; Thu, 02 May 2019 18:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJn0-0005zw-Hm
	for qemu-devel@nongnu.org; Thu, 02 May 2019 18:02:51 -0400
References: <e3e75fd5-661e-95ab-d7d6-f9a7bf6548d4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <316d5b3f-d25a-6f9d-6d28-a91f7d2bc22e@redhat.com>
Date: Thu, 2 May 2019 17:02:45 -0500
MIME-Version: 1.0
In-Reply-To: <e3e75fd5-661e-95ab-d7d6-f9a7bf6548d4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L4Y2TEEyzcSdtVJhyUK43HTUNSu5ftLE3"
Subject: Re: [Qemu-devel] Failing QEMU iotest 221
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L4Y2TEEyzcSdtVJhyUK43HTUNSu5ftLE3
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <316d5b3f-d25a-6f9d-6d28-a91f7d2bc22e@redhat.com>
Subject: Re: Failing QEMU iotest 221
References: <e3e75fd5-661e-95ab-d7d6-f9a7bf6548d4@redhat.com>
In-Reply-To: <e3e75fd5-661e-95ab-d7d6-f9a7bf6548d4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/28/19 10:21 AM, Thomas Huth wrote:
> QEMU iotest 221 is failing for me, too, when I run it with -raw:

Which filesystem?

>=20
> tests/qemu-iotests$ ./check -raw 221
> QEMU          -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../x=
86_64-softmmu/qemu-system-x86_64" -nodefaults -machine accel=3Dqtest
> QEMU_IMG      -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../q=
emu-img"=20
> QEMU_IO       -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../q=
emu-io"  --cache writeback -f raw
> QEMU_NBD      -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../q=
emu-nbd"=20
> IMGFMT        -- raw
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 thuth 3.10.0-957.10.1.el7.x86_64
> TEST_DIR      -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch
> SOCKET_SCM_HELPER -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/sock=
et_scm_helper
>=20
> 221         - output mismatch (see 221.out.bad)
> --- /home/thuth/devel/qemu/tests/qemu-iotests/221.out	2019-04-23 16:43:=
12.000000000 +0200
> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/221.out.bad	2019-04-2=
8 17:18:52.000000000 +0200
> @@ -7,10 +7,10 @@
>  [{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": fals=
e, "offset": OFFSET}]
>  wrote 1/1 bytes at offset 43008
>  1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -[{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": fals=
e, "offset": OFFSET},
> -{ "start": 40960, "length": 2049, "depth": 0, "zero": false, "data": t=
rue, "offset": OFFSET},
> +[{ "start": 0, "length": 43008, "depth": 0, "zero": true, "data": fals=
e, "offset": OFFSET},
> +{ "start": 43008, "length": 1, "depth": 0, "zero": false, "data": true=
, "offset": OFFSET},

Ugh. Hole granularities are file-system specific, so we need to figure
out some way to fuzz the input. It might also be possible to pick nicer
size numbers - perhaps if the test image is sized at 64k+1 instead of
43009 (84*512, but NOT evenly divisible by 4k), the +1 byte is more
likely to be directly one a hole boundary, rather than being somewhere
that causes rounding the hole boundary 2k earlier because of 4k or 64k
sizing constraints.

> Any ideas how to fix this?
>=20
>  Thomas
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--L4Y2TEEyzcSdtVJhyUK43HTUNSu5ftLE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzLaQUACgkQp6FrSiUn
Q2r8BAf/UreFg2mCxt4Xftu31lXncf/i+IEdeO4pXSrg80xq88sWohUCTSdzM2uS
OBG4lpC6HI3U0g6j8eyXxHM/gZZGciE0xXY2qoMlImYW1dEbzptLP3oi9agcz9mS
yQ16C2VJK3v+R2UBqVWJTytgZVJCI7P2Y8AUZHxlENBx4I2MvYAQgagarQ1UhYKi
BM1vu+utu6SB3X8DHll8t+6R2whLoA5HJEHUblIReUGNPSmkvYcBQDkJ21880TjS
bhMHm8uQyHpndTjiBAroUF+rdq16fukCKKVOk5tbrnGhhMoOfrvhZXosXR+k9Fbi
VeEhb40AHKcy7+zpIMA0sJNWKh/fRg==
=yhSy
-----END PGP SIGNATURE-----

--L4Y2TEEyzcSdtVJhyUK43HTUNSu5ftLE3--
