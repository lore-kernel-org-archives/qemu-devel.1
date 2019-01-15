Received: from eggs.gnu.org ([209.51.188.92]:37204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUAI-0007gw-54
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:14:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUA8-0000iC-20
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:14:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gjUA5-0000eV-CP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:14:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id z18so2224974qkj.10
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 11:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-3-berrange@redhat.com>
In-Reply-To: <20190115145256.9593-3-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Jan 2019 23:13:55 +0400
Message-ID: <CAMxuvaysUdsSg7WEtwn3kz16JhzZMHubcw2z5KEP7jQ-c5ng+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/12] chardev: forbid 'reconnect' option
 with server sockets
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
> The 'reconnect' option is used to give the sleep time, in seconds,
> before a client socket attempts to re-establish a connection to the
> server. It does not make sense to set this for server sockets, as they
> will always accept a new client connection immediately after the
> previous one went away.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-socket.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 6669acb35f..4570755adf 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1035,7 +1035,14 @@ static bool qmp_chardev_validate_socket(ChardevSoc=
ket *sock,
>      }
>
>      /* Validate any options which have a dependancy on client vs server =
*/
> -    if (!(sock->has_server && sock->server)) {
> +    if (!sock->has_server || sock->server) {
> +        if (sock->has_reconnect) {
> +            error_setg(errp,
> +                       "'reconnect' option is incompatible with "
> +                       "socket in server listen mode");
> +            return false;
> +        }
> +    } else {
>          if (sock->has_websocket && sock->websocket) {
>              error_setg(errp, "%s", "Websocket client is not implemented"=
);
>              return false;
> --
> 2.20.1
>
