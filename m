Received: from eggs.gnu.org ([2001:4830:134:3::10]:48661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSivH-0006Cy-RA
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSivG-0007jE-TJ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:56:47 -0400
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-4-eblake@redhat.com>
	<20170704070643.GB10298@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6aafcf61-7923-23c1-496d-6f2c195149d1@redhat.com>
Date: Wed, 5 Jul 2017 06:56:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170704070643.GB10298@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F5AGTm9KUddngsMtXtJnsiCFgimmNm8xO"
Subject: Re: [Qemu-devel] [PATCH v2 03/15] block: Add flag to avoid wasted
 work in bdrv_is_allocated()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F5AGTm9KUddngsMtXtJnsiCFgimmNm8xO
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org,
 el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com
Message-ID: <6aafcf61-7923-23c1-496d-6f2c195149d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/15] block: Add flag to avoid wasted
 work in bdrv_is_allocated()
References: <20170703221456.30817-1-eblake@redhat.com>
 <20170703221456.30817-4-eblake@redhat.com> <20170704070643.GB10298@lemon.lan>
In-Reply-To: <20170704070643.GB10298@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/04/2017 02:06 AM, Fam Zheng wrote:
> On Mon, 07/03 17:14, Eric Blake wrote:
>> @@ -1717,6 +1718,10 @@ int64_t coroutine_fn bdrv_co_get_block_status_f=
rom_backing(BlockDriverState *bs,
>>   * Drivers not implementing the functionality are assumed to not supp=
ort
>>   * backing files, hence all their sectors are reported as allocated.
>>   *
>> + * If 'allocation' is true, the caller only cares about allocation
>> + * status; this is a hint that a larger 'pnum' result is more
>> + * important than including BDRV_BLOCK_OFFSET_VALID in the return.
>> + *
>=20
> This is slightly unintuitive. I would guess "allocation =3D=3D false" m=
eans "I don't
> care about the allocation status" but it actually is "I don't care abou=
t the
> consecutiveness". The "only" semantics is missing in the parameter name=
=2E
>=20
> Maybe rename it to "consecutive" and invert the logic?  I.e. "consecuti=
ve =3D=3D
> true" means BDRV_BLOCK_OFFSET_VALID is wanted.

Reasonable idea; other [shorter] names I've been toying with:
strict
mapping
precise

any of which, if true (set true by bdrv_get_block_status), means that I
care more about BDRV_BLOCK_OFFSET_VALID and validity for learning host
offsets, if false  it means I'm okay getting a larger *pnum even if it
extends over disjoint host offsets; or:

fast

which if true (set true by bdrv_is_allocated) means I want a larger
*pnum even if I have to sacrifice accuracy by omitting
BDRV_BLOCK_OFFSET_VALID, because I'm trying to reduce effort spent.

>=20
> Sorry for bikeshedding.

Not a problem, I also had some double-takes in writing my own code
trying to remember which way I wanted the 'allocation' boolean to be
set, so coming up with a more intuitive name/default state in order to
help legibility is worth it.  Do any of my above suggestions sound better=
?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--F5AGTm9KUddngsMtXtJnsiCFgimmNm8xO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXNPtAAoJEKeha0olJ0Nq9usH/3uE+/6NKUBBGT3Q79SBPogN
gpJPYjPYnoAphBxfo/TLas3CKj2VoTyqaiv8AdiVICPL1TNDDS+eVhursZnAJ2Ko
/0ESAV2Stj1nE3La2oK+NE9S+RpCdDlyUxsfLYFNliJjaNalUHV9rWJhjIt6Lmg4
oUqSHU8/oiGPLYFv0O3FexU2y+4z+IYlPkE5uBD32b+tOntTa3z6iFzsDHw7I4gn
AFUsBhC6NwVjVDF3RblOhDYnYiNtnDLhiuUeUPEJ1AotyVEPBoPGXbRKNUKY8Ki8
dtmYxJsarO6D8I6Urwd9CMig2c771UTtY1L3vcPzo+qlo0qx9mR3OPMEpVHTQN4=
=Lzmo
-----END PGP SIGNATURE-----

--F5AGTm9KUddngsMtXtJnsiCFgimmNm8xO--
