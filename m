Received: from eggs.gnu.org ([209.51.188.92]:53218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvt6v-0004aU-Uw
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvt6u-0004gq-Va
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:18:09 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-11-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0e4a0d3a-832b-e8aa-7ea0-acce96e513d5@redhat.com>
Date: Tue, 19 Feb 2019 01:18:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190131175549.11691-11-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cGPDNHmVPvoehgLns0eerG2E3UcPvjN2I"
Subject: Re: [Qemu-devel] [RFC PATCH 10/11] qcow2: Store data file name in
 the image
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
--cGPDNHmVPvoehgLns0eerG2E3UcPvjN2I
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <0e4a0d3a-832b-e8aa-7ea0-acce96e513d5@redhat.com>
Subject: Re: [RFC PATCH 10/11] qcow2: Store data file name in the image
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-11-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.01.19 18:55, Kevin Wolf wrote:
> Rather than requiring that the external data file node is passed
> explicitly when creating the qcow2 node, store the filename in the
> designated header extension during .bdrv_create and read it from there
> as a default during .bdrv_open.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.h              |  1 +
>  block/qcow2.c              | 69 +++++++++++++++++++++++++++++++++++++-=

>  tests/qemu-iotests/082.out | 27 +++++++++++++++
>  3 files changed, 96 insertions(+), 1 deletion(-)

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6cf862e8b9..4959bf16a4 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -398,6 +398,20 @@ static int qcow2_read_extensions(BlockDriverState =
*bs, uint64_t start_offset,
>  #endif
>              break;
> =20
> +        case QCOW2_EXT_MAGIC_DATA_FILE:
> +        {
> +            s->image_data_file =3D g_malloc0(ext.len + 1);
> +            ret =3D bdrv_pread(bs->file, offset, s->image_data_file, e=
xt.len);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "ERROR: Could not data fi=
le name");

I think you accidentally a word.

> +                return ret;
> +            }
> +#ifdef DEBUG_EXT
> +            printf("Qcow2: Got external data file %s\n", s->image_data=
_file);
> +#endif
> +            break;
> +        }
> +
>          default:
>              /* unknown magic - save it in case we need to rewrite the =
header */
>              /* If you add a new feature, make sure to also update the =
fast
> @@ -1444,7 +1458,18 @@ static int coroutine_fn qcow2_do_open(BlockDrive=
rState *bs, QDict *options,
>      /* Open external data file */
>      if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
>          s->data_file =3D bdrv_open_child(NULL, options, "data-file", b=
s,
> -                                       &child_file, false, errp);
> +                                       &child_file, false, &local_err)=
;
> +        if (!s->data_file) {
> +            if (s->image_data_file) {
> +                error_free(local_err);
> +                local_err =3D NULL;

This looked a bit weird to me at first because I was wondering why you
wouldn't just pass allow_none=3Dtrue and then handle errors (by passing
them on).  But right, we want to retry with a filename set, maybe that
makes more sense of the options.

Hm.  But then again, do we really?  It matches what we do with backing
files, but that does give at least me headaches from time to time.  How
bad would it be to allow either passing all valid options through
@options (which would make qcow2 ignore the string in the header), or
use the filename given in the header alone?

> +                s->data_file =3D bdrv_open_child(s->image_data_file, o=
ptions,
> +                                               "data-file", bs, &child=
_file,
> +                                               false, errp);
> +            } else {
> +                error_propagate(errp, local_err);
> +            }
> +        }
>          if (!s->data_file) {
>              ret =3D -EINVAL;
>              goto fail;

[...]

> @@ -3229,6 +3270,26 @@ static int coroutine_fn qcow2_co_create_opts(con=
st char *filename, QemuOpts *opt
>          goto finish;
>      }
> =20
> +    /* Create and open an external data file (protocol layer) */
> +    val =3D qdict_get_try_str(qdict, BLOCK_OPT_DATA_FILE);
> +    if (val) {
> +        ret =3D bdrv_create_file(val, opts, errp);

I suppose taking an existing file is saved for later?

Max

> +        if (ret < 0) {
> +            goto finish;
> +        }
> +
> +        data_bs =3D bdrv_open(val, NULL, NULL,
> +                            BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTO=
COL,
> +                            errp);
> +        if (data_bs =3D=3D NULL) {
> +            ret =3D -EIO;
> +            goto finish;
> +        }
> +
> +        qdict_del(qdict, BLOCK_OPT_DATA_FILE);
> +        qdict_put_str(qdict, "data-file", data_bs->node_name);
> +    }
> +
>      /* Set 'driver' and 'node' options */
>      qdict_put_str(qdict, "driver", "qcow2");
>      qdict_put_str(qdict, "file", bs->node_name);


--cGPDNHmVPvoehgLns0eerG2E3UcPvjN2I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxrSzoACgkQ9AfbAGHV
z0AB0Qf/SuVGd9t0gaRooN5HlZD+i4kYsNXQ4wEyARGmAijPOCBLIgOmpuO3YHhf
CzhZeFxd1lHAE0xGbxP387XdRhfxi/7fX3Sq2gzKwiTfMbPW9za0ldpD+329qezf
/37ZnLamqvp/A17doQI2oaGJh6AkNwHFxYwznU6ZuRUcqrq+9xsTEPXc0bvrl8go
KeJYyQWCSgsapI4Ma7QX52Bv5pTWLCH/6U5rOABt3RrH2G5C0cb9h8qLeBb6aqiM
Ah7UMzN6Ru+q1UUjH4RdA4Iv1el4HbtlvZ1MpQm5/sJctLe/5I6BqSNulqWwsY4C
8TiFmy3sR+/dv/i9FSxVbRbw6jenVw==
=MEQ5
-----END PGP SIGNATURE-----

--cGPDNHmVPvoehgLns0eerG2E3UcPvjN2I--
