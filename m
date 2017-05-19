Received: from eggs.gnu.org ([2001:4830:134:3::10]:46606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBrJC-0000ch-Ta
	for qemu-devel@nongnu.org; Fri, 19 May 2017 19:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBrJ8-0008Ds-0n
	for qemu-devel@nongnu.org; Fri, 19 May 2017 19:27:46 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBrJ7-0008Be-OM
	for qemu-devel@nongnu.org; Fri, 19 May 2017 19:27:41 -0400
Received: by mail-oi0-x242.google.com with SMTP id w138so14671501oiw.3
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 16:27:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170519180342.19618-1-berrange@redhat.com>
	<20170519180342.19618-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a70c02ea-d6e8-c9c3-a078-0df3faaff9f9@amsat.org>
Date: Fri, 19 May 2017 20:27:38 -0300
MIME-Version: 1.0
In-Reply-To: <20170519180342.19618-2-berrange@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] sockets: ensure we can bind to both
 ipv4 & ipv6 separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 05/19/2017 03:03 PM, Daniel P. Berrange wrote:
> When binding to an IPv6 socket we currently force the
> IPV6_V6ONLY flag to off. This means that the IPv6 socket
> will accept both IPv4 & IPv6 sockets when QEMU is launched
> with something like
>
>   -vnc :::1
>
> While this is good for that case, it is bad for other
> cases. For example if an empty hostname is given,
> getaddrinfo resolves it to 2 addresses 0.0.0.0 and ::,
> in that order. We will thus bind to 0.0.0.0 first, and
> then fail to bind to :: on the same port. The same
> problem can happen if any other hostname lookup causes
> the IPv4 address to be reported before the IPv6 address.
>
> When we get an IPv6 bind failure, we should re-try the
> same port, but with IPV6_V6ONLY turned on again, to
> avoid clash with any IPv4 listener.
>
> This ensures that
>
>   -vnc :1
>
> will bind successfully to both 0.0.0.0 and ::, and also
> avoid
>
>   -vnc :1,to=2
>
> from mistakenly using a 2nd port for the :: listener.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  util/qemu-sockets.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index d8183f7..397212b 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -208,22 +208,37 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
>          }
>
>          socket_set_fast_reuse(slisten);
> -#ifdef IPV6_V6ONLY
> -        if (e->ai_family == PF_INET6) {
> -            /* listen on both ipv4 and ipv6 */
> -            const int off = 0;
> -            qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &off,
> -                            sizeof(off));
> -        }
> -#endif
>
>          port_min = inet_getport(e);
>          port_max = saddr->has_to ? saddr->to + port_offset : port_min;
>          for (p = port_min; p <= port_max; p++) {
> +#ifdef IPV6_V6ONLY
> +            /* listen on both ipv4 and ipv6 */
> +            int v6only = 0;
> +#endif
>              inet_setport(e, p);
> +#ifdef IPV6_V6ONLY
> +        rebind:
> +            if (e->ai_family == PF_INET6) {
> +                qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &v6only,
> +                                sizeof(v6only));
> +            }
> +#endif
>              if (bind(slisten, e->ai_addr, e->ai_addrlen) == 0) {
>                  goto listen;
>              }
> +
> +#ifdef IPV6_V6ONLY
> +            /* If we got EADDRINUSE from an IPv6 bind & V6ONLY is unset,
> +             * it could be that the IPv4 port is already claimed, so retry
> +             * with V6ONLY set
> +             */
> +            if (e->ai_family == PF_INET6 && errno == EADDRINUSE && !v6only) {
> +                v6only = 1;
> +                goto rebind;
> +            }
> +#endif
> +
>              if (p == port_max) {
>                  if (!e->ai_next) {
>                      error_setg_errno(errp, errno, "Failed to bind socket");
>
