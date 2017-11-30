Received: from eggs.gnu.org ([2001:4830:134:3::10]:54355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKoIs-0004gj-65
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKoIr-0002vl-8q
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:42 -0500
Date: Thu, 30 Nov 2017 16:07:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171130160710.GA17703@stefanha-x1.localdomain>
References: <20171129144956.11409-1-famz@redhat.com>
	<20171129144956.11409-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20171129144956.11409-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 2/9] aio: Add drain begin/end API to
 AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 10:49:49PM +0800, Fam Zheng wrote:
> diff --git a/util/async.c b/util/async.c
> index 4dd9d95a9e..cca0efd263 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -402,6 +402,7 @@ AioContext *aio_context_new(Error **errp)
>      AioContext *ctx;
> =20
>      ctx =3D (AioContext *) g_source_new(&aio_source_funcs, sizeof(AioCon=
text));
> +    QTAILQ_INIT(&ctx->drain_ops);
>      aio_context_setup(ctx);
> =20
>      ret =3D event_notifier_init(&ctx->notifier, false);
> @@ -506,3 +507,75 @@ void aio_context_release(AioContext *ctx)
>  {
>      qemu_rec_mutex_unlock(&ctx->lock);
>  }
> +
> +/* Called with ctx->lock */
> +void aio_context_drained_begin(AioContext *ctx)
> +{
> +    AioDrainOps *ops;
> +
> +    /* TODO: When all external fds are handled in the following drain_ops
> +     * callbacks, aio_disable_external can be dropped. */
> +    aio_disable_external(ctx);
> +restart:
> +    ctx->drain_ops_updated =3D false;
> +    QTAILQ_FOREACH(ops, &ctx->drain_ops, next) {
> +        ops->drained_begin(ops->opaque);
> +        if (ctx->drain_ops_updated) {
> +            goto restart;

drained_begin() can be called multiple times.  This needs to be clearly
documented to avoid surprises.

> +        }
> +    }
> +}
> +
> +/* Called with ctx->lock */
> +void aio_context_drained_end(AioContext *ctx)
> +{
> +    AioDrainOps *ops;
> +
> +restart:
> +    ctx->drain_ops_updated =3D false;
> +    QTAILQ_FOREACH(ops, &ctx->drain_ops, next) {
> +        if (ops->is_new) {
> +            continue;
> +        }
> +        ops->drained_end(ops->opaque);

drained_end() can be called multiple times.  This needs to be clearly
documented to avoid surprises.


> +        if (ctx->drain_ops_updated) {
> +            goto restart;
> +        }
> +    }
> +    if (aio_enable_external(ctx)) {
> +        QTAILQ_FOREACH(ops, &ctx->drain_ops, next) {
> +            ops->is_new =3D false;
> +        }
> +    }

This is weird, aio_context_drained_end() has nesting support for
->is_new but not for ->drained_end() calls.  I'm not sure where you're
going with these semantics yet.

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaICyuAAoJEJykq7OBq3PI6NQH/jMI5nj3R6J7DPJ79udQ44cD
KG5OGKve4hcWYgHtRRVPUP0myvrY8+GeO0DelKb9YnRrLqrpyKrfD4/V5cJE19eZ
aeijHeZuxncVENJER+41JpmKp6RXqRnprAwnNobpjFy0bAp2MGXDYXqPqlrK4qnM
1MVrNQ7XCKWnXURvzb1pCrn56KcjmlrLKe7GfTY/XGRsKQGwXXXksECRj6H3mV6U
aeRW9tIz0P7zp6VcYckiJSd8h8agzbohhVhCE6MYXRGsTDsXCaaGJeqG0KTXDfTY
sSDqZVgeQQjSwYHh708TFSiDfKJ/XHgAf6OiOn7dgVJG5DgcLJF/1DDbXEmd9tk=
=oiZq
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
