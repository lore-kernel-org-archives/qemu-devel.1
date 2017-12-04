Received: from eggs.gnu.org ([2001:4830:134:3::10]:36446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eLl6n-0006KY-EA
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 02:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eLl6j-0003Hc-5v
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 02:24:09 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:42828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eLl6i-0003HS-Ky
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 02:24:05 -0500
Received: by mail-wr0-x234.google.com with SMTP id s66so16039309wrc.9
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 23:24:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <70df9791-9d23-f83e-a5cb-81a4ed1f84b3@cn.fujitsu.com>
References: <20171128120402.22295-1-maozy.fnst@cn.fujitsu.com>
	<20171128120402.22295-2-maozy.fnst@cn.fujitsu.com>
	<CAK3tnvJmQ=hEZYYCG=ebZsZ2zjztwLj2YBQaXPKT77cBW03Ong@mail.gmail.com>
	<70df9791-9d23-f83e-a5cb-81a4ed1f84b3@cn.fujitsu.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 4 Dec 2017 07:24:02 +0000
Message-ID: <CAK3tnvJiHNhoRrDTuVB+jgus5+qxaUkU_e9c0zvr-LwLwZAfkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] colo: compare the packet based on the
 tcp sequence number
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

On Mon, Dec 4, 2017 at 3:32 AM, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
wrote:

>
>
> On 12/04/2017 09:41 AM, Zhang Chen wrote:
>
>>
>>
>> On Tue, Nov 28, 2017 at 8:04 PM, Mao Zhongyi <maozy.fnst@cn.fujitsu.com
>> <mailto:maozy.fnst@cn.fujitsu.com>> wrote:
>>
>>         The primary and secondary guest has the same TCP stream, but the
>>         the packet sizes are different due to the different fragmentation.
>>
>>         In the current impletation, compare the packet with the size of
>>         payload, but packets of the same size and payload are very few,
>>         so it triggers checkopint frequently, which leads to a very low
>>         performance of the tcp packet comparison. In addtion, the method
>>         of comparing the size of packet is not correct in itself.
>>
>>         like that:
>>         We send this payload:
>>         ------------------------------
>>         | header |1|2|3|4|5|6|7|8|9|0|
>>         ------------------------------
>>
>>         primary:
>>         ppkt1:
>>         ----------------
>>         | header |1|2|3|
>>         ----------------
>>         ppkt2:
>>         ------------------------
>>         | header |4|5|6|7|8|9|0|
>>         ------------------------
>>
>>         secondary:
>>         spkt1:
>>         ------------------------------
>>         | header |1|2|3|4|5|6|7|8|9|0|
>>         ------------------------------
>>
>>         In the original method, ppkt1 and ppkt2 are diffrent in size and
>>         spkt1, so they can't compare and trigger the checkpoint.
>>
>>         I have tested FTP get 200M and 1G file many times, I found that
>>         the performance was less than 1% of the native.
>>
>>         Now I reconstructed the comparison of TCP packets based on the
>>         TCP sequence number. first of all, ppkt1 and spkt1 have the same
>>         starting sequence number, so they can compare, even though their
>>         length is different. And then ppkt1 with a smaller payload length
>>         is used as the comparison length, if the payload is same, send
>>         out the ppkt1 and record the offset(the length of ppkt1 payload)
>>         in spkt1. The next comparison, ppkt2 and spkt1 can be compared
>>         from the recorded position of spkt1.
>>
>>         like that:
>>         ----------------
>>         | header |1|2|3| ppkt1
>>         ---------|-----|
>>                  |     |
>>         ---------v-----v--------------
>>         | header |1|2|3|4|5|6|7|8|9|0| spkt1
>>         ---------------|\------------|
>>                        | \offset     |
>>               ---------v-------------v
>>               | header |4|5|6|7|8|9|0| ppkt2
>>               ------------------------
>>
>>         In this way, the performance can reach native 20% in my multiple
>>         tests.
>>
>>     Cc: Zhang Chen <zhangckid@gmail.com <mailto:zhangckid@gmail.com>>
>>     Cc: Li Zhijian <lizhijian@cn.fujitsu.com <mailto:
>> lizhijian@cn.fujitsu.com>>
>>     Cc: Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>>
>>
>>     Reported-by: Zhang Chen <zhangckid@gmail.com <mailto:
>> zhangckid@gmail.com>>
>>     Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com <mailto:
>> maozy.fnst@cn.fujitsu.com>>
>>     Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com <mailto:
>> lizhijian@cn.fujitsu.com>>
>>
>>     ---
>>      net/colo-compare.c | 300 ++++++++++++++++++++++++++++++
>> +++--------------------
>>      net/colo.c         |   8 ++
>>      net/colo.h         |  14 +++
>>      3 files changed, 211 insertions(+), 111 deletions(-)
>>
>>     diff --git a/net/colo-compare.c b/net/colo-compare.c
>>     index 1ce195f..0752e9f 100644
>>     --- a/net/colo-compare.c
>>     +++ b/net/colo-compare.c
>>     @@ -38,6 +38,9 @@
>>      #define COMPARE_READ_LEN_MAX NET_BUFSIZE
>>      #define MAX_QUEUE_SIZE 1024
>>
>>     +#define COLO_COMPARE_FREE_PRIMARY     0x01
>>     +#define COLO_COMPARE_FREE_SECONDARY   0x02
>>     +
>>      /* TODO: Should be configurable */
>>      #define REGULAR_PACKET_CHECK_MS 3000
>>
>>     @@ -112,14 +115,31 @@ static gint seq_sorter(Packet *a, Packet *b,
>> gpointer data)
>>          return ntohl(atcp->th_seq) - ntohl(btcp->th_seq);
>>      }
>>
>>     +static void fill_pkt_seq(void *data, uint32_t *max_ack)
>>     +{
>>     +    Packet *pkt = data;
>>     +    struct tcphdr *tcphd;
>>     +
>>     +    tcphd = (struct tcphdr *)pkt->transport_header;
>>     +
>>     +    pkt->tcp_seq = ntohl(tcphd->th_seq);
>>     +    pkt->tcp_ack = ntohl(tcphd->th_ack);
>>     +    *max_ack = *max_ack > pkt->tcp_ack ? *max_ack : pkt->tcp_ack;
>>     +    pkt->hdsize = pkt->transport_header - (uint8_t *)pkt->data
>>     +                  + (tcphd->th_off << 2) - pkt->vnet_hdr_len;
>>     +    pkt->pdsize = pkt->size - pkt->hdsize;
>>
>>
>>
>> In this function you are not just "fill_pkt_seq", use "fill_pkt_tcp_info"
>> is more suitable.
>> And use "header_size" and "payload_size" instead of "hdsize" and "pdsize"
>> maybe better to read.
>>
>
> OK, it's greater, thanks.
>
>
>
>>
>>
>>     +    pkt->seq_end = pkt->tcp_seq + pkt->pdsize;
>>     +}
>>     +
>>      /*
>>       * Return 1 on success, if return 0 means the
>>       * packet will be dropped
>>       */
>>     -static int colo_insert_packet(GQueue *queue, Packet *pkt)
>>     +static int colo_insert_packet(GQueue *queue, Packet *pkt, uint32_t
>> *max_ack)
>>      {
>>          if (g_queue_get_length(queue) <= MAX_QUEUE_SIZE) {
>>              if (pkt->ip->ip_p == IPPROTO_TCP) {
>>     +            fill_pkt_seq(pkt, max_ack);
>>                  g_queue_insert_sorted(queue,
>>                                        pkt,
>>                                        (GCompareDataFunc)seq_sorter,
>>     @@ -169,12 +189,12 @@ static int packet_enqueue(CompareState *s, int
>> mode, Connection **con)
>>          }
>>
>>          if (mode == PRIMARY_IN) {
>>     -        if (!colo_insert_packet(&conn->primary_list, pkt)) {
>>     +        if (!colo_insert_packet(&conn->primary_list, pkt,
>> &conn->pack)) {
>>                  error_report("colo compare primary queue size too big,"
>>                               "drop packet");
>>              }
>>          } else {
>>     -        if (!colo_insert_packet(&conn->secondary_list, pkt)) {
>>     +        if (!colo_insert_packet(&conn->secondary_list, pkt,
>> &conn->sack)) {
>>                  error_report("colo compare secondary queue size too big,"
>>                               "drop packet");
>>              }
>>     @@ -184,6 +204,167 @@ static int packet_enqueue(CompareState *s, int
>> mode, Connection **con)
>>          return 0;
>>      }
>>
>>     +static inline bool after(uint32_t seq1, uint32_t seq2)
>>     +{
>>     +        return (int32_t)(seq1 - seq2) > 0;
>>     +}
>>     +
>>     +static void colo_release_primary_pkt(CompareState *s, Packet *pkt)
>>     +{
>>     +    int ret;
>>     +    ret = compare_chr_send(s,
>>     +                           pkt->data,
>>     +                           pkt->size,
>>     +                           pkt->vnet_hdr_len);
>>     +    if (ret < 0) {
>>     +        error_report("colo send primary packet failed");
>>     +    }
>>     +    trace_colo_compare_main("packet same and release packet");
>>     +    packet_destroy(pkt, NULL);
>>     +}
>>
>>
>> This function codes duplicate with that in colo_compare_connection(),
>> We'd better reuse it.
>>
>>
> Yeah,  I got it.
>
>
>>     +
>>     +static bool colo_compare_payload(Packet *ppkt, Packet *spkt,
>>     +                                 uint16_t poff, uint16_t soff,
>>     +                                 uint16_t len)
>>     +{
>>     +    if (memcmp(ppkt->data + poff, spkt->data + soff, len)) {
>>     +        trace_colo_compare_main("the payload is not same");
>>     +        return false;
>>     +    }
>>     +    return true;
>>     +}
>>
>>
>> This function looks like colo_packet_compare_common(),
>> Why we need add a new one?
>>
>>
> In fact, I originally intended to reuse colo_packet_compare_common,
> but the colo_packet_compare_common must be modified then can service
> for tcp comparison, it's lead to the handling of udp & icmp also need
> to changed. it's not this patch's job.
>
> In addtion, the common comparisons of tcp, udp, icmp and other should
> be the payload comparisons, we should only transmit the result of
> comparison
> to its callers, and have them to decide how to do it. So I think we need
> to simplify this function. In the next, I want to use
> colo_compare_payload()
> to instead of colo_packet_compare_common() entirely. What do you think?


Currently,  colo_compare_payload() just a rename version of
colo_packet_compare_common(),
Both input pkt->data and offset to compare the payload, and
colo_packet_compare_common() have
more debug trace info. so, It is better to modified origin function for all
protocol.




>
>
>     +
>>     +/*
>>     + * return true means that the payload is consist and
>>     + * need to make the next comparison, false means do
>>     + * the checkpoint
>>     + */
>>     +static bool colo_mark_tcp_pkt(Packet *ppkt, Packet *spkt,
>>     +                              int8_t *mark, uint32_t max_ack)
>>     +{
>>     +    *mark = 0;
>>     +
>>     +    if (ppkt->tcp_seq == spkt->tcp_seq && ppkt->seq_end ==
>> spkt->seq_end) {
>>     +        if (colo_compare_payload(ppkt, spkt, ppkt->hdsize,
>> spkt->hdsize,
>>     +                                 ppkt->hdsize)) {
>>     +            *mark = COLO_COMPARE_FREE_SECONDARY |
>> COLO_COMPARE_FREE_PRIMARY;
>>     +            return true;
>>     +        }
>>     +    }
>>     +
>>     +    /* one part of secondary packet payload still need to be
>> compared */
>>     +    if (!after(ppkt->seq_end, spkt->seq_end)) {
>>     +        if (colo_compare_payload(ppkt, spkt, ppkt->hdsize +
>> ppkt->offset,
>>     +                                 spkt->hdsize + spkt->offset,
>>     +                                 ppkt->pdsize - ppkt->offset)) {
>>     +            if (!after(ppkt->tcp_ack, max_ack)) {
>>     +                *mark = COLO_COMPARE_FREE_PRIMARY;
>>     +                spkt->offset += ppkt->pdsize - ppkt->offset;
>>     +                return true;
>>     +            } else {
>>     +                /* secondary guest hasn't ack the data, don't send
>>     +                 * out this packet
>>     +                 */
>>     +                return false;
>>     +            }
>>     +        }
>>     +    } else {
>>     +        /* primary packet is longer than secondary packet, compare
>>     +         * the same part and mark the primary packet offset
>>     +         */
>>     +        if (colo_compare_payload(ppkt, spkt, ppkt->hdsize +
>> ppkt->offset,
>>     +                                 spkt->hdsize + spkt->offset,
>>     +                                 spkt->pdsize - spkt->offset)) {
>>     +            *mark = COLO_COMPARE_FREE_SECONDARY;
>>     +            ppkt->offset += spkt->pdsize - spkt->offset;
>>     +            return true;
>>     +        }
>>     +    }
>>     +
>>     +    return false;
>>     +}
>>     +
>>     +static void colo_compare_tcp(CompareState *s, Connection *conn)
>>     +{
>>     +    Packet *ppkt = NULL, *spkt = NULL;
>>     +    int8_t mark;
>>
>>
>>
>> You should add more comments about the "max_ack".
>>
>
> OK, I will.
>
>
>
>>
>>     +    uint32_t max_ack = conn->pack > conn->sack ? conn->sack :
>> conn->pack;
>>     +
>>     +pri:
>>     +    if (g_queue_is_empty(&conn->primary_list)) {
>>     +        return;
>>     +    }
>>     +    ppkt = g_queue_pop_head(&conn->primary_list);
>>     +sec:
>>     +    if (g_queue_is_empty(&conn->secondary_list)) {
>>     +        g_queue_push_head(&conn->primary_list, ppkt);
>>     +        return;
>>     +    }
>>     +    spkt = g_queue_pop_head(&conn->secondary_list);
>>     +
>>     +    if (ppkt->tcp_seq == ppkt->seq_end) {
>>     +        colo_release_primary_pkt(s, ppkt);
>>     +        ppkt = NULL;
>>     +    }
>>     +
>>     +    if (ppkt && conn->compare_seq && !after(ppkt->seq_end,
>> conn->compare_seq)) {
>>     +        trace_colo_compare_main("pri: pkt has compared & posted,
>> destroy");
>>     +        packet_destroy(ppkt, NULL);
>>     +        ppkt = NULL;
>>     +    }
>>     +
>>     +    if (spkt->tcp_seq == spkt->seq_end) {
>>     +        packet_destroy(spkt, NULL);
>>     +        if (!ppkt) {
>>     +            goto pri;
>>     +        } else {
>>     +            goto sec;
>>     +        }
>>     +    } else {
>>     +        if (conn->compare_seq && !after(spkt->seq_end,
>> conn->compare_seq)) {
>>     +            trace_colo_compare_main("sec: pkt has compared & posted,
>> destroy");
>>     +            packet_destroy(spkt, NULL);
>>     +            if (!ppkt) {
>>     +                goto pri;
>>     +            } else {
>>     +                goto sec;
>>     +            }
>>     +        }
>>     +        if (!ppkt) {
>>     +            g_queue_push_head(&conn->secondary_list, spkt);
>>     +            goto pri;
>>     +        }
>>     +    }
>>     +
>>     +    if (colo_mark_tcp_pkt(ppkt, spkt, &mark, max_ack)) {
>>     +        if (mark == COLO_COMPARE_FREE_PRIMARY) {
>>     +            conn->compare_seq = ppkt->seq_end;
>>     +            colo_release_primary_pkt(s, ppkt);
>>     +            g_queue_push_head(&conn->secondary_list, spkt);
>>     +            goto pri;
>>     +        }
>>     +        if (mark == COLO_COMPARE_FREE_SECONDARY) {
>>     +            conn->compare_seq = spkt->seq_end;
>>     +            packet_destroy(spkt, NULL);
>>     +            goto sec;
>>     +        }
>>     +        if (mark == (COLO_COMPARE_FREE_PRIMARY |
>> COLO_COMPARE_FREE_SECONDARY)) {
>>     +            conn->compare_seq = ppkt->seq_end;
>>     +            colo_release_primary_pkt(s, ppkt);
>>     +            packet_destroy(spkt, NULL);
>>     +            goto pri;
>>     +        }
>>     +    } else {
>>     +        g_queue_push_head(&conn->primary_list, ppkt);
>>     +        g_queue_push_head(&conn->secondary_list, spkt);
>>     +
>>     +        /*
>>     +         * colo_compare_inconsistent_notify();
>>     +         * TODO: notice to checkpoint();
>>     +         */
>>     +    }
>>     +}
>>     +
>>      /*
>>       * The IP packets sent by primary and secondary
>>       * will be compared in here
>>     @@ -224,110 +405,6 @@ static int colo_packet_compare_common(Packet
>> *ppkt,
>>
>>      /*
>>       * Called from the compare thread on the primary
>>     - * for compare tcp packet
>>     - * compare_tcp copied from Dr. David Alan Gilbert's branch
>>     - */
>>     -static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
>>     -{
>>     -    struct tcphdr *ptcp, *stcp;
>>     -    int res;
>>     -
>>     -    trace_colo_compare_main("compare tcp");
>>     -
>>     -    ptcp = (struct tcphdr *)ppkt->transport_header;
>>     -    stcp = (struct tcphdr *)spkt->transport_header;
>>     -
>>     -    /*
>>     -     * The 'identification' field in the IP header is *very* random
>>     -     * it almost never matches.  Fudge this by ignoring differences
>> in
>>     -     * unfragmented packets; they'll normally sort themselves out if
>> different
>>     -     * anyway, and it should recover at the TCP level.
>>     -     * An alternative would be to get both the primary and secondary
>> to rewrite
>>     -     * somehow; but that would need some sync traffic to sync the
>> state
>>     -     */
>>     -    if (ntohs(ppkt->ip->ip_off) & IP_DF) {
>>     -        spkt->ip->ip_id = ppkt->ip->ip_id;
>>     -        /* and the sum will be different if the IDs were different */
>>     -        spkt->ip->ip_sum = ppkt->ip->ip_sum;
>>     -    }
>>     -
>>     -    /*
>>     -     * Check tcp header length for tcp option field.
>>     -     * th_off > 5 means this tcp packet have options field.
>>     -     * The tcp options maybe always different.
>>     -     * for example:
>>     -     * From RFC 7323.
>>     -     * TCP Timestamps option (TSopt):
>>     -     * Kind: 8
>>     -     *
>>     -     * Length: 10 bytes
>>     -     *
>>     -     *    +-------+-------+-------------
>> --------+---------------------+
>>     -     *    |Kind=8 |  10   |   TS Value (TSval)  |TS Echo Reply
>> (TSecr)|
>>     -     *    +-------+-------+-------------
>> --------+---------------------+
>>     -     *       1       1              4                     4
>>     -     *
>>     -     * In this case the primary guest's timestamp always different
>> with
>>     -     * the secondary guest's timestamp. COLO just focus on payload,
>>     -     * so we just need skip this field.
>>     -     */
>>     -    if (ptcp->th_off > 5) {
>>     -        ptrdiff_t ptcp_offset, stcp_offset;
>>     -
>>     -        ptcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
>>     -                      + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
>>     -        stcp_offset = spkt->transport_header - (uint8_t *)spkt->data
>>     -                      + (stcp->th_off * 4) - spkt->vnet_hdr_len;
>>     -
>>     -        /*
>>     -         * When network is busy, some tcp options(like sack) will
>> unpredictable
>>     -         * occur in primary side or secondary side. it will make
>> packet size
>>     -         * not same, but the two packet's payload is identical. colo
>> just
>>     -         * care about packet payload, so we skip the option field.
>>     -         */
>>     -        res = colo_packet_compare_common(ppkt, spkt, ptcp_offset,
>> stcp_offset);
>>     -    } else if (ptcp->th_sum == stcp->th_sum) {
>>     -        res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN,
>> ETH_HLEN);
>>     -    } else {
>>     -        res = -1;
>>     -    }
>>     -
>>     -    if (res != 0 &&
>>     -        trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))
>> {
>>     -        char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20],
>> sec_ip_dst[20];
>>     -
>>     -        strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
>>     -        strcpy(pri_ip_dst, inet_ntoa(ppkt->ip->ip_dst));
>>     -        strcpy(sec_ip_src, inet_ntoa(spkt->ip->ip_src));
>>     -        strcpy(sec_ip_dst, inet_ntoa(spkt->ip->ip_dst));
>>     -
>>     -        trace_colo_compare_ip_info(ppkt->size, pri_ip_src,
>>     -                                   pri_ip_dst, spkt->size,
>>     -                                   sec_ip_src, sec_ip_dst);
>>     -
>>     -        trace_colo_compare_tcp_info("pri tcp packet",
>>     -                                    ntohl(ptcp->th_seq),
>>     -                                    ntohl(ptcp->th_ack),
>>     -                                    res, ptcp->th_flags,
>>     -                                    ppkt->size);
>>     -
>>     -        trace_colo_compare_tcp_info("sec tcp packet",
>>     -                                    ntohl(stcp->th_seq),
>>     -                                    ntohl(stcp->th_ack),
>>     -                                    res, stcp->th_flags,
>>     -                                    spkt->size);
>>     -
>>     -        qemu_hexdump((char *)ppkt->data, stderr,
>>     -                     "colo-compare ppkt", ppkt->size);
>>     -        qemu_hexdump((char *)spkt->data, stderr,
>>     -                     "colo-compare spkt", spkt->size);
>>     -    }
>>     -
>>     -    return res;
>>     -}
>>     -
>>     -/*
>>     - * Called from the compare thread on the primary
>>       * for compare udp packet
>>       */
>>      static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
>>     @@ -492,14 +569,15 @@ static void colo_compare_connection(void
>> *opaque, void *user_data)
>>          GList *result = NULL;
>>          int ret;
>>
>>     +    if (conn->ip_proto == IPPROTO_TCP) {
>>     +        colo_compare_tcp(s, conn);
>>     +        return;
>>     +    }
>>     +
>>          while (!g_queue_is_empty(&conn->primary_list) &&
>>                 !g_queue_is_empty(&conn->secondary_list)) {
>>              pkt = g_queue_pop_head(&conn->primary_list);
>>              switch (conn->ip_proto) {
>>     -        case IPPROTO_TCP:
>>     -            result = g_queue_find_custom(&conn->secondary_list,
>>     -                     pkt, (GCompareFunc)colo_packet_compare_tcp);
>>     -            break;
>>
>>
>> I think we should put colo_compare_tcp in here, like other protocol.
>> If this compare loop can't satisfy your needs(like goto pri/sec), you can
>> fix this loop that make it more general,
>> rather than give TCP a privilege between other protocol(like compare
>> firstly).
>>
>
>
> Well, it doesn't look very sociable, in theory they should in a common
> loop, fix this
> loop make it suit the tcp comparison is the best way. But, given the
> performence of tcp
> comparison, the method of tcp comparison is completely different to the
> queue processing
> and others, so there is no way they can merge into a loop. Then split tcp
> in a single route.
> If possible, in the next, I will implemnet icmp and udp in the same way to
> keep the code
> processing process consistent.
>

Yes, I think compare icmp and udp can use the same way that handle tcp.
This version just like a temporary hack.

Thanks
Zhang Chen



>
> Thanks,
> Mao.
>
>
>
>> Thanks
>> Zhang Chen
>>
>>
>>
>>              case IPPROTO_UDP:
>>                  result = g_queue_find_custom(&conn->secondary_list,
>>                           pkt, (GCompareFunc)colo_packet_compare_udp);
>>     diff --git a/net/colo.c b/net/colo.c
>>     index a39d600..1743522 100644
>>     --- a/net/colo.c
>>     +++ b/net/colo.c
>>     @@ -138,6 +138,8 @@ Connection *connection_new(ConnectionKey *key)
>>          conn->processing = false;
>>          conn->offset = 0;
>>          conn->syn_flag = 0;
>>     +    conn->pack = 0;
>>     +    conn->sack = 0;
>>          g_queue_init(&conn->primary_list);
>>          g_queue_init(&conn->secondary_list);
>>
>>     @@ -163,6 +165,12 @@ Packet *packet_new(const void *data, int size,
>> int vnet_hdr_len)
>>          pkt->size = size;
>>          pkt->creation_ms = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>          pkt->vnet_hdr_len = vnet_hdr_len;
>>     +    pkt->tcp_seq = 0;
>>     +    pkt->tcp_ack = 0;
>>     +    pkt->seq_end = 0;
>>     +    pkt->hdsize = 0;
>>     +    pkt->pdsize = 0;
>>     +    pkt->offset = 0;
>>
>>          return pkt;
>>      }
>>     diff --git a/net/colo.h b/net/colo.h
>>     index 0658e86..97bc41e 100644
>>     --- a/net/colo.h
>>     +++ b/net/colo.h
>>     @@ -45,6 +45,14 @@ typedef struct Packet {
>>          int64_t creation_ms;
>>          /* Get vnet_hdr_len from filter */
>>          uint32_t vnet_hdr_len;
>>     +    uint32_t tcp_seq; /* sequence number */
>>     +    uint32_t tcp_ack; /* acknowledgement number */
>>     +    /* the sequence number of the last byte of the packet */
>>     +    uint32_t seq_end;
>>     +    uint8_t hdsize;  /* the header length */
>>     +    uint16_t pdsize; /* the payload length */
>>     +    /* record the payload offset(the length that has been compared)
>> */
>>     +    uint16_t offset;
>>      } Packet;
>>
>>      typedef struct ConnectionKey {
>>     @@ -64,6 +72,12 @@ typedef struct Connection {
>>          /* flag to enqueue unprocessed_connections */
>>          bool processing;
>>          uint8_t ip_proto;
>>     +    /* record the sequence number that has been compared */
>>     +    uint32_t compare_seq;
>>     +    /* the maximum of acknowledgement number in primary_list queue */
>>     +    uint32_t pack;
>>     +    /* the maximum of acknowledgement number in secondary_list queue
>> */
>>     +    uint32_t sack;
>>          /* offset = secondary_seq - primary_seq */
>>          tcp_seq  offset;
>>          /*
>>     --
>>     2.9.4
>>
>>
>>
>>
>>
>
>
