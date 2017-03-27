Received: from eggs.gnu.org ([2001:4830:134:3::10]:41164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csWYI-0006dO-A3
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csWYH-0001Aq-8S
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:27:26 -0400
References: <20170327030518.37268-1-bjsdjshi@linux.vnet.ibm.com>
	<20170327030518.37268-2-bjsdjshi@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e81b598a-0746-5d18-5ed9-dd00f65cd77a@redhat.com>
Date: Mon, 27 Mar 2017 17:27:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170327030518.37268-2-bjsdjshi@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="njGbcGwEAbn9mOqXmC9xWVshaIql0fvNh"
Subject: Re: [Qemu-devel] [PATCH RFC v2 1/1] block: pass the right options
 for BlockDriver.bdrv_open
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
--njGbcGwEAbn9mOqXmC9xWVshaIql0fvNh
From: Max Reitz <mreitz@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 kwolf@redhat.com
Cc: qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com
Message-ID: <e81b598a-0746-5d18-5ed9-dd00f65cd77a@redhat.com>
Subject: Re: [PATCH RFC v2 1/1] block: pass the right options for
 BlockDriver.bdrv_open
References: <20170327030518.37268-1-bjsdjshi@linux.vnet.ibm.com>
 <20170327030518.37268-2-bjsdjshi@linux.vnet.ibm.com>
In-Reply-To: <20170327030518.37268-2-bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 27.03.2017 05:05, Dong Jia Shi wrote:
> raw_open() expects the caller always passing in the right actual
> @options parameter. But when trying to applying snapshot on a RBD
> image, bdrv_snapshot_goto() calls raw_open() (by calling the
> bdrv_open callback on the BlockDriver) with a NULL @options, and
> that will result in a Segmentation fault.
>=20
> For the other non-raw format drivers, it also make sense to passing
> in the actual options, althought they don't trigger the problem so
> far.
>=20
> Let's prepare a @options by adding the "file" key-value pair to a
> copy of the actual options that were given for the node (i.e.
> bs->options), and pass it to the callback.
>=20
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  block/snapshot.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/snapshot.c b/block/snapshot.c
> index bf5c2ca..dfec139 100644
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
> @@ -189,9 +190,14 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>      }
> =20
>      if (bs->file) {
> +        QDict *options =3D qdict_clone_shallow(bs->options);
> +        qdict_put(options, "file",
> +                  qstring_from_str(bdrv_get_node_name(bs->file->bs)));=


I don't think you're guaranteed that "file" is a a nested QDict (if it
has been specified as a nested dict). Then you'd have both options like
"file.driver" and "file" here which will break later on.

Compare:

$ ./qemu-img snapshot -a foo
"json:{'driver':'raw','file':{'driver':'qcow2','file':{'driver':'file','f=
ilename':'foo.qcow2'}}}"
qemu-img: Cannot reference an existing block device with additional
options or a new filename

$ ./qemu-img snapshot -a foo --image-opts
driver=3Draw,file.driver=3Dqcow2,file.file.driver=3Dfile,file.file.filena=
me=3Dfoo.qcow2
qemu-img: Cannot reference an existing block device with additional
options or a new filename

By the way, afterwards both commands segfault (and I had to add a manual
error_report_err() in this function to see the error message because
normally this just passes NULL for errp...). The segfault comes from...

> +
>          drv->bdrv_close(bs);
>          ret =3D bdrv_snapshot_goto(bs->file->bs, snapshot_id);
> -        open_ret =3D drv->bdrv_open(bs, NULL, bs->open_flags, NULL);
> +        open_ret =3D drv->bdrv_open(bs, options, bs->open_flags, NULL)=
;
> +        QDECREF(options);
>          if (open_ret < 0) {
>              bdrv_unref(bs->file->bs);

=2E..here. bs->file is NULL. This is because BlockDriver.bdrv_open()
expects bs->file to be NULL and just overwrites it with the result from
bdrv_open_child().

Now if that bdrv_open_child() fails, the field becomes NULL, the old
child is leaked and the above bdrv_unref() fails.

I get that this is never supposed to happen because bdrv_open_child()
should always succeed with the node name of the existing BDS given as a
reference... but we shouldn't rely on that, I guess.


All of this is a horrible mess. It kind of worked in the past when all
of this bdrv_open()/bdrv_close() stuff was a horrible mess but now it
stands out as exceptionally ugly (and obviously broken).


Of course, we can't fix all of this for 2.9, so what I'd propose for
this patch is:

(1) Remove every option in "options" that has a "file." prefix before
the qdict_put() call.

(2) Use bdrv_unref_child(bs->file) instead of bdrv_unref(bs->file->bs).

I guess it should work with those changes. At least I hope it will.

By the way, the easiest way to do (1) is probably:

QDict *file_options;

qdict_extract_subqdict(options, &file_options, "file.");
QDECREF(file_options);


Max

>              bs->drv =3D NULL;
>=20



--njGbcGwEAbn9mOqXmC9xWVshaIql0fvNh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZL1QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AMQ4IAKjHB0QMUrQh/3XE47L8a5PrmkfJ22nq
Hi7te9LzssmMGGMiVF1eAoMVy1wg2mdCRiCGCNLl2DmEyQSsi+dDnGtVh7E36Ab3
nT/EZniX6lsVdjJ/4VVz/uHUX8mdHHBucz6hq8XtLafz+jIkpEkG2cKblhxEAzt2
f/myCyDu3SS5t7vhgsvzd3VY06ub4vs0tc38FANYvDTbKMfWALVyFQyZfp1OomMB
7wrkALCms1iNNR46HxbWpivU+1RAKRTcUOOzUooa0vprp17hEJcCxZbPRCF7CFdG
PIvCNIP9BozdHsjw7/C6lQH5ScBI26rVSYe2V7L0nHoJo+NFlaefMlo=
=sNVy
-----END PGP SIGNATURE-----

--njGbcGwEAbn9mOqXmC9xWVshaIql0fvNh--
