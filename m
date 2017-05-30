Received: from eggs.gnu.org ([2001:4830:134:3::10]:44999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFdYY-0005LD-Dt
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFdYV-0000LM-8g
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:35:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dFdYV-0000L7-0F
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:35:11 -0400
References: <20170530085346.1730-1-roman.penyaev@profitbricks.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c674491-b570-bed1-6d39-293ce8c5e5fc@redhat.com>
Date: Tue, 30 May 2017 11:35:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170530085346.1730-1-roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] coroutine-lock: do not touch coroutine
 after another one has been entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 30/05/2017 10:53, Roman Pen wrote:
> The fix is obvious: use temporal queue and do not touch coroutine after
> first qemu_coroutine_enter() is invoked.
>=20
> The issue is quite rare and happens every ~12 hours on very high IO loa=
d
> (building linux kernel with -j512 inside guest) when IO throttling is
> enabled.  With the fix applied guest is running ~35 hours and is still
> alive so far.

This is a good one.  Thanks!  Just a couple notes on English below.

> diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
> index 6328eed26bc6..026f5297f0f9 100644
> --- a/util/qemu-coroutine-lock.c
> +++ b/util/qemu-coroutine-lock.c
> @@ -77,10 +77,23 @@ void coroutine_fn qemu_co_queue_wait(CoQueue *queue=
, CoMutex *mutex)
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
> +    /*
> +     * We use temporal queue in order not to touch 'co' after entering
> +     * 'next' coroutine.  The thing is that 'next' coroutine can resum=
e
> +     * current 'co' coroutine and eventually terminate (free) it (see
> +     * linux-aio.c: ioq_submit() where qemu_laio_process_completions()
> +     * is invoked).  The rule of thumb is simple: do not touch corouti=
ne
> +     * when you enter another one.
> +     */

/* Because "co" has yielded, any coroutine that we wakeup can resume it.
 * If this happens and "co" terminates, co->co_queue_wakeup becomes
 * invalid memory.  Therefore, use a temporary queue and do not touch
 * the "co" coroutine as soon as you enter another one.
 */

> +    QSIMPLEQ_CONCAT(&tmp_queue_wakeup, &co->co_queue_wakeup);
> +
> +    while ((next =3D QSIMPLEQ_FIRST(&tmp_queue_wakeup))) {
> +        QSIMPLEQ_REMOVE_HEAD(&tmp_queue_wakeup, co_queue_next);
>          qemu_coroutine_enter(next);
>      }
>  }
> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index 486af9a62275..d020b63742af 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -126,6 +126,13 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Cor=
outine *co)
> =20
>      qemu_co_queue_run_restart(co);
> =20
> +    /*
> +     * BEWARE: in case of ret =3D=3D COROUTINE_YIELD here at this poin=
t
> +     *         after qemu_co_queue_run_restart() 'co' can be already
> +     *         freed by other coroutine, which has entered 'co'. So
> +     *         be careful and do not touch it.
> +     */

/* Beware, if ret =3D=3D COROUTINE_YIELD and qemu_co_queue_run_restart()
 * has started any other coroutine, "co" might have been reentered
 * and even freed by now!  So be careful and do not touch it.
 */

>      switch (ret) {
>      case COROUTINE_YIELD:
>          return;
>=20

Paolo
