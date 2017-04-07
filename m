Received: from eggs.gnu.org ([2001:4830:134:3::10]:40444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwQZZ-0000Cm-Fn
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwQZY-0002KG-Mc
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:52:53 -0400
Date: Fri, 7 Apr 2017 10:52:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407095245.GL13602@stefanha-x1.localdomain>
References: <cover.1491416061.git.jcody@redhat.com>
	<613303fd54633f005eeea485e32f590994eb299f.1491416061.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gwtGiOGliFx8mAnm"
Content-Disposition: inline
In-Reply-To: <613303fd54633f005eeea485e32f590994eb299f.1491416061.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 8/9] block/rbd: do not blindly set
 bs->read_only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com


--gwtGiOGliFx8mAnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:28:50PM -0400, Jeff Cody wrote:
> We do not want to just blindly set bs->read_only.  The only time
> we need to set it with the current rbd driver, is if we are using an
> rbd snapshot.  In that case, we must set it to read-only.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/rbd.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index c5e1aeb..35853c9 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -635,6 +635,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict =
*options, int flags,
>          goto failed_shutdown;
>      }
> =20
> +    /* rbd_open is always r/w */
>      r =3D rbd_open(s->io_ctx, s->image_name, &s->image, s->snap);
>      if (r < 0) {
>          error_setg_errno(errp, -r, "error reading header from %s",
> @@ -642,10 +643,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDic=
t *options, int flags,
>          goto failed_open;
>      }
> =20
> -    r =3D bdrv_set_read_only(bs, (s->snap !=3D NULL), &local_err);
> -    if (r < 0) {
> -        error_propagate(errp, local_err);
> -        goto failed_open;
> +    /* If we are using an rbd snapshot, we must be r/o, otherwise
> +     * leave as-is */
> +    if (s->snap !=3D NULL) {
> +        r =3D bdrv_set_read_only(bs, true, &local_err);
> +        if (r < 0) {
> +            error_propagate(errp, local_err);
> +            goto failed_open;
> +        }

This patch series breaks git-bisect(1) for -drive
file.driver=3Drbd,file.read-only=3Don since bdrv_set_read_only(bs, false,
&local_err) fails.

Please squash this patch where you added the bdrv_set_read_only() errp
argument.

--gwtGiOGliFx8mAnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY52FtAAoJEJykq7OBq3PI69EIAMIwLQcLUFKpNVEg9bO6VuOp
itSa9zyZnXFfT2opYWl98UHwH8hodLNbDGRVmE+heGyWJJCs09S0/rdXeLYF8J01
jrJHoc9SsP70r+3bymdYJTO2TLDpNihOCCKe91YRLaRkYS/gDiJe9H7j1N89/wEk
vGk441TtCH/0ve+CYacVA6t92QCKE/q8RHKWf1liJUxk+vdroPxnTx3TlCRx73pP
lQHm10P7/SU0O/jr1KE2Kw+gtIvU6xZ6U9AKngvKrWl/H6I2GbrIbXvVnRoh3VV7
vHd3WhmEFTrSet6SbLtb9mE/1rSBcLc2+fV0zS5yfGKBu9SIufyN0XDZLi2M7zM=
=zg9x
-----END PGP SIGNATURE-----

--gwtGiOGliFx8mAnm--
