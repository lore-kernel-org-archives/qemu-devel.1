Received: from eggs.gnu.org ([2001:4830:134:3::10]:47143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAblp-00070m-CP
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAbll-0003SV-BM
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dAbll-0003Rd-0M
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:40:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94A10C05972F
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 12:39:58 +0000 (UTC)
Date: Tue, 16 May 2017 13:39:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170516123951.GB16341@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170428121553.22408-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170428121553.22408-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sockets: ensure we can bind to both ipv4 &
 ipv6 separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Apr 28, 2017 at 01:15:53PM +0100, Daniel P. Berrange wrote:
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
> ---
>  util/qemu-sockets.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)

Ping Paolo or Gerd - any comments on this patch ?

Separately from this patch, I noticed one further possible
problem, 

Currently, the ipv4=on|off/ipv6=on|off settings are only
used to determine what getaddrinfo results we request/use.

This leads to the somewhat odd situation where if you set
ipv4=off,ipv6=on, QEMU won't be listening on an IPv4
socket, but *will still* accept IPv4 clients over the IPv6
socket due to our use of IPV6_V6ONLY=off.

So I'm thinking that when ipv4=off, we should in fact
set IPV6_V6ONLY=on.  My fear though is that this is a
semantic change that could cause regression. ie someone
might be accidentally relying on fact that ipv4=off,ipv6=on
still lets IPv4 clients connection, despite it being a
somewhat nonsensical scenario



> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 8188d9a..75d1e0f 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -207,22 +207,36 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
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
>              inet_setport(e, p);
> +#ifdef IPV6_V6ONLY
> +            if (e->ai_family == PF_INET6) {
> +                /* listen on both ipv4 and ipv6 */
> +                const int off = 0;
> +                qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &off,
> +                                sizeof(off));
> +            }
> +#endif
>              if (bind(slisten, e->ai_addr, e->ai_addrlen) == 0) {
>                  goto listen;
>              }
> +
> +#ifdef IPV6_V6ONLY
> +            if (e->ai_family == PF_INET6 && errno == EADDRINUSE) {
> +                /* listen on only ipv6 */
> +                const int on = 1;
> +                qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &on,
> +                                sizeof(on));
> +
> +                if (bind(slisten, e->ai_addr, e->ai_addrlen) == 0) {
> +                    goto listen;
> +                }
> +            }
> +#endif
> +
>              if (p == port_max) {
>                  if (!e->ai_next) {
>                      error_setg_errno(errp, errno, "Failed to bind socket");
> -- 
> 2.9.3
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
