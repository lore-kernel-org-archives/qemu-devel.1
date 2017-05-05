Received: from eggs.gnu.org ([2001:4830:134:3::10]:40479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6mdT-00079q-9m
	for qemu-devel@nongnu.org; Fri, 05 May 2017 19:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6mdS-00087R-EY
	for qemu-devel@nongnu.org; Fri, 05 May 2017 19:27:43 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:42158)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6mdS-00086t-8K
	for qemu-devel@nongnu.org; Fri, 05 May 2017 19:27:42 -0400
Date: Sat, 6 May 2017 01:27:38 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170505232738.targ5w5jm2vb73fe@var.youpi.perso.aquilenet.fr>
References: <20170505224833.17769-1-laurent@vivier.eu>
	<20170505224833.17769-2-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505224833.17769-2-laurent@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v4 1/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Hello,

Laurent Vivier, on sam. 06 mai 2017 00:48:33 +0200, wrote:
> @@ -617,6 +622,10 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
>                   * Check sockets for reading
>                   */
>                  else if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) {
> +                    if (so->so_state & SS_ISFCONNECTING) {
> +                        socks5_recv(so->s, &so->so_proxy_state);
> +                        continue;
> +                    }

Again, I don't see how this can work with both socks5 case and
non-socks5 case.  Don't we need to somehow check for the type of socket
before calling socks5_recv?

> @@ -645,11 +654,19 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
>                      /*
>                       * Check for non-blocking, still-connecting sockets
>                       */
> -                    if (so->so_state & SS_ISFCONNECTING) {
> -                        /* Connected */
> -                        so->so_state &= ~SS_ISFCONNECTING;
>  
> -                        ret = send(so->s, (const void *) &ret, 0, 0);
> +                    if (so->so_state & SS_ISFCONNECTING) {
> +                        ret = socks5_send(so->s, slirp->proxy_user,

Ditto.

> diff --git a/slirp/socks5.c b/slirp/socks5.c
> new file mode 100644
> index 0000000..2bba045
> --- /dev/null
> +++ b/slirp/socks5.c
> @@ -0,0 +1,371 @@

In v2 of the patch, this was said to have "some parts from nmap/ncat
GPLv2".  Is that really not true any more?  If any part of the file is
not original, it *has* to wear proper copyright notices, otherwise it's
copyright infrigement.

Also, see the bot build error report: <sys/socket.h> doesn't exist on
windows,

#include <windows.h>
#include <winsock2.h>
#include <ws2tcpip.h>

should be used instead.

Samuel
