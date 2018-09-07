Received: from eggs.gnu.org ([2001:4830:134:3::10]:41086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fyLqS-00069z-UY
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fyLqR-0007ZR-Qg
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:51:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fyLqR-0007VE-IF
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:51:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id v16-v6so15887879wro.11
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 11:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180907184644.2272491-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20180907184644.2272491-1-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 7 Sep 2018 22:50:50 +0400
Message-ID: <CAJ+F1CKHFr7hUekYTXq5ihAV_eZxKjX3qq_YCOGmiaakbV04fA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Fix signalling race condition in
 TPM tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, mjt@tlks.msk.ru, Peter Maydell <peter.maydell@linaro.org>

On Fri, Sep 7, 2018 at 10:47 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> This patch fixes a race condition and test failure where the main process
> waits for the signal of a thread but the thread already sent that signal
> via a condition. Since these signals are non-sticky, we need to introduce=
 a
> separate variable to make this signal sticky.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/tpm-crb-test.c |  1 +
>  tests/tpm-emu.c      | 11 ++++++++++-
>  tests/tpm-emu.h      |  1 +
>  tests/tpm-tis-test.c |  1 +
>  4 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tests/tpm-crb-test.c b/tests/tpm-crb-test.c
> index d8f9569203..6fde579bab 100644
> --- a/tests/tpm-crb-test.c
> +++ b/tests/tpm-crb-test.c
> @@ -151,6 +151,7 @@ int main(int argc, char **argv)
>      test.addr->u.q_unix.path =3D g_build_filename(tmp_path, "sock", NULL=
);
>      g_mutex_init(&test.data_mutex);
>      g_cond_init(&test.data_cond);
> +    test.data_cond_signal =3D false;
>
>      thread =3D g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
>      tpm_emu_test_wait_cond(&test);
> diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
> index 8c2bd53cad..125e697181 100644
> --- a/tests/tpm-emu.c
> +++ b/tests/tpm-emu.c
> @@ -23,9 +23,14 @@ void tpm_emu_test_wait_cond(TestState *s)
>      gint64 end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
>
>      g_mutex_lock(&s->data_mutex);
> -    if (!g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
> +
> +    if (!s->data_cond_signal &&
> +        !g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
>          g_assert_not_reached();
>      }
> +
> +    s->data_cond_signal =3D false;
> +
>      g_mutex_unlock(&s->data_mutex);
>  }
>
> @@ -72,6 +77,10 @@ void *tpm_emu_ctrl_thread(void *data)
>      QIOChannel *ioc;
>
>      qio_channel_socket_listen_sync(lioc, s->addr, &error_abort);
> +
> +    g_mutex_lock(&s->data_mutex);
> +    s->data_cond_signal =3D true;
> +    g_mutex_unlock(&s->data_mutex);
>      g_cond_signal(&s->data_cond);
>
>      qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
> diff --git a/tests/tpm-emu.h b/tests/tpm-emu.h
> index 08f902485e..8eb802a79e 100644
> --- a/tests/tpm-emu.h
> +++ b/tests/tpm-emu.h
> @@ -26,6 +26,7 @@ struct tpm_hdr {
>  typedef struct TestState {
>      GMutex data_mutex;
>      GCond data_cond;
> +    bool data_cond_signal;
>      SocketAddress *addr;
>      QIOChannel *tpm_ioc;
>      GThread *emu_tpm_thread;
> diff --git a/tests/tpm-tis-test.c b/tests/tpm-tis-test.c
> index 14754d9706..c8ec14888f 100644
> --- a/tests/tpm-tis-test.c
> +++ b/tests/tpm-tis-test.c
> @@ -446,6 +446,7 @@ int main(int argc, char **argv)
>      test.addr->u.q_unix.path =3D g_build_filename(tmp_path, "sock", NULL=
);
>      g_mutex_init(&test.data_mutex);
>      g_cond_init(&test.data_cond);
> +    test.data_cond_signal =3D false;
>
>      thread =3D g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
>      tpm_emu_test_wait_cond(&test);
> --
> 2.14.4
>
>


--=20
Marc-Andr=C3=A9 Lureau
