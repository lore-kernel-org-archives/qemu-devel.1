Received: from eggs.gnu.org ([2001:4830:134:3::10]:59858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eNKbY-0004fT-SA
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eNKbT-0004uq-Jg
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:30:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eNKbT-0004ud-C9
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:30:19 -0500
Date: Fri, 8 Dec 2017 15:30:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171208153010.GD8998@stefanha-x1.localdomain>
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <20171208105553.12249-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] lock-guard: add scoped lock
 implementation
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


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 08, 2017 at 11:55:50AM +0100, Paolo Bonzini wrote:

The implementation is somewhat complex.  Please structure the header
file so the public interfaces are clear and documented.  Move the
implementation out of the way and mark it private.  That will make it
easier for someone to figure out "how do I use lock-guard.h".

> diff --git a/include/qemu/lock-guard.h b/include/qemu/lock-guard.h
> new file mode 100644
> index 0000000000..e6a83bf9ee
> --- /dev/null
> +++ b/include/qemu/lock-guard.h
> @@ -0,0 +1,103 @@
> +#ifndef QEMU_LOCK_GUARD_H
> +#define QEMU_LOCK_GUARD_H 1
> +
> +typedef void QemuLockGuardFunc(void *);
> +typedef struct QemuLockGuard {
> +    QemuLockGuardFunc *p_lock_fn, *p_unlock_fn;
> +    void *lock;
> +    int locked;

bool?

> +#define QEMU_WITH_LOCK(type, name, lock)                                   \
> +    for (QEMU_LOCK_GUARD(type, name, lock);                                \
> +         qemu_lock_guard_is_taken(&name);                                  \
> +         qemu_lock_guard_unlock(&name))

I don't understand the need for the qemu_lock_guard_is_taken(&name)
condition, why not do the following?

  for (QEMU_LOCK_GUARD(type, name, lock);
       ;
       qemu_lock_guard_unlock(&name))

Also, the for loop means that break statements do not work inside
QEMU_WITH_LOCK() { ... }.  This needs to be documented.

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKrABAAoJEJykq7OBq3PIXf8H/jJL83+GvTcaTNJ/sIxGaLG+
hU8XBe9nYkYKXET14e9GphctMAw3YXfZshv3KCozmEebFkmSJDzYCvhBJrRkkiKq
4zGklSp9bLe3s8u6guYgzp4TeEeh55F0GcpGtGkD9RfYhUskhRHo5m1iA3mEuF5J
/MEgkGw+DL2YAvD/CG6p0fsRXODaJpNTkX5Q/mIq1BWWMGH/w4nKflHmeLCbYWDF
gpZvlnO0YdBwZyW+VlTkGAOT4fLG4DP2QpgPGXPzqKwpWXcyfXOL4O4cumojXmuD
XKwWuEVlzt/gwbfZbEhXwdYGFfJ/usfaJBeEhqB2jxZrc0iDm2gCHZO4SBucSUc=
=7Ydr
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
