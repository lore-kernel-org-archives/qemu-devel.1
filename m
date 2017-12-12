Received: from eggs.gnu.org ([2001:4830:134:3::10]:36329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eOmLG-0001Bs-Ft
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eOmLE-00038v-GL
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:19:34 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eOmLE-00038b-4X
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:19:32 -0500
Received: by mail-wm0-x244.google.com with SMTP id g75so21480431wme.0
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 07:19:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6991b2261016c48122aaf7d71e33cc1d74b620fd.1512552817.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1512552817.git.maozy.fnst@cn.fujitsu.com>
	<6991b2261016c48122aaf7d71e33cc1d74b620fd.1512552817.git.maozy.fnst@cn.fujitsu.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 12 Dec 2017 23:19:30 +0800
Message-ID: <CAK3tnv+2Eu_y_-eh901TANGEdi2RNjeU03MKRy0VgzdXkp02TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] colo: modified the payload compare
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

On Wed, Dec 6, 2017 at 5:57 PM, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
wrote:

> Modified the function colo_packet_compare_common to prepare for the
> tcp packet comparison in the next patch.
>
> Cc: Zhang Chen <zhangckid@gmail.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Jason Wang <jasowang@redhat.com>
>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  net/colo-compare.c | 71 ++++++++++++++++++++++++++++++
> ------------------------
>  1 file changed, 39 insertions(+), 32 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 0afb5f0..f833eba 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -191,10 +191,11 @@ static int packet_enqueue(CompareState *s, int mode=
,
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
>  {
>      if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
>          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20],
> sec_ip_dst[20];
> @@ -209,17 +210,7 @@ static int colo_packet_compare_common(Packet *ppkt,
>                                     sec_ip_src, sec_ip_dst);
>      }
>
> -    poffset =3D ppkt->vnet_hdr_len + poffset;
> -    soffset =3D ppkt->vnet_hdr_len + soffset;
> -
> -    if (ppkt->size - poffset =3D=3D spkt->size - soffset) {
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
> @@ -274,16 +265,23 @@ static int colo_packet_compare_tcp(Packet *spkt,
> Packet *ppkt)
>      ptrdiff_t ptcp_offset, stcp_offset;
>
>      ptcp_offset =3D ppkt->transport_header - (uint8_t *)ppkt->data
> -                  + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
> +                  + (ptcp->th_off << 2) - ppkt->vnet_hdr_len;
>      stcp_offset =3D spkt->transport_header - (uint8_t *)spkt->data
> -                  + (stcp->th_off * 4) - spkt->vnet_hdr_len;
> +                  + (stcp->th_off << 2) - spkt->vnet_hdr_len;
>      /*
>       * When network is busy, some tcp options(like sack) will
> unpredictable
>       * occur in primary side or secondary side. it will make packet size
>       * not same, but the two packet's payload is identical. colo just
>       * care about packet payload, so we skip the option field.
>       */
>

In the patch 1=EF=BC=8Cyou should remove this comments, it's out of date.



> -    res =3D colo_packet_compare_common(ppkt, spkt, ptcp_offset,
> stcp_offset);
> +    if (ppkt->size - ptcp_offset =3D=3D spkt->size - stcp_offset) {
> +        res =3D colo_compare_packet_payload(ppkt, spkt,
> +                                          ptcp_offset, stcp_offset,
> +                                          ppkt->size - ptcp_offset);
> +    } else {
> +        trace_colo_compare_main("TCP: the size of packets are different"=
);
>


Should fix this comments to "TCP: payload size of packets are diffenrent!".

Thanks
Zhang Chen



> +        res =3D -1;
> +    }
>
>      if (res !=3D 0 &&
>          trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> @@ -325,8 +323,8 @@ static int colo_packet_compare_tcp(Packet *spkt,
> Packet *ppkt)
>   */
>  static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
>  {
> -    int ret;
> -    int network_header_length =3D ppkt->ip->ip_hl * 4;
> +    uint16_t network_header_length =3D ppkt->ip->ip_hl << 2;
> +    uint16_t offset =3D network_header_length + ETH_HLEN +
> ppkt->vnet_hdr_len;
>
>      trace_colo_compare_main("compare udp");
>
> @@ -340,11 +338,12 @@ static int colo_packet_compare_udp(Packet *spkt,
> Packet *ppkt)
>       * other field like TOS,TTL,IP Checksum. we only need to compare
>       * the ip payload here.
>       */
> -    ret =3D colo_packet_compare_common(ppkt, spkt,
> -                                     network_header_length + ETH_HLEN,
> -                                     network_header_length + ETH_HLEN);
> -
> -    if (ret) {
> +    if (ppkt->size !=3D spkt->size) {
> +        trace_colo_compare_main("UDP: the size of packets are different"=
);
> +        return -1;
> +    }
> +    if (colo_compare_packet_payload(ppkt, spkt, offset, offset,
> +                                    ppkt->size - offset)) {
>          trace_colo_compare_udp_miscompare("primary pkt size",
> ppkt->size);
>          trace_colo_compare_udp_miscompare("Secondary pkt size",
> spkt->size);
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE=
))
> {
> @@ -353,9 +352,10 @@ static int colo_packet_compare_udp(Packet *spkt,
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
> @@ -364,7 +364,8 @@ static int colo_packet_compare_udp(Packet *spkt,
> Packet *ppkt)
>   */
>  static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
>  {
> -    int network_header_length =3D ppkt->ip->ip_hl * 4;
> +    uint16_t network_header_length =3D ppkt->ip->ip_hl << 2;
> +    uint16_t offset =3D network_header_length + ETH_HLEN +
> ppkt->vnet_hdr_len;
>
>      trace_colo_compare_main("compare icmp");
>
> @@ -378,9 +379,12 @@ static int colo_packet_compare_icmp(Packet *spkt,
> Packet *ppkt)
>       * other field like TOS,TTL,IP Checksum. we only need to compare
>       * the ip payload here.
>       */
> -    if (colo_packet_compare_common(ppkt, spkt,
> -                                   network_header_length + ETH_HLEN,
> -                                   network_header_length + ETH_HLEN)) {
> +    if (ppkt->size !=3D spkt->size) {
> +        trace_colo_compare_main("ICMP: the size of packets are
> different");
> +        return -1;
> +    }
> +    if (colo_compare_packet_payload(ppkt, spkt, offset, offset,
> +                                    ppkt->size - offset)) {
>          trace_colo_compare_icmp_miscompare("primary pkt size",
>                                             ppkt->size);
>          trace_colo_compare_icmp_miscompare("Secondary pkt size",
> @@ -403,6 +407,8 @@ static int colo_packet_compare_icmp(Packet *spkt,
> Packet *ppkt)
>   */
>  static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
>  {
> +    uint16_t offset =3D ppkt->vnet_hdr_len;
> +
>      trace_colo_compare_main("compare other");
>      if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
>          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20],
> sec_ip_dst[20];
> @@ -417,7 +423,8 @@ static int colo_packet_compare_other(Packet *spkt,
> Packet *ppkt)
>                                     sec_ip_src, sec_ip_dst);
>      }
>
> -    return colo_packet_compare_common(ppkt, spkt, 0, 0);
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
