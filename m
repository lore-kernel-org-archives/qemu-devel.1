Received: from eggs.gnu.org ([2001:4830:134:3::10]:49704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fjTP8-0004R5-Oo
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 13:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fjTP5-0002bK-N9
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 13:53:22 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:55454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fjTP5-0002Yj-GW
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 13:53:19 -0400
Date: Sat, 28 Jul 2018 19:53:14 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180728175314.3g7m4o7woidlaea6@var.youpi.perso.aquilenet.fr>
References: <20180726010812.5909-1-aoates@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726010812.5909-1-aoates@google.com>
Subject: Re: [Qemu-devel] [PATCH] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aoates@google.com
Cc: jan.kiszka@siemens.com, qemu-devel@nongnu.org

Hello,

aoates@google.com, le mer. 25 juil. 2018 21:08:12 -0400, a ecrit:
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
> ---
>  slirp/ip_icmp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
> index 0b667a429a..5fa67814f4 100644
> --- a/slirp/ip_icmp.c
> +++ b/slirp/ip_icmp.c
> @@ -420,7 +420,15 @@ void icmp_receive(struct socket *so)
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
> +        memmove(icp, (unsigned char *)icp + inner_hlen, len - inner_hlen);

Please also check that the provided inner_hlen is not bigger than len.
(otherwise it'd be a security issue). Also, substract inner_len from len
for coherency. In case inner_len is bigger than len, you'd set len to -1
and set errno to EINVAL, handled below.

Thanks,
Samuel
