Received: from eggs.gnu.org ([209.51.188.92]:58714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glYMe-0005b5-2I
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glYMc-0003wz-27
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:07:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glYMa-0003rC-2G
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:07:36 -0500
References: <20190117161640.5496-1-jusual@mail.ru>
	<20190117161640.5496-2-jusual@mail.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <34db0deb-0f97-0441-9e64-53957e4b870b@redhat.com>
Date: Mon, 21 Jan 2019 13:07:21 +0100
MIME-Version: 1.0
In-Reply-To: <20190117161640.5496-2-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/3] tests/libqtest: Introduce
 qtest_init_with_serial()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 2019-01-17 17:16, Julia Suvorova wrote:
> Run qtest with a socket that connects QEMU chardev and test code.
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  tests/libqtest.c | 26 ++++++++++++++++++++++++++
>  tests/libqtest.h | 11 +++++++++++
>  2 files changed, 37 insertions(+)
>=20
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 55750dd68d..3a015cfe13 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -315,6 +315,32 @@ QTestState *qtest_initf(const char *fmt, ...)
>      return s;
>  }
> =20
> +QTestState *qtest_init_with_serial(const char *extra_args, int *sock_f=
d)
> +{
> +    int sock_fd_init;
> +    char *sock_path, sock_dir[] =3D "/tmp/qtest-serial-XXXXXX";
> +    QTestState *qts;
> +
> +    g_assert(mkdtemp(sock_dir));

We normally don't do it in QEMU, but still, it theoretically possible to
turn of g_assert() by defining G_DISABLE_ASSER, so the content should be
free of side effects. See also the doc of g_assert() here:

 https://developer.gnome.org/glib/unstable/glib-Testing.html#g-assert

Thus could you please rewrite this as:

    ptr =3D mkdtemp(sock_dir);
    g_assert(ptr !=3D NULL);

?

> +    sock_path =3D g_strdup_printf("%s/sock", sock_dir);
> +
> +    sock_fd_init =3D init_socket(sock_path);
> +
> +    qts =3D qtest_initf("-chardev socket,id=3Ds0,path=3D%s,nowait "

Daniel just posted a patch that will disallow "nowait" without "server":

 https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03334.html

So I think you've got to drop the "nowait" here.

> +                      "-serial chardev:s0 %s",
> +                      sock_path, extra_args);
> +
> +    *sock_fd =3D socket_accept(sock_fd_init);
> +
> +    unlink(sock_path);
> +    g_free(sock_path);
> +    rmdir(sock_dir);
> +
> +    g_assert(*sock_fd >=3D 0);
> +
> +    return qts;
> +}
> +
>  void qtest_quit(QTestState *s)
>  {
>      g_hook_destroy_link(&abrt_hooks, g_hook_find_data(&abrt_hooks, TRU=
E, s));
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 7ea94139b0..5937f91912 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -62,6 +62,17 @@ QTestState *qtest_init(const char *extra_args);
>   */
>  QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
> =20
> +/**
> + * qtest_init_with_serial:
> + * @extra_args: other arguments to pass to QEMU.  CAUTION: these
> + * arguments are subject to word splitting and shell evaluation.
> + * @sock_fd: pointer to store the socket file descriptor for
> + * connection with serial.
> + *
> + * Returns: #QTestState instance.
> + */
> +QTestState *qtest_init_with_serial(const char *extra_args, int *sock_f=
d);
> +
>  /**
>   * qtest_quit:
>   * @s: #QTestState instance to operate on.
>=20

 Thomas
