Received: from eggs.gnu.org ([2001:4830:134:3::10]:52234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ondrejj@salstar.sk>) id 1csScR-0001Vb-Lp
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ondrejj@salstar.sk>) id 1csScM-00012Z-NZ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:15:27 -0400
Received: from work.salstar.sk ([158.197.240.41]:47628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ondrejj@salstar.sk>) id 1csScM-00011y-Cz
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:15:22 -0400
Date: Mon, 27 Mar 2017 13:15:16 +0200
From: =?utf-8?B?SsOhbiBPTkRSRUogKFNBTCk=?= <ondrejj@salstar.sk>
Message-ID: <20170327111515.GR7358@salstar.sk>
References: <db8ccb55-0570-4b6f-1635-7df2ff0b9ec3@redhat.com>
	<20170326183908.cogmdiisen2jlsh5@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170326183908.cogmdiisen2jlsh5@var.youpi.perso.aquilenet.fr>
Subject: Re: [Qemu-devel] slirp + ipxe + ipv6 dns issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Cole Robinson <crobinso@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hello Samuel,

  I tested your patch and solved my problem. Thank you.
My version: qemu-kvm-2.7.1-4.fc25.x86_64 + your patch.
Original qemu-kvm-2.7.1-4.fc25.x86_64 didn't work.

Cole, thanks for reporting. Consider applying this to Fedora package.

I am not a member of qemu-devel, so this mail will be probably rejected
from this list. Please forward it if requested.

							SAL

On Sun, Mar 26, 2017 at 08:39:08PM +0200, Samuel Thibault wrote:
> Hello,
> 
> Cole Robinson, on ven. 24 mars 2017 21:17:43 -0400, wrote:
> > I bisected to this commit:
> > 
> >     slirp: Add RDNSS advertisement
> 
> Mmm, I see.  Could you try the attached patch to confirm that it fixes
> the issue for you too?
> 
> Samuel

> diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
> index 298a48dd25..00183e5945 100644
> --- a/slirp/ip6_icmp.c
> +++ b/slirp/ip6_icmp.c
> @@ -143,17 +143,10 @@ void ndp_send_ra(Slirp *slirp)
>      /* Build IPv6 packet */
>      struct mbuf *t = m_get(slirp);
>      struct ip6 *rip = mtod(t, struct ip6 *);
> +    size_t pl_size = 0;
>      rip->ip_src = (struct in6_addr)LINKLOCAL_ADDR;
>      rip->ip_dst = (struct in6_addr)ALLNODES_MULTICAST;
>      rip->ip_nh = IPPROTO_ICMPV6;
> -    rip->ip_pl = htons(ICMP6_NDP_RA_MINLEN
> -                        + NDPOPT_LINKLAYER_LEN
> -                        + NDPOPT_PREFIXINFO_LEN
> -#ifndef _WIN32
> -                        + NDPOPT_RDNSS_LEN
> -#endif
> -                        );
> -    t->m_len = sizeof(struct ip6) + ntohs(rip->ip_pl);
>  
>      /* Build ICMPv6 packet */
>      t->m_data += sizeof(struct ip6);
> @@ -171,6 +164,7 @@ void ndp_send_ra(Slirp *slirp)
>      ricmp->icmp6_nra.reach_time = htonl(NDP_AdvReachableTime);
>      ricmp->icmp6_nra.retrans_time = htonl(NDP_AdvRetransTime);
>      t->m_data += ICMP6_NDP_RA_MINLEN;
> +    pl_size += ICMP6_NDP_RA_MINLEN;
>  
>      /* Source link-layer address (NDP option) */
>      struct ndpopt *opt = mtod(t, struct ndpopt *);
> @@ -178,6 +172,7 @@ void ndp_send_ra(Slirp *slirp)
>      opt->ndpopt_len = NDPOPT_LINKLAYER_LEN / 8;
>      in6_compute_ethaddr(rip->ip_src, opt->ndpopt_linklayer);
>      t->m_data += NDPOPT_LINKLAYER_LEN;
> +    pl_size += NDPOPT_LINKLAYER_LEN;
>  
>      /* Prefix information (NDP option) */
>      struct ndpopt *opt2 = mtod(t, struct ndpopt *);
> @@ -192,27 +187,30 @@ void ndp_send_ra(Slirp *slirp)
>      opt2->ndpopt_prefixinfo.reserved2 = 0;
>      opt2->ndpopt_prefixinfo.prefix = slirp->vprefix_addr6;
>      t->m_data += NDPOPT_PREFIXINFO_LEN;
> +    pl_size += NDPOPT_PREFIXINFO_LEN;
>  
> -#ifndef _WIN32
>      /* Prefix information (NDP option) */
> -    /* disabled for windows for now, until get_dns6_addr is implemented */
> -    struct ndpopt *opt3 = mtod(t, struct ndpopt *);
> -    opt3->ndpopt_type = NDPOPT_RDNSS;
> -    opt3->ndpopt_len = NDPOPT_RDNSS_LEN / 8;
> -    opt3->ndpopt_rdnss.reserved = 0;
> -    opt3->ndpopt_rdnss.lifetime = htonl(2 * NDP_MaxRtrAdvInterval);
> -    opt3->ndpopt_rdnss.addr = slirp->vnameserver_addr6;
> -    t->m_data += NDPOPT_RDNSS_LEN;
> -#endif
> +    {
> +        struct in6_addr addr;
> +        uint32_t scope_id;
> +        if (get_dns6_addr(&addr, &scope_id) >= 0) {
> +            /* Host system does have an IPv6 DNS server, announce our proxy.  */
> +            struct ndpopt *opt3 = mtod(t, struct ndpopt *);
> +            opt3->ndpopt_type = NDPOPT_RDNSS;
> +            opt3->ndpopt_len = NDPOPT_RDNSS_LEN / 8;
> +            opt3->ndpopt_rdnss.reserved = 0;
> +            opt3->ndpopt_rdnss.lifetime = htonl(2 * NDP_MaxRtrAdvInterval);
> +            opt3->ndpopt_rdnss.addr = slirp->vnameserver_addr6;
> +            t->m_data += NDPOPT_RDNSS_LEN;
> +            pl_size += NDPOPT_RDNSS_LEN;
> +        }
> +    }
> +
> +    rip->ip_pl = htons(pl_size);
> +    t->m_data -= sizeof(struct ip6) + pl_size;
> +    t->m_len = sizeof(struct ip6) + pl_size;
>  
>      /* ICMPv6 Checksum */
> -#ifndef _WIN32
> -    t->m_data -= NDPOPT_RDNSS_LEN;
> -#endif
> -    t->m_data -= NDPOPT_PREFIXINFO_LEN;
> -    t->m_data -= NDPOPT_LINKLAYER_LEN;
> -    t->m_data -= ICMP6_NDP_RA_MINLEN;
> -    t->m_data -= sizeof(struct ip6);
>      ricmp->icmp6_cksum = ip6_cksum(t);
>  
>      ip6_output(NULL, t, 0);
