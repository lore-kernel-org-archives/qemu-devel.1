Received: from eggs.gnu.org ([209.51.188.92]:53358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEIuN-0004sO-E4
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEItG-0004be-38
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:28:11 -0400
References: <20190401145741.28322-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
Date: Wed, 10 Apr 2019 21:28:02 +0200
MIME-Version: 1.0
In-Reply-To: <20190401145741.28322-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LTnHzBBIahXPJq4ZVlHP2MvzhL74LnGpN"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] qemu-img: Saner printing of
 large file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, Alberto Garcia <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LTnHzBBIahXPJq4ZVlHP2MvzhL74LnGpN
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
Subject: Re: [PATCH for-4.1 v2] qemu-img: Saner printing of large file sizes
References: <20190401145741.28322-1-eblake@redhat.com>
In-Reply-To: <20190401145741.28322-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.04.19 16:57, Eric Blake wrote:
> Disk sizes close to INT64_MAX cause overflow, for some pretty
> ridiculous output:
>=20
>   $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img info $=
nbd'
>   image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
>   file format: raw
>   virtual size: -8388607T (9223372036854775296 bytes)
>   disk size: unavailable
>=20
> But there's no reason to have two separate implementations of integer
> to human-readable abbreviation, where one has overflow and stops at
> 'T', while the other avoids overflow and goes all the way to 'E'. With
> this patch, the output now claims 8EiB instead of -8388607T, which
> really is the correct rounding of largest file size supported by qemu
> (we could go 511 bytes larger if we used byte-accurate sizing instead
> of rounding up to the next sector boundary, but that wouldn't change
> the human-readable result).
>=20
> Quite a few iotests need updates to expected output to match.
>=20
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> v2 - actually update iotests to match; no change to block/ code so R-b =
added

There are more iotests this breaks.  First, there is 059 for vmdk, which
looks just like the rest.

But for -m32, it gets a bit more difficult.  Every size above 999 GB
(1000 GB gets rounded to 1 TB, which is 2^31 * 512) gets printed as
"inf [unit]":

$ ./qemu-img create -f qcow2 /tmp/foo.qcow2 1T
$ ./qemu-img info /tmp/foo.qcow2
[...]
virtual size: inf TiB (1099511627776 bytes)
[...]

$ ./qemu-img create -f qcow2 /tmp/foo.qcow2 1P
$ ./qemu-img info /tmp/foo.qcow2
[...]
virtual size: inf PiB (1125899906842624 bytes)
[...]

This breaks the iotests that test the maximum disk size of more exotic
formats.  I can see failures for vdi, vhdx, and parallels.

But regardless of the iotests, we shouldn=E2=80=99t show the size as infi=
nite
just because of -m32.

Max


--LTnHzBBIahXPJq4ZVlHP2MvzhL74LnGpN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyuQ8IACgkQ9AfbAGHV
z0Dozwf8CKH5VQnBcHBXDQ2qt/VzI9o8gKDNDrIstgFW2C67jCUK2Rf5ebMYfBCy
TagUJN+vRpyJgltOG+OVBe0SeiW2GsCcvlQtUfC67LDcHT5ycoPC9o9LSsyhQRHw
wC6KNswyLDPxMz+z/lSpSinGh9NbGGtvzKd2K+PfkKPZ657++4Uj7RDiCReTWN4A
1BAR2U2PCmy01n+222GVuJm5vj8BLEF6MAS/pLVADq9jngoV+k4bC5EBN9p5g3VY
Se4a5O+MD9X9feq82+ad8snFUy68g/J7QT7GpG9+v1PigJOjGgTjvU22QpEg/R69
GLobqdfAAv+ymsJrgtqD3jAK0mPiXw==
=jIJr
-----END PGP SIGNATURE-----

--LTnHzBBIahXPJq4ZVlHP2MvzhL74LnGpN--
