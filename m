Received: from eggs.gnu.org ([2001:4830:134:3::10]:42347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eTBYW-0002P2-Ia
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 14:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eTBYU-0002wV-Kt
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 14:03:28 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:44140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eTBYU-0002vf-8b
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 14:03:26 -0500
Received: by mail-wr0-x235.google.com with SMTP id l41so19665651wre.11
	for <qemu-devel@nongnu.org>; Sun, 24 Dec 2017 11:03:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <733fdfcb43ac149d8914014cd5eb4416077e3eae.1513933605.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1513933605.git.maozy.fnst@cn.fujitsu.com>
	<733fdfcb43ac149d8914014cd5eb4416077e3eae.1513933605.git.maozy.fnst@cn.fujitsu.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 25 Dec 2017 03:03:24 +0800
Message-ID: <CAK3tnvJnwuO58R99YG_=vw-0CRqgE50rjvbzzZKKxypK8oWaNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] colo: modified the payload compare
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

On Fri, Dec 22, 2017 at 5:28 PM, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
wrote:

> Modified the function colo_packet_compare_common to prepare for the
> tcp packet comparison in the next patch.
>
> Cc: Zhang Chen <zhangckid@gmail.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Jason Wang <jasowang@redhat.com>
>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>

Reviewed-by: Zhang Chen <zhangckid@gmail.com>


> ---
>  net/colo-compare.c | 88 +++++++++++++++++++++++++++---
> ------------------------
>  1 file changed, 44 insertions(+), 44 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 0ebdec9..f39ca02 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -190,10 +190,12 @@ static int packet_enqueue(CompareState *s, int mode,
> Connection **con)
>   * return:    0  means packet same
>   *            > 0 || < 0 means packet different
>   */
> -static int colo_packet_compare_common(Packet *ppkt,
> -                                      Packet *spkt,
> -                                      int poffset,
> -                                      int soffset)
> +static int colo_compare_packet_payload(Packet *ppkt,
> +                                       Packet *spkt,
> +                                       uint16_t poffset,
> +                                       uint16_t soffset,
> +                                       uint16_t len)
> +
>  {
>      if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
>          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20],
> sec_ip_dst[20];
> @@ -208,17 +210,7 @@ static int colo_packet_compare_common(Packet *ppkt,
>                                     sec_ip_src, sec_ip_dst);
>      }
>
> -    poffset = ppkt->vnet_hdr_len + poffset;
> -    soffset = ppkt->vnet_hdr_len + soffset;
> -
> -    if (ppkt->size - poffset == spkt->size - soffset) {
> -        return memcmp(ppkt->data + poffset,
> -                      spkt->data + soffset,
> -                      spkt->size - soffset);
> -    } else {
> -        trace_colo_compare_main("Net packet size are not the same");
> -        return -1;
> -    }
> +    return memcmp(ppkt->data + poffset, spkt->data + soffset, len);
>  }
>
>  /*
> @@ -270,24 +262,19 @@ static int colo_packet_compare_tcp(Packet *spkt,
> Packet *ppkt)
>       * the secondary guest's timestamp. COLO just focus on payload,
>       * so we just need skip this field.
>       */
> -    if (ptcp->th_off > 5) {
> -        ptrdiff_t ptcp_offset, stcp_offset;
>
> -        ptcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
> -                      + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
> -        stcp_offset = spkt->transport_header - (uint8_t *)spkt->data
> -                      + (stcp->th_off * 4) - spkt->vnet_hdr_len;
> +    ptrdiff_t ptcp_offset, stcp_offset;
>
> -        /*
> -         * When network is busy, some tcp options(like sack) will
> unpredictable
> -         * occur in primary side or secondary side. it will make packet
> size
> -         * not same, but the two packet's payload is identical. colo just
> -         * care about packet payload, so we skip the option field.
> -         */
> -        res = colo_packet_compare_common(ppkt, spkt, ptcp_offset,
> stcp_offset);
> -    } else if (ptcp->th_sum == stcp->th_sum) {
> -        res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN, ETH_HLEN);
> +    ptcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
> +                  + (ptcp->th_off << 2) - ppkt->vnet_hdr_len;
> +    stcp_offset = spkt->transport_header - (uint8_t *)spkt->data
> +                  + (stcp->th_off << 2) - spkt->vnet_hdr_len;
> +    if (ppkt->size - ptcp_offset == spkt->size - stcp_offset) {
> +        res = colo_compare_packet_payload(ppkt, spkt,
> +                                          ptcp_offset, stcp_offset,
> +                                          ppkt->size - ptcp_offset);
>      } else {
> +        trace_colo_compare_main("TCP: payload size of packets are
> different");
>          res = -1;
>      }
>
> @@ -331,8 +318,8 @@ static int colo_packet_compare_tcp(Packet *spkt,
> Packet *ppkt)
>   */
>  static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
>  {
> -    int ret;
> -    int network_header_length = ppkt->ip->ip_hl * 4;
> +    uint16_t network_header_length = ppkt->ip->ip_hl << 2;
> +    uint16_t offset = network_header_length + ETH_HLEN +
> ppkt->vnet_hdr_len;
>
>      trace_colo_compare_main("compare udp");
>
> @@ -346,11 +333,12 @@ static int colo_packet_compare_udp(Packet *spkt,
> Packet *ppkt)
>       * other field like TOS,TTL,IP Checksum. we only need to compare
>       * the ip payload here.
>       */
> -    ret = colo_packet_compare_common(ppkt, spkt,
> -                                     network_header_length + ETH_HLEN,
> -                                     network_header_length + ETH_HLEN);
> -
> -    if (ret) {
> +    if (ppkt->size != spkt->size) {
> +        trace_colo_compare_main("UDP: payload size of packets are
> different");
> +        return -1;
> +    }
> +    if (colo_compare_packet_payload(ppkt, spkt, offset, offset,
> +                                    ppkt->size - offset)) {
>          trace_colo_compare_udp_miscompare("primary pkt size",
> ppkt->size);
>          trace_colo_compare_udp_miscompare("Secondary pkt size",
> spkt->size);
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))
> {
> @@ -359,9 +347,10 @@ static int colo_packet_compare_udp(Packet *spkt,
> Packet *ppkt)
>              qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec
> pkt",
>                           spkt->size);
>          }
> +        return -1;
> +    } else {
> +        return 0;
>      }
> -
> -    return ret;
>  }
>
>  /*
> @@ -370,7 +359,8 @@ static int colo_packet_compare_udp(Packet *spkt,
> Packet *ppkt)
>   */
>  static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
>  {
> -    int network_header_length = ppkt->ip->ip_hl * 4;
> +    uint16_t network_header_length = ppkt->ip->ip_hl << 2;
> +    uint16_t offset = network_header_length + ETH_HLEN +
> ppkt->vnet_hdr_len;
>
>      trace_colo_compare_main("compare icmp");
>
> @@ -384,9 +374,12 @@ static int colo_packet_compare_icmp(Packet *spkt,
> Packet *ppkt)
>       * other field like TOS,TTL,IP Checksum. we only need to compare
>       * the ip payload here.
>       */
> -    if (colo_packet_compare_common(ppkt, spkt,
> -                                   network_header_length + ETH_HLEN,
> -                                   network_header_length + ETH_HLEN)) {
> +    if (ppkt->size != spkt->size) {
> +        trace_colo_compare_main("ICMP: payload size of packets are
> different");
> +        return -1;
> +    }
> +    if (colo_compare_packet_payload(ppkt, spkt, offset, offset,
> +                                    ppkt->size - offset)) {
>          trace_colo_compare_icmp_miscompare("primary pkt size",
>                                             ppkt->size);
>          trace_colo_compare_icmp_miscompare("Secondary pkt size",
> @@ -409,6 +402,8 @@ static int colo_packet_compare_icmp(Packet *spkt,
> Packet *ppkt)
>   */
>  static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
>  {
> +    uint16_t offset = ppkt->vnet_hdr_len;
> +
>      trace_colo_compare_main("compare other");
>      if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
>          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20],
> sec_ip_dst[20];
> @@ -423,7 +418,12 @@ static int colo_packet_compare_other(Packet *spkt,
> Packet *ppkt)
>                                     sec_ip_src, sec_ip_dst);
>      }
>
> -    return colo_packet_compare_common(ppkt, spkt, 0, 0);
> +    if (ppkt->size != spkt->size) {
> +        trace_colo_compare_main("Other: payload size of packets are
> different");
> +        return -1;
> +    }
> +    return colo_compare_packet_payload(ppkt, spkt, offset, offset,
> +                                       ppkt->size - offset);
>  }
>
>  static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
> --
> 2.9.4
>
>
>
>
