Received: from eggs.gnu.org ([2001:4830:134:3::10]:43166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTrJI-0000Re-Gl
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTrJD-0007yS-Fj
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:34:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTrJD-0007wj-Al
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:33:55 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6092019DE9E
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:33:54 +0000 (UTC)
Date: Wed, 18 Jan 2017 14:33:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118143346.GA30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/16] aio: introduce aio_co_schedule and
 aio_co_wake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2017 at 02:17:16PM +0100, Paolo Bonzini wrote:
> +static void co_schedule_bh_cb(void *opaque)
> +{
> +    AioContext *ctx = opaque;
> +    QSLIST_HEAD(, Coroutine) straight, reversed;
> +
> +    QSLIST_MOVE_ATOMIC(&reversed, &ctx->scheduled_coroutines);
> +    QSLIST_INIT(&straight);
> +
> +    while (!QSLIST_EMPTY(&reversed)) {
> +        Coroutine *co = QSLIST_FIRST(&reversed);
> +        QSLIST_REMOVE_HEAD(&reversed, co_scheduled_next);
> +        QSLIST_INSERT_HEAD(&straight, co, co_scheduled_next);
> +    }
> +
> +    while (!QSLIST_EMPTY(&straight)) {
> +        Coroutine *co = QSLIST_FIRST(&straight);
> +        QSLIST_REMOVE_HEAD(&straight, co_scheduled_next);
> +        trace_aio_co_schedule_bh_cb(ctx, co);
> +        qemu_coroutine_enter(co);
> +    }
> +}

ctx->scheduled_coroutines is a specialized CoQueue.  Was there no way to
modify and then use CoQueue instead of open coding it?

> +void aio_co_wake(struct Coroutine *co)
> +{
> +    AioContext *ctx;
> +
> +    /* Read coroutine before co->ctx.  Matches smp_wmb in
> +     * qemu_coroutine_enter.
> +     */
> +    smp_read_barrier_depends();
> +    ctx = atomic_read(&co->ctx);
> +
> +    if (ctx != qemu_get_current_aio_context()) {
> +        aio_co_schedule(ctx, co);
> +        return;
> +    }
> +
> +    if (qemu_in_coroutine()) {
> +        Coroutine *self = qemu_coroutine_self();
> +        assert(self != co);
> +        QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
> +    } else {
> +        aio_context_acquire(ctx);
> +        qemu_coroutine_enter(co);
> +        aio_context_release(ctx);

Why is it necessary to acquire AioContext here?  We're already in ctx.

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf3zKAAoJEJykq7OBq3PIbRsH/jf3XYtFelKdflPoEuDw8oqd
jCJKW9hFgnQla4qYOT2e3dfBsfPyOLOromtRsfr+GDgu2HbkKkjCPK87I8GfiQNU
owOBPmW4EQp4iDHZ/FsbKEEeNPonY/qGAHgVQCKGWl7YMz5EK+7IcjOVJJ2C3EaI
YZeWm25LkBW75IJT9f2iClEZdaR9FMmdaKMbgTEWXTXYz8W5V7mxAOhdwWqATErT
q87BA0YdsgmdwHcjGS+LbN1oj3Mw8PPQb2KiydDU6NEB5Z9AEaruQcunhXF2TkWw
S9Wrks1OvClGUlOklvTzREwNQaR6j5ausCeFVw/xcRU8bzGhksL2jFQQNvXp46A=
=5HTh
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
