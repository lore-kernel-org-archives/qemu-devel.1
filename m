Received: from eggs.gnu.org ([2001:4830:134:3::10]:35873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYDjW-0004ZB-0O
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYDjS-0007pe-Q8
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:19:05 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:33403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYDjS-0007pB-Iu
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:19:02 -0500
Received: by mail-wj0-x243.google.com with SMTP id un2so8201356wjb.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:19:02 -0800 (PST)
Date: Mon, 30 Jan 2017 15:18:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130151859.GL2118@stefanha-x1.localdomain>
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8cpS+6Cx+xtICsjy"
Content-Disposition: inline
In-Reply-To: <20170120164322.21851-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/17] aio: introduce aio_co_schedule and
 aio_co_wake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com


--8cpS+6Cx+xtICsjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 05:43:06PM +0100, Paolo Bonzini wrote:
> diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
> index 14d4f1d..1efa356 100644
> --- a/include/qemu/coroutine_int.h
> +++ b/include/qemu/coroutine_int.h
> @@ -40,12 +40,20 @@ struct Coroutine {
>      CoroutineEntry *entry;
>      void *entry_arg;
>      Coroutine *caller;
> +
> +    /* Only used when the coroutine has terminated.  */
>      QSLIST_ENTRY(Coroutine) pool_next;
>      size_t locks_held;

locks_held is used when the coroutine is running.  Please add a newline
to separate it from pool_next.

> =20
> -    /* Coroutines that should be woken up when we yield or terminate */
> +    /* Coroutines that should be woken up when we yield or terminate.
> +     * Only used when the coroutine is running.
> +     */
>      QSIMPLEQ_HEAD(, Coroutine) co_queue_wakeup;
> +
> +    /* Only used when the coroutine is sleeping.  */

"running", "yielded", and "terminated" are terms with specific meanings.
Is "sleeping" a subset of "yielded" where the coroutine is waiting for a
mutex or its AioContext to schedule it?

> +static void test_multi_co_schedule_entry(void *opaque)

Missing coroutine_fn.

> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index d2f529b..cb87997 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -33,17 +33,6 @@
>  static char temp_file[] =3D "/tmp/vmst.test.XXXXXX";
>  static int temp_fd;
> =20
> -/* Fake yield_until_fd_readable() implementation so we don't have to pul=
l the
> - * coroutine code as dependency.
> - */
> -void yield_until_fd_readable(int fd)
> -{
> -    fd_set fds;
> -    FD_ZERO(&fds);
> -    FD_SET(fd, &fds);
> -    select(fd + 1, &fds, NULL, NULL, NULL);
> -}
> -
> =20
>  /* Duplicate temp_fd and seek to the beginning of the file */
>  static QEMUFile *open_test_file(bool write)

This should be a separate patch.

--8cpS+6Cx+xtICsjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj1ljAAoJEJykq7OBq3PIZPwIAIjH3iMPaVVVg1oZHhL+x5dK
bt50UnQNmdDlvjT8Ok1mKSqvMTyTsPBYCgAZmlz+WYcClxLBNmjQN0ncVzI+5g2C
/V4zlo9hfiFMcB/G6UCE9Eke6jHqB5UQvomAjxvZMGvaO0osgotRuncbtZ12FO6f
YdlFnV2ul1ykQf4y3lG0fXgXnw5EVAee+lma8zSQkFsuAiG4xXH48f+BkRXkzddJ
k3oiQiU+ss9oYfzSLXOq10zMATIBpofW4FIC48dPKTM2leeQ5Tb3hFAh191z7opT
EFJCiSyhsyYN68YjJVhKkLS1IKjjSbYXH0W1cavJDYcpnN/7iD1asClJTiPQXuo=
=FX1f
-----END PGP SIGNATURE-----

--8cpS+6Cx+xtICsjy--
