Received: from eggs.gnu.org ([2001:4830:134:3::10]:37681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNOVS-0000G4-Pg
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNOVP-00079r-7L
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:40:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eNOVO-00079C-TI
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:40:19 -0500
References: <20171208105553.12249-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32f8bbf4-1fb6-b974-f7ca-f5a91adf875e@redhat.com>
Date: Fri, 8 Dec 2017 13:40:10 -0600
MIME-Version: 1.0
In-Reply-To: <20171208105553.12249-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sKNPWNKQIPdTqEiHVgQmPX5Ne1k4hPgA9"
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using
 attribute((cleanup))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sKNPWNKQIPdTqEiHVgQmPX5Ne1k4hPgA9
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <32f8bbf4-1fb6-b974-f7ca-f5a91adf875e@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using
 attribute((cleanup))
References: <20171208105553.12249-1-pbonzini@redhat.com>
In-Reply-To: <20171208105553.12249-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 04:55 AM, Paolo Bonzini wrote:
> This is an attempt to make a C API that resembles the C++
> std::unique_lock (mostly untested).  The idea is that you can write
>=20
>     QEMU_LOCK_GUARD(QemuMutex, guard_name, &some_mutex);
>=20
> instead of
>=20
>     qemu_mutex_lock(&some_mutex);
>     ...
> out:
>     qemu_mutex_unlock(&some_mutex);
>=20
> and the mutex will be unlocked on all exit paths.  In C++ that
> would be "std::unique_lock<QemuMutex> guard_name(some_mutex);".
> Likewise,
>=20
>     QEMU_WITH_LOCK(QemuMutex, guard_name, &some_mutex) {
>         ...
>     }
>=20
> is the same as
>=20
>     qemu_mutex_lock(&some_mutex);
>     ...
>     qemu_mutex_unlock(&some_mutex);
>=20
> except that any returns within the region will unlock the mutex.

Not just returns, but ANY manner that you leave the scope, including a
goto or just falling out of the end of the scope.

(and, as Stefan pointed out, this poisons the use of 'break' when this
is used inside a loop, as it now breaks the scope of the QEMU_WITH_LOCK
instead of the outer loop).

> It's possible to use QemuLockGuard also with a spinlock or a
> CoMutex.  However, it is _not_ possible to return a QemuLockGuard
> since C doesn't have an equivalent of C++'s "move semantics", so
> there are other "constructor" macros such as QEMU_ADOPT_LOCK
> and QEMU_TAKEN_LOCK.
>=20
> On the positive side, I checked that the entire abstraction
> is removed by the compiler, the generated code is more or less
> the same.  Also, it would let us for example change block/curl.c
> to use a CoQueue instead of a home-grown list+QemuMutex.
>=20
> However, I am still not sure about the readability, and it doesn't play=

> well with another common idiom in QEMU, which is to wrap global mutexes=

> with function such as
>=20
>     static void block_job_lock(void)
>     {
>         qemu_mutex_lock(&block_job_mutex);
>     }
>=20
>     static void block_job_unlock(void)
>     {
>         qemu_mutex_unlock(&block_job_mutex);
>     }
>=20
> So I'm a bit underwhelmed by this experiment.  Other opinions?

The semantics you list here:

>     QEMU_WITH_LOCK(QemuMutex, guard_name, &some_mutex) {
>         ...
>     }

are slightly different from the semantics in nbdkit:

{
  ACQUIRE_LOCK_FOR_CURRENT_SCOPE(&some_lock);
  ...
}

In that your version requires the user to supply the scope after your
macro, instead of using your macro within the scope.  But I guess that's
because you added other helpers like QEMU_WITH_ADOPTED_LOCK,
QEMU_RETURN_LOCK, and QEMU_TAKEN_LOCK, where you have multiple
possibilities for which state the lock should be in.

Is it worth playing around with the user providing the scope around your
macros, instead of using your macro to introduce the scope?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sKNPWNKQIPdTqEiHVgQmPX5Ne1k4hPgA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloq6poACgkQp6FrSiUn
Q2oY2Qf+OrZ/OWfDgHyvH3s5Ug0VoIHmMd1AaMzVtx1IRA5b7YjK4SYKo/ERrR/z
L02ZV0djO7Psw5oxv+tR75pOr5e/+m7IejtaCcZm9/mNlO4BliQeQm4jE108ljNT
hWb5Zaxc4P/sf3lKhQSFXgW06TYVUkHPbnZIVefmdRJfGiC2EZyEjVRcUJj8iJZK
O9+4TJA84yqlkGgo4XPR66/U/bz1zRRXmMtTSab8x3vAfRM56sgW6uTQcd0RJZAF
KaXnXrzrXj/i8Yw/L5he1q/HsS5grPzt55uzgPZG4qt9yET6jtEu8Ev+jdO9FP0f
jqsqpoHCUViSAtgpvljFVaiSDWcOAg==
=GtuH
-----END PGP SIGNATURE-----

--sKNPWNKQIPdTqEiHVgQmPX5Ne1k4hPgA9--
