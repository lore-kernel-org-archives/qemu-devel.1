Received: from eggs.gnu.org ([2001:4830:134:3::10]:47757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elExF-0002Ia-4P
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elExE-0005xc-2B
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:19:37 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-8-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cb426dda-1aae-8932-f113-bdeaca9a29c9@redhat.com>
Date: Mon, 12 Feb 2018 15:19:13 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-8-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iBGfNFtv95TQXBybx2QE3lFcEwG4K98bm"
Subject: Re: [Qemu-devel] [PATCH 07/27] qcow2: Handle full/falloc
 preallocation in qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iBGfNFtv95TQXBybx2QE3lFcEwG4K98bm
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <cb426dda-1aae-8932-f113-bdeaca9a29c9@redhat.com>
Subject: Re: [PATCH 07/27] qcow2: Handle full/falloc preallocation in
 qcow2_create2()
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-8-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Once qcow2_create2() can be called directly on an already existing node=
,
> we must provide the 'full' and 'falloc' preallocation modes outside of
> creating the image on the protocol layer. Fortunately, we have
> preallocated truncate now which can provide this functionality.

When reviewing the gluster patch, I noticed that this will break
full/falloc preallocation on anything but the file protocol because
nothing else yet supports preallocated truncate...

Max

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 3f08cff1fa..0316335614 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2845,6 +2845,25 @@ static int qcow2_create2(BlockdevCreateOptions *=
create_options, Error **errp)
>      }
>      blk_set_allow_write_beyond_eof(blk, true);
> =20
> +    /* Clear the protocol layer and preallocate it if necessary */
> +    ret =3D blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    if (qcow2_opts->preallocation =3D=3D PREALLOC_MODE_FULL ||
> +        qcow2_opts->preallocation =3D=3D PREALLOC_MODE_FALLOC)
> +    {
> +        int64_t prealloc_size =3D
> +            qcow2_calc_prealloc_size(qcow2_opts->size, cluster_size,
> +                                     refcount_order);
> +
> +        ret =3D blk_truncate(blk, prealloc_size, qcow2_opts->prealloca=
tion, errp);
> +        if (ret < 0) {
> +            goto out;
> +        }
> +    }
> +
>      /* Write the header */
>      QEMU_BUILD_BUG_ON((1 << MIN_CLUSTER_BITS) < sizeof(*header));
>      header =3D g_malloc0(cluster_size);
> @@ -3081,15 +3100,6 @@ static int qcow2_create(const char *filename, Qe=
muOpts *opts, Error **errp)
> =20
> =20
>      /* Create and open the file (protocol layer) */
> -    if (prealloc =3D=3D PREALLOC_MODE_FULL || prealloc =3D=3D PREALLOC=
_MODE_FALLOC) {
> -        int refcount_order =3D ctz32(refcount_bits);
> -        int64_t prealloc_size =3D
> -            qcow2_calc_prealloc_size(size, cluster_size, refcount_orde=
r);
> -        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, prealloc_size, &erro=
r_abort);
> -        qemu_opt_set(opts, BLOCK_OPT_PREALLOC, PreallocMode_str(preall=
oc),
> -                     &error_abort);
> -    }
> -
>      ret =3D bdrv_create_file(filename, opts, errp);
>      if (ret < 0) {
>          goto finish;
>=20



--iBGfNFtv95TQXBybx2QE3lFcEwG4K98bm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBomESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AqWgIAIb6PODz1tX4RIWs4MyXDbgg2H+UUwz7
4wmwkO1W/ynA/JUoamqwqYyphbqiL8M38uOnJBpReZ+r5/7LeKzRpNolX/EoeTAU
UkEKvLG7zqOBL0J7oa7wFwpHaosFZ+Yra5aVNdZYZE02+5mRKUm7In7XjG64zLZG
c/gMPUGLUMi7vVfudDY740Sr7BugKZE0yP1JNM7Hg6NglxrHYJkDb+PEpfo7rj9B
ZhfJPDRC/B+0BiuevaKiHhMCr1iGnM7DGIKvjHalCjuDWjcS7xKsapT2oK1CH4VA
IFM3WjpAk4TWm4LEMkn6FkIDoebXs7S4epOfjiVjVcXjhoUalqUyHlk=
=9L3S
-----END PGP SIGNATURE-----

--iBGfNFtv95TQXBybx2QE3lFcEwG4K98bm--
