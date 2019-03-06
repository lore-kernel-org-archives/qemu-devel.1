Received: from eggs.gnu.org ([209.51.188.92]:56586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h1W9M-0007vQ-Do
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h1W9K-0007zj-QG
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:59:55 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1h1W9J-0007yn-Ak
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:59:54 -0500
Received: by mail-wm1-x343.google.com with SMTP id g20so5743239wmh.5
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 04:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20190306115532.23025-1-peterx@redhat.com>
	<20190306115532.23025-6-peterx@redhat.com>
In-Reply-To: <20190306115532.23025-6-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Mar 2019 13:59:38 +0100
Message-ID: <CAJ+F1CJB7LN6UQRZRAXaBAgk0K0QO_Z3EuZuHkSAan0jH8FLUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] iothread: document about why we
 need explicit aio_poll()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Mar 6, 2019 at 1:05 PM Peter Xu <peterx@redhat.com> wrote:
>
> After consulting Paolo I know why we'd better keep the explicit
> aio_poll() in iothread_run().  Document it directly into the code so
> that future readers will know the answer from day one.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  iothread.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/iothread.c b/iothread.c
> index 045825a348..14e9f3779e 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -64,6 +64,15 @@ static void *iothread_run(void *opaque)
>      qemu_sem_post(&iothread->init_done_sem);
>
>      while (iothread->running) {
> +        /*
> +         * Note: from functional-wise the g_main_loop_run() below can
> +         * already cover the aio_poll() events, but we can't run the
> +         * main loop unconditionally because explicit aio_poll() here
> +         * is faster than g_main_loop_run() when we do not need the
> +         * gcontext at all (e.g., pure block layer iothreads).  In
> +         * other words, when we want to run the gcontext with the
> +         * iothread we need to pay some performance for functionality.
> +         */
>          aio_poll(iothread->ctx, true);
>
>          /*
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
