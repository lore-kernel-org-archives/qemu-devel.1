Received: from eggs.gnu.org ([2001:4830:134:3::10]:40731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXtfb-0003EN-7S
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 15:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXtfY-00057k-3K
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 15:30:31 -0400
References: <152750903916.663961.9369851345277129751.stgit@bahia.lan>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ac4381db-2953-de6a-c5bf-27d81f68d418@redhat.com>
Date: Tue, 26 Jun 2018 21:30:23 +0200
MIME-Version: 1.0
In-Reply-To: <152750903916.663961.9369851345277129751.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IhCwCn1CIpGolDPt8y0LIs5wl84P0RP4g"
Subject: Re: [Qemu-devel] [PATCH v4] block: fix QEMU crash with scsi-hd and
 drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IhCwCn1CIpGolDPt8y0LIs5wl84P0RP4g
From: Max Reitz <mreitz@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Message-ID: <ac4381db-2953-de6a-c5bf-27d81f68d418@redhat.com>
Subject: Re: [PATCH v4] block: fix QEMU crash with scsi-hd and drive_del
References: <152750903916.663961.9369851345277129751.stgit@bahia.lan>
In-Reply-To: <152750903916.663961.9369851345277129751.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-28 14:03, Greg Kurz wrote:
> Removing a drive with drive_del while it is being used to run an I/O
> intensive workload can cause QEMU to crash.
>=20
> An AIO flush can yield at some point:
>=20
> blk_aio_flush_entry()
>  blk_co_flush(blk)
>   bdrv_co_flush(blk->root->bs)
>    ...
>     qemu_coroutine_yield()
>=20
> and let the HMP command to run, free blk->root and give control
> back to the AIO flush:
>=20
>     hmp_drive_del()
>      blk_remove_bs()
>       bdrv_root_unref_child(blk->root)
>        child_bs =3D blk->root->bs
>        bdrv_detach_child(blk->root)
>         bdrv_replace_child(blk->root, NULL)
>          blk->root->bs =3D NULL
>         g_free(blk->root) <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D b=
lk->root becomes stale
>        bdrv_unref(child_bs)
>         bdrv_delete(child_bs)
>          bdrv_close()
>           bdrv_drained_begin()
>            bdrv_do_drained_begin()
>             bdrv_drain_recurse()
>              aio_poll()
>               ...
>               qemu_coroutine_switch()
>=20
> and the AIO flush completion ends up dereferencing blk->root:
>=20
>   blk_aio_complete()
>    scsi_aio_complete()
>     blk_get_aio_context(blk)
>      bs =3D blk_bs(blk)
>  ie, bs =3D blk->root ? blk->root->bs : NULL
>             ^^^^^
>             stale
>=20
> The problem is that we should avoid making block driver graph
> changes while we have in-flight requests. Let's drain all I/O
> for this BB before calling bdrv_root_unref_child().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v4: - call blk_drain() in blk_remove_bs() (Kevin)
>=20
> v3: - start drained section before modifying the graph (Stefan)
>=20
> v2: - drain I/O requests when detaching the BDS (Stefan, Paolo)
> ---
>  block/block-backend.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 89f47b00ea24..bee1f0e41461 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -768,6 +768,11 @@ void blk_remove_bs(BlockBackend *blk)
> =20
>      blk_update_root_state(blk);
> =20
> +    /* bdrv_root_unref_child() will cause blk->root to become stale an=
d may
> +     * switch to a completion coroutine later on. Let's drain all I/O =
here
> +     * to avoid that and a potential QEMU crash.
> +     */
> +    blk_drain(blk);
>      bdrv_root_unref_child(blk->root);
>      blk->root =3D NULL;
>  }

For some reason, this patch breaks iotest 083 (with -nbd) on tmpfs for me=
=2E

Only on tmpfs, though, so it's probably not going to be just a simple
reference output fix.

Max


--IhCwCn1CIpGolDPt8y0LIs5wl84P0RP4g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsylFAACgkQ9AfbAGHV
z0Cb8AgAjMmYJOq+0/6BBXzyYxPwYl1ccXip6QMe0/IgBsHtRbFQEMg+ZgIYZFC1
HgXJx6JN23WHeot0nYTbtClwv1Ble3WEAds1zc+q1FMkMzW8X7sKfUxBOAk0O4VR
Y+F7AGkMa9yHyczUeyD/MhXoSStEs4TseBTsK6OmiAZpCQ7rf7MaPF6+a+AFYJLB
44h1BAK2vfLBfgFdnARwYh01EfWcL3u6vuweIwaMYSPhnaCfbaTqE/nQCoud4gG8
r3TgiLkF/3bTyevuB8FbzCm4I5HDUrckbiOgxRdDRBh3quHBZjE1q2kwylI2+STX
tuyxxNvpLS8BcyMbrSwJlwqYL6vNTQ==
=tLwt
-----END PGP SIGNATURE-----

--IhCwCn1CIpGolDPt8y0LIs5wl84P0RP4g--
