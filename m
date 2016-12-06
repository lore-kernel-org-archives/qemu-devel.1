Received: from eggs.gnu.org ([2001:4830:134:3::10]:36464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cENFf-0005vs-Sf
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 16:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cENFe-0006gU-OM
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 16:26:15 -0500
References: <20161203181914.7467-1-eblake@redhat.com>
	<0c1ad753-561b-62c9-cdd6-2dfebb020b2b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d6e0a4ba-d64b-7b9d-a7a1-53170ddbb543@redhat.com>
Date: Tue, 6 Dec 2016 15:26:00 -0600
MIME-Version: 1.0
In-Reply-To: <0c1ad753-561b-62c9-cdd6-2dfebb020b2b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KT9vtxefdxabH17mvCOfFRrceFaMWgF0F"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Discard/zero clusters by byte count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KT9vtxefdxabH17mvCOfFRrceFaMWgF0F
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Message-ID: <d6e0a4ba-d64b-7b9d-a7a1-53170ddbb543@redhat.com>
Subject: Re: [PATCH] qcow2: Discard/zero clusters by byte count
References: <20161203181914.7467-1-eblake@redhat.com>
 <0c1ad753-561b-62c9-cdd6-2dfebb020b2b@redhat.com>
In-Reply-To: <0c1ad753-561b-62c9-cdd6-2dfebb020b2b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 03:01 PM, Max Reitz wrote:
> On 03.12.2016 19:19, Eric Blake wrote:
>> Passing a byte offset, but sector count, when we ultimately
>> want to operate on cluster granularity, is madness.  Clean up
>> the interfaces to take byte offset and count.  Rename
>> qcow2_discard_clusters() and qcow2_zero_clusters() to the
>> shorter qcow2_discard() and qcow2_zero() to make sure backports
>> don't get confused by changed units.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> 2.9 material, depends on 'Don't strand clusters near 2G intervals
>> during commit'
>>

>> @@ -1595,20 +1593,24 @@ static int zero_single_l2(BlockDriverState *bs=
, uint64_t offset,
>>      return nb_clusters;
>>  }
>>
>> -int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb=
_sectors,
>> -                        int flags)
>> +int qcow2_zero(BlockDriverState *bs, uint64_t offset, uint64_t count,=

>> +               int flags)
>=20
> Hmm, I personally liked qcow2_zero_clusters() better. qcow2_zero()
> doesn't really express that it means the verb "to zero".
>=20
> Also, while you are making a good point why the function should be
> renamed, qcow2_zero_clusters() was much more accurate because offset an=
d
> count are expected to be cluster-aligned.
>=20
> The only alternative I can come up with would be "qcow2_write_zeroes";
> that at least solves the first issue I have with this, but not the
> second one...

Maybe qcow2_cluster_zeroize() and qcow2_cluster_discard()? That gets the
benefit of the rename (to force all callers to use the right semantics),
while still being legible as an object-verb naming: the action
('discard' or 'zeroize') is performed on 'qcow2 cluster' objects.

>=20
>>  {
>>      BDRVQcow2State *s =3D bs->opaque;
>>      uint64_t nb_clusters;
>>      int ret;
>>
>> +    /* Block layer guarantees cluster alignment */
>=20
> Hm, it's rather qcow2_co_pwrite_zeroes(), isn't it? The block layer wil=
l
> split unaligned requests into head, body and tail and it will still
> submit head and tail (though separately).

Hmm, good point.  I'll have to come up with some way to reword that.

>=20
> As far as I can see, it's qcow2_co_pwrite_zeroes() which then guarantee=
s
> that only the aligned part gets through to qcow2_zero().
>=20
>=20
> The patch looks good apart from these nit picks, though.
>=20
> Max
>=20
>> +    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>> +    assert(QEMU_IS_ALIGNED(count, s->cluster_size));

And since I'm adding assertions that the zero operation is never
attempted on unaligned parts, maybe I should also add asserts that
discards are never unaligned, perhaps as a prereq patch.

I'll wait a bit and see if anyone else has better naming ideas for the
functions, before I try to send a v2.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KT9vtxefdxabH17mvCOfFRrceFaMWgF0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRyzoAAoJEKeha0olJ0Nq4TEH/iOXKGzISSJ+8SR4csFW03R0
P4TveGMaTFYc81JLHA+izW/fgAzakPlQmtlc3b7u2sVmeNwtXt3DXqPc7UrVogYH
tPnd5Z5g1F0i2IOreWa7nxngqOOaOGp246YC3etKZJL0unSI9IBLLn1HGk0uXBUu
ahV6rgYp0/tPBknVSEPLujWr2lds4PkD4GmhxhaliUJ9Akv0D4yaK3Q37QRRTkuR
LAXP1OzUXgICbCl+6DSCl0sdL/DLV+RCNwIYoDPXUz8L5jDvwUyVW1IasUzsPfeW
NDWptzj0Es5UI8+PAwc+05+hNfbLDlMgTa302JBhITKa3aCB0/f1sv+GYzyYUJI=
=wMQO
-----END PGP SIGNATURE-----

--KT9vtxefdxabH17mvCOfFRrceFaMWgF0F--
