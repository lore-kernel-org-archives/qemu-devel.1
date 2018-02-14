Received: from eggs.gnu.org ([2001:4830:134:3::10]:57392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1elxiI-0004yL-CN
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1elxiD-0002dU-DY
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:07:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1elxiD-0002dA-4Z
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:07:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E41E9EB6F9
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 14:06:52 +0000 (UTC)
Date: Wed, 14 Feb 2018 14:06:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180214140647.GC7545@stefanha-x1.localdomain>
References: <20180213142102.14450-1-stefanha@redhat.com>
	<20180213142102.14450-2-stefanha@redhat.com>
	<73eb771d-ddcd-42e6-5895-23e6024ccc80@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <73eb771d-ddcd-42e6-5895-23e6024ccc80@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block: extract AIO_WAIT_WHILE()
 from BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 10:01:06AM -0600, Eric Blake wrote:
> Trying to understand here:
>=20
>=20
> > +#define AIO_WAIT_WHILE(wait, ctx, cond) ({                  \
> > +    bool waited_ =3D false;                                   \
> > +    bool busy_ =3D true;                                      \
> > +    AioWait *wait_ =3D (wait);                                \
> > +    AioContext *ctx_ =3D (ctx);                               \
> > +    if (aio_context_in_iothread(ctx_)) {                    \
> > +        while ((cond) || busy_) {                           \
> > +            busy_ =3D aio_poll(ctx_, (cond));                 \
> > +            waited_ |=3D !!(cond) | busy_;                    \
> > +        }                                                   \
>=20
> If we are in an iothread already, we never dereference wait,

No, the name and documentation for aio_context_in_iothread() is
misleading.  It actually means "does this AioContext belong to the
current thread?", which is more general than just the IOThread case.

aio_context_in_iothread() returns true when:
1. We are the IOThread that owns ctx. <-- the case you thought of
2. We are the main loop and ctx =3D=3D qemu_get_aio_context().
   ^--- the sneaky case that BDRV_POLL_WHILE() has always relied on

> > +    } else {                                                \
> > +        assert(qemu_get_current_aio_context() =3D=3D            \
> > +               qemu_get_aio_context());                     \
> > +        assert(!wait_->need_kick);                          \
>=20
> but if we are in the main loop, wait must be non-NULL.

The else statement only handles the case where the main loop is waiting
for an IOThread AioContext.

s/in the main loop/in the main loop and ctx is an IOThread AioContext/

>=20
> > +++ b/include/block/block.h
> > @@ -2,6 +2,7 @@
> >   #define BLOCK_H
> >   #include "block/aio.h"
> > +#include "block/aio-wait.h"
> >   #include "qapi-types.h"
> >   #include "qemu/iov.h"
> >   #include "qemu/coroutine.h"
> > @@ -367,41 +368,14 @@ void bdrv_drain_all_begin(void);
> >   void bdrv_drain_all_end(void);
> >   void bdrv_drain_all(void);
> > +/* Returns NULL when bs =3D=3D NULL */
> > +AioWait *bdrv_get_aio_wait(BlockDriverState *bs);
>=20
> This can return NULL, so it is only ever safe to use in an iothread; beca=
use
> if it is used in the main loop,...
>=20
> > +
> >   #define BDRV_POLL_WHILE(bs, cond) ({                       \
>=20
> > +    AIO_WAIT_WHILE(bdrv_get_aio_wait(bs_),                 \
> > +                   bdrv_get_aio_context(bs_),              \
> > +                   cond); })
>=20
> ...we can pass NULL as the wait parameter, which will crash.

It won't crash since if (aio_context_in_iothread(ctx_)) will take the true
case when bs_ =3D=3D NULL.

> > +++ b/block/io.c
>=20
> >   void bdrv_wakeup(BlockDriverState *bs)
> >   {
> > -    /* The barrier (or an atomic op) is in the caller.  */
> > -    if (atomic_read(&bs->wakeup)) {
> > -        aio_bh_schedule_oneshot(qemu_get_aio_context(), dummy_bh_cb, N=
ULL);
> > -    }
> > +    aio_wait_kick(bdrv_get_aio_wait(bs));
>=20
> this is another case where passing NULL...

bdrv_wakeup() is only called when bs !=3D NULL.

I hope this explains things!  The main issue that raised these questions
was that aio_context_in_iothread() has a misleading name.  Shall we
rename it?

I'm having a hard time picking a new name because it must not be
confused with AioContext acquire/release, which doesn't influence the
"native" AioContext that the current thread has an affinity with.

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJahEJ3AAoJEJykq7OBq3PIOEEH/21MwZK7gTO7St3rmfVaZeRW
5y4wBR2PH6Hz4di9HbMJB1L12cy+JX6fe/4HpPlivyNKQvQwseo5pS4m4cQeb35R
9btNZIEb7kG+l/0UeEAuXtpdrkrwUMTA4JUKepT2tIiXJdMvVnsL1AmvBL3MvIGb
RX/BISiJpB8VQYqFBgXdhvg1Vwjok2tpuwWxdlD9YiAirVpgNUJ8qPJ8ZqR3kk0r
97biW5HGZumzfkKGWtWNQ0i8xAxn4Qqf0hi5coedGPGc6igSIcvZ+IdRKrLAfN6M
sJTWmFGTIIo3e90toihBOb6m8w/bw4a+1aRbmPCUMGBviB6skaMvlqZ1yiAKa58=
=OMMS
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
