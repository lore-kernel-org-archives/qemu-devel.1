Received: from eggs.gnu.org ([2001:4830:134:3::10]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egDGp-0006Zw-Dp
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egDGo-0002uq-ES
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:31:03 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-6-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3a7536f1-c4af-da6c-1282-ba336e96a86c@redhat.com>
Date: Mon, 29 Jan 2018 18:30:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DRAcufDQf4pkPoMegrqtSgzpurmuaPCeB"
Subject: Re: [Qemu-devel] [RFC PATCH 05/10] qcow2: Use BlockdevRef in
 qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DRAcufDQf4pkPoMegrqtSgzpurmuaPCeB
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <3a7536f1-c4af-da6c-1282-ba336e96a86c@redhat.com>
Subject: Re: [RFC PATCH 05/10] qcow2: Use BlockdevRef in qcow2_create2()
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-6-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-11 20:52, Kevin Wolf wrote:
> Instead of passing a separate BlockDriverState* into qcow2_create2(),
> make use of the BlockdevRef that is included in BlockdevCreateOptions.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h |  1 +
>  block.c               | 39 +++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c         | 33 +++++++++++++++++++++------------
>  3 files changed, 61 insertions(+), 12 deletions(-)

[...]

> diff --git a/block.c b/block.c
> index a8da4f2b25..c9b0e1d6d3 100644
> --- a/block.c
> +++ b/block.c

[...]

> @@ -2405,6 +2407,43 @@ BdrvChild *bdrv_open_child(const char *filename,=

>      return c;
>  }
> =20
> +/* TODO Future callers may need to specify parent/child_role in order =
for
> + * option inheritance to work. Existing callers use it for the root no=
de. */
> +BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **err=
p)
> +{
> +    BlockDriverState *bs =3D NULL;
> +    Error *local_err =3D NULL;
> +    QObject *obj =3D NULL;
> +    QDict *qdict =3D NULL;
> +    const char *reference =3D NULL;
> +    Visitor *v =3D NULL;
> +
> +    if (ref->type =3D=3D QTYPE_QSTRING) {
> +        reference =3D ref->u.reference;
> +    } else {
> +        BlockdevOptions *options =3D &ref->u.definition;
> +        assert(ref->type =3D=3D QTYPE_QDICT);
> +
> +        v =3D qobject_output_visitor_new(&obj);
> +        visit_type_BlockdevOptions(v, NULL, &options, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            goto fail;
> +        }
> +        visit_complete(v, &obj);
> +
> +        qdict =3D qobject_to_qdict(obj);
> +        qdict_flatten(qdict);
> +    }
> +
> +    bs =3D bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, er=
rp);
> +
> +fail:
> +    qobject_decref(obj);

I'd prefer QDECREF(qdict), myself, although I can't quite explain why.
Probably because @qdict is the object you're actually using and @obj is
just some temporary designation.

Also, doesn't bdrv_open_inherit() take ownership of @qdict and thus @obj?=


Max

> +    visit_free(v);
> +    return bs;
> +}
> +
>  static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *b=
s,
>                                                     int flags,
>                                                     QDict *snapshot_opt=
ions,


--DRAcufDQf4pkPoMegrqtSgzpurmuaPCeB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvWk0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AFzgH/1y3eDV2JrdY4HH1nvw2obSB5IZMIOid
8sDxJKYijQy0Jz2bdQ02gOMDK14C9t462hxoOyrPkb/NvcsyU6DZ3rpQMENJ4IIY
3Niz6BBPpX9YHjCbWi4c0rcXt3napD3JkS/wkC7n3nuWc6rEpffF2OTT3xzRUTT2
4jmx8g3ULBui+v8PCgYzVhJqLZWoMD8j7nU7m7NgUxiAFQtGooKEoW2EMyNbV+VB
CJKi70tTrRn8FBP+GM08qsg0qA+kjLgUm43wtw54aCuCoJRlku93dbsxiaA0KQX7
wkwyL12PhqxwuScAwRzFOFor4TUGEYFLOPBWaxVgXHGA79vjP+Ma6Mg=
=ogbR
-----END PGP SIGNATURE-----

--DRAcufDQf4pkPoMegrqtSgzpurmuaPCeB--
