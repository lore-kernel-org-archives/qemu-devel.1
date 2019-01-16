Received: from eggs.gnu.org ([209.51.188.92]:34106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjda2-0001mm-Ap
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjdZf-0000Lr-M7
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:17:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjdZf-0000Ix-Cn
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:17:11 -0500
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6f5b1e3a-2ef3-6c80-9e36-eea38092f155@redhat.com>
Date: Wed, 16 Jan 2019 06:17:03 +0100
MIME-Version: 1.0
In-Reply-To: <20190115145256.9593-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 2019-01-15 15:52, Daniel P. Berrang=C3=A9 wrote:
> The 'wait'/'nowait' parameter is used to tell server sockets whether to
> block until a client is accepted during initialization. Client chardevs
> have always silently ignored this option. Various tests were mistakenly
> passing this option for their client chardevs.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  chardev/char-socket.c          | 12 +++++++++++-
>  tests/ivshmem-test.c           |  2 +-
>  tests/libqtest.c               |  4 ++--
>  tests/test-filter-redirector.c |  4 ++--
>  4 files changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 4570755adf..233f16f72d 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1047,6 +1047,12 @@ static bool qmp_chardev_validate_socket(ChardevS=
ocket *sock,
>              error_setg(errp, "%s", "Websocket client is not implemente=
d");
>              return false;
>          }
> +        if (sock->has_wait) {
> +            error_setg(errp, "%s",
> +                       "'wait' option is incompatible with "
> +                       "socket in client connect mode");
> +            return false;
> +        }
>      }
> =20
>      return true;
> @@ -1220,7 +1226,11 @@ static void qemu_chr_parse_socket(QemuOpts *opts=
, ChardevBackend *backend,
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
> =20
>  static void setup_vm_with_server(IVState *s, int nvectors, bool msi)
>  {
> -    char *cmd =3D g_strdup_printf("-chardev socket,id=3Dchr0,path=3D%s=
,nowait "
> +    char *cmd =3D g_strdup_printf("-chardev socket,id=3Dchr0,path=3D%s=
 "
>                                  "-device ivshmem%s,chardev=3Dchr0,vect=
ors=3D%d",
>                                  tmpserver,
>                                  msi ? "-doorbell" : ",size=3D1M,msi=3D=
off",

I think there will be a conflict with the patch 'Remove deprecated
"ivshmem" legacy device' that is currently in Michael's PULL request ...
could you please rebase this patch in a day or two once that PULL has
been merged?

Apart from that, patch looks fine to me.

Acked-by: Thomas Huth <thuth@redhat.com>
