Received: from eggs.gnu.org ([2001:4830:134:3::10]:36232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy41e-0001Gw-Cf
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy41d-0007qh-2V
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:12:38 -0400
References: <20170411011718.9152-1-eblake@redhat.com>
	<20170411011718.9152-8-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b8732f2-0bb7-8a23-2ab5-38aeae82574c@redhat.com>
Date: Tue, 11 Apr 2017 17:12:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170411011718.9152-8-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h7JQIWHOvwkS2buHDd30TExvq7SUAWm1s"
Subject: Re: [Qemu-devel] [PATCH v9 07/13] qcow2: Discard/zero clusters by
 byte count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h7JQIWHOvwkS2buHDd30TExvq7SUAWm1s
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <4b8732f2-0bb7-8a23-2ab5-38aeae82574c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 07/13] qcow2: Discard/zero clusters by
 byte count
References: <20170411011718.9152-1-eblake@redhat.com>
 <20170411011718.9152-8-eblake@redhat.com>
In-Reply-To: <20170411011718.9152-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2017 08:17 PM, Eric Blake wrote:
> Passing a byte offset, but sector count, when we ultimately
> want to operate on cluster granularity, is madness.  Clean up
> the external interfaces to take both offset and count as bytes,
> while still keeping the assertion added previously that the
> caller must align the values to a cluster.  Then rename things
> to make sure backports don't get confused by changed units:
> instead of qcow2_discard_clusters() and qcow2_zero_clusters(),
> we now have qcow2_cluster_discard() and qcow2_cluster_zeroize().
>=20
> The internal functions still operate on clusters at a time, and
> return an int for number of cleared clusters; but on an image
> with 2M clusters, a single L2 table holds 256k entries that each
> represent a 2M cluster, totalling well over INT_MAX bytes if we
> ever had a request for that many bytes at once.  All our callers
> currently limit themselves to 32-bit bytes (and therefore fewer
> clusters), but by making this function 64-bit clean, we have one
> less place to clean up if we later improve the block layer to
> support 64-bit bytes through all operations (with the block layer
> auto-fragmenting on behalf of more-limited drivers), rather than
> the current state where some interfaces are artificially limited
> to INT_MAX at a time.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20

> +int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
> +                          uint64_t bytes, int flags)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      uint64_t end_offset;
>      uint64_t nb_clusters;
> +    int64_t cleared;
>      int ret;
>=20
> -    end_offset =3D offset + (nb_sectors << BDRV_SECTOR_BITS);
> +    end_offset =3D offset + bytes;
>=20
>      /* Caller must pass aligned values, except at image end */
>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>      assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
>             end_offset =3D=3D bs->total_sectors << BDRV_SECTOR_BITS);
> +    assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));

And I promptly botched my rebasing.  qemu-iotests 154 caught my mistake
(the whole point of calculating end_offset is because bytes need not be
cluster-aligned if end_offset is at EOF). I'll send the obvious fixup.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--h7JQIWHOvwkS2buHDd30TExvq7SUAWm1s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7VTNAAoJEKeha0olJ0Nq3+kH/Ap0Y+vP8urQb2SDXi/82xzK
QKhZyC0jXEv8DKmZChqP/fi3asD7UKwBFqladEIbbvSRaYJ1oUbcMNE+3jr4FOq0
Vr3dJkY5+B5LsHp+DEdG//lF2HxfoWI52iRlCRbZHENEFUAeRGXrJitMJDF8fH7E
UvSXmmHjmV+i2M0rd3maW/Th3Dtg1FHTOcsrszrcujfglbLdfXmPW/DWoFWrrFIe
X8lwmB/psh6DoCC1TsfulSnIG4LEjcG97C8KTbU5qi/q2RDJc0mcW1tqq4B+ks+g
Re29D7yiF3JH8wwdJItm9LxRQWuS5dGJWJPSIEKWASTHd7z+RHhbZi17gBIP9uA=
=rvmM
-----END PGP SIGNATURE-----

--h7JQIWHOvwkS2buHDd30TExvq7SUAWm1s--
