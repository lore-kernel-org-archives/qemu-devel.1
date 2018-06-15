Received: from eggs.gnu.org ([2001:4830:134:3::10]:39041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTrVN-0001c1-UY
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTrVN-0008Et-1K
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:23:17 -0400
Date: Fri, 15 Jun 2018 17:23:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180615162308.GF12972@stefanha-x1.localdomain>
References: <20180608060417.10170-1-famz@redhat.com>
	<20180608060417.10170-7-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Content-Disposition: inline
In-Reply-To: <20180608060417.10170-7-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/6] mirror: Use copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 08, 2018 at 02:04:17PM +0800, Fam Zheng wrote:
> +static void mirror_copy_range_complete(void *opaque, int ret)
> +{
> +    MirrorOp *op = opaque;
> +    MirrorBlockJob *s = op->s;
> +
> +    aio_context_acquire(blk_get_aio_context(s->common.blk));
> +    trace_mirror_copy_range_complete(s, ret, op->offset, op->bytes);
> +    if (!ret) {
> +        mirror_iteration_done(op, ret);
> +    } else {
> +        uint64_t bytes;
> +
> +        s->use_copy_range = false;
> +        s->in_flight--;
> +        s->bytes_in_flight -= op->bytes;
> +        bytes = mirror_do_read(s, op->offset, op->bytes);

A coroutine_fn cannot be called from a non-coroutine_fn.  This will
crash if mirror_do_read() yields.

> +        /* No alignment adjusting in mirror_do_read since we've already done
> +         * that in mirror_do_copy(). */
> +        assert(bytes == op->bytes);
> +        g_free(op);
> +    }
> +    aio_context_release(blk_get_aio_context(s->common.blk));
> +}
> +
> +static uint64_t mirror_do_copy(MirrorBlockJob *s, int64_t offset,
> +                               uint64_t bytes)
> +{
> +    uint64_t ret;
> +    MirrorOp *op;
> +
> +    if (!s->use_copy_range || offset < BLOCK_PROBE_BUF_SIZE) {

BLOCK_PROBE_BUF_SIZE is a detail of the raw-format.c driver.  Is it
appropriate to do this in the mirror job?

Can raw-format.c's copy_range() callbacks check BLOCK_PROBE_BUF_SIZE and
handle this case?  That way nothing besides raw-format.c needs to know
about probe protection.

> +        return mirror_do_read(s, offset, bytes);

mirror_do_read() can (indirectly) yield, so mirror_do_copy() must be
declared coroutine_fn.

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbI+frAAoJEJykq7OBq3PIAOQH/RtD0WZdwpbf4o4XnT5huvr0
RKyaKz15otmbRePX2771KvIOb1E4hga4g38hGFIAvlbZEzduMAwWAs2y8lh8FSVX
mPYWDMew5X0PHjvMi++j33Zho7q0Wl+TMW7avrfQsxJi00LPtibWNIuOuh5UoOjA
YE8/l7PVqz7Umlsjp3Z7a2WkyKehLmqCDeq/ZAWukFRnNY/OpXlVidRQDICVVx0q
n0Stmw7x4CtF/S6zx/gD7AolwZ/yier8XemYb0dgOMpYKTMj0GMGsGy6EnyhrUGw
FalZHcHphe6+nuA/bMXQFzLaI1Eiz9UkpMvg8LKS+6JTa8AFy6j/xA3GvPp6En8=
=dYHg
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--
