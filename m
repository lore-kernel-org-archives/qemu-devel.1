Received: from eggs.gnu.org ([2001:4830:134:3::10]:48491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0OGZ-0005CC-8p
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0OGW-0003o2-3s
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:18:11 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f0OGV-0003nD-UF
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:18:08 -0400
Received: by mail-it0-f65.google.com with SMTP id e98-v6so9822994itd.4
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 02:18:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-8-peterx@redhat.com>
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-8-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 11:18:06 +0200
Message-ID: <CAMxuvaxmh=VsRQLfcrK_+opYQ+aVujADTcVdzEosz7amGD8C_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 7/8] tests: introduce
 qtest_init_with_qmp_format()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Mar 26, 2018 at 8:39 AM, Peter Xu <peterx@redhat.com> wrote:
> It is abstracted from qtest_init_without_qmp_handshake(). It works just
> like qtest_init_without_qmp_handshake() but further it would allow the
> caller to specify the QMP parameter.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/libqtest.c | 14 +++++++++++---
>  tests/libqtest.h | 14 ++++++++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 200b2b9e92..d2af1b17f0 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -166,19 +166,22 @@ static const char *qtest_qemu_binary(void)
>      return qemu_bin;
>  }
>
> -QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
> +QTestState *qtest_init_with_qmp_format(const char *extra_args,
> +                                       const char *qmp_format)
>  {
>      QTestState *s;
>      int sock, qmpsock, i;
>      gchar *socket_path;
>      gchar *qmp_socket_path;
>      gchar *command;
> +    gchar *qmp_params;
>      const char *qemu_binary =3D qtest_qemu_binary();
>
>      s =3D g_new(QTestState, 1);
>
>      socket_path =3D g_strdup_printf("/tmp/qtest-%d.sock", getpid());
>      qmp_socket_path =3D g_strdup_printf("/tmp/qtest-%d.qmp", getpid());
> +    qmp_params =3D g_strdup_printf(qmp_format, qmp_socket_path);
>
>      /* It's possible that if an earlier test run crashed it might
>       * have left a stale unix socket lying around. Delete any
> @@ -199,12 +202,12 @@ QTestState *qtest_init_without_qmp_handshake(const =
char *extra_args)
>          command =3D g_strdup_printf("exec %s "
>                                    "-qtest unix:%s,nowait "
>                                    "-qtest-log %s "
> -                                  "-qmp unix:%s,nowait "
> +                                  "%s "
>                                    "-machine accel=3Dqtest "
>                                    "-display none "
>                                    "%s", qemu_binary, socket_path,
>                                    getenv("QTEST_LOG") ? "/dev/fd/2" : "/=
dev/null",
> -                                  qmp_socket_path,
> +                                  qmp_params,
>                                    extra_args ?: "");
>          execlp("/bin/sh", "sh", "-c", command, NULL);
>          exit(1);
> @@ -237,6 +240,11 @@ QTestState *qtest_init_without_qmp_handshake(const c=
har *extra_args)
>      return s;
>  }
>
> +QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
> +{
> +    return qtest_init_with_qmp_format(extra_args, "-qmp unix:%s,nowait")=
;
> +}
> +
>  QTestState *qtest_init(const char *extra_args)
>  {
>      QTestState *s =3D qtest_init_without_qmp_handshake(extra_args);
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 811169453a..1f3605ce73 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -62,6 +62,20 @@ QTestState *qtest_init(const char *extra_args);
>   */
>  QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
>
> +/**
> + * qtest_init_with_qmp_format:
> + * @extra_args: other arguments to pass to QEMU.
> + * @qmp_format: format of QMP parameters, should contain one "%s"
> + *              field so that the socket path will be filled later.
> + *
> + * Note that this function will work just like
> + * qtest_init_without_qmp_handshake(), so no QMP handshake will be done.
> + *
> + * Returns: #QTestState instance.
> + */
> +QTestState *qtest_init_with_qmp_format(const char *extra_args,
> +                                       const char *qmp_format);
> +
>  /**
>   * qtest_quit:
>   * @s: #QTestState instance to operate on.
> --
> 2.14.3
>
