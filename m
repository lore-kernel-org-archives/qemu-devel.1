Received: from eggs.gnu.org ([209.51.188.92]:37405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUAR-0007nx-W0
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:14:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUAQ-0000sJ-PV
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:14:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gjUAQ-0000mR-FH
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:14:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id z18so2225407qkj.10
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 11:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-4-berrange@redhat.com>
In-Reply-To: <20190115145256.9593-4-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Jan 2019 23:14:08 +0400
Message-ID: <CAMxuvayWRyL4MLkychGT0Kq4JttcDt6Wjt9GF5L_HT=Z4eOCoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/12] chardev: forbid 'wait' option with
 client sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 15, 2019 at 6:53 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> The 'wait'/'nowait' parameter is used to tell server sockets whether to
> block until a client is accepted during initialization. Client chardevs
> have always silently ignored this option. Various tests were mistakenly
> passing this option for their client chardevs.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-socket.c          | 12 +++++++++++-
>  tests/ivshmem-test.c           |  2 +-
>  tests/libqtest.c               |  4 ++--
>  tests/test-filter-redirector.c |  4 ++--
>  4 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 4570755adf..233f16f72d 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1047,6 +1047,12 @@ static bool qmp_chardev_validate_socket(ChardevSoc=
ket *sock,
>              error_setg(errp, "%s", "Websocket client is not implemented"=
);
>              return false;
>          }
> +        if (sock->has_wait) {
> +            error_setg(errp, "%s",
> +                       "'wait' option is incompatible with "
> +                       "socket in client connect mode");
> +            return false;
> +        }
>      }
>
>      return true;
> @@ -1220,7 +1226,11 @@ static void qemu_chr_parse_socket(QemuOpts *opts, =
ChardevBackend *backend,
>      sock->tn3270 =3D is_tn3270;
>      sock->has_websocket =3D true;
>      sock->websocket =3D is_websock;
> -    sock->has_wait =3D true;
> +    /*
> +     * We have different default to QMP for 'wait' when 'server'
> +     * is set, hence we can't just check for existance of 'wait'
> +     */
> +    sock->has_wait =3D qemu_opt_find(opts, "wait") || is_listen;
>      sock->wait =3D is_waitconnect;
>      sock->has_reconnect =3D qemu_opt_find(opts, "reconnect");
>      sock->reconnect =3D reconnect;
> diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
> index fe5eb304b1..faffc1c624 100644
> --- a/tests/ivshmem-test.c
> +++ b/tests/ivshmem-test.c
> @@ -293,7 +293,7 @@ static void *server_thread(void *data)
>
>  static void setup_vm_with_server(IVState *s, int nvectors, bool msi)
>  {
> -    char *cmd =3D g_strdup_printf("-chardev socket,id=3Dchr0,path=3D%s,n=
owait "
> +    char *cmd =3D g_strdup_printf("-chardev socket,id=3Dchr0,path=3D%s "
>                                  "-device ivshmem%s,chardev=3Dchr0,vector=
s=3D%d",
>                                  tmpserver,
>                                  msi ? "-doorbell" : ",size=3D1M,msi=3Dof=
f",
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 55750dd68d..79bcb24b1c 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -232,9 +232,9 @@ QTestState *qtest_init_without_qmp_handshake(const ch=
ar *extra_args)
>      qtest_add_abrt_handler(kill_qemu_hook_func, s);
>
>      command =3D g_strdup_printf("exec %s "
> -                              "-qtest unix:%s,nowait "
> +                              "-qtest unix:%s "
>                                "-qtest-log %s "
> -                              "-chardev socket,path=3D%s,nowait,id=3Dcha=
r0 "
> +                              "-chardev socket,path=3D%s,id=3Dchar0 "
>                                "-mon chardev=3Dchar0,mode=3Dcontrol "
>                                "-machine accel=3Dqtest "
>                                "-display none "
> diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirecto=
r.c
> index 9ca9feabf8..6dc21dd4fb 100644
> --- a/tests/test-filter-redirector.c
> +++ b/tests/test-filter-redirector.c
> @@ -96,7 +96,7 @@ static void test_redirector_tx(void)
>          "-device %s,netdev=3Dqtest-bn0,id=3Dqtest-e0 "
>          "-chardev socket,id=3Dredirector0,path=3D%s,server,nowait "
>          "-chardev socket,id=3Dredirector1,path=3D%s,server,nowait "
> -        "-chardev socket,id=3Dredirector2,path=3D%s,nowait "
> +        "-chardev socket,id=3Dredirector2,path=3D%s "
>          "-object filter-redirector,id=3Dqtest-f0,netdev=3Dqtest-bn0,"
>          "queue=3Dtx,outdev=3Dredirector0 "
>          "-object filter-redirector,id=3Dqtest-f1,netdev=3Dqtest-bn0,"
> @@ -166,7 +166,7 @@ static void test_redirector_rx(void)
>          "-device %s,netdev=3Dqtest-bn0,id=3Dqtest-e0 "
>          "-chardev socket,id=3Dredirector0,path=3D%s,server,nowait "
>          "-chardev socket,id=3Dredirector1,path=3D%s,server,nowait "
> -        "-chardev socket,id=3Dredirector2,path=3D%s,nowait "
> +        "-chardev socket,id=3Dredirector2,path=3D%s "
>          "-object filter-redirector,id=3Dqtest-f0,netdev=3Dqtest-bn0,"
>          "queue=3Drx,indev=3Dredirector0 "
>          "-object filter-redirector,id=3Dqtest-f1,netdev=3Dqtest-bn0,"
> --
> 2.20.1
>
