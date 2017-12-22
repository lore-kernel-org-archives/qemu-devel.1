Received: from eggs.gnu.org ([2001:4830:134:3::10]:59717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNso-0001yi-Dt
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNsc-00006b-KH
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:01:06 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:43985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eSNsc-00005p-B3
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:00:54 -0500
Received: by mail-wm0-x244.google.com with SMTP id n138so21968349wmg.2
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 06:00:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171222134527.14467-3-berrange@redhat.com>
References: <20171222134527.14467-1-berrange@redhat.com>
	<20171222134527.14467-3-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Dec 2017 15:00:52 +0100
Message-ID: <CAJ+F1CJNV29V7-TC97CNaPYnwKcT+7FdNNDgsjZR5WN1G_ixKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/8] sockets: move fd_is_socket() into
 common sockets code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Fri, Dec 22, 2017 at 2:45 PM, Daniel P. Berrange <berrange@redhat.com> w=
rote:
> The fd_is_socket() helper method is useful in a few places, so put it in
> the common sockets code. Make the code more compact while moving it.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Now that you do some code change, it would be welcome with a small unit tes=
t ;)

anyway,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/qemu/sockets.h |  1 +
>  io/channel-util.c      | 13 -------------
>  util/qemu-sockets.c    |  8 ++++++++
>  3 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
> index 4f7311b52a..5680880f5a 100644
> --- a/include/qemu/sockets.h
> +++ b/include/qemu/sockets.h
> @@ -12,6 +12,7 @@ int inet_aton(const char *cp, struct in_addr *ia);
>  #include "qapi-types.h"
>
>  /* misc helpers */
> +bool fd_is_socket(int fd);
>  int qemu_socket(int domain, int type, int protocol);
>  int qemu_accept(int s, struct sockaddr *addr, socklen_t *addrlen);
>  int socket_set_cork(int fd, int v);
> diff --git a/io/channel-util.c b/io/channel-util.c
> index 0fb4bd0837..423d79845a 100644
> --- a/io/channel-util.c
> +++ b/io/channel-util.c
> @@ -24,19 +24,6 @@
>  #include "io/channel-socket.h"
>
>
> -static bool fd_is_socket(int fd)
> -{
> -    int optval;
> -    socklen_t optlen;
> -    optlen =3D sizeof(optval);
> -    return qemu_getsockopt(fd,
> -                           SOL_SOCKET,
> -                           SO_TYPE,
> -                           (char *)&optval,
> -                           &optlen) =3D=3D 0;
> -}
> -
> -
>  QIOChannel *qio_channel_new_fd(int fd,
>                                 Error **errp)
>  {
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index af4f01211a..5e42f6d88d 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -91,6 +91,14 @@ NetworkAddressFamily inet_netfamily(int family)
>      return NETWORK_ADDRESS_FAMILY_UNKNOWN;
>  }
>
> +bool fd_is_socket(int fd)
> +{
> +    int optval;
> +    socklen_t optlen =3D sizeof(optval);
> +    return !qemu_getsockopt(fd, SOL_SOCKET, SO_TYPE, &optval, &optlen);
> +}
> +
> +
>  /*
>   * Matrix we're trying to apply
>   *
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
