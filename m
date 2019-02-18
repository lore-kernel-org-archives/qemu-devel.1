Received: from eggs.gnu.org ([209.51.188.92]:49764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvsnF-0002Ol-3V
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvsnB-0005np-8i
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:57:47 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-9-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <67996e1d-1d6f-2990-3b96-22554f261029@redhat.com>
Date: Tue, 19 Feb 2019 00:57:21 +0100
MIME-Version: 1.0
In-Reply-To: <20190131175549.11691-9-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YXILkOyToyd4ggV1CmgNTeuvlpjx5SJfh"
Subject: Re: [Qemu-devel] [RFC PATCH 08/11] qcow2: Add basic data-file
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YXILkOyToyd4ggV1CmgNTeuvlpjx5SJfh
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <67996e1d-1d6f-2990-3b96-22554f261029@redhat.com>
Subject: Re: [RFC PATCH 08/11] qcow2: Add basic data-file infrastructure
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-9-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.01.19 18:55, Kevin Wolf wrote:
> This adds a .bdrv_open option to specify the external data file node.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  3 ++-
>  block/qcow2.h        |  4 +++-
>  block/qcow2.c        | 25 +++++++++++++++++++++++--
>  3 files changed, 28 insertions(+), 4 deletions(-)

[...]

> diff --git a/block/qcow2.h b/block/qcow2.h
> index c161970882..e2114900b4 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h

[...]

> @@ -205,7 +206,8 @@ enum {
>      QCOW2_INCOMPAT_DATA_FILE        =3D 1 << QCOW2_INCOMPAT_DATA_FILE_=
BITNR,
> =20
>      QCOW2_INCOMPAT_MASK          =3D QCOW2_INCOMPAT_DIRTY
> -                                 | QCOW2_INCOMPAT_CORRUPT,
> +                                 | QCOW2_INCOMPAT_CORRUPT
> +                                 | QCOW2_INCOMPAT_DATA_FILE,

This hunk seems to belong somewhere else.

>  };
> =20
>  /* Compatible feature bits */
> diff --git a/block/qcow2.c b/block/qcow2.c
> index ac9934b3ed..376232d3f0 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1441,8 +1441,22 @@ static int coroutine_fn qcow2_do_open(BlockDrive=
rState *bs, QDict *options,
>          goto fail;
>      }
> =20
> -    /* TODO Open external data file */
> -    s->data_file =3D bs->file;
> +    /* Open external data file */
> +    if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
> +        s->data_file =3D bdrv_open_child(NULL, options, "data-file", b=
s,
> +                                       &child_file, false, errp);
> +        if (!s->data_file) {
> +            ret =3D -EINVAL;
> +            goto fail;
> +        }
> +    } else if (qdict_get(options, QCOW2_OPT_DATA_FILE)) {

I get the idea, but this isn't crumpled so this key may not exist (but
data-file.driver and data-file.filename may).  Of course the fact that
these options remain unused will be caught by the block layer, but that
makes the error message below a bit less useful.

Max

> +        error_setg(errp, "'data-file' can only be set for images with =
an "
> +                         "external data file");
> +        ret =3D -EINVAL;
> +        goto fail;
> +    } else {
> +        s->data_file =3D bs->file;
> +    }
> =20
>      /* qcow2_read_extension may have set up the crypto context
>       * if the crypt method needs a header region, some methods


--YXILkOyToyd4ggV1CmgNTeuvlpjx5SJfh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxrRmIACgkQ9AfbAGHV
z0CWlQf/RpKigJFiGZ4ruLeNyqEMZgaPVMfXGePtB2uXhG55lGmZU4dMFDrlNSVa
KwuYI2aT/XucY4eIm4V/lY08kOnEOnkhLLmVoMmVDCAN2jxYXoemSvPZ91adsFOw
TToVEEYh9ONciWjuMauodc9CtNHYPJkYz3NHvoXck+tHPyejjBEyzUoZHmVnsOW+
04RdHFIWYK8Y0AzuMvXlQ4BEZIA7ZWivELFxfq52rh/9RpXU7FHKdmsIRjektCB5
RpUiMYhkYPDLcA5p0aXLmShPQ/GjDZflO3NsvhfJ3idPGthC/teJ/b0esX0UNQKy
UEUCI/p8ClMbl4PYzdIBjyu22OS1Iw==
=DtfG
-----END PGP SIGNATURE-----

--YXILkOyToyd4ggV1CmgNTeuvlpjx5SJfh--
