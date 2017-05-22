Received: from eggs.gnu.org ([2001:4830:134:3::10]:58685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCsZl-0004Wa-Is
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCsZi-00059z-Fz
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCsZi-00059W-66
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:01:02 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-2-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f628e214-2faa-0cf2-c5d2-39b0b6505fc2@redhat.com>
Date: Mon, 22 May 2017 14:00:53 -0500
MIME-Version: 1.0
In-Reply-To: <1495186480-114192-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HOKJmW2KSLFsAsOnIBUHI6e2u3NwTvf1V"
Subject: Re: [Qemu-devel] [PATCH v1 01/13] qcow2: alloc space for COW in one
 chunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "Denis V. Lunev" <den@openvz.org>, den@virtuozzo.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HOKJmW2KSLFsAsOnIBUHI6e2u3NwTvf1V
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "Denis V. Lunev" <den@openvz.org>, den@virtuozzo.com,
 mreitz@redhat.com
Message-ID: <f628e214-2faa-0cf2-c5d2-39b0b6505fc2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 01/13] qcow2: alloc space for COW in one
 chunk
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1495186480-114192-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 04:34 AM, Anton Nefedov wrote:
> From: "Denis V. Lunev" <den@openvz.org>
>=20
> Currently each single write operation can result in 3 write operations
> if guest offsets are not cluster aligned. One write is performed for th=
e
> real payload and two for COW-ed areas. Thus the data possibly lays
> non-contiguously on the host filesystem. This will reduce further
> sequential read performance significantly.
>=20
> The patch allocates the space in the file with cluster granularity,
> ensuring
>   1. better host offset locality
>   2. less space allocation operations
>      (which can be expensive on distributed storages)

s/storages/storage/

>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/qcow2.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>=20

> diff --git a/block/qcow2.c b/block/qcow2.c
> index a8d61f0..2e6a0ec 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1575,6 +1575,32 @@ fail:
>      return ret;
>  }
> =20
> +static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2met=
a)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    BlockDriverState *file =3D bs->file->bs;
> +    QCowL2Meta *m;
> +    int ret;
> +
> +    for (m =3D l2meta; m !=3D NULL; m =3D m->next) {
> +        uint64_t bytes =3D m->nb_clusters << s->cluster_bits;
> +
> +        if (m->cow_start.nb_bytes =3D=3D 0 && m->cow_end.nb_bytes =3D=3D=
 0) {
> +            continue;
> +        }
> +
> +        /* try to alloc host space in one chunk for better locality */=

> +        ret =3D file->drv->bdrv_co_pwrite_zeroes(file, m->alloc_offset=
, bytes, 0);

Are we guaranteed that this is a fast operation?  (That is, it either
results in a hole or an error, and doesn't waste time tediously writing
actual zeroes)

> +
> +        if (ret !=3D 0) {
> +            continue;
> +        }

Supposing we are using a file system that doesn't support holes, then
ret will not be zero, and we ended up not allocating anything after all.
 Is that a problem that we are just blindly continuing the loop as our
reaction to the error?

/reads further

I guess not - you aren't reacting to any error call, but merely using
the side effect that an allocation happened for speed when it worked,
and ignoring failure (you get the old behavior of the write() now
causing the allocation) when it didn't.

> +
> +        file->total_sectors =3D MAX(file->total_sectors,
> +                                  (m->alloc_offset + bytes) / BDRV_SEC=
TOR_SIZE);
> +    }
> +}
> +
>  static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_=
t offset,
>                                           uint64_t bytes, QEMUIOVector =
*qiov,
>                                           int flags)
> @@ -1656,8 +1682,12 @@ static coroutine_fn int qcow2_co_pwritev(BlockDr=
iverState *bs, uint64_t offset,
>          if (ret < 0) {
>              goto fail;
>          }
> -
>          qemu_co_mutex_unlock(&s->lock);
> +
> +        if (bs->file->bs->drv->bdrv_co_pwrite_zeroes !=3D NULL) {
> +            handle_alloc_space(bs, l2meta);
> +        }

Is it really a good idea to be modifying the underlying protocol image
outside of the mutex?

At any rate, it looks like your patch is doing a best-effort write
zeroes as an attempt to trigger consecutive allocation of the entire
cluster in the underlying protocol right after a cluster has been
allocated at the qcow2 format layer.  Which means there are more
syscalls now than there were previously, but now when we do three
write() calls at offsets B, A, C, those three calls are into file space
that was allocated earlier by the write zeroes, rather than fresh calls
into unallocated space that is likely to trigger up to three disjoint
allocations.

As a discussion point, wouldn't we achieve the same effect of less
fragmentation if we instead collect our data into a bounce buffer, and
only then do a single write() (or more likely, a writev() where the iov
is set up to reconstruct a single buffer on the syscall, but where the
source data is still at different offsets)?  We'd be avoiding the extra
syscalls of pre-allocating the cluster, and while our write() call is
still causing allocations, at least it is now one cluster-aligned
write() rather than three sub-cluster out-of-order write()s.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HOKJmW2KSLFsAsOnIBUHI6e2u3NwTvf1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIzVlAAoJEKeha0olJ0NquyUIAIjI8s0J94RBfo0jZaU5YCQr
OahPS8cwcziX5JMOolqvn6MQ7tpEv53wpW009xJBp6e8vRIoHWRuFcd40iILnyYQ
GwvfFh2KyqQDyfD1kA4skxGxeeuJQpB97TVXWUMwBglzVWnt5BiC5/QqY4lBTspd
eYoriEyXyLbHQEBjbYJTA1PrZxRt3I86PypSVoR5ysX6dZ5nt+NvBSkJ8/3Z7seh
gVVGEicetqDO3Lx3WUegAtHEwm+y+NAnAS0+hnqOw+wtJncDXTaBqmd+uTHagNNd
09vVYaWBiU2x+Tq5ppV9Jw00nBOCKnBmvBizobKOLFR0xRUEfvTTsTetZCksZ8c=
=J9+i
-----END PGP SIGNATURE-----

--HOKJmW2KSLFsAsOnIBUHI6e2u3NwTvf1V--
