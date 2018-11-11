Received: from eggs.gnu.org ([2001:4830:134:3::10]:53556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLwwY-0005TI-5r
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 16:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLwwX-0006yS-7y
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 16:06:54 -0500
References: <cover.1541595424.git.berto@igalia.com>
	<a54f07d612171ce5c3994373356447d0c6df0679.1541595424.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e287b314-bb9f-3258-550d-3c1ce079d036@redhat.com>
Date: Sun, 11 Nov 2018 22:06:41 +0100
MIME-Version: 1.0
In-Reply-To: <a54f07d612171ce5c3994373356447d0c6df0679.1541595424.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ORevxOKwQQvuEkkJnYMi6xX1tEnAA1v3E"
Subject: Re: [Qemu-devel] [PATCH v4 15/15] block: Assert that flags are
 up-to-date in bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ORevxOKwQQvuEkkJnYMi6xX1tEnAA1v3E
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <e287b314-bb9f-3258-550d-3c1ce079d036@redhat.com>
Subject: Re: [PATCH v4 15/15] block: Assert that flags are up-to-date in
 bdrv_reopen_prepare()
References: <cover.1541595424.git.berto@igalia.com>
 <a54f07d612171ce5c3994373356447d0c6df0679.1541595424.git.berto@igalia.com>
In-Reply-To: <a54f07d612171ce5c3994373356447d0c6df0679.1541595424.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.11.18 13:59, Alberto Garcia wrote:
> Towards the end of bdrv_reopen_queue_child(), before starting to
> process the children, the update_flags_from_options() function is
> called in order to have BDRVReopenState.flags in sync with the options
> from the QDict.
>=20
> This is necessary because during the reopen process flags must be
> updated for all nodes in the queue so bdrv_is_writable_after_reopen()
> and the permission checks work correctly.
>=20
> Because of that, calling update_flags_from_options() again in
> bdrv_reopen_prepare() doesn't really change the flags (they are
> already up-to-date). But we need to call it in order to remove those
> options from QemuOpts and that way indicate that they have been
> processed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 68f1e3b45e..03277b3d19 100644
> --- a/block.c
> +++ b/block.c
> @@ -3178,6 +3178,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_s=
tate, BlockReopenQueue *queue,
>                          Error **errp)
>  {
>      int ret =3D -1;
> +    int old_flags;
>      Error *local_err =3D NULL;
>      BlockDriver *drv;
>      QemuOpts *opts;
> @@ -3203,7 +3204,12 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_=
state, BlockReopenQueue *queue,
>          goto error;
>      }
> =20
> +    /* This was already called in bdrv_reopen_queue_child() so the fla=
gs
> +     * are up-to-date. This time we simply want to remove the options =
from
> +     * QemuOpts in order to indicate that they have been processed. */=

> +    old_flags =3D reopen_state->flags;
>      update_flags_from_options(&reopen_state->flags, opts);
> +    assert(old_flags =3D=3D reopen_state->flags);

Reviewed-by: Max Reitz <mreitz@redhat.com>

Although as my bike-shedding for today I'd like to say that I'd find it
more intuitive to store the "just remove the options" call result into
old_flags instead (or rather something renamed), i.e.

    flags_copy =3D reopen_state->flags;
    update_flags_from_options(&flags_copy, opts);
    assert(flags_copy =3D=3D reopen_state->flags);

Not that it matters.

Max


--ORevxOKwQQvuEkkJnYMi6xX1tEnAA1v3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvomeEACgkQ9AfbAGHV
z0CXCQf9HRZHm1/Nn+lgadfglqQxYXbP45FzxLX6SJPYZVWby/rR+rec9BgKI3b1
LZH4LE9chaEj8O0RJDSkX5svSxW7zPFdc80HU4VERFEFNE2jYZ/q7sQjloWmfuXw
xCczgUcEDAHW202xiGgvWIdtFfL9E4yTBzry/SOTAe+9f9DZVZl8NKqCSzx5oKcB
9xaHpGsVuVVqJu6wKT9I+LwevNvfz3p9KWrOQjSqVcOKYAldJEiefMdWHTrui6AN
RNyhvsB+EcnNye2jdD1viFm4RxQMC55oPJ+Kv2ftPOqkpXEn0AkffRldPZbyW9x1
j7p6E7upomomCK8C4YfWQFxQseBaRA==
=etht
-----END PGP SIGNATURE-----

--ORevxOKwQQvuEkkJnYMi6xX1tEnAA1v3E--
