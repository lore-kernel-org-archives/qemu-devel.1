Received: from eggs.gnu.org ([2001:4830:134:3::10]:41602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctKoW-00078W-BP
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 17:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctKoV-00013I-0m
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 17:07:32 -0400
References: <20170329011637.89377-1-bjsdjshi@linux.vnet.ibm.com>
	<20170329011637.89377-2-bjsdjshi@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e445fb5a-7076-a557-d0c0-94dbf60b289a@redhat.com>
Date: Wed, 29 Mar 2017 23:07:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170329011637.89377-2-bjsdjshi@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dxTFtoVAe5WeMDg9E3AK6P5ljUE9qHMnq"
Subject: Re: [Qemu-devel] [PATCH v3 1/1] block: pass the right options for
 BlockDriver.bdrv_open()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-block@nongnu.org, kwolf@redhat.com
Cc: qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dxTFtoVAe5WeMDg9E3AK6P5ljUE9qHMnq
From: Max Reitz <mreitz@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 kwolf@redhat.com
Cc: qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com
Message-ID: <e445fb5a-7076-a557-d0c0-94dbf60b289a@redhat.com>
Subject: Re: [PATCH v3 1/1] block: pass the right options for
 BlockDriver.bdrv_open()
References: <20170329011637.89377-1-bjsdjshi@linux.vnet.ibm.com>
 <20170329011637.89377-2-bjsdjshi@linux.vnet.ibm.com>
In-Reply-To: <20170329011637.89377-2-bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 29.03.2017 03:16, Dong Jia Shi wrote:
> raw_open() expects the caller always passing in the right actual
> @options parameter. But when trying to applying snapshot on a RBD
> image, bdrv_snapshot_goto() calls raw_open() (by calling the
> bdrv_open callback on the BlockDriver) with a NULL @options, and
> that will result in a Segmentation fault.
>=20
> For the other non-raw format drivers, it also makes sense to passing
> in the actual options, althought they don't trigger the problem so
> far.
>=20
> Let's prepare a @options by adding the "file" key-value pair to a
> copy of the actual options that were given for the node (i.e.
> bs->options), and pass it to the callback.
>=20
> BlockDriver.bdrv_open() expects bs->file to be NULL and just
> overwrites it with the result from bdrv_open_child(). If that
> bdrv_open_child() fails, the field becomes NULL. While we are at
> it, we also correct the cleanning up action for a call failure of
> BlockDriver.bdrv_open() by replacing bdrv_unref() with
> bdrv_unref_child().
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  block/snapshot.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/snapshot.c b/block/snapshot.c
> index bf5c2ca..281626c 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -27,6 +27,7 @@
>  #include "block/block_int.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qerror.h"
> +#include "qapi/qmp/qstring.h"
> =20
>  QemuOptsList internal_snapshot_opts =3D {
>      .name =3D "snapshot",
> @@ -189,11 +190,20 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>      }
> =20
>      if (bs->file) {
> +        QDict *options =3D qdict_clone_shallow(bs->options);
> +        QDict *file_options;
> +
> +        qdict_extract_subqdict(options, &file_options, "file.");
> +        QDECREF(file_options);
> +        qdict_put(options, "file",
> +                  qstring_from_str(bdrv_get_node_name(bs->file->bs)));=

> +
>          drv->bdrv_close(bs);
>          ret =3D bdrv_snapshot_goto(bs->file->bs, snapshot_id);
> -        open_ret =3D drv->bdrv_open(bs, NULL, bs->open_flags, NULL);
> +        open_ret =3D drv->bdrv_open(bs, options, bs->open_flags, NULL)=
;
> +        QDECREF(options);
>          if (open_ret < 0) {
> -            bdrv_unref(bs->file->bs);
> +            bdrv_unref_child(bs, bs->file);
>              bs->drv =3D NULL;
>              return open_ret;
>          }

I just noticed another issue (sorry I did not before...):

In drv->bdrv_open(), the block driver will generally overwrite bs->file
without looking at it because it assumes that it's NULL. That means we
should probably actually make sure it's NULL because otherwise we will
the child BDS will have a reference count that is 1 too high.

(bdrv_open_inherit() (ultimately called from bdrv_open_child()) invokes
bdrv_ref() for a child BDS specified by node-name reference.)

That means we should unconditionally invoke
bdrv_unref_child(bs, bs->file) before calling drv->bdrv_open(). But we
have to wrap everything in bdrv_ref()/bdrv_unref() so the BDS isn't
deleted in the meantime.

So I think it should look something like this:

BlockDriverState *file;
QDict *options =3D ...;
QDict *file_options;

file =3D bs->file->bs;
/* Prevent it from getting deleted when detached from bs */
bdrv_ref(file);

qdict_extract_subqdict(...);
QDECREF(file_options);
qdict_put(..., qstring_from_str(bdrv_get_node_name(file)));

drv->bdrv_close(bs);
bdrv_unref_child(bs, bs->file);
bs->file =3D NULL;

ret =3D bdrv_snapshot_goto(file, snapshot_id);
open_ret =3D drv->bdrv_open(...);
if (open_ret < 0) {
    bdrv_unref(file);
    bs->drv =3D NULL;
    return open_ret;
}

assert(bs->file->bs =3D=3D file);
bdrv_unref(file);


Max


--dxTFtoVAe5WeMDg9E3AK6P5ljUE9qHMnq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljcIgoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AFG0H/RsxXd1zZtN4qAfqiB6LJFojHPiUqCch
Mqkjx38SmO+3/ZaLsB2ZuXYkv+SKbqAX0+KR0G+hgnbp94SZBdbVcV5+u9AwObz9
OrZ0qNmvRwbeYjUn3uPNqy4JVdG9fATEjPGC9p/VtBfU5bdSeMpGaCy9hkeo2sX2
8oh/ebjhNyNdb8DY6Dx6/2b3EuBUV8jOoN5+gnU5F5J/CCbwIn8dPhHMQJg8NEpz
pSqVHr//CbkqeRYhE2pB0pa+etcGfnCjW5tRwqzq9b05TRjUrAusB6j+ZPmNtrrI
7pFZbWO+zUCSzd4cZp8fwcuiVEPILhwmdz/CADhQVW4e3jsU5LeUafM=
=mTh2
-----END PGP SIGNATURE-----

--dxTFtoVAe5WeMDg9E3AK6P5ljUE9qHMnq--
