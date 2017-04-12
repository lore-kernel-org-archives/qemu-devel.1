Received: from eggs.gnu.org ([2001:4830:134:3::10]:55342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyINj-0001B3-15
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyINh-000625-KA
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:32:23 -0400
References: <20170411011718.9152-1-eblake@redhat.com>
	<20170411011718.9152-2-eblake@redhat.com>
	<20170412094909.GC4955@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7b17ce22-cba3-5170-2f1a-7d1cc9dbf4c2@redhat.com>
Date: Wed, 12 Apr 2017 08:32:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170412094909.GC4955@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="22IWg9sf7IqCkfh0VlQbf7xdQqkwHvAhq"
Subject: Re: [Qemu-devel] [PATCH v9 01/13] qcow2: Unallocate unmapped zero
 clusters if no backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--22IWg9sf7IqCkfh0VlQbf7xdQqkwHvAhq
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <7b17ce22-cba3-5170-2f1a-7d1cc9dbf4c2@redhat.com>
Subject: Re: [PATCH v9 01/13] qcow2: Unallocate unmapped zero clusters if no
 backing file
References: <20170411011718.9152-1-eblake@redhat.com>
 <20170411011718.9152-2-eblake@redhat.com>
 <20170412094909.GC4955@noname.str.redhat.com>
In-Reply-To: <20170412094909.GC4955@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 04:49 AM, Kevin Wolf wrote:
> Am 11.04.2017 um 03:17 hat Eric Blake geschrieben:
>> 'qemu-img map' already coalesces information about unallocated
>> clusters (those with status 0) and pure zero clusters (those
>> with status BDRV_BLOCK_ZERO and no offset).  Furthermore, all
>> qcow2 images with no backing file already report all unallocated
>> clusters (in the preallocation sense of clusters with no offset)
>> as BDRV_BLOCK_ZERO, regardless of whether the QCOW_OFLAG_ZERO was
>> set in that L2 entry (QCOW_OFLAG_ZERO also implies a return of
>> BDRV_BLOCK_ALLOCATED, but we intentionally do not expose that bit
>> to external users), thanks to generic block layer code in
>> bdrv_co_get_block_status().
>>
>> So, for an image with no backing file, having bdrv_pwrite_zeroes
>> mark clusters as unallocated (defer to backing file) rather than
>> reads-as-zero (regardless of backing file) makes no difference
>> to normal behavior, but may potentially allow for fewer writes to
>> the L2 table of a freshly-created image where the L2 table is
>> initially written to all-zeroes (although I don't actually know
>> if we skip an L2 update and flush when re-writing the same
>> contents as already present).
>=20
> I don't get this. Allocating a cluster always involves an L2 update, no=

> matter whether it was previously unallocated or a zero cluster.

But we're NOT allocating a cluster.  Either we are unmapping a cluster,
or are we are changing a pure unallocated cluster (bdrv_get_block_status
of 0) to a read-as-zero but unallocated cluster (status 1) [different
from the 'bdrv_is_allocated' sense of an allocated cluster being any
cluster determined by the current layer instead of by its backing file -
I really wish we wouldn't overload 'allocated' to two different
meanings, but am not sure which of the two meanings would be better to
rename, and to what].  My argument is that for a brand new image with no
backing file, all the clusters are pure unallocated, and that a write
zero with unmapping is doing more work by writing 0 =3D> 1 than it would
by leaving 0 =3D> 0, with identical results.


>=20
>> Furthermore, this matches the behavior of discard_single_l2(), in
>> favoring an unallocated cluster over a zero cluster when full
>> discard is requested.
>=20
> The only use for "full discard" is qcow2_make_empty(). It explicitly
> requests that the backing file becomes visible again. This is a
> completely different case.
>=20
> In other words, in order to stay consistent between discard and
> write_zeroes from a guest POV, we need to leave this code alone.

I already argued that from a guest POV, the code is identical.  The only
situation that I changed is the situation where there is no backing
file, so the guest is guaranteed to read zeros from the cluster whether
the cluster is marked pure unallocated (0) or as reads-as-zero
unallocated (1).  The guest already requested unmapping, so they don't
need the preallocated-reads-as-zero (1 | offset).

Note that I absolutely agree that we must NOT make this change when
there is a backing file - a guest request to write zeroes MUST use
reads-as-zero (1) or preallocated reads-as-zero (1 | offset), and not
pure unallocated, unless we can guarantee that falling back to the
backing file will also read as zeroes, but taking the time to learn the
backing file status is not worth the expense.

>=20
>> Meanwhile, version 2 qcow2 files (compat=3D0.10) lack support for an
>> explicit zero cluster.  This minor tweak therefore allows us to turn
>> write zeroes with unmap into an actual unallocation on those files,
>> where they used to return -ENOTSUP and cause an allocation due to
>> the fallback to explicitly written zeroes.
>=20
> Okay, this is true.
>=20
> But I doubt that making write_zeroes more efficient on v2 images withou=
t
> a backing file is really worth any extra complexity at this point...

Is it just my commit message that is wrong?  The code itself is fairly
short to review (I spent a lot more time on the commit message than on
the code - and it looks like I still need more time on the commit
message).  And later patches in the series DO depend on this, so I'm not
ready to just drop the patch yet.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--22IWg9sf7IqCkfh0VlQbf7xdQqkwHvAhq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7ixbAAoJEKeha0olJ0NqbLgIAKVcDCz1PIQIdnyQCE2Oj2+8
unSy4/xxsIdGtuSdREbC1P9ZpIXPSo/xB5DU8vDQLI80l/yXKOmcNiKAjXwobGpa
sunGQpz2HYQIdoXDvYpgdnykdAmuQl4fIoGSm+IcmBBjksRUe1sHPuiQ0cj7e/ub
j0UUeY5KYoRyjvTPthBcrfTksk1qajkeBRkErcNIPEtHKEWHv5x/+zCQ8bsezXtQ
AWJEWeK23T98L/5ISV1wg1ZuG2m6L/EzFWuCswFBQOWBmtK5nZxH6JGYNKvfZjQv
SIbhivT08tCST1xkocAWhNSBPvYDDq3RHbPf0b/OJgbEw/W7+62Rhspn42Yd1hM=
=QZbu
-----END PGP SIGNATURE-----

--22IWg9sf7IqCkfh0VlQbf7xdQqkwHvAhq--
