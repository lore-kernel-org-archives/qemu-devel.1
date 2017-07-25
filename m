Received: from eggs.gnu.org ([2001:4830:134:3::10]:43484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZwIW-0000Vv-OL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZwIT-00023F-0G
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:38:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dZwIS-00022l-Mp
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:38:32 -0400
Date: Tue, 25 Jul 2017 10:38:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725093824.GJ26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.28627297ce9b47260986349ac22bf2de37bb9be6.1500709594.git-series.knut.omang@oracle.com>
	<ee5cd7796873b061804bf6f8546759109473000b.1500709594.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee5cd7796873b061804bf6f8546759109473000b.1500709594.git-series.knut.omang@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/4] sockets: factor out
 create_fast_reuse_socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Sat, Jul 22, 2017 at 09:49:31AM +0200, Knut Omang wrote:
> First refactoring step to prepare for fixing the problem
> exposed with the test-listen test in the previous commit
> 
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  util/qemu-sockets.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 1358c81..578f25b 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -149,6 +149,20 @@ int inet_ai_family_from_address(InetSocketAddress *addr,
>      return PF_UNSPEC;
>  }
>  
> +static int create_fast_reuse_socket(struct addrinfo *e, Error **errp)
> +{
> +    int slisten = qemu_socket(e->ai_family, e->ai_socktype, e->ai_protocol);
> +    if (slisten < 0) {
> +        if (!e->ai_next) {
> +            error_setg_errno(errp, errno, "Failed to create socket");
> +        }
> +        return -1;
> +    }
> +
> +    socket_set_fast_reuse(slisten);
> +    return slisten;
> +}

As mentioned in the previous review, I don't think we should have
methods like this which sometimes report an error on failure, and
sometimes don't report an error. It makes it hard to review the
callers for correctness of error handling. 

> +
>  static int inet_listen_saddr(InetSocketAddress *saddr,
>                               int port_offset,
>                               bool update_addr,
> @@ -210,21 +224,17 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
>          return -1;
>      }
>  
> -    /* create socket + bind */
> +    /* create socket + bind/listen */
>      for (e = res; e != NULL; e = e->ai_next) {
>          getnameinfo((struct sockaddr*)e->ai_addr,e->ai_addrlen,
>  		        uaddr,INET6_ADDRSTRLEN,uport,32,
>  		        NI_NUMERICHOST | NI_NUMERICSERV);
> -        slisten = qemu_socket(e->ai_family, e->ai_socktype, e->ai_protocol);
> +
> +        slisten = create_fast_reuse_socket(e, &err);
>          if (slisten < 0) {
> -            if (!e->ai_next) {
> -                error_setg_errno(errp, errno, "Failed to create socket");
> -            }

So please leave this here.

>              continue;
>          }
>  
> -        socket_set_fast_reuse(slisten);
> -
>          port_min = inet_getport(e);
>          port_max = saddr->has_to ? saddr->to + port_offset : port_min;
>          for (p = port_min; p <= port_max; p++) {


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
