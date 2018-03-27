Received: from eggs.gnu.org ([2001:4830:134:3::10]:53908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0m2e-0003Oo-3Z
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0m2a-0007nG-5m
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:41:24 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f0m2a-0007ly-1G
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:41:20 -0400
Received: by mail-it0-f67.google.com with SMTP id 19-v6so14662321itw.3
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 03:41:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180327013620.1644387-4-eblake@redhat.com>
References: <20180327013620.1644387-1-eblake@redhat.com>
	<20180327013620.1644387-4-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Mar 2018 12:41:18 +0200
Message-ID: <CAMxuvaw6btZaYUAdWCjFvcG=aWv=beYgTyKCORG2uCrm34n4wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] tests: Add parameter to
 qtest_init_without_qmp_handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, borntraeger@de.ibm.com, Markus Armbruster <armbru@redhat.com>

On Tue, Mar 27, 2018 at 3:36 AM, Eric Blake <eblake@redhat.com> wrote:
> Allow callers to choose whether to allow OOB support during a test;
> for now, all existing callers pass false, but the next patch will
> add a new caller.  Also, rewrite the monitor setup to be generic
> (using the -qmp shorthand is insufficient for honoring the parameter).
>
> Based on an idea by Peter Xu, in <20180326063901.27425-8-peterx@redhat.co=
m>
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/libqtest.h |  7 +++++--
>  tests/libqtest.c | 10 ++++++----
>  tests/qmp-test.c |  2 +-
>  3 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 811169453ab..cbe8df44730 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -56,11 +56,14 @@ QTestState *qtest_init(const char *extra_args);
>
>  /**
>   * qtest_init_without_qmp_handshake:
> - * @extra_args: other arguments to pass to QEMU.
> + * @use_oob: true to have the server advertise OOB support
> + * @extra_args: other arguments to pass to QEMU.  CAUTION: these
> + * arguments are subject to word splitting and shell evaluation.
>   *
>   * Returns: #QTestState instance.
>   */
> -QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
> +QTestState *qtest_init_without_qmp_handshake(bool use_oob,
> +                                             const char *extra_args);
>
>  /**
>   * qtest_quit:
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 200b2b9e92a..6f33a37667c 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -166,7 +166,8 @@ static const char *qtest_qemu_binary(void)
>      return qemu_bin;
>  }
>
> -QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
> +QTestState *qtest_init_without_qmp_handshake(bool use_oob,
> +                                             const char *extra_args)
>  {
>      QTestState *s;
>      int sock, qmpsock, i;
> @@ -199,12 +200,13 @@ QTestState *qtest_init_without_qmp_handshake(const =
char *extra_args)
>          command =3D g_strdup_printf("exec %s "
>                                    "-qtest unix:%s,nowait "
>                                    "-qtest-log %s "
> -                                  "-qmp unix:%s,nowait "
> +                                  "-chardev socket,path=3D%s,nowait,id=
=3Dchar0 "
> +                                  "-mon chardev=3Dchar0,mode=3Dcontrol%s=
 "
>                                    "-machine accel=3Dqtest "
>                                    "-display none "
>                                    "%s", qemu_binary, socket_path,
>                                    getenv("QTEST_LOG") ? "/dev/fd/2" : "/=
dev/null",
> -                                  qmp_socket_path,
> +                                  qmp_socket_path, use_oob ? ",x-oob=3Do=
n" : "",
>                                    extra_args ?: "");
>          execlp("/bin/sh", "sh", "-c", command, NULL);
>          exit(1);
> @@ -239,7 +241,7 @@ QTestState *qtest_init_without_qmp_handshake(const ch=
ar *extra_args)
>
>  QTestState *qtest_init(const char *extra_args)
>  {
> -    QTestState *s =3D qtest_init_without_qmp_handshake(extra_args);
> +    QTestState *s =3D qtest_init_without_qmp_handshake(false, extra_args=
);
>
>      /* Read the QMP greeting and then do the handshake */
>      qtest_qmp_discard_response(s, "");
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index 8de99a4727e..2134d95db97 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -81,7 +81,7 @@ static void test_qmp_protocol(void)
>      QList *capabilities;
>      QTestState *qts;
>
> -    qts =3D qtest_init_without_qmp_handshake(common_args);
> +    qts =3D qtest_init_without_qmp_handshake(false, common_args);
>
>      /* Test greeting */
>      resp =3D qtest_qmp_receive(qts);
> --
> 2.14.3
>
