Received: from eggs.gnu.org ([2001:4830:134:3::10]:47254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6GnW-0003Ch-82
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6GnT-0003HS-25
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:27:58 -0400
Date: Thu, 4 May 2017 14:27:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504132750.GM32376@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g6DVDhPhk1bqxDrC"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 07/17] throttle-groups: do not
 use qemu_co_enter_next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--g6DVDhPhk1bqxDrC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 02:00:48PM +0200, Paolo Bonzini wrote:
> Prepare for removing this function; always restart throttled requests
> from coroutine context.  This will matter when restarting throttled
> requests will have to acquire a CoMutex.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/throttle-groups.c | 65 +++++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 58 insertions(+), 7 deletions(-)

I don't understand this patch :(.

> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 69bfbd4..d66bf62 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -260,6 +260,18 @@ static bool throttle_group_schedule_timer(BlockBacke=
nd *blk, bool is_write)
>      return must_wait;
>  }
> =20
> +/* Start the next pending I/O request for a BlockBackend.
> + *
> + * @blk:       the current BlockBackend
> + * @is_write:  the type of operation (read/write)

The return value is undocumented.

> + */
> +static bool throttle_group_co_restart_queue(BlockBackend *blk, bool is_w=
rite)

This function calls qemu_co_queue_next(), which has coroutine_fn, so
this function must also be marked coroutine_fn.

> +{
> +    BlockBackendPublic *blkp =3D blk_get_public(blk);
> +
> +    return qemu_co_queue_next(&blkp->throttled_reqs[is_write]);
> +}
> +
>  /* Look for the next pending I/O request and schedule it.
>   *
>   * This assumes that tg->lock is held.
> @@ -287,7 +299,7 @@ static void schedule_next_request(BlockBackend *blk, =
bool is_write)
>      if (!must_wait) {
>          /* Give preference to requests from the current blk */
>          if (qemu_in_coroutine() &&
> -            qemu_co_queue_next(&blkp->throttled_reqs[is_write])) {
> +            throttle_group_co_restart_queue(blk, is_write)) {
>              token =3D blk;
>          } else {
>              ThrottleTimers *tt =3D &blk_get_public(token)->throttle_time=
rs;
> @@ -340,18 +352,57 @@ void coroutine_fn throttle_group_co_io_limits_inter=
cept(BlockBackend *blk,
>      qemu_mutex_unlock(&tg->lock);
>  }
> =20
> -void throttle_group_restart_blk(BlockBackend *blk)
> +typedef struct {
> +    BlockBackend *blk;
> +    bool is_write;
> +    int ret;

s/ret/bool/

> +} RestartData;
> +
> +static void throttle_group_restart_queue_entry(void *opaque)

This is a coroutine entry function, it must be marked coroutine_fn.

>  {
> -    BlockBackendPublic *blkp =3D blk_get_public(blk);
> +    RestartData *data =3D opaque;
> +
> +    data->ret =3D throttle_group_co_restart_queue(data->blk, data->is_wr=
ite);
> +}
> +
> +static int throttle_group_restart_queue(BlockBackend *blk, bool is_write)

s/int/bool/

> +{
> +    Coroutine *co;
> +    RestartData rd =3D {
> +        .blk =3D blk,
> +        .is_write =3D is_write
> +    };
> +
> +    aio_context_acquire(blk_get_aio_context(blk));
> +    co =3D qemu_coroutine_create(throttle_group_restart_queue_entry, &rd=
);
> +    /* The request doesn't start until after throttle_group_restart_queu=
e_entry
> +     * returns, so the coroutine cannot yield.
> +     */

I don't understand this sentence.

This function assumes that throttle_group_restart_queue_entry(),
throttle_group_co_restart_queue(), and qemu_co_queue_next() do not
yield.  Making these assumptions is fragile :(.

But how does that relate to "the request doesn't start until after
throttle_group_restart_queue_entry returns"?

> +    qemu_coroutine_enter(co);
> +    aio_context_release(blk_get_aio_context(blk));
> +    return rd.ret;
> +}
> +
> +static void throttle_group_restart_blk_entry(void *opaque)

This is a coroutine entry function so it must be marked coroutine_fn.

> +{
> +    BlockBackend *blk =3D opaque;
>      int i;
> =20
>      for (i =3D 0; i < 2; i++) {
> -        while (qemu_co_enter_next(&blkp->throttled_reqs[i])) {
> +        while (throttle_group_co_restart_queue(blk, i)) {
>              ;
>          }
>      }

Why is the throttle_group_restart_blk_entry() coroutine necessary?
throttle_group_co_restart_queue() already spawns a coroutine which is
used for queuing.  I think this function could be a non-coroutine
function.

>  }
> =20
> +void throttle_group_restart_blk(BlockBackend *blk)
> +{
> +    Coroutine *co;
> +
> +    co =3D qemu_coroutine_create(throttle_group_restart_blk_entry, blk);
> +    qemu_coroutine_enter(co);
> +}
> +
>  /* Update the throttle configuration for a particular group. Similar
>   * to throttle_config(), but guarantees atomicity within the
>   * throttling group.
> @@ -376,8 +427,8 @@ void throttle_group_config(BlockBackend *blk, Throttl=
eConfig *cfg)
>      throttle_config(ts, tt, cfg);
>      qemu_mutex_unlock(&tg->lock);
> =20
> -    qemu_co_enter_next(&blkp->throttled_reqs[0]);
> -    qemu_co_enter_next(&blkp->throttled_reqs[1]);
> +    throttle_group_restart_queue(blk, 0);
> +    throttle_group_restart_queue(blk, 1);
>  }
> =20
>  /* Get the throttle configuration from a particular group. Similar to
> @@ -417,7 +468,7 @@ static void timer_cb(BlockBackend *blk, bool is_write)
> =20
>      /* Run the request that was waiting for this timer */
>      aio_context_acquire(blk_get_aio_context(blk));
> -    empty_queue =3D !qemu_co_enter_next(&blkp->throttled_reqs[is_write]);
> +    empty_queue =3D !throttle_group_restart_queue(blk, is_write);
>      aio_context_release(blk_get_aio_context(blk));
> =20
>      /* If the request queue was empty then we have to take care of
> --=20
> 2.9.3
>=20
>=20
>=20

--g6DVDhPhk1bqxDrC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCyxWAAoJEJykq7OBq3PIUIIIAMP6aN3LWWXfQQFmfBBzH5PJ
rYX64wPdohp3vzJ7Zu8/GqNPX+KobOtDC7Bkbp04aTczrnC1/bZWEBhJciPK4Y8Y
omy2zpg58HaHqCg7sZHMYE3mUI5RC5ikrnbmlvuQWSBUoty3YJ41KPeWFtjN4npF
b4quS3iyyB44slCKQSUwp11oTERJxQ2F566xlPeXaBLIrrWqbmdV0efs+6Xo8yce
UoGmHqELJChrSM4mpUCpRuoFSbaor5vBTQMZRZ6Vt+TM28DvgmulbWX1ZVD3cK+s
3J/yRFEAEVmaV0fYLfk/XpLDB6sI36KmjKbEJjf7u67YExFL50JWfYWcXqoYQG8=
=D2CP
-----END PGP SIGNATURE-----

--g6DVDhPhk1bqxDrC--
