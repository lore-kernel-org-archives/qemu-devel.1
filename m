Received: from eggs.gnu.org ([2001:4830:134:3::10]:33957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eD5TI-0000F9-4X
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eD5TH-0002Bb-A6
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:19:32 -0500
Date: Fri, 10 Nov 2017 09:19:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171110091921.GB31658@stefanha-x1.localdomain>
References: <20171109204315.27072-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20171109204315.27072-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] block: Keep strong reference when
 draining all BDS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2017 at 09:43:15PM +0100, Max Reitz wrote:
> Draining a BDS may lead to graph modifications, which in turn may result
> in it and other BDS being stripped of their current references.  If
> bdrv_drain_all_begin() and bdrv_drain_all_end() do not keep strong
> references themselves, the BDS they are trying to drain (or undrain) may
> disappear right under their feet -- or, more specifically, under the
> feet of BDRV_POLL_WHILE() in bdrv_drain_recurse().
>=20
> This fixes an occasional hang of iotest 194.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/io.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index 3d5ef2cabe..a0a2833e8e 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -340,7 +340,10 @@ void bdrv_drain_all_begin(void)
>      bool waited =3D true;
>      BlockDriverState *bs;
>      BdrvNextIterator it;
> -    GSList *aio_ctxs =3D NULL, *ctx;
> +    GSList *aio_ctxs =3D NULL, *ctx, *bs_list =3D NULL, *bs_list_entry;
> +
> +    /* Must be called from the main loop */
> +    assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context());
> =20
>      block_job_pause_all();
> =20
> @@ -355,6 +358,12 @@ void bdrv_drain_all_begin(void)
>          if (!g_slist_find(aio_ctxs, aio_context)) {
>              aio_ctxs =3D g_slist_prepend(aio_ctxs, aio_context);
>          }
> +
> +        /* Keep a strong reference to all root BDS and copy them into
> +         * an own list because draining them may lead to graph
> +         * modifications. */
> +        bdrv_ref(bs);
> +        bs_list =3D g_slist_prepend(bs_list, bs);
>      }
> =20
>      /* Note that completion of an asynchronous I/O operation can trigger=
 any
> @@ -370,7 +379,11 @@ void bdrv_drain_all_begin(void)
>              AioContext *aio_context =3D ctx->data;
> =20
>              aio_context_acquire(aio_context);
> -            for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
> +            for (bs_list_entry =3D bs_list; bs_list_entry;
> +                 bs_list_entry =3D bs_list_entry->next)
> +            {
> +                bs =3D bs_list_entry->data;
> +
>                  if (aio_context =3D=3D bdrv_get_aio_context(bs)) {
>                      waited |=3D bdrv_drain_recurse(bs, true);
>                  }
> @@ -379,24 +392,52 @@ void bdrv_drain_all_begin(void)
>          }
>      }
> =20
> +    for (bs_list_entry =3D bs_list; bs_list_entry;
> +         bs_list_entry =3D bs_list_entry->next)
> +    {
> +        bdrv_unref(bs_list_entry->data);
> +    }
> +
>      g_slist_free(aio_ctxs);
> +    g_slist_free(bs_list);
>  }

Which specific parts of this function access bs without a reference?

I see bdrv_next() may do QTAILQ_NEXT(bs, monitor_list) after
bdrv_drain_recurse() has returned.

Anything else?

If bdrv_next() is the only issue then I agree with Fam that it makes
sense to build the ref/unref into bdrv_next().

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBW8ZAAoJEJykq7OBq3PIuOoH/RQKmIMVxdKgUg2DcKRNiFgg
L3VTGg6F4//GP5V7h0cLlXJKOPb4NtTI0sSLHMb5WOdVggkyTfphnNsyFPsET9q9
needwnAerQGWYM+Y6FV55yehmTtRUYICL5CJBtlDQ8cjkfJvwXL2UuoOE8U/yEaU
Sk4SQraoxCn7AY1oVFflw7YZF6jGXDaXMrA/H6lf9Me/q97Hu861sD7MBkwPLniq
NDMBU/DYZt362cm1UX5xw8uTexrfFL0Si5N2W8um6qlt2bO+u04qR5e2mZ8qY537
uWYpRiRE6SJHPmVCsXxfmBX8vM3X0ouRGvJhouLlGY/uDwNLrAs2RuQ8ChdYrvQ=
=pvdJ
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
