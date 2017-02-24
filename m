Received: from eggs.gnu.org ([2001:4830:134:3::10]:40025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chNDg-0002lr-MG
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chNDb-0003Sy-9L
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:16:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chNDb-0003SM-0B
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:15:59 -0500
References: <764ca07c-af5e-55e3-18c5-7870b9103ba4@kamp.de>
	<3f2dd35f-aed2-087e-6ed5-0b1ae47c0ff0@redhat.com>
	<12913D3E-C367-4D6E-BD35-594A8F114ED6@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86af33e8-0a7b-bd3b-47b7-b7bc066d1c36@redhat.com>
Date: Fri, 24 Feb 2017 15:15:55 -0600
MIME-Version: 1.0
In-Reply-To: <12913D3E-C367-4D6E-BD35-594A8F114ED6@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="McWoW2IISqw28Th5ShKwKbStTWs0IIuQA"
Subject: Re: [Qemu-devel] RFC QCOW2 compression speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, Laszlo Ersek <lersek@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--McWoW2IISqw28Th5ShKwKbStTWs0IIuQA
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, Laszlo Ersek <lersek@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <86af33e8-0a7b-bd3b-47b7-b7bc066d1c36@redhat.com>
Subject: Re: [Qemu-devel] RFC QCOW2 compression speed
References: <764ca07c-af5e-55e3-18c5-7870b9103ba4@kamp.de>
 <3f2dd35f-aed2-087e-6ed5-0b1ae47c0ff0@redhat.com>
 <12913D3E-C367-4D6E-BD35-594A8F114ED6@kamp.de>
In-Reply-To: <12913D3E-C367-4D6E-BD35-594A8F114ED6@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 01:54 PM, Peter Lieven wrote:
>=20
> Changing the compression level via environment or a QCOW2 parameter is =
not a big deal. However, it helps not that much regarding speed. What hel=
ps is increasing the window size, but this is an incompatible change. And=
 if we go for an incompatible change I would think about using a better c=
ompression algorithm than zlib deflate.

Indeed, lzma (think xz), or zstd, or $compression_of_the_day... may be
better, and it may be disk-image dependent which algorithm is best. It
sounds like we need to improve the qcow2 spec to add a header extension
that describes the current compression algorithm and parameters; if
omitted the image uses zlib with fixed window size, but if present, we
can put everything we need to be able to choose other compression
tunings and be able to decompress (still, it has to be an all-or-none).
We'd also need to set an incompatible_features flag if the compression
header extension is present with non-default values so that older qemu
don't go corrupting the compressed data.  And then you start having to
worry about modularity (do you compile qemu with support for all
compression libraries, or can you pick and choose which ones to compile
in at the risk of which images you can't open, or do you figure out how
to dlopen the right libraries as needed...)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--McWoW2IISqw28Th5ShKwKbStTWs0IIuQA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsKKMAAoJEKeha0olJ0NqlE0H/jweHiTjKYr5CIQ70A73tOQi
Yu3sAHZ8xQ500rLeVFkW8U17tHbrGpypCD9Fdo86c9VDkm/y1CflcDLpBVqMYSeG
KVxwPY1MW02grImc8ZzW+GYbZ/9WEXn9VHG/nyXL0gBUPYKsOTSj/yQxp4MKd9J0
4RxwEvALl34dEmstOYFEFZ8vKC0ANamkQaP64ddtSfKYqtYq9+uhaOcX8xg267ls
ftrRyZW0sve8dY9FhdYGM26jzIPQ++E71IkbIODjItxUA0ZZo9ZLPLM3gndC0Dqd
y7hNlLKNqq3YG6Sh+D1PmFxgKs4wCcj6KlXUl7OO+tW6yZhwc2MGQYs57jbKXuo=
=3civ
-----END PGP SIGNATURE-----

--McWoW2IISqw28Th5ShKwKbStTWs0IIuQA--
