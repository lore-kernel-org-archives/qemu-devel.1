Received: from eggs.gnu.org ([2001:4830:134:3::10]:52432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2pat-0005RV-M2
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 21:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2pas-00064u-JQ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 21:48:43 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-18-eblake@redhat.com>
	<ada8b8e3-aa6e-b06a-d2bf-6f7e994f0e7d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1bdb54f9-87d4-74a8-e097-c0918dc53fd9@redhat.com>
Date: Mon, 24 Apr 2017 20:48:27 -0500
MIME-Version: 1.0
In-Reply-To: <ada8b8e3-aa6e-b06a-d2bf-6f7e994f0e7d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0I9rIVFpv59hrXtwqct7QiQQQ9tDNsWRq"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 17/17] block: Make
 bdrv_is_allocated_above() byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Fam Zheng <famz@redhat.com>, Wen Congyang <wency@cn.fujitsu.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0I9rIVFpv59hrXtwqct7QiQQQ9tDNsWRq
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Changlong Xie <xiecl.fnst@cn.fujitsu.com>,
 Fam Zheng <famz@redhat.com>, Wen Congyang <wency@cn.fujitsu.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <1bdb54f9-87d4-74a8-e097-c0918dc53fd9@redhat.com>
Subject: Re: [Qemu-block] [PATCH 17/17] block: Make bdrv_is_allocated_above()
 byte-based
References: <20170411222945.11741-1-eblake@redhat.com>
 <20170411222945.11741-18-eblake@redhat.com>
 <ada8b8e3-aa6e-b06a-d2bf-6f7e994f0e7d@redhat.com>
In-Reply-To: <ada8b8e3-aa6e-b06a-d2bf-6f7e994f0e7d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2017 06:06 PM, John Snow wrote:
>=20
>=20
> On 04/11/2017 06:29 PM, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  In the common case, allocation is unlikely to ever use
>> values that are not naturally sector-aligned, but it is possible
>> that byte-based values will let us be more precise about allocation
>> at the end of an unaligned file that can do byte-based access.
>>
>> Changing the signature of the function to use int64_t *pnum ensures
>> that the compiler enforces that all callers are updated.  For now,
>> the io.c layer still assert()s that all callers are sector-aligned,
>> but that can be relaxed when a later patch implements byte-based
>> block status.  Therefore, for the most part this patch is just the
>> addition of scaling at the callers followed by inverse scaling at
>> bdrv_is_allocated().  But some code, particularly stream_run(),
>> gets a lot simpler because it no longer has to mess with sectors.
>>

>> +++ b/block/io.c
>> @@ -1930,52 +1930,46 @@ int coroutine_fn bdrv_is_allocated(BlockDriver=
State *bs, int64_t offset,
>>  /*
>>   * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TO=
P]
>>   *
>> - * Return true if the given sector is allocated in any image between
>> + * Return true if the given offset is allocated in any image between
>=20
> perhaps "range" instead of "offset"?
>=20
>>   * BASE and TOP (inclusive).  BASE can be NULL to check if the given
>> - * sector is allocated in any image of the chain.  Return false other=
wise,
>> + * offset is allocated in any image of the chain.  Return false other=
wise,
>>   * or negative errno on failure.

Seems reasonable.


>>          /*
>> -         * [sector_num, nb_sectors] is unallocated on top but interme=
diate
>> -         * might have
>> -         *
>> -         * [sector_num+x, nr_sectors] allocated.
>> +         * [offset, bytes] is unallocated on top but intermediate
>> +         * might have [offset+x, bytes-x] allocated.
>>           */
>> -        if (n > psectors_inter &&
>> +        if (n > pnum_inter &&
>>              (intermediate =3D=3D top ||
>> -             sector_num + psectors_inter < intermediate->total_sector=
s)) {
>=20
>=20
>=20
>> -            n =3D psectors_inter;
>> +             offset + pnum_inter < (intermediate->total_sectors *
>> +                                    BDRV_SECTOR_SIZE))) {
>=20
> Naive question: not worth using either bdrv_getlength for bytes, or the=

> bdrv_nb_sectors helpers?

bdrv_getlength(intermediate) should indeed be the same as
intermediate->total_sectors * BDRV_SECTOR_SIZE (for now - ultimately it
would be nice to track a byte length rather than a sector length for
images). I can make that cleanup for v2.

>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0I9rIVFpv59hrXtwqct7QiQQQ9tDNsWRq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/qrrAAoJEKeha0olJ0NqPnYH/19/V4IN7i/ssA3aLfQbbepC
Ul+qYStsiVUkRfz7aCcBcwYF1V7H42SuFR62LmyW8fJcV1LRod+Mr9BeXLvwbkVy
bo18hoHBtiAsydgc9kwPdCuFSWQC6jIL1yNTDadc5UYqp3OZcjocKGQTacRYHNLU
Ll1KWrrD+x/QznoFd7HYqxz4xPs0p7GveDlN05qppADc7CsL2vtgfxgngmLW5aNM
1SkiamuwiupMOwoP0GnEcR0yjADpWLTyZ0ZzGTthuj9zOp2ruWfs+TAHACFmSlju
IMulw6gPwollNlFI2zCJjj6S18RzOVWOWJn93eDgn5rxDI40c53+iC7FKVhlRwQ=
=7XV4
-----END PGP SIGNATURE-----

--0I9rIVFpv59hrXtwqct7QiQQQ9tDNsWRq--
