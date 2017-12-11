Received: from eggs.gnu.org ([2001:4830:134:3::10]:37101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOLEv-00079x-6x
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:23:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOLEr-0000sO-7v
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:23:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eOLEq-0000rN-VQ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:23:09 -0500
Date: Mon, 11 Dec 2017 10:23:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171211102304.GC13593@stefanha-x1.localdomain>
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-6-pbonzini@redhat.com>
	<20171208151306.GC8998@stefanha-x1.localdomain>
	<9c90d2b3-242e-5ffc-3e48-cf05e6fe85c3@redhat.com>
	<a53f2cc7-9da4-bd8e-4d0b-bb3c32c9d4a9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <a53f2cc7-9da4-bd8e-4d0b-bb3c32c9d4a9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] thread-pool: convert to use lock guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 02:02:32PM -0600, Eric Blake wrote:
> On 12/08/2017 12:12 PM, Paolo Bonzini wrote:
> > On 08/12/2017 16:13, Stefan Hajnoczi wrote:
> >>> -    qemu_mutex_lock(&pool->lock);
> >>> +    QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
> >>>      if (pool->idle_threads =3D=3D 0 && pool->cur_threads < pool->max=
_threads) {
> >>>          spawn_thread(pool);
> >>>      }
> >>>      QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
> >>> -    qemu_mutex_unlock(&pool->lock);
> >>> +    qemu_lock_guard_unlock(&pool_guard);
> >> Why not QEMU_WITH_LOCK()?  Then you can get rid of the explicit unlock.
> >=20
> > I agree that QEMU_WITH_LOCK_GUARD is better in this case. (IIRC I wrote
> > this patch before coming up with the is_taken trick!).
> >=20
> > My main question for the series is what you think the balance should be
> > between a more widely applicable API and a simpler one.
>=20
> If you require the user to provide the scope, this could be:
>=20
> @@ -258,12 +254,12 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPool *pool,
>=20
>      trace_thread_pool_submit(pool, req, arg);
>=20
> -    qemu_mutex_lock(&pool->lock);
> -    if (pool->idle_threads =3D=3D 0 && pool->cur_threads < pool->max_thr=
eads) {
> -        spawn_thread(pool);
> -    QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
> +    {
> +        QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
> +        if (pool->idle_threads =3D=3D 0 && pool->cur_threads <
> pool->max_threads) {
> +            spawn_thread(pool);
> +        }
> +        QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
>      }
> -    qemu_mutex_unlock(&pool->lock);
>      qemu_sem_post(&pool->sem);
>      return &req->common;
>  }
>=20
> In other words, I don't see what 'QEMU_WITH_LOCK_GUARD() {}' buys us
> over '{ QEMU_LOCK_GUARD() }'.

The QEMU_WITH_LOCK_GUARD() {} syntax is nice because it's similar to
if/while/for statements.

However, { QEMU_LOCK_GUARD() } doesn't hide a for statement in a macro
so the break statement works inside the scope.  Less chance of bugs.

I'd be okay without QEMU_WITH_LOCK_GUARD().

Stefan

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaLlyIAAoJEJykq7OBq3PI1gkH/2y3EVNGx+9/aO2LJYSxFt3c
HQ8EBU+FF6k8IRxlpHdMeipmA2xnb3MSC+XTFIdnAmzFoA50kB31MBkpfYqyQTOa
r7dlCMZHa8kc5LYSTRTJFNCG2YoNZmBZ8tPaHsohBbOfztHW96O/I/U/fgDQLG6D
NoeTssch+C6iiVNuHsHJ6xqn3bDTwnKHgUJd2GBkUa+SRmVhHaWgahch+LuGyu2m
WOZsSA7iWmj1GntBbiRc6hqM5UiyBboKduttpp8iOayIOiUcA9ztk5py5z2STmpu
9+uenSzai2pI9+dz/wuhLMgPwsY7VjyBY6YUSjVeEbEkqLSE0t/CgIG/Wh0V0vg=
=cvd1
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
