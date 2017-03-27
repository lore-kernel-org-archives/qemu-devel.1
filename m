Received: from eggs.gnu.org ([2001:4830:134:3::10]:56205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csVyO-0005CF-Nu
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csVyK-0006YF-Q9
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:50:20 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csVyK-0006YA-La
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:50:16 -0400
Received: by mail-qt0-x241.google.com with SMTP id x35so7901681qtc.1
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 07:50:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170326184634.25042-1-samuel.thibault@ens-lyon.org>
	<20170326184634.25042-2-samuel.thibault@ens-lyon.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7e4c1077-9ee2-616b-5317-d55780427907@amsat.org>
Date: Mon, 27 Mar 2017 11:50:13 -0300
MIME-Version: 1.0
In-Reply-To: <20170326184634.25042-2-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] slirp: Make RA build more flexible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, jan.kiszka@siemens.com

On 03/26/2017 03:46 PM, Samuel Thibault wrote:
> Do not hardcode the RA size at all, use a pl_size variable which
> accounts the accumulated size, and fill rip->ip_pl at the end.
>
> This will allow to make some blocks optional.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  slirp/ip6_icmp.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
> index 298a48dd25..d0f5cc1456 100644
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
> @@ -192,6 +187,7 @@ void ndp_send_ra(Slirp *slirp)
>      opt2->ndpopt_prefixinfo.reserved2 = 0;
>      opt2->ndpopt_prefixinfo.prefix = slirp->vprefix_addr6;
>      t->m_data += NDPOPT_PREFIXINFO_LEN;
> +    pl_size += NDPOPT_PREFIXINFO_LEN;
>
>  #ifndef _WIN32
>      /* Prefix information (NDP option) */
> @@ -203,16 +199,14 @@ void ndp_send_ra(Slirp *slirp)
>      opt3->ndpopt_rdnss.lifetime = htonl(2 * NDP_MaxRtrAdvInterval);
>      opt3->ndpopt_rdnss.addr = slirp->vnameserver_addr6;
>      t->m_data += NDPOPT_RDNSS_LEN;
> +    pl_size += NDPOPT_RDNSS_LEN;
>  #endif
>
> +    rip->ip_pl = htons(pl_size);
> +    t->m_data -= sizeof(struct ip6) + pl_size;
> +    t->m_len = sizeof(struct ip6) + pl_size;
> +
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
>
