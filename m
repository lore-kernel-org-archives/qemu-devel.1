Received: from eggs.gnu.org ([2001:4830:134:3::10]:40968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQUs-0007en-A6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQUr-0005NP-DH
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:40:26 -0400
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-2-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dc941df3-64cf-d798-7003-852efa8e0e4a@redhat.com>
Date: Mon, 12 Mar 2018 17:40:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180309214611.19122-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C2H222jsrYEO5kHql7NXiTIO4e12XGN1A"
Subject: Re: [Qemu-devel] [PATCH 1/7] parallels: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C2H222jsrYEO5kHql7NXiTIO4e12XGN1A
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <dc941df3-64cf-d798-7003-852efa8e0e4a@redhat.com>
Subject: Re: [PATCH 1/7] parallels: Support .bdrv_co_create
References: <20180309214611.19122-1-kwolf@redhat.com>
 <20180309214611.19122-2-kwolf@redhat.com>
In-Reply-To: <20180309214611.19122-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-09 22:46, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to parallels, which
> enables image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  18 ++++-
>  block/parallels.c    | 199 ++++++++++++++++++++++++++++++++++++++-----=
--------
>  2 files changed, 168 insertions(+), 49 deletions(-)

[...]

> diff --git a/block/parallels.c b/block/parallels.c
> index c13cb619e6..2da5e56a9d 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c

[...]

> @@ -542,24 +580,107 @@ static int coroutine_fn parallels_co_create_opts=
(const char *filename,

[...]

> +static int coroutine_fn parallels_co_create_opts(const char *filename,=

> +                                                 QemuOpts *opts,
> +                                                 Error **errp)
> +{

[...]

> +    /* Now get the QAPI type BlockdevCreateOptions */
> +    qdict_put_str(qdict, "driver", "parallels");
> +    qdict_put_str(qdict, "file", bs->node_name);
> +
> +    qobj =3D qdict_crumple(qdict, errp);

Any reason for this crumpling other than because it doesn't change
anything and if it did, it would be for the better?

The rest looks OK to me, and I just think this creates an exact copy of
qdict, so I guess:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +    QDECREF(qdict);
> +    qdict =3D qobject_to_qdict(qobj);
> +    if (qdict =3D=3D NULL) {
> +        ret =3D -EINVAL;
> +        goto done;
> +    }
> +
> +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> +    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_=
err);
> +    visit_free(v);


--C2H222jsrYEO5kHql7NXiTIO4e12XGN1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqmrWgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AcYYH/iJcZlbaZ4XGPmzWbMUPpO7fBOFacFOW
azTZdUfDNCOGzKcc7Bjhd51y8+BUyELok6BxnqtNmpvr3IMGVT8phnCZn3pBAvrj
/LeEirtYIJFGPEOgZ5l6mYF9OINjtp8dnSGhjY6pLLUhnegDIri2JZzEgiZi9jIF
xG4NUHJ7hq1rZUnkP/Tfn42UMlBspPdva+4kdndP1yj8vfe225yCNHZBOJMNjvRC
ZopoQsPolZ5xKsB/rPqBnzluQijI4Rww8GEUy/2bqqb+TROav3nAtCllOAIDTniY
f3mMuW9gl1HvF3jsiX99V10c60oGGjL0288kJ1LpM0HMbfmRQ4B8xQk=
=CWXJ
-----END PGP SIGNATURE-----

--C2H222jsrYEO5kHql7NXiTIO4e12XGN1A--
