Received: from eggs.gnu.org ([2001:4830:134:3::10]:59011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9SE-00062b-QQ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9S5-00034C-0A
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:26:34 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:43385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eg9S4-00033D-Lw
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:26:24 -0500
Received: by mail-wr0-x233.google.com with SMTP id t16so7189196wrc.10
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 05:26:24 -0800 (PST)
Date: Mon, 29 Jan 2018 13:26:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129132621.GD20446@stefanha-x1.localdomain>
References: <20180125175949.7780-1-pbonzini@redhat.com>
	<20180125175949.7780-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <20180125175949.7780-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] coroutine-lock: make
 qemu_co_enter_next thread-safe
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


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 06:59:48PM +0100, Paolo Bonzini wrote:
> qemu_co_queue_next does not need to release and re-acquire the mutex,
> because the queued coroutine does not run immediately.  However, this
> does not hold for qemu_co_enter_next.  Now that qemu_co_queue_wait
> can synchronize (via QemuLockable) with code that is not running in
> coroutine context, it's important that code using qemu_co_enter_next
> can easily use a standardized locking idiom.
>=20
> First of all, qemu_co_enter_next must use aio_co_wake to restart the
> coroutine.  Second, the function gains a second argument, a QemuLockable*,
> and the comments of qemu_co_queue_next and qemu_co_queue_restart_all
> are adjusted to clarify the difference.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  fsdev/qemu-fsdev-throttle.c |  4 ++--
>  include/qemu/coroutine.h    | 15 ++++++++++-----
>  util/qemu-coroutine-lock.c  | 10 ++++++++--
>  3 files changed, 20 insertions(+), 9 deletions(-)
>=20
> diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
> index 49eebb5412..1dc07fbc12 100644
> --- a/fsdev/qemu-fsdev-throttle.c
> +++ b/fsdev/qemu-fsdev-throttle.c
> @@ -20,13 +20,13 @@
>  static void fsdev_throttle_read_timer_cb(void *opaque)
>  {
>      FsThrottle *fst =3D opaque;
> -    qemu_co_enter_next(&fst->throttled_reqs[false]);
> +    qemu_co_enter_next(&fst->throttled_reqs[false], NULL);
>  }
> =20
>  static void fsdev_throttle_write_timer_cb(void *opaque)
>  {
>      FsThrottle *fst =3D opaque;
> -    qemu_co_enter_next(&fst->throttled_reqs[true]);
> +    qemu_co_enter_next(&fst->throttled_reqs[true], NULL);
>  }
> =20
>  void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **=
errp)
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index 1e5f0957e6..6fdbc837c0 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -188,21 +188,26 @@ void qemu_co_queue_init(CoQueue *queue);
>  void coroutine_fn qemu_co_queue_wait_impl(CoQueue *queue, QemuLockable *=
lock);
> =20
>  /**
> - * Restarts the next coroutine in the CoQueue and removes it from the qu=
eue.
> + * Removes the next coroutine from the CoQueue; it will run as soon as t=
he
> + * current one yields.
>   *
> - * Returns true if a coroutine was restarted, false if the queue is empt=
y.
> + * Returns true if a coroutine was removed, false if the queue is empty.
>   */
>  bool coroutine_fn qemu_co_queue_next(CoQueue *queue);
> =20
>  /**
> - * Restarts all coroutines in the CoQueue and leaves the queue empty.
> + * Empties the CoQueue; all coroutines in it will run in FIFO orer as so=
on
> + * as the current one yields.
>   */
>  void coroutine_fn qemu_co_queue_restart_all(CoQueue *queue);
> =20
>  /**
> - * Enter the next coroutine in the queue
> + * Immediately enter the next coroutine in the queue.  Release the mutex
> + * while it runs.

s/mutex/lock/

Is this doc comment correct?  I see multiple cases due to aio_co_wake():

1. Called from coroutine context with current AioContext matching next
   coroutine's AioContext: arrange for next coroutine to be entered
   *after* we yield (not "immediately").

2. Called from non-coroutine context with current AioContext matching
   next coroutine's AioContext: immediately enter next coroutine.

3. Called from different AioContext than next coroutine: arrange for
   next coroutine to be entered at some point.

>   */
> -bool qemu_co_enter_next(CoQueue *queue);
> +#define qemu_co_enter_next(queue, lock) \
> +    qemu_co_enter_next_impl(queue, QEMU_MAKE_LOCKABLE(lock))
> +bool qemu_co_enter_next_impl(CoQueue *queue, QemuLockable *lock);
> =20
>  /**
>   * Checks if the CoQueue is empty.
> diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
> index 2a66fc1467..78fb79acf8 100644
> --- a/util/qemu-coroutine-lock.c
> +++ b/util/qemu-coroutine-lock.c
> @@ -132,7 +132,7 @@ void coroutine_fn qemu_co_queue_restart_all(CoQueue *=
queue)
>      qemu_co_queue_do_restart(queue, false);
>  }
> =20
> -bool qemu_co_enter_next(CoQueue *queue)
> +bool qemu_co_enter_next_impl(CoQueue *queue, QemuLockable *lock)
>  {
>      Coroutine *next;
> =20
> @@ -142,7 +142,13 @@ bool qemu_co_enter_next(CoQueue *queue)
>      }
> =20
>      QSIMPLEQ_REMOVE_HEAD(&queue->entries, co_queue_next);
> -    qemu_coroutine_enter(next);
> +    if (lock) {
> +        qemu_lockable_unlock(lock);
> +    }
> +    aio_co_wake(next);
> +    if (lock) {
> +        qemu_lockable_lock(lock);
> +    }
>      return true;
>  }
> =20
> --=20
> 2.14.3
>=20
>=20
>=20

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJabyD9AAoJEJykq7OBq3PI6zwIAKkoBmAyJhWHxUNwU1SO8Pjl
Q/xCa71oqOUQBAWpaqxM20KEXYp3KAkHXrNtkVqrx+sTgqtoaDR+c3sVGDdVIUyB
g3+fcMMmjJEssYRLGNYsWCOQimyPmwWM6m5m/DDfqVf6bTgcqlC+e1I6NmM85urW
KxtnxOL3L+ZWlXk7Wx9FWV8HCFblsFF/rTZgyWXb2+BIvVmW8kTtwzwrviRcUQFb
eQoTazHv9Nr2pCA4kFmEAn8YXIHXW3dNi3yctJuUL/AcDdJANKqAFZQc5mJwGLVm
N4UYakErMh7zOD43SlaXqu6W+PLq59rK90GYxJBdT9YmKR8K6aqdw/imL8amQIA=
=AquV
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
