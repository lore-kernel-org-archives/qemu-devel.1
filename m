Received: from eggs.gnu.org ([2001:4830:134:3::10]:52450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGpSL-0003Tp-QI
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGpSH-0002J9-PT
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:57:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1cGpSH-0002J3-Hc
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:57:25 -0500
References: <1480432054-12065-1-git-send-email-yuval.shaia@oracle.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <49d12199-a508-123f-61f6-5b9b87ed73bc@redhat.com>
Date: Tue, 13 Dec 2016 16:57:21 +0100
MIME-Version: 1.0
In-Reply-To: <1480432054-12065-1-git-send-email-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] slirp,
 disas: Replace min/max with MIN/MAX macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, laurent@vivier.eu, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com
Cc: qemu-devel@nongnu.org



On 29/11/2016 16:07, Yuval Shaia wrote:
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
> v0 -> v1:
> 	* Remove unndeeded "include" as suggested by Fam Zheng
> 	* Change commit message's prefix as suggested by Markus Armbruster
> 	* Utilize MIN macro in two extra places in file disas/m68k.c
> v1 -> v2:
> 	* Fix errros from checkpatch
> ---
>  disas/m68k.c       |  8 ++------
>  slirp/dhcpv6.c     |  2 +-
>  slirp/ip6_icmp.c   |  2 +-
>  slirp/slirp.c      |  2 +-
>  slirp/slirp.h      |  5 -----
>  slirp/tcp_input.c  | 16 ++++++++--------
>  slirp/tcp_output.c |  6 +++---
>  slirp/tcp_timer.c  |  2 +-
>  slirp/tcpip.h      |  2 +-
>  9 files changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git a/disas/m68k.c b/disas/m68k.c
> index 8e7c3f7..073abb9 100644
> --- a/disas/m68k.c
> +++ b/disas/m68k.c
> @@ -4698,10 +4698,6 @@ get_field (const unsigned char *data, enum floatformat_byteorders order,
>    return result;
>  }
>  
> -#ifndef min
> -#define min(a, b) ((a) < (b) ? (a) : (b))
> -#endif
> -
>  /* Convert from FMT to a double.
>     FROM is the address of the extended float.
>     Store the double in *TO.  */
> @@ -4733,7 +4729,7 @@ floatformat_to_double (const struct floatformat *fmt,
>        nan = 0;
>        while (mant_bits_left > 0)
>  	{
> -	  mant_bits = min (mant_bits_left, 32);
> +          mant_bits = MIN(mant_bits_left, 32);
>  
>  	  if (get_field (ufrom, fmt->byteorder, fmt->totalsize,
>  			 mant_off, mant_bits) != 0)
> @@ -4793,7 +4789,7 @@ floatformat_to_double (const struct floatformat *fmt,
>  
>    while (mant_bits_left > 0)
>      {
> -      mant_bits = min (mant_bits_left, 32);
> +      mant_bits = MIN(mant_bits_left, 32);
>  
>        mant = get_field (ufrom, fmt->byteorder, fmt->totalsize,
>  			 mant_off, mant_bits);
> diff --git a/slirp/dhcpv6.c b/slirp/dhcpv6.c
> index 02c51c7..d266611 100644
> --- a/slirp/dhcpv6.c
> +++ b/slirp/dhcpv6.c
> @@ -168,7 +168,7 @@ static void dhcpv6_info_request(Slirp *slirp, struct sockaddr_in6 *srcsas,
>                          sa[0], sa[1], sa[2], sa[3], sa[4], sa[5], sa[6], sa[7],
>                          sa[8], sa[9], sa[10], sa[11], sa[12], sa[13], sa[14],
>                          sa[15], slirp->bootp_filename);
> -        slen = min(slen, smaxlen);
> +        slen = MIN(slen, smaxlen);
>          *resp++ = slen >> 8;                    /* option-len high byte */
>          *resp++ = slen;                         /* option-len low byte */
>          resp += slen;
> diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
> index 6d18e28..298a48d 100644
> --- a/slirp/ip6_icmp.c
> +++ b/slirp/ip6_icmp.c
> @@ -95,7 +95,7 @@ void icmp6_send_error(struct mbuf *m, uint8_t type, uint8_t code)
>  #endif
>  
>      rip->ip_nh = IPPROTO_ICMPV6;
> -    const int error_data_len = min(m->m_len,
> +    const int error_data_len = MIN(m->m_len,
>              IF_MTU - (sizeof(struct ip6) + ICMP6_ERROR_MINLEN));
>      rip->ip_pl = htons(ICMP6_ERROR_MINLEN + error_data_len);
>      t->m_len = sizeof(struct ip6) + ntohs(rip->ip_pl);
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 6e2b4e5..60539de 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -774,7 +774,7 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
>  static void arp_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
>  {
>      struct slirp_arphdr *ah = (struct slirp_arphdr *)(pkt + ETH_HLEN);
> -    uint8_t arp_reply[max(ETH_HLEN + sizeof(struct slirp_arphdr), 64)];
> +    uint8_t arp_reply[MAX(ETH_HLEN + sizeof(struct slirp_arphdr), 64)];
>      struct ethhdr *reh = (struct ethhdr *)arp_reply;
>      struct slirp_arphdr *rah = (struct slirp_arphdr *)(arp_reply + ETH_HLEN);
>      int ar_op;
> diff --git a/slirp/slirp.h b/slirp/slirp.h
> index a1f3139..3877f66 100644
> --- a/slirp/slirp.h
> +++ b/slirp/slirp.h
> @@ -292,9 +292,4 @@ int tcp_emu(struct socket *, struct mbuf *);
>  int tcp_ctl(struct socket *);
>  struct tcpcb *tcp_drop(struct tcpcb *tp, int err);
>  
> -#ifndef _WIN32
> -#define min(x,y) ((x) < (y) ? (x) : (y))
> -#define max(x,y) ((x) > (y) ? (x) : (y))
> -#endif
> -
>  #endif
> diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
> index c5063a9..edb98f0 100644
> --- a/slirp/tcp_input.c
> +++ b/slirp/tcp_input.c
> @@ -596,7 +596,7 @@ findso:
>            win = sbspace(&so->so_rcv);
>  	  if (win < 0)
>  	    win = 0;
> -	  tp->rcv_wnd = max(win, (int)(tp->rcv_adv - tp->rcv_nxt));
> +          tp->rcv_wnd = MAX(win, (int)(tp->rcv_adv - tp->rcv_nxt));
>  	}
>  
>  	switch (tp->t_state) {
> @@ -1065,8 +1065,8 @@ trimthenstep6:
>  				else if (++tp->t_dupacks == TCPREXMTTHRESH) {
>  					tcp_seq onxt = tp->snd_nxt;
>  					u_int win =
> -					    min(tp->snd_wnd, tp->snd_cwnd) / 2 /
> -						tp->t_maxseg;
> +                                                MIN(tp->snd_wnd, tp->snd_cwnd) /
> +                                                2 / tp->t_maxseg;
>  
>  					if (win < 2)
>  						win = 2;
> @@ -1138,7 +1138,7 @@ trimthenstep6:
>  
>  		  if (cw > tp->snd_ssthresh)
>  		    incr = incr * incr / cw;
> -		  tp->snd_cwnd = min(cw + incr, TCP_MAXWIN<<tp->snd_scale);
> +                  tp->snd_cwnd = MIN(cw + incr, TCP_MAXWIN << tp->snd_scale);
>  		}
>  		if (acked > so->so_snd.sb_cc) {
>  			tp->snd_wnd -= so->so_snd.sb_cc;
> @@ -1586,11 +1586,11 @@ tcp_mss(struct tcpcb *tp, u_int offer)
>  
>  	switch (so->so_ffamily) {
>  	case AF_INET:
> -	    mss = min(IF_MTU, IF_MRU) - sizeof(struct tcphdr)
> +            mss = MIN(IF_MTU, IF_MRU) - sizeof(struct tcphdr)
>  	                              + sizeof(struct ip);
>  	    break;
>  	case AF_INET6:
> -	    mss = min(IF_MTU, IF_MRU) - sizeof(struct tcphdr)
> +            mss = MIN(IF_MTU, IF_MRU) - sizeof(struct tcphdr)
>  	                              + sizeof(struct ip6);
>  	    break;
>  	default:
> @@ -1598,8 +1598,8 @@ tcp_mss(struct tcpcb *tp, u_int offer)
>  	}
>  
>  	if (offer)
> -		mss = min(mss, offer);
> -	mss = max(mss, 32);
> +            mss = MIN(mss, offer);
> +        mss = MAX(mss, 32);
>  	if (mss < tp->t_maxseg || offer != 0)
>  	   tp->t_maxseg = mss;
>  
> diff --git a/slirp/tcp_output.c b/slirp/tcp_output.c
> index 819db27..90b5c37 100644
> --- a/slirp/tcp_output.c
> +++ b/slirp/tcp_output.c
> @@ -88,7 +88,7 @@ tcp_output(struct tcpcb *tp)
>  again:
>  	sendalot = 0;
>  	off = tp->snd_nxt - tp->snd_una;
> -	win = min(tp->snd_wnd, tp->snd_cwnd);
> +        win = MIN(tp->snd_wnd, tp->snd_cwnd);
>  
>  	flags = tcp_outflags[tp->t_state];
>  
> @@ -127,7 +127,7 @@ again:
>  		}
>  	}
>  
> -	len = min(so->so_snd.sb_cc, win) - off;
> +        len = MIN(so->so_snd.sb_cc, win) - off;
>  
>  	if (len < 0) {
>  		/*
> @@ -193,7 +193,7 @@ again:
>  		 * taking into account that we are limited by
>  		 * TCP_MAXWIN << tp->rcv_scale.
>  		 */
> -		long adv = min(win, (long)TCP_MAXWIN << tp->rcv_scale) -
> +                long adv = MIN(win, (long)TCP_MAXWIN << tp->rcv_scale) -
>  			(tp->rcv_adv - tp->rcv_nxt);
>  
>  		if (adv >= (long) (2 * tp->t_maxseg))
> diff --git a/slirp/tcp_timer.c b/slirp/tcp_timer.c
> index f9060c7..52ef5f9 100644
> --- a/slirp/tcp_timer.c
> +++ b/slirp/tcp_timer.c
> @@ -233,7 +233,7 @@ tcp_timers(register struct tcpcb *tp, int timer)
>  		 * to go below this.)
>  		 */
>  		{
> -		u_int win = min(tp->snd_wnd, tp->snd_cwnd) / 2 / tp->t_maxseg;
> +                u_int win = MIN(tp->snd_wnd, tp->snd_cwnd) / 2 / tp->t_maxseg;
>  		if (win < 2)
>  			win = 2;
>  		tp->snd_cwnd = tp->t_maxseg;
> diff --git a/slirp/tcpip.h b/slirp/tcpip.h
> index 7bdb971..07dbf2c 100644
> --- a/slirp/tcpip.h
> +++ b/slirp/tcpip.h
> @@ -85,7 +85,7 @@ struct tcpiphdr {
>  /* This is the difference between the size of a tcpiphdr structure, and the
>   * size of actual ip+tcp headers, rounded up since we need to align data.  */
>  #define TCPIPHDR_DELTA\
> -    (max(0,\
> +    (MAX(0,\
>           (sizeof(struct tcpiphdr)\
>            - sizeof(struct ip) - sizeof(struct tcphdr) + 3) & ~3))
>  
> 
