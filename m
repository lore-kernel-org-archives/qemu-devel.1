Received: from eggs.gnu.org ([2001:4830:134:3::10]:36910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eCSUq-0004Ly-VQ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eCSUn-0007JC-SQ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:42:32 -0500
Date: Wed, 8 Nov 2017 15:42:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171108154226.GC6118@stefanha-x1.localdomain>
References: <20171107223708.17935-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <20171107223708.17935-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] coroutine: Fix documentation of
 co_aio_sleep_ns()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 04:37:08PM -0600, Eric Blake wrote:
> co_sleep_ns() was removed in commit 0b9caf9b, leaving behind a
> stale comment.  Update the documentation to match the current
> usage of this function.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/qemu/coroutine.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index 9aff9a735e..01ae415767 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -262,8 +262,11 @@ void qemu_co_rwlock_unlock(CoRwlock *lock);
>  /**
>   * Yield the coroutine for a given duration
>   *
> - * Behaves similarly to co_sleep_ns(), but the sleeping coroutine will be
> - * resumed when using aio_poll().
> + * This function uses timers and hence needs to know the event loop
> + * (#AioContext) to place the timer on.  In any case, co_aio_sleep_ns()
> + * does not affect the #AioContext where the current coroutine is runnin=
g,
> + * as the coroutine will restart on the same #AioContext that it is
> + * running on.

I cannot parse the second sentence.  What does "affecting" an AioContext
mean?  Does "where the current coroutine is running" simply mean "the
caller"?

What is it trying to say?  My guess is: the caller will be resumed in
the current AioContext, not the timer's AioContext.

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaAyXiAAoJEJykq7OBq3PIwh0IAL4pfFSf9PALYrgxxTriXh8S
HqzTBC7aPX441apOYEB9bD4sQ+jE+QlaaJqu4ecq3sZMCo9KvWWWvxcY9mML+mU/
8hgsZhil1PmEo6WweW90fxlXx6s3tCYQdClsjD3E4iSMIJ9wNa0oG5X7TnBYyb+5
RoxfAa8yR2GxD22k0ORmqk3RxIvr8nXXB/ZrfgF3LBJZ8tm1V7n+A2J2MQ+YsSaL
9IcQ9dPJYP5fnOrYtgf3HeW9QSS7MCFUKvamgkuwoFBfadTct4jgQyzao9+F2Bz2
UUxijz+6viQzjEzMYL3987OM+rPXF2Fa4q3hVOHpgtK5B4mJYiRLtzxYVyn6ClU=
=5FrG
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
