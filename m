Received: from eggs.gnu.org ([209.51.188.92]:44576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsCuJ-0007Ko-TJ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsCuI-0002jS-IH
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:37:55 -0500
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-7-mreitz@redhat.com>
	<4db6ac46-6dfd-64fc-a5f0-4e3d2a5802ab@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <01b69ba7-4172-773c-caf1-1a219b8967d4@redhat.com>
Date: Fri, 8 Feb 2019 19:11:11 +0100
MIME-Version: 1.0
In-Reply-To: <4db6ac46-6dfd-64fc-a5f0-4e3d2a5802ab@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ymjoxskSFPS4fX93ChtWNdOi9maKrJAr5"
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
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ymjoxskSFPS4fX93ChtWNdOi9maKrJAr5
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <01b69ba7-4172-773c-caf1-1a219b8967d4@redhat.com>
Subject: Re: [PATCH v3 6/8] block: Try to create well typed json:{} filenames
References: <20190206195551.28893-1-mreitz@redhat.com>
 <20190206195551.28893-7-mreitz@redhat.com>
 <4db6ac46-6dfd-64fc-a5f0-4e3d2a5802ab@redhat.com>
In-Reply-To: <4db6ac46-6dfd-64fc-a5f0-4e3d2a5802ab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.02.19 21:43, Eric Blake wrote:
> On 2/6/19 1:55 PM, Max Reitz wrote:
>=20
> In the subject, s/well typed/well-typed/
>=20
>> By applying a health mix of qdict_flatten(), qdict_crumple(),
>=20
> s/health/healty/
>=20
>> qdict_stringify_for_keyval(), the keyval input visitor, and the QObjec=
t
>> output visitor (not necessarily in that order),

More importantly, this is just wrong (or rather, outdated).  I fixed it
in the cover letter but forgot to fix it here.  This version just uses
qdict_flatten(), the flat-confused input visitor and the output visitor.
 There is no longer a qdict_stringify_for_keyval() because Markus's
flat-confused visitor made it unnecessary.

>>                                                 we can at least try to=

>> bring bs->full_open_options into accordance with the QAPI schema.  Thi=
s
>> may not always work (there are some options left that have not been
>> QAPI-fied yet), but in practice it usually will.
>>
>> In any case, sometimes emitting wrongly typed json:{} filenames is
>> better than doing it effectively half the time.
>=20
> And someday, if we ever switch the block layer to use QAPI types all th=
e
> way, we can drop some of these hacks that have built up over time. But
> not a show-stopper for this series.
>=20
>>
>> This affects some iotests because json:{} filenames are now usually
>> crumpled.  In 198, "format": "auto" now appears in the qcow2 encryptio=
n
>> options because going through a visitor makes optional discriminators'=

>> default values explicit.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534396
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block.c                    | 68 +++++++++++++++++++++++++++++++++++++=
-
>>  tests/qemu-iotests/059.out |  2 +-
>>  tests/qemu-iotests/099.out |  4 +--
>>  tests/qemu-iotests/110.out |  2 +-
>>  tests/qemu-iotests/198.out |  4 +--
>>  tests/qemu-iotests/207.out | 10 +++---
>>  6 files changed, 78 insertions(+), 12 deletions(-)
>>
>=20
>> +/**
>> + * Take a blockdev @options QDict and convert its values to the
>> + * correct type.
>> + *
>> + * Fail if @options does not match the QAPI schema of BlockdevOptions=
=2E
>> + *
>> + * In case of failure, return NULL and set @errp.
>> + *
>> + * In case of success, return a correctly typed new QDict.
>> + */
>> +static QDict *bdrv_type_blockdev_opts(const QDict *options, Error **e=
rrp)
>> +{
>> +    Visitor *v;
>> +    BlockdevOptions *blockdev_options;
>> +    QObject *typed_opts;
>> +    QDict *string_options;
>> +    Error *local_err =3D NULL;
>> +
>> +    string_options =3D qdict_clone_shallow(options);
>> +
>> +    qdict_flatten(string_options);
>> +    v =3D qobject_input_visitor_new_flat_confused(string_options, err=
p);
>> +    if (!v) {
>> +        error_prepend(errp, "Failed to prepare options: ");
>> +        return NULL;
>> +    }
>> +
>> +    visit_type_BlockdevOptions(v, NULL, &blockdev_options, &local_err=
);
>> +    visit_free(v);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        error_prepend(errp, "Not a valid BlockdevOptions object: ");
>> +        return NULL;
>> +    }
>> +
>> +    v =3D qobject_output_visitor_new(&typed_opts);
>> +    visit_type_BlockdevOptions(v, NULL, &blockdev_options, &local_err=
);
>> +    if (!local_err) {
>> +        visit_complete(v, &typed_opts);
>> +    }
>> +    visit_free(v);
>> +    qapi_free_BlockdevOptions(blockdev_options);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return NULL;
>> +    }
>> +
>> +    return qobject_to(QDict, typed_opts);
>> +}
>> +
>>  /* Updates the following BDS fields:
>>   *  - exact_filename: A filename which may be used for opening a bloc=
k device
>>   *                    which (mostly) equals the given BDS (even witho=
ut any
>> @@ -5698,10 +5749,25 @@ void bdrv_refresh_filename(BlockDriverState *b=
s)
>>      if (bs->exact_filename[0]) {
>>          pstrcpy(bs->filename, sizeof(bs->filename), bs->exact_filenam=
e);
>>      } else {
>> -        QString *json =3D qobject_to_json(QOBJECT(bs->full_open_optio=
ns));
>> +        QString *json;
>> +        QDict *typed_opts, *json_opts;
>> +
>> +        typed_opts =3D bdrv_type_blockdev_opts(bs->full_open_options,=
 NULL);
>> +
>> +        /*
>> +         * We cannot be certain that bs->full_open_options matches
>> +         * BlockdevOptions, so bdrv_type_blockdev_opts() may fail.
>> +         * That is not fatal, we can just emit bs->full_open_options
>> +         * directly -- qemu will accept that, even if it does not
>> +         * match the schema.
>> +         */
>> +        json_opts =3D typed_opts ?: bs->full_open_options;
>> +
>> +        json =3D qobject_to_json(QOBJECT(json_opts));
>>          snprintf(bs->filename, sizeof(bs->filename), "json:%s",
>>                   qstring_get_str(json));
>=20
> I so need to revive my series that created a JSON output visitor (to
> skip the qobject_to_json() intermediate step). But that's a topic for
> another day.
>=20
>> +++ b/tests/qemu-iotests/059.out
>> @@ -2050,7 +2050,7 @@ wrote 512/512 bytes at offset 10240
>> =20
>>  =3D=3D=3D Testing monolithicFlat with internally generated JSON file =
name =3D=3D=3D
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 subforma=
t=3DmonolithicFlat
>> -can't open: Cannot use relative extent paths with VMDK descriptor fil=
e 'json:{"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "d=
river": "blkdebug", "inject-error.0.event": "read_aio"}'
>> +can't open: Cannot use relative extent paths with VMDK descriptor fil=
e 'json:{"inject-error": [{"event": "read_aio"}], "image": {"driver": "fi=
le", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug"}'
>=20
> "inject-error" sorts after "image"; meanwhile, the QAPI definition of
> BlockdevOptionsBlkdebug sorts image before inject-error. It looks like
> this output is randomized; can that bite us (as we've recently found
> with other iotests where python 2 vs. 3 sorting mattered)?  And can we
> do better?  (My QAPI JSON output visitor would guarantee the output in
> QAPI definition order)

It can't bite us in the Python 2 vs. 3 sense because the order is
determined by qemu code alone (so it is stable for one version of qemu),
but of course a real order would be nicer.

I don't think it makes sense to parse the filename in the iotest (for
one thing, we'd need to convert this test to Python for that) so we'd be
able to guarantee some order in the output, so I think it's best to just
live with it for now.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Once again, thanks!

Max


--ymjoxskSFPS4fX93ChtWNdOi9maKrJAr5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxdxj8ACgkQ9AfbAGHV
z0AuMQf+PHGqG5taJWBqFIZWlwZULNgFjMID9K3+FVrmH+mZs1H521HaMb92UWwj
bkvzwtdZm76+K49q8y1XTG/RDM4zpN95cHdCLbLlHMsLjPpVuvsXewLRnjmRkTZW
IHAJT+JZw8drU0RIPu3wwq0iyNDzdNRx3xWiXrR7kpcpCZY3UVl9PiSBcO2OBH9N
SqwkDeB+rHDPlz7ERPKXN/w9mVxJPFdZkXwi47dlcMPZPnKc9W9gbtDDq1EV19IB
wOXyLdtitoOWLQCFEIqMmWpHTK250C+ScR2+ESCf7TtiBuC583fWbowA/LspzQx+
uPar7ekDolFros2wOdq4mzRixj2N0A==
=JnGk
-----END PGP SIGNATURE-----

--ymjoxskSFPS4fX93ChtWNdOi9maKrJAr5--
