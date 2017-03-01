Received: from eggs.gnu.org ([2001:4830:134:3::10]:55669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjDRo-0006ic-4X
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 18:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjDRm-0006EA-Ma
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 18:14:16 -0500
References: <20170228193340.63980-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8a6dc229-b526-1a89-9874-30b4c4002e45@redhat.com>
Date: Wed, 1 Mar 2017 17:14:05 -0600
MIME-Version: 1.0
In-Reply-To: <20170228193340.63980-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4XcSfeL5DSj6UeGRD3lx3qlIF9SDaIhSJ"
Subject: Re: [Qemu-devel] [PATCH v4] backup: allow target without
 .bdrv_get_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4XcSfeL5DSj6UeGRD3lx3qlIF9SDaIhSJ
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a6dc229-b526-1a89-9874-30b4c4002e45@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] backup: allow target without
 .bdrv_get_info
References: <20170228193340.63980-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170228193340.63980-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 01:33 PM, Vladimir Sementsov-Ogievskiy wrote:
> Currently backup to nbd target is broken, as nbd doesn't have
> .bdrv_get_info realization.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> v4: use error_report()
>     add article
>=20
> v3: fix compilation (I feel like an idiot)
>     adjust wording (Fam)
>    =20
> v2: add WARNING
>=20
> =3D=3D=3D
>=20
> Since commit
>=20
> commit 4c9bca7e39a6e07ad02c1dcde3478363344ec60b
> Author: John Snow <jsnow@redhat.com>
> Date:   Thu Feb 25 15:58:30 2016 -0500
>=20
>     block/backup: avoid copying less than full target clusters
>=20
> backup to nbd target is broken, we have "Couldn't determine the cluster=
 size of
> the target image".
>=20
> Proposed NBD protocol extension - NBD_OPT_INFO should finally solve thi=
s problem.
> But until it is not realized, we need allow backup to nbd target due to=
 backward
> compatibility.

Looks like my patches for NBD_OPT_INFO did not get included in a pull
request for 2.9, and therefore missed soft freeze.
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04528.html

In particular, there was confusion on whether the NBD protocol should be
advertising the preferred block size for I/O (as in struct
stat.st_blksize) vs. the optimum size (SCSI documents this as an
optional parameter, but if set, then transactions larger than the
optimal may take longer than ordinary). I'm also not sure where qcow2's
cluster size should fit into this (it behaves more like a block size, in
that anything smaller requires a read-modify-write, and therefore feels
more like what NBD has currently documented as the preferred size).
qemu's BlockLimits structure may need to track both numbers separately
(right now, it appears to only be tracking the SCSI sense, although that
is not documented well), and the NBD protocol extension proposal may
need a tweak to expose more than just min/preferred/max values.

Even though my NBD patches will miss 2.9, I think yours qualifies as a
bug fix and can therefore be included under the soft freeze rules.

>=20
> Furthermore, is it entirely ok to disallow backup if bds lacks .bdrv_ge=
t_info?
> Which behavior should be default: to fail backup or to use default clus=
ter size?

Avoiding the risk of corrupted data is important.

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
>  block/backup.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index ea38733849..ea160e9e82 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -24,6 +24,7 @@
>  #include "qemu/cutils.h"
>  #include "sysemu/block-backend.h"
>  #include "qemu/bitmap.h"
> +#include "qemu/error-report.h"
> =20
>  #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
>  #define SLICE_TIME 100000000ULL /* ns */
> @@ -638,7 +639,16 @@ BlockJob *backup_job_create(const char *job_id, Bl=
ockDriverState *bs,
>       * backup cluster size is smaller than the target cluster size. Ev=
en for
>       * targets with a backing file, try to avoid COW if possible. */
>      ret =3D bdrv_get_info(target, &bdi);
> -    if (ret < 0 && !target->backing) {
> +    if (ret =3D=3D -ENOTSUP) {
> +        /* Cluster size is not defined */
> +        error_report("WARNING: The target block device doesn't provide=
 "
> +                     "information about the block size and it doesn't =
have a "
> +                     "backing file. The default block size of %u bytes=
 is "
> +                     "used. If the actual block size of the target exc=
eeds "
> +                     "this default, the backup may be unusable",
> +                     BACKUP_CLUSTER_SIZE_DEFAULT);
> +        job->cluster_size =3D BACKUP_CLUSTER_SIZE_DEFAULT;
> +    } else if (ret < 0 && !target->backing) {
>          error_setg_errno(errp, -ret,
>              "Couldn't determine the cluster size of the target image, =
"
>              "which has no backing file");
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--4XcSfeL5DSj6UeGRD3lx3qlIF9SDaIhSJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYt1W9AAoJEKeha0olJ0Nq5SwIAJ2XmN20jTHa/0eH6w0gnOQy
r1aboEg2490fDMpdp9iO+Y+q9cB6clbxT6g+2WcBjItYRNQUzmLf3IzWz3xVPhqA
Djju/M7l4dwr0i+yh2m5iqWcZpNUINLuvYn29SIjcXT2xSJwEZERWTNoCRLd9Ktf
vGutNU/0U1ivBdoWmXIUw7cL1yKofsq0fQRhFj6wYntX7cKIjXUGpF+BYb5ttMLI
JnvS6V9qZU7EL2hKmpeQaY1h9KPKaGhGjkOKonXCoLw+7v2BNtYNxnL1b4CzV5HP
RoC197Cx+L231tinU5GLnU7hyLXfdykPdAfpyvdvDqvNI5E7o86veJgrA84gVLM=
=L61M
-----END PGP SIGNATURE-----

--4XcSfeL5DSj6UeGRD3lx3qlIF9SDaIhSJ--
