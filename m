Received: from eggs.gnu.org ([2001:4830:134:3::10]:39422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fjmnq-0006Ar-5A
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 10:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fjmnn-0004vA-2v
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 10:36:10 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:32790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fjmnm-0004u9-R3
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 10:36:06 -0400
Date: Sun, 29 Jul 2018 16:36:03 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180729143603.c5gttlsperko4lso@var.youpi.perso.aquilenet.fr>
References: <20180729015426.67133-1-aoates@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729015426.67133-1-aoates@google.com>
Subject: Re: [Qemu-devel] [PATCH v2] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aoates@google.com
Cc: qemu-devel@nongnu.org, jan.kiszka@siemens.com

Hello,

aoates@google.com, le sam. 28 juil. 2018 21:54:26 -0400, a ecrit:
> From: Andrew Oates <aoates@google.com>
> 
> On Linux, SOCK_DGRAM+IPPROTO_ICMP sockets give only the ICMP packet when
> read from.  On macOS, however, the socket acts like a SOCK_RAW socket
> and includes the IP header as well.
> 
> This change strips the extra IP header from the received packet on macOS
> before sending it to the guest.
> 
> Signed-off-by: Andrew Oates <aoates@google.com>

Applied to my tree, thanks!

> ---
> v2: check validity of inner_hlen and update len appropriately
> 
>  slirp/ip_icmp.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
> index 0b667a429a..76c6d54b11 100644
> --- a/slirp/ip_icmp.c
> +++ b/slirp/ip_icmp.c
> @@ -420,7 +420,21 @@ void icmp_receive(struct socket *so)
>      icp = mtod(m, struct icmp *);
>  
>      id = icp->icmp_id;
> -    len = qemu_recv(so->s, icp, m->m_len, 0);
> +    len = qemu_recv(so->s, icp, M_ROOM(m), 0);
> +#ifdef CONFIG_DARWIN
> +    if (len > 0) {
> +        /* Skip the IP header that OS X (unlike Linux) includes. */
> +        struct ip *inner_ip = mtod(m, struct ip *);
> +        int inner_hlen = inner_ip->ip_hl << 2;
> +        if (inner_hlen > len) {
> +            len = -1;
> +            errno = -EINVAL;
> +        } else {
> +            len -= inner_hlen;
> +            memmove(icp, (unsigned char *)icp + inner_hlen, len);
> +        }
> +    }
> +#endif
>      icp->icmp_id = id;
>  
>      m->m_data -= hlen;
> -- 
> 2.17.0
> 

-- 
Samuel
"...Unix, MS-DOS, and Windows NT (also known as the Good, the Bad, and
the Ugly)."
(By Matt Welsh)
