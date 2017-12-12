Received: from eggs.gnu.org ([2001:4830:134:3::10]:49632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOmlL-0007jn-Si
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOmlI-0002FU-It
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:46:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eOmlI-0002Ek-9v
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:46:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 477EE4A6EA
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 15:46:27 +0000 (UTC)
References: <20171212111219.32601-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f78b1ce3-9da6-f0aa-3451-b9a97237eb37@redhat.com>
Date: Tue, 12 Dec 2017 16:46:21 +0100
MIME-Version: 1.0
In-Reply-To: <20171212111219.32601-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sockets: remove obsolete code that updated
 listen address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 12/12/2017 12:12, Daniel P. Berrange wrote:
> When listening on unix/tcp sockets there was optional code that would update
> the original SocketAddress struct with the info about the actual address that
> was listened on. Since the conversion of everything to QIOChannelSocket, no
> remaining caller made use of this feature. It has been replaced with the ability
> to query the listen address after the fact using the function
> qio_channel_socket_get_local_address. This is a better model when the input
> address can result in listening on multiple distinct sockets.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/qemu/sockets.h |  2 +-
>  qga/channel-posix.c    |  2 +-
>  util/qemu-sockets.c    | 31 +++++--------------------------
>  3 files changed, 7 insertions(+), 28 deletions(-)
> 
> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
> index 4f7311b52a..8889bcb1ec 100644
> --- a/include/qemu/sockets.h
> +++ b/include/qemu/sockets.h
> @@ -35,7 +35,7 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp);
>  
>  NetworkAddressFamily inet_netfamily(int family);
>  
> -int unix_listen(const char *path, char *ostr, int olen, Error **errp);
> +int unix_listen(const char *path, Error **errp);
>  int unix_connect(const char *path, Error **errp);
>  
>  SocketAddress *socket_parse(const char *str, Error **errp);
> diff --git a/qga/channel-posix.c b/qga/channel-posix.c
> index 3f34465159..b812bf4d51 100644
> --- a/qga/channel-posix.c
> +++ b/qga/channel-posix.c
> @@ -190,7 +190,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
>          if (fd < 0) {
>              Error *local_err = NULL;
>  
> -            fd = unix_listen(path, NULL, strlen(path), &local_err);
> +            fd = unix_listen(path, &local_err);
>              if (local_err != NULL) {
>                  g_critical("%s", error_get_pretty(local_err));
>                  error_free(local_err);
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index a1cf47e625..703ce8ad8e 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -199,7 +199,6 @@ static int try_bind(int socket, InetSocketAddress *saddr, struct addrinfo *e)
>  
>  static int inet_listen_saddr(InetSocketAddress *saddr,
>                               int port_offset,
> -                             bool update_addr,
>                               Error **errp)
>  {
>      struct addrinfo ai,*res,*e;
> @@ -327,15 +326,6 @@ listen_failed:
>      return -1;
>  
>  listen_ok:
> -    if (update_addr) {
> -        g_free(saddr->host);
> -        saddr->host = g_strdup(uaddr);
> -        g_free(saddr->port);
> -        saddr->port = g_strdup_printf("%d",
> -                                      inet_getport(e) - port_offset);
> -        saddr->has_ipv6 = saddr->ipv6 = e->ai_family == PF_INET6;
> -        saddr->has_ipv4 = saddr->ipv4 = e->ai_family != PF_INET6;
> -    }
>      freeaddrinfo(res);
>      return slisten;
>  }
> @@ -791,7 +781,6 @@ static int vsock_parse(VsockSocketAddress *addr, const char *str,
>  #ifndef _WIN32
>  
>  static int unix_listen_saddr(UnixSocketAddress *saddr,
> -                             bool update_addr,
>                               Error **errp)
>  {
>      struct sockaddr_un un;
> @@ -856,12 +845,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>          goto err;
>      }
>  
> -    if (update_addr && pathbuf) {
> -        g_free(saddr->path);
> -        saddr->path = pathbuf;
> -    } else {
> -        g_free(pathbuf);
> -    }
> +    g_free(pathbuf);
>      return sock;
>  
>  err:
> @@ -921,7 +905,6 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
>  #else
>  
>  static int unix_listen_saddr(UnixSocketAddress *saddr,
> -                             bool update_addr,
>                               Error **errp)
>  {
>      error_setg(errp, "unix sockets are not available on windows");
> @@ -938,7 +921,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
>  #endif
>  
>  /* compatibility wrapper */
> -int unix_listen(const char *str, char *ostr, int olen, Error **errp)
> +int unix_listen(const char *str, Error **errp)
>  {
>      char *path, *optstr;
>      int sock, len;
> @@ -958,11 +941,7 @@ int unix_listen(const char *str, char *ostr, int olen, Error **errp)
>          saddr->path = g_strdup(str);
>      }
>  
> -    sock = unix_listen_saddr(saddr, true, errp);
> -
> -    if (sock != -1 && ostr) {
> -        snprintf(ostr, olen, "%s%s", saddr->path, optstr ? optstr : "");
> -    }
> +    sock = unix_listen_saddr(saddr, errp);
>  
>      qapi_free_UnixSocketAddress(saddr);
>      return sock;
> @@ -1053,11 +1032,11 @@ int socket_listen(SocketAddress *addr, Error **errp)
>  
>      switch (addr->type) {
>      case SOCKET_ADDRESS_TYPE_INET:
> -        fd = inet_listen_saddr(&addr->u.inet, 0, false, errp);
> +        fd = inet_listen_saddr(&addr->u.inet, 0, errp);
>          break;
>  
>      case SOCKET_ADDRESS_TYPE_UNIX:
> -        fd = unix_listen_saddr(&addr->u.q_unix, false, errp);
> +        fd = unix_listen_saddr(&addr->u.q_unix, errp);
>          break;
>  
>      case SOCKET_ADDRESS_TYPE_FD:
> 

Queued, thanks.

Paolo
