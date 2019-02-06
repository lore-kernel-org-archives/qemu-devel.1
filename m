Received: from eggs.gnu.org ([209.51.188.92]:51688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grUFv-0002dS-Fd
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grU2K-0003Wp-R2
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:43:14 -0500
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4db6ac46-6dfd-64fc-a5f0-4e3d2a5802ab@redhat.com>
Date: Wed, 6 Feb 2019 14:43:08 -0600
MIME-Version: 1.0
In-Reply-To: <20190206195551.28893-7-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dVatmKq42HOtbXFv2VC42HkZojwL4HkG3"
Subject: Re: [Qemu-devel] [PATCH v3 6/8] block: Try to create well typed
 json:{} filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dVatmKq42HOtbXFv2VC42HkZojwL4HkG3
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <4db6ac46-6dfd-64fc-a5f0-4e3d2a5802ab@redhat.com>
Subject: Re: [PATCH v3 6/8] block: Try to create well typed json:{} filenames
References: <20190206195551.28893-1-mreitz@redhat.com>
 <20190206195551.28893-7-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 1:55 PM, Max Reitz wrote:

In the subject, s/well typed/well-typed/

> By applying a health mix of qdict_flatten(), qdict_crumple(),

s/health/healty/

> qdict_stringify_for_keyval(), the keyval input visitor, and the QObject=

> output visitor (not necessarily in that order), we can at least try to
> bring bs->full_open_options into accordance with the QAPI schema.  This=

> may not always work (there are some options left that have not been
> QAPI-fied yet), but in practice it usually will.
>=20
> In any case, sometimes emitting wrongly typed json:{} filenames is
> better than doing it effectively half the time.

And someday, if we ever switch the block layer to use QAPI types all the
way, we can drop some of these hacks that have built up over time. But
not a show-stopper for this series.

>=20
> This affects some iotests because json:{} filenames are now usually
> crumpled.  In 198, "format": "auto" now appears in the qcow2 encryption=

> options because going through a visitor makes optional discriminators'
> default values explicit.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534396
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c                    | 68 +++++++++++++++++++++++++++++++++++++-=

>  tests/qemu-iotests/059.out |  2 +-
>  tests/qemu-iotests/099.out |  4 +--
>  tests/qemu-iotests/110.out |  2 +-
>  tests/qemu-iotests/198.out |  4 +--
>  tests/qemu-iotests/207.out | 10 +++---
>  6 files changed, 78 insertions(+), 12 deletions(-)
>=20

> +/**
> + * Take a blockdev @options QDict and convert its values to the
> + * correct type.
> + *
> + * Fail if @options does not match the QAPI schema of BlockdevOptions.=

> + *
> + * In case of failure, return NULL and set @errp.
> + *
> + * In case of success, return a correctly typed new QDict.
> + */
> +static QDict *bdrv_type_blockdev_opts(const QDict *options, Error **er=
rp)
> +{
> +    Visitor *v;
> +    BlockdevOptions *blockdev_options;
> +    QObject *typed_opts;
> +    QDict *string_options;
> +    Error *local_err =3D NULL;
> +
> +    string_options =3D qdict_clone_shallow(options);
> +
> +    qdict_flatten(string_options);
> +    v =3D qobject_input_visitor_new_flat_confused(string_options, errp=
);
> +    if (!v) {
> +        error_prepend(errp, "Failed to prepare options: ");
> +        return NULL;
> +    }
> +
> +    visit_type_BlockdevOptions(v, NULL, &blockdev_options, &local_err)=
;
> +    visit_free(v);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "Not a valid BlockdevOptions object: ");
> +        return NULL;
> +    }
> +
> +    v =3D qobject_output_visitor_new(&typed_opts);
> +    visit_type_BlockdevOptions(v, NULL, &blockdev_options, &local_err)=
;
> +    if (!local_err) {
> +        visit_complete(v, &typed_opts);
> +    }
> +    visit_free(v);
> +    qapi_free_BlockdevOptions(blockdev_options);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    return qobject_to(QDict, typed_opts);
> +}
> +
>  /* Updates the following BDS fields:
>   *  - exact_filename: A filename which may be used for opening a block=
 device
>   *                    which (mostly) equals the given BDS (even withou=
t any
> @@ -5698,10 +5749,25 @@ void bdrv_refresh_filename(BlockDriverState *bs=
)
>      if (bs->exact_filename[0]) {
>          pstrcpy(bs->filename, sizeof(bs->filename), bs->exact_filename=
);
>      } else {
> -        QString *json =3D qobject_to_json(QOBJECT(bs->full_open_option=
s));
> +        QString *json;
> +        QDict *typed_opts, *json_opts;
> +
> +        typed_opts =3D bdrv_type_blockdev_opts(bs->full_open_options, =
NULL);
> +
> +        /*
> +         * We cannot be certain that bs->full_open_options matches
> +         * BlockdevOptions, so bdrv_type_blockdev_opts() may fail.
> +         * That is not fatal, we can just emit bs->full_open_options
> +         * directly -- qemu will accept that, even if it does not
> +         * match the schema.
> +         */
> +        json_opts =3D typed_opts ?: bs->full_open_options;
> +
> +        json =3D qobject_to_json(QOBJECT(json_opts));
>          snprintf(bs->filename, sizeof(bs->filename), "json:%s",
>                   qstring_get_str(json));

I so need to revive my series that created a JSON output visitor (to
skip the qobject_to_json() intermediate step). But that's a topic for
another day.

> +++ b/tests/qemu-iotests/059.out
> @@ -2050,7 +2050,7 @@ wrote 512/512 bytes at offset 10240
> =20
>  =3D=3D=3D Testing monolithicFlat with internally generated JSON file n=
ame =3D=3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 subformat=
=3DmonolithicFlat
> -can't open: Cannot use relative extent paths with VMDK descriptor file=
 'json:{"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "dr=
iver": "blkdebug", "inject-error.0.event": "read_aio"}'
> +can't open: Cannot use relative extent paths with VMDK descriptor file=
 'json:{"inject-error": [{"event": "read_aio"}], "image": {"driver": "fil=
e", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug"}'

"inject-error" sorts after "image"; meanwhile, the QAPI definition of
BlockdevOptionsBlkdebug sorts image before inject-error. It looks like
this output is randomized; can that bite us (as we've recently found
with other iotests where python 2 vs. 3 sorting mattered)?  And can we
do better?  (My QAPI JSON output visitor would guarantee the output in
QAPI definition order)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--dVatmKq42HOtbXFv2VC42HkZojwL4HkG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbRtwACgkQp6FrSiUn
Q2oVpQgAnb+ibPX7OQ6kLgDrKHSgT22f4R1CA2tq8aZsyBdaue52O+bGQONgy8R4
kCK90DhARBPVKiF1aUBMULoK34qie0/QNUbBwfQ6lSxY+ELtzZhQRZ5l2h4XneUv
6oj6NTtsZtffsB24aDAsAgYpxTqkXc0AKFgcpyj4s/FzHBoEaEFgrLWeDheoXysr
qDFaDVBhR/eDUaLNieeTuqwHSeMRJZURjPFHQjfedKzssiXLD5uU3f93nUzIP96Q
XMY0+LKxfpKj/eGOE8rRM+duhshGwz9s5EAJepq/B14+pEc7OzaOKW2At07fUnHP
CBVNOXAjZcJoAdyCtQD1mZfwvI38PQ==
=6alK
-----END PGP SIGNATURE-----

--dVatmKq42HOtbXFv2VC42HkZojwL4HkG3--
