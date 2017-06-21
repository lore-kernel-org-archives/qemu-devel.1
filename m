Received: from eggs.gnu.org ([2001:4830:134:3::10]:59587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNo7t-0004oV-L0
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNo7s-000860-NA
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:29:29 -0400
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
	<20170613121639.17853-3-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <364b26de-e7fa-1a90-ac33-2a444ca281eb@redhat.com>
Date: Thu, 22 Jun 2017 00:29:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170613121639.17853-3-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Bp70rI1VojAjBaoGcj5HgaCagac1VngTu"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qcow2: add qcow2_cache_discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bp70rI1VojAjBaoGcj5HgaCagac1VngTu
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <364b26de-e7fa-1a90-ac33-2a444ca281eb@redhat.com>
Subject: Re: [PATCH v2 2/4] qcow2: add qcow2_cache_discard
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
 <20170613121639.17853-3-pbutsykin@virtuozzo.com>
In-Reply-To: <20170613121639.17853-3-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-13 14:16, Pavel Butsykin wrote:
> Whenever l2/refcount table clusters are discarded from the file we can
> automatically drop unnecessary content of the cache tables. This reduce=
s
> the chance of eviction useful cache data and eliminates inconsistent da=
ta
> in thecache with the data in the file.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  block/qcow2-cache.c    | 21 +++++++++++++++++++++
>  block/qcow2-refcount.c |  5 +++++
>  block/qcow2.h          |  1 +
>  3 files changed, 27 insertions(+)
>=20
> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
> index 1d25147392..7931edf237 100644
> --- a/block/qcow2-cache.c
> +++ b/block/qcow2-cache.c
> @@ -411,3 +411,24 @@ void qcow2_cache_entry_mark_dirty(BlockDriverState=
 *bs, Qcow2Cache *c,
>      assert(c->entries[i].offset !=3D 0);
>      c->entries[i].dirty =3D true;
>  }
> +
> +void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, uint64_t=
 offset)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < c->size; i++) {
> +        if (c->entries[i].offset =3D=3D offset) {
> +            goto found; /* table offset */
> +        }
> +    }
> +    return;
> +
> +found:
> +    assert(c->entries[i].ref =3D=3D 0);
> +
> +    c->entries[i].offset =3D 0;
> +    c->entries[i].lru_counter =3D 0;
> +    c->entries[i].dirty =3D false;
> +
> +    qcow2_cache_table_release(bs, c, i, 1);
> +}
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 7c06061aae..576ab551d6 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -767,6 +767,11 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount=
(BlockDriverState *bs,
>          s->set_refcount(refcount_block, block_index, refcount);
> =20
>          if (refcount =3D=3D 0 && s->discard_passthrough[type]) {
> +            qcow2_cache_put(bs, s->refcount_block_cache, &refcount_blo=
ck);

I don't like this very much. It works, but it feels bad.

Would it be possible to store this refblock's offset somewhere and only
put it back if @offset is equal to that?

> +            qcow2_cache_discard(bs, s->refcount_block_cache, offset);
> +
> +            qcow2_cache_discard(bs, s->l2_table_cache, offset);
> +

So you're blindly calling qcow2_cache_discard() on @offset because
@offset may be pointing to a refblock or an L2 table? Right, that works,
but it still deserves a comment, I think (that we have no idea whether
@offset actually points to any of these refcount structures, but that we
also just don't have to care).

Looks OK to me, functionally, but I'd at least like to have that comment.=


Max

>              update_refcount_discard(bs, cluster_offset, s->cluster_siz=
e);
>          }
>      }
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 1801dc30dc..07faa6dc78 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -597,5 +597,6 @@ int qcow2_cache_get(BlockDriverState *bs, Qcow2Cach=
e *c, uint64_t offset,
>  int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_=
t offset,
>      void **table);
>  void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table=
);
> +void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, uint64_t=
 offset);
> =20
>  #endif
>=20



--Bp70rI1VojAjBaoGcj5HgaCagac1VngTu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZSvM/EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQMJX
CACOsUE+k0Q6Yt6iVyPhUUVqhNZ1D2MCfm8G/79wArdqECaWxN+xatdyQdsVmBtD
WyLtOq8Hv/DDVgcUsj1J6MRY+j6HrJjSrjrgtm4d+A+M1X3xCa9lLmYvvj6CyMM2
ECDKRez9vXqjMVSmd0aguO+1LEqYMbW4/yXCnOWRtNWo43ASIYCpUGJNeKaRG1nn
tRxeGoI7+4UjtkC9r+hRl4QSQpiRaz9HHY1XIMCY0XzOhlyixPOMzDTTm4zw8I+l
3djmHySdW6n8Tu2zKo3zJrXteoX4dGVmOBeUPNPXizXeNoVZ58WoZCJ59uOvw3FZ
pURoZwXV/r4b391yxdeejNRg
=Rl7D
-----END PGP SIGNATURE-----

--Bp70rI1VojAjBaoGcj5HgaCagac1VngTu--
