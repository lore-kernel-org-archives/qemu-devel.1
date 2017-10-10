Received: from eggs.gnu.org ([2001:4830:134:3::10]:57275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1vp2-00016x-EE
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1vow-0005au-LF
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:47:52 -0400
References: <20171004020048.26379-1-eblake@redhat.com>
	<20171004020048.26379-5-eblake@redhat.com>
	<20171010141505.GK4177@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <baf35f07-393d-fb45-6be3-2f787b8741d7@redhat.com>
Date: Tue, 10 Oct 2017 09:47:31 -0500
MIME-Version: 1.0
In-Reply-To: <20171010141505.GK4177@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RWIpqxqs2ODCkQDmngl7raE2Xx8dj2GNG"
Subject: Re: [Qemu-devel] [PATCH v5 04/23] qcow2: Switch is_zero_sectors()
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RWIpqxqs2ODCkQDmngl7raE2Xx8dj2GNG
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <baf35f07-393d-fb45-6be3-2f787b8741d7@redhat.com>
Subject: Re: [PATCH v5 04/23] qcow2: Switch is_zero_sectors() to byte-based
References: <20171004020048.26379-1-eblake@redhat.com>
 <20171004020048.26379-5-eblake@redhat.com>
 <20171010141505.GK4177@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171010141505.GK4177@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 09:15 AM, Kevin Wolf wrote:
> Am 04.10.2017 um 04:00 hat Eric Blake geschrieben:
>> We are gradually converting to byte-based interfaces, as they are
>> easier to reason about than sector-based.  Convert another internal
>> function (no semantic change), and rename it to is_zero() in the
>> process.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>>

>> +static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t byt=
es)
>>  {
>>      int nr;
>>      int64_t res;
>> +    int64_t start;
>>
>> -    if (start + count > bs->total_sectors) {
>> -        count =3D bs->total_sectors - start;
>> +    /* Widen to sector boundaries, then clamp to image length, before=

>> +     * checking status of underlying sectors */
>> +    start =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
>> +    bytes =3D QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE) - start=
;
>=20
> Why do we still widen to sector boundaries after this series is fully
> applied? Isn't the whole point that we don't have to do this any more?

The widening is necessary as long as...

>> +    res =3D bdrv_get_block_status_above(bs, NULL, start >> BDRV_SECTO=
R_BITS,
>> +                                      bytes >> BDRV_SECTOR_BITS, &nr,=
 NULL);

we still shift. But you are right; patch 12/23 should be able to drop
the rounding.  I'll double check that it still works, but assuming that
it does, v6 will include that cleanup.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RWIpqxqs2ODCkQDmngl7raE2Xx8dj2GNG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnc3YMACgkQp6FrSiUn
Q2ouOAf/QNcjB0M7u9BKD7uAdwR2l6O4yEOk1qVAKk/81SN7tDvkiTZz2WI2GXl2
xd4SxV7b/5BEV3pgaCQ0jGJVnisOk9OUFOtXrXRLr8vxPbJ6/UTMzOZIap0Wq7n4
csolz43psrEjqckEjxvO2y0EAfCMA/bv7zuplNLYTvxE4RJsVkRu2QkA4LNJNn6T
YLAAu7xnHFbORfm6S2tjGh4V9Wu1B2EFjWaNbf2IsGEFjf+UFYIoKNJJrgTOU/3L
+DzkqjOgdW7Dx7lBB2Cm1TnM5jNV0KxC0RINFTkw2z66UtTPhzI8Trkj5JWTIkta
tMbYjx8tGHt+X7FYrN5ru6gny7h39w==
=i1j8
-----END PGP SIGNATURE-----

--RWIpqxqs2ODCkQDmngl7raE2Xx8dj2GNG--
