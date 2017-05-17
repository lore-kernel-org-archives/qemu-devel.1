Received: from eggs.gnu.org ([2001:4830:134:3::10]:58333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAzBk-0004BI-Jp
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAzBj-0003TD-Lr
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:40:28 -0400
References: <20170516204724.1617-1-eblake@redhat.com>
	<20170516204724.1617-10-eblake@redhat.com>
	<871srnd78k.fsf@secure.mitica>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf05aa64-93f8-c067-6286-3b9b10a76c02@redhat.com>
Date: Wed, 17 May 2017 08:40:05 -0500
MIME-Version: 1.0
In-Reply-To: <871srnd78k.fsf@secure.mitica>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m0Qsh112dmHf3XqlA97oF0mHH386JJmkk"
Subject: Re: [Qemu-devel] [PATCH v2 09/12] dirty-bitmap: Change
 bdrv_[re]set_dirty_bitmap() to use bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m0Qsh112dmHf3XqlA97oF0mHH386JJmkk
From: Eric Blake <eblake@redhat.com>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org,
 Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <cf05aa64-93f8-c067-6286-3b9b10a76c02@redhat.com>
Subject: Re: [PATCH v2 09/12] dirty-bitmap: Change bdrv_[re]set_dirty_bitmap()
 to use bytes
References: <20170516204724.1617-1-eblake@redhat.com>
 <20170516204724.1617-10-eblake@redhat.com> <871srnd78k.fsf@secure.mitica>
In-Reply-To: <871srnd78k.fsf@secure.mitica>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 06:59 AM, Juan Quintela wrote:
> Eric Blake <eblake@redhat.com> wrote:
>> Some of the callers were already scaling bytes to sectors; others
>> can be easily converted to pass byte offsets, all in our shift
>> towards a consistent byte interface everywhere.  Making the change
>> will also make it easier to write the hold-out callers to use byte
>> rather than sectors for their iterations; it also makes it easier
>> for a future dirty-bitmap patch to offload scaling over to the
>> internal hbitmap.  Although all callers happen to pass
>> sector-aligned values, make the internal scaling robust to any
>> sub-sector requests.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>=20
>=20
>> +
>>      assert(bdrv_dirty_bitmap_enabled(bitmap));
>> -    hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
>> +    hbitmap_set(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
>> +                end_sector - (offset >> BDRV_SECTOR_BITS));
>=20
> It is just me, or we use:
>=20
> bytes =3D sectors * BDRV_SECTOR_SIZE
> or
> bytes =3D sectors << BDRV_SECTOR_BITS

BDRV_SECTOR_SIZE is ULL, while BDRV_SECTOR_BITS is not. Multiplying by
SIZE guarantees a 64-bit answer, but shifting by bits will give only a
32-bit answer if the left hand side of << is not already 64 bits (I've
had bugs in earlier conversion patches where I used << but should have
used *).  So for scaling up, my recent round of patches have been
favoring * (ideally, since BDRV_SECTOR_SIZE is a power-of-2 constant,
the compiler optimizes it into a shift anyways instead of wasting time
on a multiply).

For scaling down, '/ SIZE' and '>> BITS' are equivalent, but I prefer
the >> form.

>=20
> and the same from bytes to sectors (no, this patch is consistent,
> but just looking at the file ....)

The real end-goal is to update the file to track the entire process with
bytes everywhere (and skip the intermediate representation in sectors),
which will reduce the number of scaling operations needed in the first
place.  migration/block.c isn't quite there yet, but we'll get there.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--m0Qsh112dmHf3XqlA97oF0mHH386JJmkk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHFK1AAoJEKeha0olJ0NqeYYH/jxyUzWIaVVXnzEYHHunFt5D
u4ufERaY+W7aoRttfjexeQ7k12481fjiOEpThJplGpP4InqFW/TtoiUc50mCKvxs
8rPRGiMMMZVnAE9aYu11qpKXVwa30P6Y3jKNE46SYtvrkHJM4Wp/9Ivzmi3u0m5K
jntmQYuC5TsXDCdDgbsKyJfhKrnpkr92JRHIl4o1MPXU9yWyeQeumd4ylrxuwMly
L0lCDwBvzn5Nc745JO73m9m1h5M8AE1j22zko4CXJXJk+kgUGDfv43+E9h3bbdQr
X4raZssXcRxkIw7mv45zNOQZ+ag+wAOSCfKFLHpc1/EeY8Sh6HR62BBrntA8Xu0=
=M8sD
-----END PGP SIGNATURE-----

--m0Qsh112dmHf3XqlA97oF0mHH386JJmkk--
