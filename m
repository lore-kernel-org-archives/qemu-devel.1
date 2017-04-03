Received: from eggs.gnu.org ([2001:4830:134:3::10]:49470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv6vK-0005Pb-FO
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv6vG-0006Yy-In
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:41:54 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv6vG-0006Yj-EY
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:41:50 -0400
Received: by mail-qk0-x244.google.com with SMTP id p68so161610qke.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 11:41:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170403171843.3363-1-dgilbert@redhat.com>
	<20170403171843.3363-4-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <246e17c1-001e-0aba-8849-86c253350280@amsat.org>
Date: Mon, 3 Apr 2017 15:41:46 -0300
MIME-Version: 1.0
In-Reply-To: <20170403171843.3363-4-dgilbert@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 3/5] slirp: Common lhost/fhost union
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, samuel.thibault@gnu.org, jan.kiszka@siemens.com
Cc: quintela@redhat.com

On 04/03/2017 02:18 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The socket structure has a pair of unions for lhost and fhost
> addresses; the unions are identical so split them out into
> a separate union declaration.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  slirp/socket.h | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/slirp/socket.h b/slirp/socket.h
> index 8feed2a..c1be77e 100644
> --- a/slirp/socket.h
> +++ b/slirp/socket.h
> @@ -15,6 +15,12 @@
>   * Our socket structure
>   */
>
> +union slirp_sockaddr {
> +    struct sockaddr_storage ss;
> +    struct sockaddr_in sin;
> +    struct sockaddr_in6 sin6;
> +};
> +
>  struct socket {
>    struct socket *so_next,*so_prev;      /* For a linked list of sockets */
>
> @@ -31,22 +37,14 @@ struct socket {
>    struct tcpiphdr *so_ti;	   /* Pointer to the original ti within
>  				    * so_mconn, for non-blocking connections */
>    int so_urgc;
> -  union {   /* foreign host */
> -      struct sockaddr_storage ss;
> -      struct sockaddr_in sin;
> -      struct sockaddr_in6 sin6;
> -  } fhost;
> +  union slirp_sockaddr fhost;      /* Foreign host */
>  #define so_faddr fhost.sin.sin_addr
>  #define so_fport fhost.sin.sin_port
>  #define so_faddr6 fhost.sin6.sin6_addr
>  #define so_fport6 fhost.sin6.sin6_port
>  #define so_ffamily fhost.ss.ss_family
>
> -  union {   /* local host */
> -      struct sockaddr_storage ss;
> -      struct sockaddr_in sin;
> -      struct sockaddr_in6 sin6;
> -  } lhost;
> +  union slirp_sockaddr lhost;      /* Local host */
>  #define so_laddr lhost.sin.sin_addr
>  #define so_lport lhost.sin.sin_port
>  #define so_laddr6 lhost.sin6.sin6_addr
>
