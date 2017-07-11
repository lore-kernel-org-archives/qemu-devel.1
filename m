Received: from eggs.gnu.org ([2001:4830:134:3::10]:43195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUyrz-0000pT-CS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUyry-00026V-Br
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:22:43 -0400
References: <20170711124024.1396-1-pbutsykin@virtuozzo.com>
	<20170711124024.1396-4-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <003c6002-c8b2-a4be-c1ef-3225e170190f@redhat.com>
Date: Tue, 11 Jul 2017 19:22:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170711124024.1396-4-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RQs7fpJaKH9MpolvcQhIICnoE4an8tqf3"
Subject: Re: [Qemu-devel] [PATCH v4 3/4] qcow2: add shrink image support
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
--RQs7fpJaKH9MpolvcQhIICnoE4an8tqf3
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <003c6002-c8b2-a4be-c1ef-3225e170190f@redhat.com>
Subject: Re: [PATCH v4 3/4] qcow2: add shrink image support
References: <20170711124024.1396-1-pbutsykin@virtuozzo.com>
 <20170711124024.1396-4-pbutsykin@virtuozzo.com>
In-Reply-To: <20170711124024.1396-4-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-11 14:40, Pavel Butsykin wrote:
> This patch add shrinking of the image file for qcow2. As a result, this=
 allows
> us to reduce the virtual image size and free up space on the disk witho=
ut
> copying the image. Image can be fragmented and shrink is done by punchi=
ng holes
> in the image file.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-cluster.c  |  40 ++++++++++++++++++
>  block/qcow2-refcount.c | 110 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c          |  42 ++++++++++++++-----
>  block/qcow2.h          |  14 +++++++
>  qapi/block-core.json   |   3 +-
>  5 files changed, 198 insertions(+), 11 deletions(-)

[...]

> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 0141c9cbe7..e52d1698b5 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c

[...]

> +    for (i =3D 0; i < s->refcount_table_size; i++) {
> +        if (s->refcount_table[i] && !reftable_tmp[i]) {
> +            uint64_t discard_offs =3D s->refcount_table[i] & REFT_OFFS=
ET_MASK;
> +            uint64_t refblock_offs =3D get_refblock_offset(s, discard_=
offs);
> +            uint64_t cluster_index =3D discard_offs >> s->cluster_bits=
;
> +            uint32_t block_index =3D cluster_index & (s->refcount_bloc=
k_size - 1);
> +            void *refblock;
> +
> +            assert(discard_offs !=3D 0);
> +
> +            ret =3D qcow2_cache_get(bs, s->refcount_block_cache, refbl=
ock_offs,
> +                                  &refblock);
> +            if (ret < 0) {
> +                goto out;
> +            }
> +
> +            if (s->get_refcount(refblock, block_index) !=3D 1) {
> +                qcow2_signal_corruption(bs, true, -1, -1, "Invalid ref=
count:"
> +                                        " refblock offset %#" PRIx64
> +                                        ", reftable index %d"
> +                                        ", block offset %#" PRIx64
> +                                        ", refcount %#" PRIx64,
> +                                        refblock_offs, i, discard_offs=
,
> +                                        s->get_refcount(refblock, bloc=
k_index));

Nice, thanks!

Max


--RQs7fpJaKH9MpolvcQhIICnoE4an8tqf3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZZQlXEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQL4h
B/wPUxTLiqktsq4fowU0LV8Gc0ArN7pxUlDQFL6q8Jjnh5eF2xuR5RmiD6f3MPRT
r9eyLvdwCDvG3DiVjJOq1IfaypTUPnJqDdZJGxjNhlYdEi6NizCobXyuJkAwH2Jt
AwTklGmdH/w6wyvgmRdA8DmfJnCEmmze6jj4iK9vjPdYjeiCvBTIG9ZejkAfq15G
uiDWiTxUdgsKsudVw/dvxWRR4SWSijUX5GDs86ewBjCmD+BV0RWXtpCdfEDaDhE8
f5gaIsTQkDaiECGqUv+J8fntErJAjkdzY+rBLmX4gG4EjuvWPj44VuSYOT4zOvDJ
iIBk3M58eZ5GLsZFri0xuKgT
=Z7op
-----END PGP SIGNATURE-----

--RQs7fpJaKH9MpolvcQhIICnoE4an8tqf3--
