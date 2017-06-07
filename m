Received: from eggs.gnu.org ([2001:4830:134:3::10]:50704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIdPb-0006VU-TY
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIdPa-00088f-Rf
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:02:24 -0400
References: <cover.1496844254.git.berto@igalia.com>
	<2ddc2703be89a250994478c92ca7695b4b88791b.1496844254.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5be69f00-7630-bdb1-70a8-02a078798f15@redhat.com>
Date: Wed, 7 Jun 2017 11:02:06 -0500
MIME-Version: 1.0
In-Reply-To: <2ddc2703be89a250994478c92ca7695b4b88791b.1496844254.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AbwWMJJv1qlCtrU2PhqgRMbqBmFmrMMCb"
Subject: Re: [Qemu-devel] [PATCH v2 2/7] qcow2: Use unsigned int for both
 members of Qcow2COWRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AbwWMJJv1qlCtrU2PhqgRMbqBmFmrMMCb
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <5be69f00-7630-bdb1-70a8-02a078798f15@redhat.com>
Subject: Re: [PATCH v2 2/7] qcow2: Use unsigned int for both members of
 Qcow2COWRegion
References: <cover.1496844254.git.berto@igalia.com>
 <2ddc2703be89a250994478c92ca7695b4b88791b.1496844254.git.berto@igalia.com>
In-Reply-To: <2ddc2703be89a250994478c92ca7695b4b88791b.1496844254.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 09:08 AM, Alberto Garcia wrote:
> Qcow2COWRegion has two attributes:
>=20
> - The offset of the COW region from the start of the first cluster
>   touched by the I/O request. Since it's always going to be positive
>   and the maximum request size is at most INT_MAX, we can use a
>   regular unsigned int to store this offset.

I don't know if we will ever get to the point that we allow a 64-bit
request at the block layer (and then the block layer guarantees it is
split down to the driver's limits, which works when a driver is still
bound by 32-bit limits).  But we ALSO know that a cluster is at most 2M
(in our current implementation of qcow2), so the offset of where the COW
region starts in relation to the start of a cluster is < 2M.

>=20
> - The size of the COW region in bytes. This is guaranteed to be >=3D 0,=

>   so we should use an unsigned type instead.

And likewise, since a COW region is a sub-cluster, and clusters are
bounded at 2M, we also have a sub-int upper bound on the size of the regi=
on.

>=20
> In x86_64 this reduces the size of Qcow2COWRegion from 16 to 8 bytes.
> It will also help keep some assertions simpler now that we know that
> there are no negative numbers.
>=20
> The prototype of do_perform_cow() is also updated to reflect these
> changes.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 4 ++--
>  block/qcow2.h         | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index d1c419f52b..a86c5a75a9 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -406,8 +406,8 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_=
t sector_num,
>  static int coroutine_fn do_perform_cow(BlockDriverState *bs,
>                                         uint64_t src_cluster_offset,
>                                         uint64_t cluster_offset,
> -                                       int offset_in_cluster,
> -                                       int bytes)
> +                                       unsigned offset_in_cluster,
> +                                       unsigned bytes)

I don't know if the code base has a strong preference for 'unsigned int'
over 'unsigned', but it doesn't bother me.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AbwWMJJv1qlCtrU2PhqgRMbqBmFmrMMCb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOCN+AAoJEKeha0olJ0NqWnkH/2awSt9RXZfnkyRbJLHD/Fee
QrNiRxWIMWqF4YOnlUF2jw5dEZ0zmxSBgjHwMjLIUWcWxgeuTibe7M3D43LSWg5k
AGmZHbboUn6zq9zplQ0RpHWto7Wum+aZQbOlkj8fezJKAL8izE7LRPTIuxgBvUYJ
E3MWiu5JDTReBM3pmZhSfjFYc0gQJA2iynGXadZWl/FdI24mgxL/NjiqUx8bfbMB
vWJ0kRFEdIK0JeAqeVmGXQoDg/TfcEkzP+D6InnhyMrFJkmGyv3w3lroQ3Ew5cqv
bJJ7lun9HFsAeSq7vWXvoX4HD+pdmF0CH3B40eKWnMjstOqN462TqIp6yIVxFpE=
=Vq1n
-----END PGP SIGNATURE-----

--AbwWMJJv1qlCtrU2PhqgRMbqBmFmrMMCb--
