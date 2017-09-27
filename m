Received: from eggs.gnu.org ([2001:4830:134:3::10]:59553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxHX1-0000h0-La
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 14:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxHX0-0006HQ-Lf
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 14:58:03 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-13-eblake@redhat.com>
	<28a79c88-ca25-70c3-9e5b-fc794854fb34@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61cc4e97-bfb7-6f58-dbdc-09a7cd8516a7@redhat.com>
Date: Wed, 27 Sep 2017 13:57:45 -0500
MIME-Version: 1.0
In-Reply-To: <28a79c88-ca25-70c3-9e5b-fc794854fb34@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ePk6CwGDq6vBm9PfLmRfOKOqCTWsAeRQi"
Subject: Re: [Qemu-devel] [PATCH v4 12/23] block: Convert
 bdrv_get_block_status_above() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ePk6CwGDq6vBm9PfLmRfOKOqCTWsAeRQi
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <61cc4e97-bfb7-6f58-dbdc-09a7cd8516a7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 12/23] block: Convert
 bdrv_get_block_status_above() to bytes
References: <20170913160333.23622-1-eblake@redhat.com>
 <20170913160333.23622-13-eblake@redhat.com>
 <28a79c88-ca25-70c3-9e5b-fc794854fb34@redhat.com>
In-Reply-To: <28a79c88-ca25-70c3-9e5b-fc794854fb34@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2017 01:41 PM, John Snow wrote:
>=20
>=20
> On 09/13/2017 12:03 PM, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  In the common case, allocation is unlikely to ever use
>> values that are not naturally sector-aligned, but it is possible
>> that byte-based values will let us be more precise about allocation
>> at the end of an unaligned file that can do byte-based access.
>>
>> Changing the name of the function from bdrv_get_block_status_above()
>> to bdrv_block_status_above() ensures that the compiler enforces that
>> all callers are updated.  For now, the io.c layer still assert()s
>> that all callers are sector-aligned, but that can be relaxed when a
>> later patch implements byte-based block status in the drivers.
>>
>> For the most part this patch is just the addition of scaling at the
>> callers followed by inverse scaling at bdrv_block_status().  But some
>> code, particularly bdrv_block_status(), gets a lot simpler because
>> it no longer has to mess with sectors.  Likewise, mirror code no
>> longer computes s->granularity >> BDRV_SECTOR_BITS, and can therefore
>> drop an assertion (fix a neighboring assertion to use is_power_of_2
>> while there).
>>
>=20
> Huh, I suppose so, yeah. Do you have a test that covers what happens in=

> this newly available use case?

Not directly - the mirror code no longer requires sector alignment, but
is still unlikely to use sub-sector requests unless a particular driver
returns really small status information.  I suppose we could tweak the
blkdebug driver to force status requests to be fragmented at
ridiculously small alignments, and then prove that mirroring still
occurs correctly, once all the series are in, but it's probably more
effort than it is worth to force sub-sector mirroring if we don't have a
real use case that will rely on it.

>=20
>> For ease of review, bdrv_get_block_status() was tackled separately.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>=20
> Looks mechanically correct, anyway.
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ePk6CwGDq6vBm9PfLmRfOKOqCTWsAeRQi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnL9KkACgkQp6FrSiUn
Q2rbIggAg9Gq5MW8X8+8P12kVomClRQRCcAr0WulIyDQeYzQ4ebe8eP9H6bXOxTy
y9JiGwv9wECvx7wgzgC/VV4VBTASQgBOBER8ACVGSPwmjEeKH/g5h2RGowhg/E49
9p6LD4YnwlnkW7fAqISgJHK9fjFkFBB/ehgKzJBk3Vk5wP5XTtT1n7B/ER9xX/SQ
3Kli/mfo1R//jh8GyvG+FhooqxNOKPRcuuQfYx/mpTrhk8As3fWCez1BN8eTeiN8
tvUmIw7lnMPhvTXXZqNRQHDljQcR0PC9R6+KlEl9CwVnK9UnR3Lm46SXjunYAmxf
3cPTwMuin7ZsYIX1fAA0vlsDFfWEig==
=RIQg
-----END PGP SIGNATURE-----

--ePk6CwGDq6vBm9PfLmRfOKOqCTWsAeRQi--
