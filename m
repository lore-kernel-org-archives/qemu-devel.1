Received: from eggs.gnu.org ([2001:4830:134:3::10]:41209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPRGW-0004vN-I3
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPRGQ-0002gI-Lr
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:29:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dPRGQ-0002fy-CX
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:29:02 -0400
Date: Mon, 26 Jun 2017 11:28:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170626102852.GH495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.050aaed1de4cecd4ba9a4dc6576d1d148a8a9004.1498213152.git-series.knut.omang@oracle.com>
	<b107bc13f30e0b4a8ca8de1db178aef3fade9164.1498213152.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b107bc13f30e0b4a8ca8de1db178aef3fade9164.1498213152.git-series.knut.omang@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/4] sockets: factor out
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

On Fri, Jun 23, 2017 at 12:31:06PM +0200, Knut Omang wrote:
> First refactoring step to prepare for fixing the problem
> exposed with the test-listen test in the previous commit
> 
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  util/qemu-sockets.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 852773d..699e36c 100644
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

I think that having this method sometimes report an error message, and
sometimes not report an error message, depending on state of a variable
used by the caller is rather unpleasant. I'd much rather see this
error message reporting remain in the caller.

> +        return -1;
> +    }
> +
> +    socket_set_fast_reuse(slisten);
> +    return slisten;
> +}
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
>              continue;

It isn't shown in this diff context, but at the end of the outer
loop we have

   error_setg_errno(errp, errno, "Failed to find available port");

so IIUC, even this pre-existing code is wrong. If 'e->ai_next' is
NULL, we report an error message here. Then, we continue to the
next loop iteration, which causes use to terminate the loop
entirely. At which point we'll report another error message
over the top of the one we already have. So I think the error
reporting does still need refactoring, but not in the way it
is done here.

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
