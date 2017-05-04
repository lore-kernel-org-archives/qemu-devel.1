Received: from eggs.gnu.org ([2001:4830:134:3::10]:58107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d656k-0005xe-JS
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d656j-0000MY-J4
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:59:02 -0400
References: <20170503231120.23507-1-mreitz@redhat.com>
	<20170503231120.23507-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4e8a9cf8-9d01-3df3-2b0b-d1f3e04b3f04@redhat.com>
Date: Wed, 3 May 2017 19:58:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170503231120.23507-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nRxHn8rPdT5AHtpxKQjP5EFBELccd6tQD"
Subject: Re: [Qemu-devel] [PATCH 3/4] qcow2: Discard preallocated zero
 clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nRxHn8rPdT5AHtpxKQjP5EFBELccd6tQD
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <4e8a9cf8-9d01-3df3-2b0b-d1f3e04b3f04@redhat.com>
Subject: Re: [PATCH 3/4] qcow2: Discard preallocated zero clusters
References: <20170503231120.23507-1-mreitz@redhat.com>
 <20170503231120.23507-4-mreitz@redhat.com>
In-Reply-To: <20170503231120.23507-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/03/2017 06:11 PM, Max Reitz wrote:
> In discard_single_l2(), we completely discard normal clusters instead o=
f
> simply turning them into preallocated zero clusters. That means we
> should probably do the same with such preallocated zero clusters:
> Discard them instead of keeping them allocated.
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-cluster.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index fb91fd8979..31077d8102 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1511,7 +1511,8 @@ static int discard_single_l2(BlockDriverState *bs=
, uint64_t offset,
>                  break;
> =20
>              case QCOW2_CLUSTER_ZERO:
> -                if (!full_discard) {
> +                /* Preallocated zero clusters should be discarded in a=
ny case */
> +                if (!full_discard && (old_l2_entry & L2E_OFFSET_MASK) =
=3D=3D 0) {

Again, if we had a separate QCOW2_CLUSTER_* for plain vs. pre-allocated
zero, this might be easier to write.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nRxHn8rPdT5AHtpxKQjP5EFBELccd6tQD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCnzOAAoJEKeha0olJ0NqCFIH/0rNgo48Dq/hm2+FZuVWXKKH
thLHR03i6a+zPMQu/3EoPjxCEZledzVzaE+/PYZpx0Or2oT5w1bBnx9vP6CV4av1
CfUcVrLoR8MkD23i8af7yCd3y8WrN435pjD8Sw2VhqZ2R82IsxDnhgHA3CCezKR7
5x1y268toQzLg9mRzzIdThp7rAfU+zYjS48BGQNAnJyYIDhVtBMMCmvW2RZkIY5u
tfJMtprwOQ1i+lyxa5hJ9PjhnlMh9gZu1KbL9uBahR5qBYk4w1Cu8SPaV7KJiQTh
S47syy2nqAsUJ617krPBpqMd0SNQZzE4TH2CEd59s2pE8bjKOJTK3X3Q9aJdPU8=
=D6Dg
-----END PGP SIGNATURE-----

--nRxHn8rPdT5AHtpxKQjP5EFBELccd6tQD--
