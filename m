Received: from eggs.gnu.org ([2001:4830:134:3::10]:35317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr16W-00061e-B9
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr16S-0000Bd-FI
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:40:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr16S-0000As-5o
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:40:28 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56D1F64A78
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 11:40:27 +0000 (UTC)
References: <1490268208-23368-1-git-send-email-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24dcf0a9-971f-7576-f863-f7db01aa62aa@redhat.com>
Date: Thu, 23 Mar 2017 12:40:24 +0100
MIME-Version: 1.0
In-Reply-To: <1490268208-23368-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] sockets: Fix
 socket_address_to_string() hostname truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com



On 23/03/2017 12:23, Markus Armbruster wrote:
> We first snprintf() to a fixed buffer, then g_strdup() the result
> *boggle*.
> 
> Worse, the size of the fixed buffer INET6_ADDRSTRLEN + 5 + 4 is bogus:
> the 4 correctly accounts for '[', ']', ':' and '\0', but
> INET6_ADDRSTRLEN is not a suitable limit for inet->host, and 5 is not
> one for inet->port!  They are for host and port in *numeric* form
> (exploiting that INET6_ADDRSTRLEN > INET_ADDRSTRLEN), but inet->host
> can also be a hostname, and inet->port can be a service name, to be
> resolved with getaddrinfo().
> 
> Fortunately, the only user so far is the "socket" network backend's
> net_socket_connected(), which uses it to initialize a NetSocketState's
> info_str[].  info_str[] has considerable more space: 256 instead of
> 55.  So the bug's impact appears to be limited to truncated "info
> networks" with the "socket" network backend.
> 
> The fix is obvious: use g_strdup_printf().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/qemu-sockets.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 7c120c4..40164bf 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1307,19 +1307,14 @@ char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
>  {
>      char *buf;
>      InetSocketAddress *inet;
> -    char host_port[INET6_ADDRSTRLEN + 5 + 4];

/me learnt about INET6_ADDRSTRLEN today.

>      switch (addr->type) {
>      case SOCKET_ADDRESS_KIND_INET:
>          inet = addr->u.inet.data;
>          if (strchr(inet->host, ':') == NULL) {
> -            snprintf(host_port, sizeof(host_port), "%s:%s", inet->host,
> -                    inet->port);
> -            buf = g_strdup(host_port);
> +            buf = g_strdup_printf("%s:%s", inet->host, inet->port);
>          } else {
> -            snprintf(host_port, sizeof(host_port), "[%s]:%s", inet->host,
> -                    inet->port);
> -            buf = g_strdup(host_port);
> +            buf = g_strdup_printf("[%s]:%s", inet->host, inet->port);
>          }
>          break;
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
