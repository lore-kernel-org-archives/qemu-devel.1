Received: from eggs.gnu.org ([2001:4830:134:3::10]:33261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYYWh-0001Ad-P9
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYYWg-0003eS-NY
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:31:15 -0500
Date: Tue, 31 Jan 2017 13:31:06 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131133106.GH18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-7-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-7-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 06/21] backup: rewrite top mode cluster
 skipping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:49PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> @@ -374,6 +379,101 @@ static bool coroutine_fn yield_and_check(BackupBloc=
kJob *job)
>      return false;
>  }
> =20
> +static void backup_skip_clusters(BackupBlockJob *job,
> +                                 int64_t start, int64_t end)

Missing coroutine_fn to document that this function must be called from
coroutine context.

> +{
> +    CowRequest cow_request;
> +
> +    wait_for_overlapping_requests(job, start, end);
> +    cow_request_begin(&cow_request, job, start, end);
> +
> +    if (end * job->cluster_size > job->common.len) {
> +        int64_t n;
> +        end--;
> +        n =3D job->common.len - end * job->cluster_size;
> +        assert(n > 0);
> +
> +        if (hbitmap_get(job->copy_bitmap, end)) {
> +            hbitmap_reset(job->copy_bitmap, end, 1);
> +            job->common.offset +=3D n;
> +        }
> +    }
> +
> +    for ( ; start < end; start++) {
> +        if (!hbitmap_get(job->copy_bitmap, start)) {
> +            continue;
> +        }
> +
> +        hbitmap_reset(job->copy_bitmap, start, 1);
> +        job->common.offset +=3D job->cluster_size;
> +    }
> +
> +    cow_request_end(&cow_request);
> +}
> +
> +static int backup_skip_unallocated_clusters(BackupBlockJob *job,
> +                                            BlockDriverState *base,
> +                                            int64_t start, int *n)

Missing coroutine_fn.

> +{
> +    int ret;
> +    int64_t sectors_per_cluster =3D cluster_size_sectors(job);
> +    BlockDriverState *bs =3D blk_bs(job->common.blk);
> +    int64_t sector_end =3D job->common.len >> BDRV_SECTOR_BITS;
> +    int64_t sector =3D start * sectors_per_cluster;
> +    int max_sectors =3D MIN(max_query_sectors(job), sector_end - sector);
> +    int n_sectors =3D 0;
> +
> +    ret =3D bdrv_is_allocated_above(bs, base, sector, max_sectors, &n_se=
ctors);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (sector + n_sectors =3D=3D sector_end || ret =3D=3D 1) {
> +        *n =3D DIV_ROUND_UP(n_sectors, sectors_per_cluster);
> +    } else if (n_sectors < sectors_per_cluster) {
> +        *n =3D 1;
> +        ret =3D 1;
> +    } else {
> +        *n =3D n_sectors / sectors_per_cluster;
> +    }
> +
> +    if (ret =3D=3D 0) {
> +        backup_skip_clusters(job, start, start + *n);
> +    }
> +
> +    return 0;
> +}
> +
> +static void backup_skip_loop(BackupBlockJob *job, BlockDriverState *base)

Missing coroutine_fn.

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkJGaAAoJEJykq7OBq3PIOXQH/iX5UrYU91yL8+m87OxH3xcJ
b7ZmkyXEJbB1eEdd/mEMBHkGLftqqWChsL5OQIumeK22ZhF8TkmhVB4lz6kARp5f
XN1H3YC1RElhCgcYPIqv8dCQBQZU3BNMqGyQfRysl2iw5jjxAO5hhqz+vJP/B+bD
YuF6VrSA0ScOSbyYRC0FAZcyuKlRL2L6vHnRYDboX/36TWuwNDFLZMX6etgoW9ng
EDpytQ6CA6z3sacTLpW2+sl065VCCQx/Ml+ciQqCIN3K+bNCEdyV+3QWJ06ZuREK
l1pgXX6tv9oAP0WE4GSEk5IGIIKwbXXGdr51UmWS/N9HT2QOEG21X4Aa2uEGusw=
=K9Jr
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
