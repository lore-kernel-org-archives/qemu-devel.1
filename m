Received: from eggs.gnu.org ([2001:4830:134:3::10]:55158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eNKL0-0000Mk-7T
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eNKKx-0000PK-Ef
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:13:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eNKKx-0000MT-5a
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:13:15 -0500
Date: Fri, 8 Dec 2017 15:13:06 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171208151306.GC8998@stefanha-x1.localdomain>
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20171208105553.12249-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] thread-pool: convert to use lock guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 11:55:53AM +0100, Paolo Bonzini wrote:
> @@ -88,9 +88,9 @@ static void *worker_thread(void *opaque)
> =20
>          do {
>              pool->idle_threads++;
> -            qemu_mutex_unlock(&pool->lock);
> +            qemu_lock_guard_unlock(&pool_guard);
>              ret =3D qemu_sem_timedwait(&pool->sem, 10000);
> -            qemu_mutex_lock(&pool->lock);
> +            qemu_lock_guard_lock(&pool_guard);

Or:

  QEMU_WITHOUT_LOCK_GUARD(pool_guard) {
      ret =3D qemu_sem_timedwait(&pool->sem, 10000);
  }

Seems funny but I like it. :)

Unfortunately it's tricky to come up with good semantics.  A 'return'
statement inside QEMU_WITHOUT_LOCK_GUARD() should leave the lock
unlocked.  But a 'break' statement may need to reacquire the lock...

> @@ -258,12 +254,12 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPool *pool,
> =20
>      trace_thread_pool_submit(pool, req, arg);
> =20
> -    qemu_mutex_lock(&pool->lock);
> +    QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
>      if (pool->idle_threads =3D=3D 0 && pool->cur_threads < pool->max_thr=
eads) {
>          spawn_thread(pool);
>      }
>      QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
> -    qemu_mutex_unlock(&pool->lock);
> +    qemu_lock_guard_unlock(&pool_guard);

Why not QEMU_WITH_LOCK()?  Then you can get rid of the explicit unlock.

> @@ -330,7 +326,7 @@ void thread_pool_free(ThreadPool *pool)
> =20
>      assert(QLIST_EMPTY(&pool->head));
> =20
> -    qemu_mutex_lock(&pool->lock);
> +    QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
> =20
>      /* Stop new threads from spawning */
>      qemu_bh_delete(pool->new_thread_bh);
> @@ -344,7 +340,7 @@ void thread_pool_free(ThreadPool *pool)
>          qemu_cond_wait(&pool->worker_stopped, &pool->lock);
>      }
> =20
> -    qemu_mutex_unlock(&pool->lock);
> +    qemu_lock_guard_unlock(&pool_guard);

Here too.  I don't see the advantage of replacing a single lock/unlock
with QEMU_LOCK_GUARD/unlock, if it cannot be made shorter/safer then
it's fine to use QemuMutex directly.

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKqwCAAoJEJykq7OBq3PIeiQIAIjwa3WaXnURnU0EYCZP6X0X
bK8VvQ85T6ZRhhu+gOA6JJxSZDELZ7R0kxdM7eASdfHDyX4Wn92Fz8vBA8viyAhL
Qik+jsO+WRgL1ljCcAKaUkyCjJF/+GZBpCxAutsT+Q0BONemmIrLZwubCimxILiK
TaaIY4l0WHPKsg42fhFzQtAou24v6I4NTh3DnJvGjrEbNSgB/YjvV+9Pf1MqyiXl
45B/24z7e5LGJDvLmZSVLKKZbqG3K7qevUmTtZnnz4GP99DW/vJ5CiuB6/vXMriE
au2rnuKDbUsaH3Wk8mT0pvXDAoH+R6DOdzsytuNujQP/nadFL+OVTnDdA1aR0cY=
=5Sgp
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
