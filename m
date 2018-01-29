Received: from eggs.gnu.org ([2001:4830:134:3::10]:58876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egDwl-0007TN-HU
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egDwk-0007su-FK
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:14:23 -0500
Date: Mon, 29 Jan 2018 19:14:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129181410.GR6141@localhost.localdomain>
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-6-kwolf@redhat.com>
	<3a7536f1-c4af-da6c-1282-ba336e96a86c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6BvahUXLYAruDZOj"
Content-Disposition: inline
In-Reply-To: <3a7536f1-c4af-da6c-1282-ba336e96a86c@redhat.com>
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
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org


--6BvahUXLYAruDZOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.01.2018 um 18:30 hat Max Reitz geschrieben:
> On 2018-01-11 20:52, Kevin Wolf wrote:
> > Instead of passing a separate BlockDriverState* into qcow2_create2(),
> > make use of the BlockdevRef that is included in BlockdevCreateOptions.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/block.h |  1 +
> >  block.c               | 39 +++++++++++++++++++++++++++++++++++++++
> >  block/qcow2.c         | 33 +++++++++++++++++++++------------
> >  3 files changed, 61 insertions(+), 12 deletions(-)
>=20
> [...]
>=20
> > diff --git a/block.c b/block.c
> > index a8da4f2b25..c9b0e1d6d3 100644
> > --- a/block.c
> > +++ b/block.c
>=20
> [...]
>=20
> > @@ -2405,6 +2407,43 @@ BdrvChild *bdrv_open_child(const char *filename,
> >      return c;
> >  }
> > =20
> > +/* TODO Future callers may need to specify parent/child_role in order =
for
> > + * option inheritance to work. Existing callers use it for the root no=
de. */
> > +BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **err=
p)
> > +{
> > +    BlockDriverState *bs =3D NULL;
> > +    Error *local_err =3D NULL;
> > +    QObject *obj =3D NULL;
> > +    QDict *qdict =3D NULL;
> > +    const char *reference =3D NULL;
> > +    Visitor *v =3D NULL;
> > +
> > +    if (ref->type =3D=3D QTYPE_QSTRING) {
> > +        reference =3D ref->u.reference;
> > +    } else {
> > +        BlockdevOptions *options =3D &ref->u.definition;
> > +        assert(ref->type =3D=3D QTYPE_QDICT);
> > +
> > +        v =3D qobject_output_visitor_new(&obj);
> > +        visit_type_BlockdevOptions(v, NULL, &options, &local_err);
> > +        if (local_err) {
> > +            error_propagate(errp, local_err);
> > +            goto fail;
> > +        }
> > +        visit_complete(v, &obj);
> > +
> > +        qdict =3D qobject_to_qdict(obj);
> > +        qdict_flatten(qdict);
> > +    }
> > +
> > +    bs =3D bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, er=
rp);
> > +
> > +fail:
> > +    qobject_decref(obj);
>=20
> I'd prefer QDECREF(qdict), myself, although I can't quite explain why.
> Probably because @qdict is the object you're actually using and @obj is
> just some temporary designation.

Hm... If visit_type_BlockdevOptions() fails, qdict is not yet assigned.
Are we sure that obj remains NULL in this case?

qobject_decref(obj) looks more obviously correct to me.

> Also, doesn't bdrv_open_inherit() take ownership of @qdict and thus @obj?

That's a very good point...

Kevin

> Max
>=20
> > +    visit_free(v);
> > +    return bs;
> > +}
> > +
> >  static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *b=
s,
> >                                                     int flags,
> >                                                     QDict *snapshot_opt=
ions,
>=20




--6BvahUXLYAruDZOj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJab2RyAAoJEH8JsnLIjy/Wer4P/R31+A3GdeRTumWm/g4O6TV0
5ORCgtmVk7LIv9BR+bKYxl6+MzLWBAPzBpptEleP0JOo44sz7DR8VHx89ggqQZmJ
IdvLL0aCk37dAwMhYGZMNL7fP0NpRa0RlVoL+P5FLzi+HrFx1XoE/riq2wW0JCAK
9zVZxX6MzLIlLZdBShfWY2IsGrySmOlSarnaiWS2ZbT+FhsFG4q8a7eUToi9rSRO
HBsoBmRIgFY7KouOemq/6497O13QmwzjmIKsmKUS4Ot+qgje753vigH2Lmv2l2t3
ldAVBm8+ofWpijuJPry5j7f/whm584LfSe1fTYcHwbCkWmWAWcm2svlzMiZQdTjT
u+6u2/D5bewnLdUFmmd3yWWP2cp32QVr95BuiRwIdfQRY6qgz32dQKgDyFPmYVXl
ZuRFh9gkY78ktp7xnZaL7xqqRXRkrVb7+bpZM2scz0saB7Lywm7EFauKxwx9EFwj
bfk+kw+YbYhyCbwagn8p61yLtdmnsGCk9CsrhYiFfcczgllmkNZQvedYYBLqsbBt
ovPhvmZOk+nN2Nb7FoxxNg2G7WwHRdUTH9VsfQrWL4aHkRsPdAI1ISikqbi5FVzZ
ouK+WAypHDBpMWWcJbYr+gZpagbZeV7Y9Ugpd6VH0TjlhwMeRRa9j9tlvV4ZeNii
M0jzRcBkzNkXY3b2HVR/
=KvyB
-----END PGP SIGNATURE-----

--6BvahUXLYAruDZOj--
