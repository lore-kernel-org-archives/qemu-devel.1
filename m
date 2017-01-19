Received: from eggs.gnu.org ([2001:4830:134:3::10]:34997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cUFu0-0006uM-Gu
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cUFtw-0005rv-Fr
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:49:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cUFtw-0005qo-7X
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:49:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31C4D61BA0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 16:49:28 +0000 (UTC)
Date: Thu, 19 Jan 2017 16:49:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170119164925.GB27032@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-2-pbonzini@redhat.com>
	<20170118143346.GA30347@stefanha-x1.localdomain>
	<b665a226-cd82-9cf2-858b-39eb8a98ae34@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <b665a226-cd82-9cf2-858b-39eb8a98ae34@redhat.com>
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


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 04:40:29PM +0100, Paolo Bonzini wrote:
> On 18/01/2017 15:33, Stefan Hajnoczi wrote:
> > On Fri, Jan 13, 2017 at 02:17:16PM +0100, Paolo Bonzini wrote:
> >> +static void co_schedule_bh_cb(void *opaque)
> >> +{
> >> +    AioContext *ctx =3D opaque;
> >> +    QSLIST_HEAD(, Coroutine) straight, reversed;
> >> +
> >> +    QSLIST_MOVE_ATOMIC(&reversed, &ctx->scheduled_coroutines);
> >> +    QSLIST_INIT(&straight);
> >> +
> >> +    while (!QSLIST_EMPTY(&reversed)) {
> >> +        Coroutine *co =3D QSLIST_FIRST(&reversed);
> >> +        QSLIST_REMOVE_HEAD(&reversed, co_scheduled_next);
> >> +        QSLIST_INSERT_HEAD(&straight, co, co_scheduled_next);
> >> +    }
> >> +
> >> +    while (!QSLIST_EMPTY(&straight)) {
> >> +        Coroutine *co =3D QSLIST_FIRST(&straight);
> >> +        QSLIST_REMOVE_HEAD(&straight, co_scheduled_next);
> >> +        trace_aio_co_schedule_bh_cb(ctx, co);
> >> +        qemu_coroutine_enter(co);
> >> +    }
> >> +}
> >=20
> > ctx->scheduled_coroutines is a specialized CoQueue.  Was there no way to
> > modify and then use CoQueue instead of open coding it?
>=20
> First of all, I'm trying to avoid a circular dependency when CoQueue can
> use aio_co_schedule (indirectly through aio_co_wake) after patch 7.
>=20
> Secondarily, co_schedule_bh_cb can perform a single pass on
> ctx->scheduled_coroutines because it will be rescheduled by
> aio_co_schedule.  The same is not true for qemu_co_queue_restart_all.
>=20
> Also, CoQueue can have multiple consumers, while scheduled_coroutines
> cannot.  Currently, CoQueue needs no thread-safety because it's
> protected by AioContext and/or by the non-preemptive nature of
> coroutines.  Later, it's going to be protected by an external CoMutex,
> just like a mutex/condvar pair.  scheduled_coroutines is different in
> this respect.

Thanks for explaining.

> >> +void aio_co_wake(struct Coroutine *co)
> >> +{
> >> +    AioContext *ctx;
> >> +
> >> +    /* Read coroutine before co->ctx.  Matches smp_wmb in
> >> +     * qemu_coroutine_enter.
> >> +     */
> >> +    smp_read_barrier_depends();
> >> +    ctx =3D atomic_read(&co->ctx);
> >> +
> >> +    if (ctx !=3D qemu_get_current_aio_context()) {
> >> +        aio_co_schedule(ctx, co);
> >> +        return;
> >> +    }
> >> +
> >> +    if (qemu_in_coroutine()) {
> >> +        Coroutine *self =3D qemu_coroutine_self();
> >> +        assert(self !=3D co);
> >> +        QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_nex=
t);
> >> +    } else {
> >> +        aio_context_acquire(ctx);
> >> +        qemu_coroutine_enter(co);
> >> +        aio_context_release(ctx);
> >=20
> > Why is it necessary to acquire AioContext here?  We're already in ctx.
>=20
> We're in its thread, but we've not necessarily acquired it yet.
> aio_co_wake is called "aio_*" because it's a central place for
> AioContext to acquire itself for coroutines.  This way, coroutines only
> care about CoMutexes, and not about AioContext.  This was "highly
> recommended" :) by Kevin last year and it's the main change since the
> previous posting
> (https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg05416.html for
> example).

I see.  That also explains why we don't need to acquire AioContext if
we're already in a coroutine.

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYgO4VAAoJEJykq7OBq3PIfo4H/1ADEeSqrw29KDuxbx6pIzFn
/rR+tmfnC2R9RsMZYivwyGk+AvFWEt5DffVhoeJ5OBLaOKxztu3leXfe6FAqJQlD
b7XflBN/irCYCXwKR1VicOQBjFaIeAAZn2U2YWLCAErCIsy8dIhfBhWb6gpkbpKO
8OwgLAB+Z8tnGn7rNR4PGWVwM7/P/zslXpyyE1K0dAB9M4h/bwGZp6KO6UEGs+Vf
5V9N/aOL75SCNQ0k8FfMOCzv/12PLFHsAVL6Gju/4hLiZVUD4XC0ZRpn7vFdheBu
Htji9VVAECQiWYclorhWHnK50r3MIy7BuG1r0kc7EYPlzZdsdWIYWrcjokBUw6E=
=ie34
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
