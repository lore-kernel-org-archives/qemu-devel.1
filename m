Received: from eggs.gnu.org ([2001:4830:134:3::10]:42473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHszM-0004oz-IQ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHszJ-0006dE-0R
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHszI-0006bF-Mh
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:28:08 -0400
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496330073-51338-5-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73fcc353-6e95-f28d-9f61-be3c4674b122@redhat.com>
Date: Mon, 5 Jun 2017 09:28:01 -0500
MIME-Version: 1.0
In-Reply-To: <1496330073-51338-5-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D2HUWBUwq7JIlC00O8xqsGTbP1gTMDEtS"
Subject: Re: [Qemu-devel] [PATCH v2 04/15] qcow2: alloc space for COW in one
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
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, "Denis V. Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D2HUWBUwq7JIlC00O8xqsGTbP1gTMDEtS
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com,
 "Denis V. Lunev" <den@openvz.org>
Message-ID: <73fcc353-6e95-f28d-9f61-be3c4674b122@redhat.com>
Subject: Re: [PATCH v2 04/15] qcow2: alloc space for COW in one chunk
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1496330073-51338-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496330073-51338-5-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 10:14 AM, Anton Nefedov wrote:
> From: "Denis V. Lunev" <den@openvz.org>
>=20
> Currently each single write operation can result in 3 write operations

Maybe:

Currently each single guest write operation can result in up to 3 host
write operations

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
>      (which can be expensive on distributed storage)
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/qcow2.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index b3ba5da..cd5efba 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1575,6 +1575,24 @@ fail:
>      return ret;
>  }
> =20
> +static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2met=
a)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    QCowL2Meta *m;
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

> +        bdrv_co_pwrite_zeroes(bs->file, m->alloc_offset, bytes,
> +                              BDRV_REQ_ALLOCATE);

Is it worth a trace point, to easily track when we are using
handle_alloc_space()?  Or do existing trace points in
bdrv_co_pwrite_zeroes already sufficiently serve the purpose?

> +    }
> +}
> +
>  static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_=
t offset,
>                                           uint64_t bytes, QEMUIOVector =
*qiov,
>                                           int flags)
> @@ -1656,8 +1674,12 @@ static coroutine_fn int qcow2_co_pwritev(BlockDr=
iverState *bs, uint64_t offset,
>          if (ret < 0) {
>              goto fail;
>          }
> -
>          qemu_co_mutex_unlock(&s->lock);
> +
> +        if (bs->file->bs->supported_zero_flags & BDRV_REQ_ALLOCATE) {
> +            handle_alloc_space(bs, l2meta);
> +        }
> +

This certainly looks better than v1!

>          BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
>          trace_qcow2_writev_data(qemu_coroutine_self(),
>                                  cluster_offset + offset_in_cluster);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--D2HUWBUwq7JIlC00O8xqsGTbP1gTMDEtS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNWpxAAoJEKeha0olJ0NqB3gH/2YMen7i7B+aCbaV4Qz1FQXi
lF5aKh1q+xpldR9ridkYksITGnQrwSfKG0R04PJuD2MFzUg7aVVSiuZa0NeLbrdz
6/4HWYVDKSFPcXF1q33Ko7U3qnmDdAw8UyJimreZayp2tFO63HLtS4H+mY9F0gfs
q1ed4LrokBQCUI5ksRjRSpBNyCUEovnc1Pyi4QHRDGX+P01/iOD5vRwEqcZXqIEA
U8ud7v449Mbn2gDxpN2rRu5ptCX7QKl8a8XQlPQmBTaqkPHvD0N0rql0y6FnoCo1
NYAMIZ/R5WhOw5ApUHAFSLV/ZwjeQ4FWI3QX8xiAclOpRTsIcCoyjziTQddpQH8=
=q/2j
-----END PGP SIGNATURE-----

--D2HUWBUwq7JIlC00O8xqsGTbP1gTMDEtS--
