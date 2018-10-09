Received: from eggs.gnu.org ([2001:4830:134:3::10]:52672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9ocA-00030h-Mi
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9oc9-0006Rq-RY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:47:42 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9oc9-0006RL-Kq
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:47:41 -0400
Received: by mail-wr1-x442.google.com with SMTP id n1-v6so1069884wrt.10
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 02:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-14-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-14-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 13:47:28 +0400
Message-ID: <CAJ+F1CJ_XUDJdXfRCBT0Oz48=8RZaWP5HJuUZhpxP+vBVq41Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/31] net/socket: Fix invalid socket type
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

Hi
On Mon, Oct 8, 2018 at 9:45 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  net_socket_fd_init() does that, and then fails without
> setting an error.  Wrong.  I didn't analyze how exactly this can
> break.  A caller that reports the error on failure would crash.
>
> Broken when commit c37f0bb1d0d (v2.11.0) converted the function to
> Error.  Fix by calling error_setg() instead of error_report().
>
> Fixes: c37f0bb1d0d24e3a6b5f4659bb305913dcb798a6
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  net/socket.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index 6917fbcbf5..90ef3517be 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -453,8 +453,8 @@ static NetSocketState *net_socket_fd_init(NetClientSt=
ate *peer,
>      case SOCK_STREAM:
>          return net_socket_fd_init_stream(peer, model, name, fd, is_conne=
cted);
>      default:
> -        error_report("socket type=3D%d for fd=3D%d must be either"
> -                     " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
> +        error_setg(errp, "socket type=3D%d for fd=3D%d must be either"
> +                   " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
>          closesocket(fd);
>      }
>      return NULL;
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
