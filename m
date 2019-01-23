Received: from eggs.gnu.org ([209.51.188.92]:42723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmJaI-0005vg-LG
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmJOo-0003S5-9t
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:21:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmJOn-0003PF-Lx
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:21:02 -0500
Received: by mail-wr1-x443.google.com with SMTP id s12so2662640wrt.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 06:21:01 -0800 (PST)
References: <20190123120759.7162-1-jusual@mail.ru>
	<20190123120759.7162-2-jusual@mail.ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190123120759.7162-2-jusual@mail.ru>
Date: Wed, 23 Jan 2019 14:20:58 +0000
Message-ID: <87zhrrzc8l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/3] tests/libqtest: Introduce
 qtest_init_with_serial()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?utf-8?Q?G=C3=B6rtz?= <contrib@steffen-goertz.de>


Julia Suvorova <jusual@mail.ru> writes:

> Run qtest with a socket that connects QEMU chardev and test code.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/libqtest.c | 25 +++++++++++++++++++++++++
>  tests/libqtest.h | 11 +++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 55750dd68d..6fb30855fa 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -315,6 +315,31 @@ QTestState *qtest_initf(const char *fmt, ...)
>      return s;
>  }
>
> +QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd)
> +{
> +    int sock_fd_init;
> +    char *sock_path, sock_dir[] =3D "/tmp/qtest-serial-XXXXXX";
> +    QTestState *qts;
> +
> +    g_assert_true(mkdtemp(sock_dir) !=3D NULL);
> +    sock_path =3D g_strdup_printf("%s/sock", sock_dir);
> +
> +    sock_fd_init =3D init_socket(sock_path);
> +
> +    qts =3D qtest_initf("-chardev socket,id=3Ds0,path=3D%s -serial chard=
ev:s0 %s",
> +                      sock_path, extra_args);
> +
> +    *sock_fd =3D socket_accept(sock_fd_init);
> +
> +    unlink(sock_path);
> +    g_free(sock_path);
> +    rmdir(sock_dir);
> +
> +    g_assert_true(*sock_fd >=3D 0);
> +
> +    return qts;
> +}
> +
>  void qtest_quit(QTestState *s)
>  {
>      g_hook_destroy_link(&abrt_hooks, g_hook_find_data(&abrt_hooks, TRUE,=
 s));
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 7ea94139b0..5937f91912 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -62,6 +62,17 @@ QTestState *qtest_init(const char *extra_args);
>   */
>  QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
>
> +/**
> + * qtest_init_with_serial:
> + * @extra_args: other arguments to pass to QEMU.  CAUTION: these
> + * arguments are subject to word splitting and shell evaluation.
> + * @sock_fd: pointer to store the socket file descriptor for
> + * connection with serial.
> + *
> + * Returns: #QTestState instance.
> + */
> +QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd);
> +
>  /**
>   * qtest_quit:
>   * @s: #QTestState instance to operate on.


--
Alex Benn=C3=A9e
