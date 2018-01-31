Received: from eggs.gnu.org ([2001:4830:134:3::10]:52541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyMl-0006Mi-Cm
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyMk-0002Oj-6l
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:48:19 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<e2cb85926f1f4910c7d18fcc902be60109592381.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4361f774-7d2e-1a67-bde9-da421df554f9@redhat.com>
Date: Wed, 31 Jan 2018 20:48:08 +0100
MIME-Version: 1.0
In-Reply-To: <e2cb85926f1f4910c7d18fcc902be60109592381.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Kx3sk7J42btAMgiOmLmJi5HSOB646LE19"
Subject: Re: [Qemu-devel] [PATCH v3 13/39] qcow2: Add l2_slice_size field to
 BDRVQcow2State
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kx3sk7J42btAMgiOmLmJi5HSOB646LE19
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <4361f774-7d2e-1a67-bde9-da421df554f9@redhat.com>
Subject: Re: [PATCH v3 13/39] qcow2: Add l2_slice_size field to BDRVQcow2State
References: <cover.1516978645.git.berto@igalia.com>
 <e2cb85926f1f4910c7d18fcc902be60109592381.1516978645.git.berto@igalia.com>
In-Reply-To: <e2cb85926f1f4910c7d18fcc902be60109592381.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> The BDRVQcow2State structure contains an l2_size field, which stores
> the number of 64-bit entries in an L2 table.
>=20
> For efficiency reasons we want to be able to load slices instead of
> full L2 tables, so we need to know how many entries an L2 slice can
> hold.
>=20
> An L2 slice is the portion of an L2 table that is loaded by the qcow2
> cache. At the moment that cache can only load complete tables,
> therefore an L2 slice has the same size as an L2 table (one cluster)
> and l2_size =3D=3D l2_slice_size.
>=20
> Later we'll allow smaller slices, but until then we have to use this
> new l2_slice_size field to make the rest of the code ready for that.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.c | 3 +++
>  block/qcow2.h | 1 +
>  2 files changed, 4 insertions(+)

Am I missing something or does this patch miss setting l2_slice_size in
qcow2_do_open()?

Max

> diff --git a/block/qcow2.c b/block/qcow2.c
> index e2d4bf7ad5..78f067cae7 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -805,6 +805,7 @@ static void read_cache_sizes(BlockDriverState *bs, =
QemuOpts *opts,
>  typedef struct Qcow2ReopenState {
>      Qcow2Cache *l2_table_cache;
>      Qcow2Cache *refcount_block_cache;
> +    int l2_slice_size; /* Number of entries in a slice of the L2 table=
 */
>      bool use_lazy_refcounts;
>      int overlap_check;
>      bool discard_passthrough[QCOW2_DISCARD_MAX];
> @@ -886,6 +887,7 @@ static int qcow2_update_options_prepare(BlockDriver=
State *bs,
>          }
>      }
> =20
> +    r->l2_slice_size =3D s->cluster_size / sizeof(uint64_t);
>      r->l2_table_cache =3D qcow2_cache_create(bs, l2_cache_size);
>      r->refcount_block_cache =3D qcow2_cache_create(bs, refcount_cache_=
size);
>      if (r->l2_table_cache =3D=3D NULL || r->refcount_block_cache =3D=3D=
 NULL) {
> @@ -1049,6 +1051,7 @@ static void qcow2_update_options_commit(BlockDriv=
erState *bs,
>      }
>      s->l2_table_cache =3D r->l2_table_cache;
>      s->refcount_block_cache =3D r->refcount_block_cache;
> +    s->l2_slice_size =3D r->l2_slice_size;
> =20
>      s->overlap_check =3D r->overlap_check;
>      s->use_lazy_refcounts =3D r->use_lazy_refcounts;
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 0559afbc63..e0aee88811 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -251,6 +251,7 @@ typedef struct BDRVQcow2State {
>      int cluster_bits;
>      int cluster_size;
>      int cluster_sectors;
> +    int l2_slice_size;
>      int l2_bits;
>      int l2_size;
>      int l1_size;
>=20



--Kx3sk7J42btAMgiOmLmJi5HSOB646LE19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyHXgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A0uUIALfidpHeGHFzIyazbyVkqR6xxSygaWRF
qVIfbTsxis9Lwq1iaeeci8iGW22POL1Sq4vjs+pCaJanlDY0OvNB/44Ye9DMlVEl
s1y+CLD574p3OpM6QMkR4vX/E1RUcZlDcJivhMOhn9ux0FVIk8oVJ7OED7qgmdjv
AHaW0VAj3J3AXpTq3Mzk/i3P5o4JMNgVweza32bJ9DlN1a22Cebts/phsvzkDrRx
L9sZFeFsWs27ekhrTAGMmFBvQugaTl4z5socgXv4TalwyJkyLpRI4T3dGHs4I1nq
xQ53A9lrciD2RZK0+qlDZtqTpkyGe4TGuoFQltK20d6Ew32pu3cgTXs=
=ap4D
-----END PGP SIGNATURE-----

--Kx3sk7J42btAMgiOmLmJi5HSOB646LE19--
