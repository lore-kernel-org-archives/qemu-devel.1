Received: from eggs.gnu.org ([2001:4830:134:3::10]:57991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGeSs-0001J3-G0
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 00:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGeSr-0003sd-35
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 00:45:34 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGeSq-0003sK-SR
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 00:45:33 -0400
Received: by mail-oi0-x243.google.com with SMTP id w138so9946398oiw.3
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 21:45:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170601082935.19993-1-berrange@redhat.com>
	<20170601082935.19993-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <30c8be72-96cc-e107-ac8f-42216dcba4b9@amsat.org>
Date: Fri, 2 Jun 2017 01:45:28 -0300
MIME-Version: 1.0
In-Reply-To: <20170601082935.19993-4-berrange@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] sockets: ensure we don't accept
 IPv4 clients when IPv4 is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On 06/01/2017 05:29 AM, Daniel P. Berrange wrote:
> Currently if you disable listening on IPv4 addresses, via the
> CLI flag ipv4=off, we still mistakenly accept IPv4 clients via
> the IPv6 listener socket due to IPV6_V6ONLY flag being unset.
>
> We must ensure IPV6_V6ONLY is always set if ipv4=off
>
> This fixes the following scenarios
>
>   -incoming tcp::9000,ipv6=on
>   -incoming tcp:[::]:9000,ipv6=on
>   -chardev socket,id=cdev0,host=,port=9000,server,nowait,ipv4=off
>   -chardev socket,id=cdev0,host=,port=9000,server,nowait,ipv6=on
>   -chardev socket,id=cdev0,host=::,port=9000,server,nowait,ipv4=off
>   -chardev socket,id=cdev0,host=::,port=9000,server,nowait,ipv6=on
>
> which all mistakenly accepted IPv4 clients
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  util/qemu-sockets.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
>
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 81bc8de..852773d 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -104,17 +104,16 @@ NetworkAddressFamily inet_netfamily(int family)
>   *   f     t       PF_INET6
>   *   t     -       PF_INET
>   *   t     f       PF_INET
> - *   t     t       PF_INET6
> + *   t     t       PF_INET6/PF_UNSPEC
>   *
>   * NB, this matrix is only about getting the necessary results
>   * from getaddrinfo(). Some of the cases require further work
>   * after reading results from getaddrinfo in order to fully
> - * apply the logic the end user wants. eg with the last case
> - * ipv4=t + ipv6=t + PF_INET6, getaddrinfo alone can only
> - * guarantee the ipv6=t part of the request - we need more
> - * checks to provide ipv4=t part of the guarantee. This is
> - * outside scope of this method and not currently handled by
> - * callers at all.
> + * apply the logic the end user wants.
> + *
> + * In the first and last cases, we must set IPV6_V6ONLY=0
> + * when binding, to allow a single listener to potentially
> + * accept both IPv4+6 addresses.
>   */
>  int inet_ai_family_from_address(InetSocketAddress *addr,
>                                  Error **errp)
> @@ -124,6 +123,23 @@ int inet_ai_family_from_address(InetSocketAddress *addr,
>          error_setg(errp, "Cannot disable IPv4 and IPv6 at same time");
>          return PF_UNSPEC;
>      }
> +    if ((addr->has_ipv6 && addr->ipv6) && (addr->has_ipv4 && addr->ipv4)) {
> +        /*
> +         * Some backends can only do a single listener. In that case
> +         * we want empty hostname to resolve to "::" and then use the
> +         * flag IPV6_V6ONLY==0 to get both protocols on 1 socket. This
> +         * doesn't work for addresses other than "", so they're just
> +         * inevitably broken until multiple listeners can be used,
> +         * and thus we honour getaddrinfo automatic protocol detection
> +         * Once all backends do multi-listener, remove the PF_INET6
> +         * branch entirely.
> +         */
> +        if (!addr->host || g_str_equal(addr->host, "")) {
> +            return PF_INET6;
> +        } else {
> +            return PF_UNSPEC;
> +        }
> +    }
>      if ((addr->has_ipv6 && addr->ipv6) || (addr->has_ipv4 && !addr->ipv4)) {
>          return PF_INET6;
>      }
> @@ -213,8 +229,14 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
>          port_max = saddr->has_to ? saddr->to + port_offset : port_min;
>          for (p = port_min; p <= port_max; p++) {
>  #ifdef IPV6_V6ONLY
> -            /* listen on both ipv4 and ipv6 */
> -            int v6only = 0;
> +            /*
> +             * Deals with first & last cases in matrix in comment
> +             * for inet_ai_family_from_address().
> +             */
> +            int v6only =
> +                ((!saddr->has_ipv4 && !saddr->has_ipv6) ||
> +                 (saddr->has_ipv4 && saddr->ipv4 &&
> +                  saddr->has_ipv6 && saddr->ipv6)) ? 0 : 1;
>  #endif
>              inet_setport(e, p);
>  #ifdef IPV6_V6ONLY
>
