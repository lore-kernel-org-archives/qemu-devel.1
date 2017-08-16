Received: from eggs.gnu.org ([2001:4830:134:3::10]:56147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhv0H-0005kp-J4
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhv0E-0002A1-Ga
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:52:45 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dhv0E-00029m-6X
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:52:42 -0400
Received: by mail-wm0-x242.google.com with SMTP id y206so4160304wmd.5
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 02:52:42 -0700 (PDT)
Date: Wed, 16 Aug 2017 10:52:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170816095238.GE3180@stefanha-x1.localdomain>
References: <1502782095-3912-1-git-send-email-wang.yong155@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <1502782095-3912-1-git-send-email-wang.yong155@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-iothread: IOThread supports the
 GMainContext event loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang yong <wang.yong155@zte.com.cn>
Cc: pbonzini@redhat.com, stefanha@redhat.com, famz@redhat.com, jasowang@redhat.com, zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com, wang.guang55@zte.com.cn, qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 03:28:15PM +0800, Wang yong wrote:
> From: Wang Yong <wang.yong155@zte.com.cn>
>=20
> IOThread uses AioContext event loop and does not run a GMainContext.
> Therefore,chardev cannot work in IOThread,such as the chardev is
> used for colo-compare packets reception.
>=20
> This patch makes the IOThread run the GMainContext event loop,
> chardev and IOThread can work together.
>=20
> Signed-off-by: Wang Yong<wang.yong155@zte.com.cn>
> Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>

There is usually a space between the name and email address.  Tools and
humans searching git log might not find you if you format the S-o-b line
without a space.

> ---
>  include/sysemu/iothread.h | 10 +++++++++
>  iothread.c                | 54 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 64 insertions(+)
>=20
> diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
> index e6da1a4..89e913c 100644
> --- a/include/sysemu/iothread.h
> +++ b/include/sysemu/iothread.h
> @@ -20,10 +20,19 @@
>  #define TYPE_IOTHREAD "iothread"
> =20
>  typedef struct {
> +    GMainContext *worker_context;
> +    GMainLoop *main_loop;
> +    GOnce once;
> +
> +    QEMUBH *bh;
> +} GMainOnce;

Please do not use the glib namespace (G*, g_*) because it's easy to
confuse GMainOnce with glib APIs like GOnce.

I suggest inlining these fields in IOThread instead of defining a new
struct.

> +
> +typedef struct {
>      Object parent_obj;
> =20
>      QemuThread thread;
>      AioContext *ctx;
> +    GMainOnce thread_gonce;
>      QemuMutex init_done_lock;
>      QemuCond init_done_cond;    /* is thread initialization done? */
>      bool stopping;
> @@ -41,5 +50,6 @@ typedef struct {
>  char *iothread_get_id(IOThread *iothread);
>  AioContext *iothread_get_aio_context(IOThread *iothread);
>  void iothread_stop_all(void);
> +GMainContext *iothread_get_g_main_context(IOThread *iothread);
> =20
>  #endif /* IOTHREAD_H */
> diff --git a/iothread.c b/iothread.c
> index beeb870..9995eb0 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -72,6 +72,9 @@ static int iothread_stop(Object *object, void *opaque)
>          return 0;
>      }
>      iothread->stopping =3D true;
> +    if (iothread->thread_gonce.main_loop) {
> +        g_main_loop_quit(iothread->thread_gonce.main_loop);
> +    }
>      aio_notify(iothread->ctx);
>      qemu_thread_join(&iothread->thread);
>      return 0;
> @@ -125,6 +128,7 @@ static void iothread_complete(UserCreatable *obj, Err=
or **errp)
> =20
>      qemu_mutex_init(&iothread->init_done_lock);
>      qemu_cond_init(&iothread->init_done_cond);
> +    iothread->thread_gonce.once =3D (GOnce) G_ONCE_INIT;
> =20
>      /* This assumes we are called from a thread with useful CPU affinity=
 for us
>       * to inherit.
> @@ -309,3 +313,53 @@ void iothread_stop_all(void)
> =20
>      object_child_foreach(container, iothread_stop, NULL);
>  }
> +
> +static void iothread_g_main_context_bh(void *opaque)
> +{
> +    GMainOnce *g =3D opaque;
> +
> +    qemu_bh_delete(g->bh);
> +    g->bh =3D NULL;
> +
> +    g_main_context_push_thread_default(g->worker_context);
> +
> +    g->main_loop =3D g_main_loop_new(g->worker_context, TRUE);
> +    g_main_loop_run(g->main_loop);

Running the glib main loop from a BH function means deleted BHs can
never be freed in aio-posix.c:aio_bh_poll():

  if (qemu_lockcnt_dec_if_lock(&ctx->list_lock)) {
      bhp =3D &ctx->first_bh;
      while (*bhp) {
          bh =3D *bhp;
          if (bh->deleted && !bh->scheduled) {
              *bhp =3D bh->next;
              g_free(bh);
          } else {
              bhp =3D &bh->next;
          }
      }
      qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
  }

ctx->list_lock is held by iothread_run() -> aio_poll() so
qemu_lockcnt_dec_if_lock() always returns false.

Instead of running the glib event loop inside aio_poll() I would modify
iothread_run():

    while (!atomic_read(&iothread->stopping)) {
	if (atomic_read(&iothread->use_glib_event_loop)) {
	    iothread_glib_event_loop();
	    break;
        }

        aio_poll(iothread->ctx, true);
    }

> +
> +    g_main_loop_unref(g->main_loop);
> +    g->main_loop =3D NULL;
> +
> +    g_main_context_pop_thread_default(g->worker_context);
> +    g_main_context_unref(g->worker_context);
> +    g->worker_context =3D NULL;
> +}
> +
> +static gpointer iothread_g_main_context_init(gpointer g_data)
> +{
> +    AioContext *ctx;
> +    IOThread *iothread =3D (IOThread *)g_data;

No cast is necessary from void * to another pointer type in C.  Please
remove the cast.

> +    GMainOnce *g =3D &iothread->thread_gonce;
> +    GSource *source;
> +
> +    g->worker_context =3D g_main_context_new();
> +
> +    ctx =3D iothread_get_aio_context(iothread);
> +    source =3D aio_get_g_source(ctx);
> +    g_source_attach(source, g->worker_context);
> +    g_source_unref(source);
> +
> +    g->bh =3D aio_bh_new(ctx,
> +                       iothread_g_main_context_bh, g);
> +    qemu_bh_schedule(g->bh);
> +
> +    return (gpointer) g->worker_context;

No cast is necessary from a pointer type to void * in C.  Please remove
the cast.

> +}
> +
> +GMainContext *iothread_get_g_main_context(IOThread *iothread)
> +{
> +    GMainOnce *g =3D &iothread->thread_gonce;
> +
> +    g_once(&g->once, iothread_g_main_context_init, iothread);
> +
> +    return (GMainContext *) g->once.retval;

No cast is necessary from a pointer type to void * in C.  Please remove
the cast.

A dangling pointer is returned if this this function is called after
iothread_g_main_context_bh() has terminated.  It would be safer to
return g->worker_context instead of g->once.retval.

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZlBXmAAoJEJykq7OBq3PI118IALj2M6H5QtD8RaKH5vbyg40b
XCtFegen3T5bXw53wpGEjkP6rvF46sLPLZEkFmckxZ3bSD2ECqojI4je8jXw2KES
/weMWVY5PoqahKb7xkB3/XKsPFUCNbYUpFMAfWLP91RAdxFTcU7EZE+aMzphAaXw
DkNjmaNJ7KQ/vhp6Zb7cBtd+ThioUBUkxRD/Q4jrfyrBnUydHP1HTiCrxyYsPMDT
Z4Epnb2w0IG0SQOfMEbfghJPNP2pSOYK7sut4SwTtiFhcNPaCr5MvcP9wRtxr6nx
QbAdsdYZFTfdpzITNy83kwlNQSrIUMgJui74lVGBO/HgDlMSnY4Rl58yjDCkRH0=
=tIGi
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
