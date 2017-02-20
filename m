Received: from eggs.gnu.org ([2001:4830:134:3::10]:43097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfv6Z-0006sD-Gw
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 16:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfv6V-0005cu-Ie
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 16:02:43 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfv6V-0005co-Dx
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 16:02:39 -0500
Received: by mail-qt0-x244.google.com with SMTP id x35so4782113qtc.1
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 13:02:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170220185020.774-1-dgilbert@redhat.com>
	<20170220185020.774-4-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <131d13b5-a960-fc5c-4400-cafdf3f96245@amsat.org>
Date: Mon, 20 Feb 2017 18:02:34 -0300
MIME-Version: 1.0
In-Reply-To: <20170220185020.774-4-dgilbert@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 3/5] slirp: Common lhost/fhost union
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com
Cc: quintela@redhat.com

On 02/20/2017 03:50 PM, Dr. David Alan Gilbert (git) wrote:
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
