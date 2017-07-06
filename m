Received: from eggs.gnu.org ([2001:4830:134:3::10]:37988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT5hp-0002sN-NP
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT5hl-00077i-OC
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:16:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dT5hl-00076r-F3
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:16:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CF04A4F81
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 12:16:19 +0000 (UTC)
References: <20170704122325.25634-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <93dea10b-83f9-db95-107b-9da8cff3baa9@redhat.com>
Date: Thu, 6 Jul 2017 07:16:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170704122325.25634-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HuPIX6FPkOFOMErarFLbDPOelCu8Rb13O"
Subject: Re: [Qemu-devel] [PATCH] qemu-thread: Assert locks are initialized
 before using
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HuPIX6FPkOFOMErarFLbDPOelCu8Rb13O
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <93dea10b-83f9-db95-107b-9da8cff3baa9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-thread: Assert locks are initialized
 before using
References: <20170704122325.25634-1-famz@redhat.com>
In-Reply-To: <20170704122325.25634-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/04/2017 07:23 AM, Fam Zheng wrote:
> Not all platforms check whether a lock is initialized before used.  In
> particular Linux seems to be more permissive than OSX.
>=20
> Check initialization state explicitly in our code to catch such bugs
> earlier.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  include/qemu/thread-posix.h |  4 ++++
>  include/qemu/thread-win32.h |  5 +++++
>  util/qemu-thread-posix.c    | 27 +++++++++++++++++++++++++++
>  util/qemu-thread-win32.c    | 34 +++++++++++++++++++++++++++++++++-
>  4 files changed, 69 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
> index 09d1e15..e5e3a0f 100644
> --- a/include/qemu/thread-posix.h
> +++ b/include/qemu/thread-posix.h
> @@ -12,10 +12,12 @@ typedef QemuMutex QemuRecMutex;
> =20
>  struct QemuMutex {
>      pthread_mutex_t lock;
> +    bool initialized;
>  };

Are we worried about an object living on the stack and inheriting bit
values that make the object already appear initialized?  Would a magic
number a little less likely than '1' reduce the risk of inherited stack
garbage throwing us off?

Then again, several years ago, the Cygwin project quit using a magic
number cookie to track if synchronization objects were initialized, as
it ran into issues where repeated calls to a function that allocates an
object would cause the second allocation to fail because it saw leftover
stack contents from the first time through, so even with it's use of
something a little less likely than a bool '1', it still became a problem=
=2E


> @@ -58,6 +61,7 @@ void qemu_mutex_lock(QemuMutex *mutex)
>  {
>      int err;
> =20
> +    assert(mutex->initialized);
>      err =3D pthread_mutex_lock(&mutex->lock);
>      if (err)
>          error_exit(err, __func__);

Are we sure this isn't going to penalize our code speed, by adding a
conditional on every lock/unlock?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HuPIX6FPkOFOMErarFLbDPOelCu8Rb13O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXioPAAoJEKeha0olJ0NqVzgIAKDE8LF0Ks07gzyYVeG1/Gka
w1t70hzLIoAsQeXPW50iIySQ7lHuJl+/+du8ZD0S/x/b7fPupfeMeG/7nxg2yPfc
+CYjjdoyJfVbA5pu7eACpMpsgZbFgQ4HxnPXWLOTm0ZrHsv0wrMf4hjy0j8jrz1k
mlAYM/lVjp0vlr4en3cbx6mY7gTI0k6DXlelt5E+RNoZ+DI7d5ZFslSdSs7AX3bR
W6BPqc3FuhSzxWd3wzdYKTnGtkoZIDLXXlKN9pj9tki/8yTOzP9cBfzkgd/YVzeT
K+ahFJg4GIMhggcgdQzvL9Zj6ZltVbmVFEbXXywu3oWTdUhUHkawOJsCzWD4uSY=
=x0SX
-----END PGP SIGNATURE-----

--HuPIX6FPkOFOMErarFLbDPOelCu8Rb13O--
