Received: from eggs.gnu.org ([2001:4830:134:3::10]:55432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cdKCF-0003E6-0f
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cdKCD-00034F-Rr
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:13:50 -0500
References: <20170212014724.10618-1-mreitz@redhat.com>
	<w51lgtazdqs.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8d536684-8a07-7c34-16ca-be234685ab2a@redhat.com>
Date: Mon, 13 Feb 2017 18:13:38 +0100
MIME-Version: 1.0
In-Reply-To: <w51lgtazdqs.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HaokacblsB190kF998C9LV3FbB8Imd2gj"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Swap request limit
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HaokacblsB190kF998C9LV3FbB8Imd2gj
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8d536684-8a07-7c34-16ca-be234685ab2a@redhat.com>
Subject: Re: [Qemu-block] [PATCH] block: Swap request limit definitions
References: <20170212014724.10618-1-mreitz@redhat.com>
 <w51lgtazdqs.fsf@maestria.local.igalia.com>
In-Reply-To: <w51lgtazdqs.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 09:39, Alberto Garcia wrote:
> On Sun 12 Feb 2017 02:47:24 AM CET, Max Reitz <mreitz@redhat.com> wrote=
:
>=20
>> -#define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS, \
>> -                                     INT_MAX >> BDRV_SECTOR_BITS)
>> -#define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECT=
OR_BITS)
>> +#define BDRV_REQUEST_MAX_BYTES      MIN(SIZE_MAX, INT_MAX)
>> +#define BDRV_REQUEST_MAX_SECTORS    (BDRV_REQUEST_MAX_BYTES >> BDRV_S=
ECTOR_BITS)
>=20
> I'm just pointing it out because I don't know if this can cause
> problems, but this patch would make BDRV_REQUEST_MAX_BYTES not a
> multiple of the sector size (INT_MAX is actually a prime number).

Very good point. I don't think this could be an issue, though. For one
thing, the use of BDRV_REQUEST_MAX_BYTES is very limited.

Apart from that, I guess the main issue would be that if you send an
unaligned head/tail the automatic round-up would exceed
BDRV_REQUEST_MAX_SECTORS. But this is a pre-existing issue, actually:
When you issue a request with an unaligned head and 2G - 512 bytes
length, bdrv_co_pwritev() will align it to 2G (which is greater than
INT_MAX).

(Can be tested trivially with:

$ qemu-io -c 'write 511 2147483136' --image-opts driver=3Dnull-co,size=3D=
4G

and some debugging code in block/io.c)

You can make the request even bigger by increasing the
bs->bl.request_alignment.

Not a big issue, though, as bdrv_aligned_p{read,write}v() actually take
an unsigned int and break down requests greater than INT_MAX
automatically. As long as bs->bl.request_alignment stays under 1G or so
we'll be fine (i.e. as long as we don't get an unsigned int overflow) --
and when it breaks it won't be because BDRV_REQUEST_MAX_BYTES is not
aligned to sectors.

Max


--HaokacblsB190kF998C9LV3FbB8Imd2gj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlih6UISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQbgIALE5wwqpWZ+PnDvLgZutciEjVUFrIiBJ
KrXfL4sIRXaYz4e2ohmTS2Sr2ijJWahvzWPLcAyJh79Zdq6z36HV/cOTVwto+2Ox
zUAz2Ae+APwyLFXqdfxMmeiRlXByuJCz/oORhbuTDOQzgaN+PP031Bu2H+cczmuF
Ei95xDSIFizkqJk2J4z5GTkMX1o4UqWQjY7BBMPuAI9XaqnmSo7m+kW+c0JhxHdN
DOs1fxZYqZhHGDZhWVk8jr23cvbYnkuyw/aV27TAY/GQnUuelNmo9+jCDip0jOae
cqnEZVul//s5S7BwVrd0ZgnBTcNrce6dJ6YbS+kwrAw1bd4mrr6DJqc=
=X3ma
-----END PGP SIGNATURE-----

--HaokacblsB190kF998C9LV3FbB8Imd2gj--
