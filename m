Received: from eggs.gnu.org ([2001:4830:134:3::10]:35844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG3KK-0005qK-2S
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG3KH-0002ys-De
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:06:16 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:32850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dG3KH-0002yW-7N
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:06:13 -0400
Received: by mail-wm0-x243.google.com with SMTP id b84so3511083wmh.0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:06:13 -0700 (PDT)
Date: Wed, 31 May 2017 14:06:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531130609.GE16733@stefanha-x1.localdomain>
References: <20170530100736.3338-1-roman.penyaev@profitbricks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+mQKy/8VjtYrTtD4"
Content-Disposition: inline
In-Reply-To: <20170530100736.3338-1-roman.penyaev@profitbricks.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] coroutine-lock: do not touch
 coroutine after another one has been entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--+mQKy/8VjtYrTtD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 12:07:36PM +0200, Roman Pen wrote:
> diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
> index 6328eed26bc6..d589d8c66d5e 100644
> --- a/util/qemu-coroutine-lock.c
> +++ b/util/qemu-coroutine-lock.c
> @@ -77,10 +77,20 @@ void coroutine_fn qemu_co_queue_wait(CoQueue *queue, =
CoMutex *mutex)
>  void qemu_co_queue_run_restart(Coroutine *co)
>  {
>      Coroutine *next;
> +    QSIMPLEQ_HEAD(, Coroutine) tmp_queue_wakeup =3D
> +        QSIMPLEQ_HEAD_INITIALIZER(tmp_queue_wakeup);
> =20
>      trace_qemu_co_queue_run_restart(co);
> -    while ((next =3D QSIMPLEQ_FIRST(&co->co_queue_wakeup))) {
> -        QSIMPLEQ_REMOVE_HEAD(&co->co_queue_wakeup, co_queue_next);
> +
> +    /* Because "co" has yielded, any coroutine that we wakeup can resume=
 it.
> +     * If this happens and "co" terminates, co->co_queue_wakeup becomes
> +     * invalid memory.  Therefore, use a temporary queue and do not touch
> +     * the "co" coroutine as soon as you enter another one.
> +     */
> +    QSIMPLEQ_CONCAT(&tmp_queue_wakeup, &co->co_queue_wakeup);
> +
> +    while ((next =3D QSIMPLEQ_FIRST(&tmp_queue_wakeup))) {
> +        QSIMPLEQ_REMOVE_HEAD(&tmp_queue_wakeup, co_queue_next);
>          qemu_coroutine_enter(next);
>      }
>  }

What happens if co remains alive and qemu_coroutine_enter(next) causes
additional coroutines to add themselves to co->co_queue_wakeup?

I think they used to be entered but not anymore after this patch.  Not
sure if anything depends on this behavior...

--+mQKy/8VjtYrTtD4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLr/BAAoJEJykq7OBq3PIjd0H/Auq47nIHuSMOxX2kyl4qkEN
h6ELhWxWQvvTUgihghtEbmJX2xw2BF+7zd/MNLP3pPePS0uzK3Ml/fpmq0JX6OOE
LhbduSPAjuHtdjDVU+jNxdJFWHrpOVMKONhvlnO+Ec4Hr0DlGocsiQ5iC6N+LYaQ
9WCSaFz28Ydflrab1wMF/FSYnRutjnpu2l2GfCevh4pIJUCL87cb34ia744x8iPL
LPh1qhmIIZR84qGiUxf2chiXfr1xaeCcuuMRbekjN4SftXUd3ze0zLqEtKYRr2Pf
cSX/AK7eMYG0caYdZp94wOaG67GFR84BQqER+KxJWhe2MY/ip67Qm90LXbwrzMM=
=7N1Z
-----END PGP SIGNATURE-----

--+mQKy/8VjtYrTtD4--
