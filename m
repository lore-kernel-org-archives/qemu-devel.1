Received: from eggs.gnu.org ([2001:4830:134:3::10]:59545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYFBq-0002vZ-MZ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYFBp-00006z-PG
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:52:26 -0500
References: <20161220191523.5779-1-eblake@redhat.com>
	<20161220191523.5779-3-eblake@redhat.com>
	<c251adb7-7269-95f1-66aa-6d2457e5d8f6@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08d6f722-22b5-5604-46f7-0d1f812756f5@redhat.com>
Date: Mon, 30 Jan 2017 10:52:18 -0600
MIME-Version: 1.0
In-Reply-To: <c251adb7-7269-95f1-66aa-6d2457e5d8f6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="68XhqHMDD6ecTmj8mlgMjG5hxLdxjQX1b"
Subject: Re: [Qemu-devel] [PATCH v4 2/7] qcow2: Discard/zero clusters by
 byte count
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
--68XhqHMDD6ecTmj8mlgMjG5hxLdxjQX1b
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Message-ID: <08d6f722-22b5-5604-46f7-0d1f812756f5@redhat.com>
Subject: Re: [PATCH v4 2/7] qcow2: Discard/zero clusters by byte count
References: <20161220191523.5779-1-eblake@redhat.com>
 <20161220191523.5779-3-eblake@redhat.com>
 <c251adb7-7269-95f1-66aa-6d2457e5d8f6@redhat.com>
In-Reply-To: <c251adb7-7269-95f1-66aa-6d2457e5d8f6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/28/2017 02:21 PM, Max Reitz wrote:
> On 20.12.2016 20:15, Eric Blake wrote:
>> Passing a byte offset, but sector count, when we ultimately
>> want to operate on cluster granularity, is madness.  Clean up
>> the interfaces to take both offset and count as bytes, while
>> still keeping the assertion added previously that the caller
>> must align the values to a cluster.  Then rename things to
>> make sure backports don't get confused by changed units:
>> instead of qcow2_discard_clusters() and qcow2_zero_clusters(),
>> we now have qcow2_cluster_discard and qcow2_cluster_zeroize().
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> +int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
>> +                          uint64_t count, int flags);
>=20
> I know byte count parameters are often called "count", but I find it a
> bit problematic if the function name contains a word that can be a unit=
=2E
> In these cases, it's not entirely clear whether "count" refers to bytes=

> or clusters. Maybe "length" or "size" would be better?

Now that you mention it, 'cluster' and 'count' is indeed confusing.  I'm
leaning towards 'size'.  Do I need to respin, or is that something that
the maintainer is comfortable tweaking?

>=20
> Purely subjective and thus optional, of course.
>=20
> Another thing: I'm not quite positive whether qcow2_cluster_zeroize()
> can actually handle a byte count greater than INT_MAX. If you could pas=
s
> such a number to it, the multiplication "ret * s->cluster_size" might
> overflow. It's only caller qcow2_co_pwrite_zeroes() will never exceed
> that limit, but maybe this should be made clear somewhere -- either by
> making the parameter an int instead of a uint64_t or by asserting it in=

> the function.

I'd lean towards an assertion, especially since it would be nice to
someday unify all the internal block interfaces to get to a 64-bit
interface wherever possible (limiting ourselves to 32-bit is necessary
for some drivers, like NBD, but that limitation should be enforced via
proper BlockLimits, rather than by inherent limits in our API).  An
assertion with 64-bit types is better than yet one more place to audit
for missing assertions if we use a 32-bit type now and then widen to
64-bit later.


>> -int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,
>> -    int nb_sectors, enum qcow2_discard_type type, bool full_discard)
>> +int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
>> +                          uint64_t count, enum qcow2_discard_type typ=
e,
>> +                          bool full_discard)
>>  {
>>      BDRVQcow2State *s =3D bs->opaque;
>> -    uint64_t end_offset;
>> +    uint64_t end_offset =3D offset + count;
>>      uint64_t nb_clusters;
>>      int ret;
>>
>> -    end_offset =3D offset + (nb_sectors << BDRV_SECTOR_BITS);
>> -
>>      /* Caller must pass aligned values */
>>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>>      assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size));
>=20
> Directly below this we have "offset - end_offset" which could be
> shortened to "count" (or "length" or "size" or...).

Okay, there's now enough comments that it's worth me respinning a v5.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--68XhqHMDD6ecTmj8mlgMjG5hxLdxjQX1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj29CAAoJEKeha0olJ0NqYDAIAJ3DxZRTg1+2pl2y9jlYiDzC
N31EBil/Qh8GaPmutFzzMRH0mxDBw+m6iUyHEN9IofL82Wg69+39zCOy4xZ1Q8cW
6R5LQ2yEWVEOBFX5JYmvp1bsu3sriJ6bLTIERqDiGzhTHhMs1aQ/Bz0Enr/5ZSU8
owm8dMd4Tiy95af4fXezH88DE+HGLmPYBwP26fVDofR/gc9U4fWaYmiBmNXc/jw0
rzohLy2DxdvTscK1vJDie2hcQK46EY00j6WqtMvgDs/l33G3ltfNdlLaTHxDGpCL
FeGgXxu3oGRcj9b5R0Wt1Jl/0OSsih0Aq0P+p5yBg+uqmzmyDBCAAgPBT17Da/4=
=iblf
-----END PGP SIGNATURE-----

--68XhqHMDD6ecTmj8mlgMjG5hxLdxjQX1b--
