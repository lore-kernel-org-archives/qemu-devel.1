Received: from eggs.gnu.org ([2001:4830:134:3::10]:59655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gRHyg-0008WI-BS
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gRHya-0002nC-Qb
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:35:10 -0500
References: <20181126141639.13208-1-kwolf@redhat.com>
	<20181126141639.13208-2-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c092d5b7-ebf6-adce-827a-2743c2d2e4db@redhat.com>
Date: Mon, 26 Nov 2018 15:34:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181126141639.13208-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Yz6c3SIhcy5ko5P5v51eB5lJldea9oIZv"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v2 1/2] block: Don't inactivate
 children before parents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yz6c3SIhcy5ko5P5v51eB5lJldea9oIZv
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <c092d5b7-ebf6-adce-827a-2743c2d2e4db@redhat.com>
Subject: Re: [PATCH for-3.1 v2 1/2] block: Don't inactivate children before
 parents
References: <20181126141639.13208-1-kwolf@redhat.com>
 <20181126141639.13208-2-kwolf@redhat.com>
In-Reply-To: <20181126141639.13208-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.11.18 15:16, Kevin Wolf wrote:
> bdrv_child_cb_inactivate() asserts that parents are already inactive
> when children get inactivated. This precondition is necessary because
> parents could still issue requests in their inactivation code.
>=20
> When block nodes are created individually with -blockdev, all of them
> are monitor owned and will be returned by bdrv_next() in an undefined
> order (in practice, in the order of their creation, which is usually
> children before parents), which obviously fails the assertion:
>=20
> qemu: block.c:899: bdrv_child_cb_inactivate: Assertion `bs->open_flags =
& BDRV_O_INACTIVE' failed.
>=20
> This patch fixes the ordering by skipping nodes with still active
> parents in bdrv_inactivate_recurse() because we know that they will be
> covered by recursion when the last active parent becomes inactive.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/block.c b/block.c
> index 5ba3435f8f..e9181c3be7 100644
> --- a/block.c
> +++ b/block.c

[...]

> @@ -4622,6 +4638,14 @@ static int bdrv_inactivate_recurse(BlockDriverSt=
ate *bs,
>          return -ENOMEDIUM;
>      }
> =20
> +    /* Make sure that we don't inactivate a child before its parent.
> +     * It will be covered by recursion from the yet active parent. */
> +    if (bdrv_has_bds_parent(bs, true)) {

Overall the patch looks good to me, apart from the fact that I still
think this should only be checked if setting_flag is true.

(Because BDRV_O_INACTIVE is only set during the second pass, so this
check will lead to the first pass not doing anything (and thus not
calling bs->drv->bdrv_inactivate()) on any non-root bs.)

Max

> +        return 0;
> +    }
> +
> +    assert(!(bs->open_flags & BDRV_O_INACTIVE));
> +
>      if (!setting_flag && bs->drv->bdrv_inactivate) {
>          ret =3D bs->drv->bdrv_inactivate(bs);
>          if (ret < 0) {


--Yz6c3SIhcy5ko5P5v51eB5lJldea9oIZv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlv8BI4ACgkQ9AfbAGHV
z0DI3Af+I25u9eFoJBTZ6+AEy3t34KxYZ4TAKxvaUYzh6V/BpJEaYZ+DQ/Rm/pJt
Lom42pLzukPVAue/TFf8L8wYE9DaG+YEAB4vKU/3/HNAOQS+naaJjggSViDjzsLX
ek4fk5m5nezP/NeejKaTg0R8/HTXyaiq8nBvu2WmXg3C9famuqpwpyqAJ827u7WN
dVF4bohYr9jeBQ49HkOeE8tn3yoODSrk/Go7Yz4n1IjEO/QmDZUAaUGxjPwFzEan
DGQmf5Gm/4MWoD37o1HlfXn5i0v+cqjOy59EOCVUit3WsKo+6YkC3jj8U9Moce6o
SciRvmgz9zRsFnXN7AM8BrDPkaW6dg==
=uyEq
-----END PGP SIGNATURE-----

--Yz6c3SIhcy5ko5P5v51eB5lJldea9oIZv--
