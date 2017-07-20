Received: from eggs.gnu.org ([2001:4830:134:3::10]:55639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYGzT-0004d9-1y
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:20:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYGzR-0003q8-R8
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:20:03 -0400
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
	<1500560441-5670-9-git-send-email-pl@kamp.de>
	<6c67ca5d-56be-548b-8854-5891818c4217@redhat.com>
	<8b0c6cba-3a8e-62dd-35af-46dc05420ec7@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a336b66-1fe9-cc1f-414c-75852c65d04d@redhat.com>
Date: Thu, 20 Jul 2017 14:19:52 -0500
MIME-Version: 1.0
In-Reply-To: <8b0c6cba-3a8e-62dd-35af-46dc05420ec7@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="39bWIvGtxtqA7sAi9BAqf7MxJ3HW3r3xc"
Subject: Re: [Qemu-devel] [PATCH V4 08/10] block/qcow2: start using the
 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--39bWIvGtxtqA7sAi9BAqf7MxJ3HW3r3xc
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <6a336b66-1fe9-cc1f-414c-75852c65d04d@redhat.com>
Subject: Re: [PATCH V4 08/10] block/qcow2: start using the compress format
 extension
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
 <1500560441-5670-9-git-send-email-pl@kamp.de>
 <6c67ca5d-56be-548b-8854-5891818c4217@redhat.com>
 <8b0c6cba-3a8e-62dd-35af-46dc05420ec7@kamp.de>
In-Reply-To: <8b0c6cba-3a8e-62dd-35af-46dc05420ec7@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 11:30 AM, Peter Lieven wrote:

>> The new code is now unconditionally initializing with -15 instead of
>> -12.  Does that matter, or does decompression work regardless of windo=
w
>> size used at creation, as long as the initialized size at decompressio=
n
>> is at least as large?  On the other hand, I guess that means if someon=
e
>> compresses with a large window, and then I initialize the decompressor=

>> with a small window, my decompression will fail?  That's why knowing t=
he
>> minimum window size should be part of the spec, whether or not we make=

>> it a tunable.
>=20
> The decompression is supposed to fail if you compress with 15 and
> decompress with 12. In fact it doesn't.

Actually, I think (this is my guess here, not actual researched fact)
that the decompression error is possible ONLY if compression produced a
symbol that actually required more than 12 bits of memory - to get that
large of a symbol, you need to compress a lot of bits.  For our default
cluster of 64k, it might very well be that you rarely, if ever,
encounter a single cluster that compresses differently under window size
15 than it did under window size 12 (other than perhaps the speed at
which compression took place), because there simply wasn't enough
content to reach the point where you needed a symbol in the compression
stream using more than 12 bits.  So in that case, compressing under 15
and decompressing under 12 doesn't hit the error.  But as you get larger
cluster sizes (2M clusters), or perhaps if you pass particularly nasty
sequences of input to compression (I'm not sure what sequences would
have the right properties), then you do indeed result in a compression
stream that starts to encounter symbols exceeding the window size.

But if my guess is right, then don't read the docs as "decompression
will fail", but rather as "decompression may fail" if you set the
decompress window smaller than the compression window.

> I would like to avoid the windowBits in the qcow2 header as it makes
>=20
> the code to read and write it more complicated. If you don't like the c=
hange
>=20
> of the windowBits we can even stick with 12. If someone wants fast comp=
ression
>=20
> he will likely not use zlib at all and use lzo.

Also, note that historically, 'compress -b N' has allowed tuning the
window size; current POSIX states that compress only has to support
windows from 9 to 14, but permits implementations to use up to 16 (and
future POSIX is considering improving the compress utility to require
support for 16 as the window size, https://posix.rhansen.org/p/bug1041).
 I don't know why gzip didn't expose a '-b N' windowsize parameter the
way compress did, but it sounds like the same thing.

>=20
> I just changed the windowBits to 15 as it increases speed and improves =
compression.

Does windowBits 16 make any difference?

>=20
> (likely at the cost of memory during compression/decompression)
>=20
>=20
> Peter
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--39bWIvGtxtqA7sAi9BAqf7MxJ3HW3r3xc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllxAlgACgkQp6FrSiUn
Q2pYPQf/SFyXuUpPrnf4RZie/AM7iUhXQJDNWSyWrkSpafe8/nuMdBba80wpU5HL
6fV9k8BXIM/yMOcZOlpYTsuwUmc0OHB9JFR4IecQcdqDVsnznCJn+3tGPDBWuhjK
/uVB8l5s9LvtNZrZxuudn+pwD0sc0Ag1jr5pzuypldgYuZD8Y6E1N9FsvAE28ksE
PGM9boJoN6cLV0sDlnCBXdy2XeTdTuTLjOTOmZ1lkg8Z4dJ9KIhrvQqooyEwag4Z
vdgyfJM3lCPmUYR+m+1T6PB6JEFFrVl7pp5N2tOzsHRY5lSsoQDUK9nByXH0W1Wq
MQ5nQWaCWfWFZ/u4uNAHp/EI6BxSTw==
=4zmK
-----END PGP SIGNATURE-----

--39bWIvGtxtqA7sAi9BAqf7MxJ3HW3r3xc--
