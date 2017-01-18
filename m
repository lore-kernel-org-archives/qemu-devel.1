Received: from eggs.gnu.org ([2001:4830:134:3::10]:45716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTrXj-0005pS-Bj
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:48:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTrXh-00050q-7P
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:48:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTrXg-00050Y-V9
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:48:53 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13E2945DCF
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:48:53 +0000 (UTC)
Date: Wed, 18 Jan 2017 14:48:49 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118144849.GE30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-6-pbonzini@redhat.com>
	<20170116113824.GD14226@lemon.Home>
	<20170116125559.GH13096@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline
In-Reply-To: <20170116125559.GH13096@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/16] io: make qio_channel_yield aware of
 AioContexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2017 at 12:55:59PM +0000, Daniel P. Berrange wrote:
> On Mon, Jan 16, 2017 at 07:38:24PM +0800, Fam Zheng wrote:
> > On Fri, 01/13 14:17, Paolo Bonzini wrote:
> > > Support separate coroutines for reading and writing, and place the
> > > read/write handlers on the AioContext that the QIOChannel is register=
ed
> > > with.
> > >=20
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  include/io/channel.h   | 37 ++++++++++++++++++----
> > >  io/channel.c           | 86 ++++++++++++++++++++++++++++++++++++++--=
----------
> > >  tests/Makefile.include |  2 +-
> > >  3 files changed, 96 insertions(+), 29 deletions(-)
> > >=20
> > > diff --git a/include/io/channel.h b/include/io/channel.h
> > > index 665edd7..d7bad94 100644
> > > --- a/include/io/channel.h
> > > +++ b/include/io/channel.h
> > > @@ -23,6 +23,7 @@
> > > =20
> > >  #include "qemu-common.h"
> > >  #include "qom/object.h"
> > > +#include "qemu/coroutine.h"
> > >  #include "block/aio.h"
> > > =20
> > >  #define TYPE_QIO_CHANNEL "qio-channel"
> > > @@ -59,8 +60,6 @@ typedef gboolean (*QIOChannelFunc)(QIOChannel *ioc,
> > >                                     GIOCondition condition,
> > >                                     gpointer data);
> > > =20
> > > -typedef struct QIOChannelRestart QIOChannelRestart;
> > > -
> > >  /**
> > >   * QIOChannel:
> > >   *
> > > @@ -84,8 +83,8 @@ struct QIOChannel {
> > >      unsigned int features; /* bitmask of QIOChannelFeatures */
> > >      char *name;
> > >      AioContext *ctx;
> > > -    QIOChannelRestart *read_coroutine;
> > > -    QIOChannelRestart *write_coroutine;
> > > +    Coroutine *read_coroutine;
> > > +    Coroutine *write_coroutine;
> > >  #ifdef _WIN32
> > >      HANDLE event; /* For use with GSource on Win32 */
> > >  #endif
> > > @@ -508,13 +507,37 @@ guint qio_channel_add_watch(QIOChannel *ioc,
> > > =20
> > > =20
> > >  /**
> > > + * qio_channel_set_aio_context:
> > > + * @ioc: the channel object
> > > + * @ctx: the #AioContext to set the handlers on
> > > + *
> > > + * Request that qio_channel_yield() sets I/O handlers on
> > > + * the given #AioContext.  If @ctx is %NULL, qio_channel_yield()
> > > + * uses QEMU's main thread event loop.
> > > + */
> > > +void qio_channel_set_aio_context(QIOChannel *ioc,
> > > +                                 AioContext *ctx);
> > > +
> > > +/**
> > > + * qio_channel_detach_aio_context:
> > > + * @ioc: the channel object
> > > + *
> > > + * Disable any I/O handlers set by qio_channel_yield().  With the
> > > + * help of aio_co_schedule(), this allows moving a coroutine that was
> > > + * paused by qio_channel_yield() to another context.
> > > + */
> > > +void qio_channel_detach_aio_context(QIOChannel *ioc);
> > > +
> > > +/**
> > >   * qio_channel_yield:
> > >   * @ioc: the channel object
> > >   * @condition: the I/O condition to wait for
> > >   *
> > > - * Yields execution from the current coroutine until
> > > - * the condition indicated by @condition becomes
> > > - * available.
> > > + * Yields execution from the current coroutine until the condition
> > > + * indicated by @condition becomes available.  @condition must
> > > + * be either %G_IO_IN or %G_IO_OUT; it cannot contain both.  In
> > > + * addition, no two coroutine can be waiting on the same condition
> > > + * and channel at the same time.
> > >   *
> > >   * This must only be called from coroutine context
> > >   */
> > > diff --git a/io/channel.c b/io/channel.c
> > > index ce470d7..1e043bf 100644
> > > --- a/io/channel.c
> > > +++ b/io/channel.c
> > > @@ -21,7 +21,7 @@
> > >  #include "qemu/osdep.h"
> > >  #include "io/channel.h"
> > >  #include "qapi/error.h"
> > > -#include "qemu/coroutine.h"
> > > +#include "qemu/main-loop.h"
> > > =20
> > >  bool qio_channel_has_feature(QIOChannel *ioc,
> > >                               QIOChannelFeature feature)
> > > @@ -238,36 +238,80 @@ off_t qio_channel_io_seek(QIOChannel *ioc,
> > >  }
> > > =20
> > > =20
> > > -typedef struct QIOChannelYieldData QIOChannelYieldData;
> > > -struct QIOChannelYieldData {
> > > -    QIOChannel *ioc;
> > > -    Coroutine *co;
> > > -};
> > > +static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc);
> > > +
> > > +static void qio_channel_restart_read(void *opaque)
> > > +{
> > > +    QIOChannel *ioc =3D opaque;
> > > +    Coroutine *co =3D ioc->read_coroutine;
> > > =20
> > > +    ioc->read_coroutine =3D NULL;
> > > +    qio_channel_set_aio_fd_handlers(ioc);
> > > +    aio_co_wake(co);
> > > +}
> > > =20
> > > -static gboolean qio_channel_yield_enter(QIOChannel *ioc,
> > > -                                        GIOCondition condition,
> > > -                                        gpointer opaque)
> > > +static void qio_channel_restart_write(void *opaque)
> > >  {
> > > -    QIOChannelYieldData *data =3D opaque;
> > > -    qemu_coroutine_enter(data->co);
> > > -    return FALSE;
> > > +    QIOChannel *ioc =3D opaque;
> > > +    Coroutine *co =3D ioc->write_coroutine;
> > > +
> > > +    ioc->write_coroutine =3D NULL;
> > > +    qio_channel_set_aio_fd_handlers(ioc);
> > > +    aio_co_wake(co);
> > >  }
> > > =20
> > > +static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc)
> > > +{
> > > +    IOHandler *rd_handler =3D NULL, *wr_handler =3D NULL;
> > > +    AioContext *ctx;
> > > +
> > > +    if (ioc->read_coroutine) {
> > > +	rd_handler =3D qio_channel_restart_read;
> >=20
> > s/\t/        /
> >=20
> > > +    }
> > > +    if (ioc->write_coroutine) {
> > > +	rd_handler =3D qio_channel_restart_write;
> >=20
> > s/\t/        /
> >=20
> > > +    }
> > > +
> > > +    ctx =3D ioc->ctx ? ioc->ctx : iohandler_get_aio_context();
> > > +    qio_channel_set_aio_fd_handler(ioc, ctx, rd_handler, wr_handler,=
 ioc);
> > > +}
> > > +
> > > +void qio_channel_set_aio_context(QIOChannel *ioc,
> > > +                                 AioContext *ctx)
> > > +{
> > > +    AioContext *old_ctx;
> > > +    if (ioc->ctx =3D=3D ctx) {
> > > +        return;
> > > +    }
> > > +
> > > +    old_ctx =3D ioc->ctx ? ioc->ctx : iohandler_get_aio_context();
> > > +    qio_channel_set_aio_fd_handler(ioc, old_ctx, NULL, NULL, NULL);
> > > +    ioc->ctx =3D ctx;
> > > +    qio_channel_set_aio_fd_handlers(ioc);
> > > +}
> > > +
> > > +void qio_channel_detach_aio_context(QIOChannel *ioc)
> > > +{
> > > +    ioc->read_coroutine =3D NULL;
> > > +    ioc->write_coroutine =3D NULL;
> > > +    qio_channel_set_aio_fd_handlers(ioc);
> >=20
> > Why is qio_channel_set_aio_fd_handler not needed here?
> >=20
> > > +    ioc->ctx =3D NULL;
> > > +}
> > > =20
> > >  void coroutine_fn qio_channel_yield(QIOChannel *ioc,
> > >                                      GIOCondition condition)
> > >  {
> > > -    QIOChannelYieldData data;
> > > -
> > >      assert(qemu_in_coroutine());
> > > -    data.ioc =3D ioc;
> > > -    data.co =3D qemu_coroutine_self();
> > > -    qio_channel_add_watch(ioc,
> > > -                          condition,
> > > -                          qio_channel_yield_enter,
> > > -                          &data,
> > > -                          NULL);
> > > +    if (condition =3D=3D G_IO_IN) {
> > > +        assert(!ioc->read_coroutine);
> > > +        ioc->read_coroutine =3D qemu_coroutine_self();
> > > +    } else if (condition =3D=3D G_IO_OUT) {
> > > +        assert(!ioc->write_coroutine);
> > > +        ioc->write_coroutine =3D qemu_coroutine_self();
> > > +    } else {
> > > +        abort();
> > > +    }
> > > +    qio_channel_set_aio_fd_handlers(ioc);
> > >      qemu_coroutine_yield();
> > >  }
> > > =20
> > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > index 3b8ed9d..7d11bbb 100644
> > > --- a/tests/Makefile.include
> > > +++ b/tests/Makefile.include
> > > @@ -493,7 +493,7 @@ tests/check-qjson$(EXESUF): tests/check-qjson.o $=
(test-util-obj-y)
> > >  tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(te=
st-qom-obj-y)
> > >  tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test=
-qom-obj-y)
> > > =20
> > > -tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o=
 $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y)
> > > +tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o=
 $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y) $(test-block-obj-y)
> >=20
> > I guess this is a hint for moving coroutine code into a lower level lib=
rary like
> > util.
>=20
> The coroutine code is already in util/, so I'm assuming this is actually
> for the AioContext stuff. Yes, though, AioContext ought to be moved into
> util/ as part of this series IMHO, since the io/ channel code shouldn't
> have a dependancy on block/ layer.

That makes sense to me.  I think the move is overdue since coroutines
are widely useful outside the block layer and aren't specific to block
I/O.

Stefan

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf4BRAAoJEJykq7OBq3PIXGwIAJZ+Rh4swepWRUP/tf5vbU4G
cNj9EdQN8uX293+DNhEtws7jFsby0IfYCnMjP1loFXpoJQWqRaPIh3Bn7ggOIbEQ
JSMZaKYUHxViT28SLMTkEdiBUKLZOydI0Z4BZcl6gOGw0y+VYdsxt+BOgFQ+Bt7w
Z3ucIahSjdtwW6j9Xdb7VjI7HTUSGqd80XUbg4KB7tQLI0bY13MQrQFRroIgwN28
337//tCmSIg0BTWgsMX3FiwfR/IgAMMeGMooHpFNA3JgikCLdvt2pahcMKLD3on1
GhoJMfmAENEkvNeg9r5uftlMZwEy0apytxY6Q158+9APuFsavkx/4u68toEeG3w=
=J469
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--
