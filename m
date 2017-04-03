Received: from eggs.gnu.org ([2001:4830:134:3::10]:48770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv18u-0003uB-5u
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv18p-0003CC-9f
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:31:32 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv18p-0003C7-5E
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:31:27 -0400
Received: by mail-qk0-x244.google.com with SMTP id p22so18992497qka.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:31:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1490268208-23368-1-git-send-email-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e82055bb-2322-a6f6-39cb-778f647f23ae@amsat.org>
Date: Mon, 3 Apr 2017 09:31:22 -0300
MIME-Version: 1.0
In-Reply-To: <1490268208-23368-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: pbonzini@redhat.com, kraxel@redhat.com

On 03/23/2017 08:23 AM, Markus Armbruster wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
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
