Received: from eggs.gnu.org ([2001:4830:134:3::10]:40122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eP0Z3-0002dM-Dx
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 01:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eP0Yy-0006gY-NE
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 01:30:45 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:17889
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eP0Yx-0006dg-Ap
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 01:30:40 -0500
References: <cover.1512552817.git.maozy.fnst@cn.fujitsu.com>
	<9b6c4156006f0c440f11849aa9e70f19d610a29e.1512552817.git.maozy.fnst@cn.fujitsu.com>
	<CAK3tnvLsmgPw=cB-6PGQ_e3PzoNe5jJtrysf2gHDNaq7DMkgdg@mail.gmail.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <ab1dae9f-6bea-7157-7617-b3b72e1582cf@cn.fujitsu.com>
Date: Wed, 13 Dec 2017 14:25:58 +0800
MIME-Version: 1.0
In-Reply-To: <CAK3tnvLsmgPw=cB-6PGQ_e3PzoNe5jJtrysf2gHDNaq7DMkgdg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] colo: compare the packet based on
 the tcp sequence number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

Hi, Chen

On 12/12/2017 11:21 PM, Zhang Chen wrote:
>
>
> On Wed, Dec 6, 2017 at 5:57 PM, Mao Zhongyi <maozy.fnst@cn.fujitsu.com <mailto:maozy.fnst@cn.fujitsu.com>> wrote:
>
>     The primary and secondary guest has the same TCP stream, but the
>     the packet sizes are different due to the different fragmentation.
>
>
> Maybe comments fix to this way is better:
> Packet size some time different or when network is busy.

Thanks, but I think original comments is more clear. :)

>
>
>
>     In the current implementation, compare the packet with the size of
>     payload, but packets of the same size and payload are very few,
>
>
>
> Based on same payload size, but TCP protocol can not garantee send the same one packet in the same way,
>
>
>
>     so it triggers checkopint frequently, which leads to a very low
>     performance of the tcp packet comparison. In addtion, the method
>
>
>
>     of comparing the size of packet is not correct in itself.
>
>
>
> Previous way do not just comparing the size of packet,  it focus on the packet payload, same as what you do,

The size here refers to the payload size. In the previous way, it focus on the packet payload， but there is
still a problem: if the packet the same payload size but different content also can be compared, it costs extra
and useless memcmp().

I think the focus on the payload comparison itself is no problem, but that the same size of payload can be compared
is not reasonable.

> But lack of the different size packet handle, So I think this patch set add the handler for the situation of the TCP
> comparison in different pri/sec packet size.

In this patch, even though the same pri/sec packet size if the start seq are not same, it also can't be compared.
So this patch set are not a supplement to what was missing situation. Although it did it in terms of function, the
thinking is totally different.

>
>
>
>
>
>     like that:
>     We send this payload:
>     ------------------------------
>     | header |1|2|3|4|5|6|7|8|9|0|
>     ------------------------------
>
>     primary:
>     ppkt1:
>     ----------------
>     | header |1|2|3|
>     ----------------
>     ppkt2:
>     ------------------------
>     | header |4|5|6|7|8|9|0|
>     ------------------------
>
>     secondary:
>     spkt1:
>     ------------------------------
>     | header |1|2|3|4|5|6|7|8|9|0|
>     ------------------------------
>
>     In the original method, ppkt1 and ppkt2 are diffrent in size and
>     spkt1, so they can't compare and trigger the checkpoint.
>
>     I have tested FTP get 200M and 1G file many times, I found that
>     the performance was less than 1% of the native.
>
>     Now I reconstructed the comparison of TCP packets based on the
>     TCP sequence number. first of all, ppkt1 and spkt1 have the same
>     starting sequence number, so they can compare, even though their
>     length is different. And then ppkt1 with a smaller payload length
>     is used as the comparison length, if the payload is same, send
>     out the ppkt1 and record the offset(the length of ppkt1 payload)
>     in spkt1. The next comparison, ppkt2 and spkt1 can be compared
>     from the recorded position of spkt1.
>
>     like that:
>     ----------------
>     | header |1|2|3| ppkt1
>     ---------|-----|
>              |     |
>     ---------v-----v--------------
>     | header |1|2|3|4|5|6|7|8|9|0| spkt1
>     ---------------|\------------|
>                    | \offset     |
>           ---------v-------------v
>           | header |4|5|6|7|8|9|0| ppkt2
>           ------------------------
>
>     In this way, the performance can reach native 20% in my multiple
>     tests.
>
>     Cc: Zhang Chen <zhangckid@gmail.com <mailto:zhangckid@gmail.com>>
>     Cc: Li Zhijian <lizhijian@cn.fujitsu.com <mailto:lizhijian@cn.fujitsu.com>>
>     Cc: Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>>
>
>     Reported-by: Zhang Chen <zhangckid@gmail.com <mailto:zhangckid@gmail.com>>
>     Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com <mailto:maozy.fnst@cn.fujitsu.com>>
>     Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com <mailto:lizhijian@cn.fujitsu.com>>
>     ---
>      net/colo-compare.c | 285 ++++++++++++++++++++++++++++++++++-------------------
>      net/colo.c         |   8 ++
>      net/colo.h         |  14 +++
>      net/trace-events   |   1 -
>      4 files changed, 205 insertions(+), 103 deletions(-)
>
>     diff --git a/net/colo-compare.c b/net/colo-compare.c
>     index f833eba..683ec4e 100644
>     --- a/net/colo-compare.c
>     +++ b/net/colo-compare.c
>     @@ -38,6 +38,9 @@
>      #define COMPARE_READ_LEN_MAX NET_BUFSIZE
>      #define MAX_QUEUE_SIZE 1024
>
>     +#define COLO_COMPARE_FREE_PRIMARY     0x01
>     +#define COLO_COMPARE_FREE_SECONDARY   0x02
>     +
>      /* TODO: Should be configurable */
>      #define REGULAR_PACKET_CHECK_MS 3000
>
>     @@ -112,14 +115,31 @@ static gint seq_sorter(Packet *a, Packet *b, gpointer data)
>          return ntohl(atcp->th_seq) - ntohl(btcp->th_seq);
>      }
>
>     +static void fill_pkt_tcp_info(void *data, uint32_t *max_ack)
>     +{
>     +    Packet *pkt = data;
>     +    struct tcphdr *tcphd;
>     +
>     +    tcphd = (struct tcphdr *)pkt->transport_header;
>     +
>     +    pkt->tcp_seq = ntohl(tcphd->th_seq);
>     +    pkt->tcp_ack = ntohl(tcphd->th_ack);
>     +    *max_ack = *max_ack > pkt->tcp_ack ? *max_ack : pkt->tcp_ack;
>     +    pkt->header_size = pkt->transport_header - (uint8_t *)pkt->data
>     +                       + (tcphd->th_off << 2) - pkt->vnet_hdr_len;
>     +    pkt->payload_size = pkt->size - pkt->header_size;
>     +    pkt->seq_end = pkt->tcp_seq + pkt->payload_size;
>     +}
>     +
>      /*
>       * Return 1 on success, if return 0 means the
>       * packet will be dropped
>       */
>     -static int colo_insert_packet(GQueue *queue, Packet *pkt)
>     +static int colo_insert_packet(GQueue *queue, Packet *pkt, uint32_t *max_ack)
>      {
>          if (g_queue_get_length(queue) <= MAX_QUEUE_SIZE) {
>              if (pkt->ip->ip_p == IPPROTO_TCP) {
>     +            fill_pkt_tcp_info(pkt, max_ack);
>                  g_queue_insert_sorted(queue,
>                                        pkt,
>                                        (GCompareDataFunc)seq_sorter,
>     @@ -169,12 +189,12 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
>          }
>
>          if (mode == PRIMARY_IN) {
>     -        if (!colo_insert_packet(&conn->primary_list, pkt)) {
>     +        if (!colo_insert_packet(&conn->primary_list, pkt, &conn->pack)) {
>                  error_report("colo compare primary queue size too big,"
>                               "drop packet");
>              }
>          } else {
>     -        if (!colo_insert_packet(&conn->secondary_list, pkt)) {
>     +        if (!colo_insert_packet(&conn->secondary_list, pkt, &conn->sack)) {
>                  error_report("colo compare secondary queue size too big,"
>                               "drop packet");
>              }
>     @@ -184,6 +204,25 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
>          return 0;
>      }
>
>     +static inline bool after(uint32_t seq1, uint32_t seq2)
>     +{
>     +        return (int32_t)(seq1 - seq2) > 0;
>     +}
>     +
>     +static void colo_release_primary_pkt(CompareState *s, Packet *pkt)
>     +{
>     +    int ret;
>     +    ret = compare_chr_send(s,
>     +                           pkt->data,
>     +                           pkt->size,
>     +                           pkt->vnet_hdr_len);
>     +    if (ret < 0) {
>     +        error_report("colo send primary packet failed");
>     +    }
>     +    trace_colo_compare_main("packet same and release packet");
>     +    packet_destroy(pkt, NULL);
>     +}
>     +
>      /*
>       * The IP packets sent by primary and secondary
>       * will be compared in here
>     @@ -214,107 +253,148 @@ static int colo_compare_packet_payload(Packet *ppkt,
>      }
>
>      /*
>     - * Called from the compare thread on the primary
>     - * for compare tcp packet
>     - * compare_tcp copied from Dr. David Alan Gilbert's branch
>     + * return true means that the payload is consist and
>     + * need to make the next comparison, false means do
>     + * the checkpoint
>       */
>     -static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
>     +static bool colo_mark_tcp_pkt(Packet *ppkt, Packet *spkt,
>     +                              int8_t *mark, uint32_t max_ack)
>      {
>     -    struct tcphdr *ptcp, *stcp;
>     -    int res;
>     -
>     -    trace_colo_compare_main("compare tcp");
>     +    *mark = 0;
>
>     -    ptcp = (struct tcphdr *)ppkt->transport_header;
>     -    stcp = (struct tcphdr *)spkt->transport_header;
>     +    if (ppkt->tcp_seq == spkt->tcp_seq && ppkt->seq_end == spkt->seq_end) {
>     +        if (colo_compare_packet_payload(ppkt, spkt,
>     +                                        ppkt->header_size, spkt->header_size,
>     +                                        ppkt->payload_size)) {
>     +            *mark = COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRIMARY;
>     +            return true;
>     +        }
>     +    }
>
>     -    /*
>     -     * The 'identification' field in the IP header is *very* random
>     -     * it almost never matches.  Fudge this by ignoring differences in
>     -     * unfragmented packets; they'll normally sort themselves out if different
>     -     * anyway, and it should recover at the TCP level.
>     -     * An alternative would be to get both the primary and secondary to rewrite
>     -     * somehow; but that would need some sync traffic to sync the state
>     -     */
>     -    if (ntohs(ppkt->ip->ip_off) & IP_DF) {
>     -        spkt->ip->ip_id = ppkt->ip->ip_id;
>     -        /* and the sum will be different if the IDs were different */
>     -        spkt->ip->ip_sum = ppkt->ip->ip_sum;
>     +    /* one part of secondary packet payload still need to be compared */
>     +    if (!after(ppkt->seq_end, spkt->seq_end)) {
>     +        if (colo_compare_packet_payload(ppkt, spkt,
>     +                                        ppkt->header_size + ppkt->offset,
>     +                                        spkt->header_size + spkt->offset,
>     +                                        ppkt->payload_size - ppkt->offset)) {
>     +            if (!after(ppkt->tcp_ack, max_ack)) {
>     +                *mark = COLO_COMPARE_FREE_PRIMARY;
>     +                spkt->offset += ppkt->payload_size - ppkt->offset;
>     +                return true;
>     +            } else {
>     +                /* secondary guest hasn't ack the data, don't send
>     +                 * out this packet
>     +                 */
>     +                return false;
>     +            }
>     +        }
>     +    } else {
>     +        /* primary packet is longer than secondary packet, compare
>     +         * the same part and mark the primary packet offset
>     +         */
>     +        if (colo_compare_packet_payload(ppkt, spkt,
>     +                                        ppkt->header_size + ppkt->offset,
>     +                                        spkt->header_size + spkt->offset,
>     +                                        spkt->payload_size - spkt->offset)) {
>     +            *mark = COLO_COMPARE_FREE_SECONDARY;
>     +            ppkt->offset += spkt->payload_size - spkt->offset;
>     +            return true;
>     +        }
>          }
>
>     -    /*
>     -     * Check tcp header length for tcp option field.
>     -     * th_off > 5 means this tcp packet have options field.
>     -     * The tcp options maybe always different.
>     -     * for example:
>     -     * From RFC 7323.
>     -     * TCP Timestamps option (TSopt):
>     -     * Kind: 8
>     -     *
>     -     * Length: 10 bytes
>     -     *
>     -     *    +-------+-------+---------------------+---------------------+
>     -     *    |Kind=8 |  10   |   TS Value (TSval)  |TS Echo Reply (TSecr)|
>     -     *    +-------+-------+---------------------+---------------------+
>     -     *       1       1              4                     4
>     -     *
>     -     * In this case the primary guest's timestamp always different with
>     -     * the secondary guest's timestamp. COLO just focus on payload,
>     -     * so we just need skip this field.
>     -     */
>     -    ptrdiff_t ptcp_offset, stcp_offset;
>     +    return false;
>     +}
>     +
>     +static void colo_compare_tcp(CompareState *s, Connection *conn)
>     +{
>     +    Packet *ppkt = NULL, *spkt = NULL;
>     +    int8_t mark;
>
>     -    ptcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
>     -                  + (ptcp->th_off << 2) + ppkt->vnet_hdr_len;
>     -    stcp_offset = spkt->transport_header - (uint8_t *)spkt->data
>     -                  + (stcp->th_off << 2) + spkt->vnet_hdr_len;
>          /*
>     -     * When network is busy, some tcp options(like sack) will unpredictable
>     -     * occur in primary side or secondary side. it will make packet size
>     -     * not same, but the two packet's payload is identical. colo just
>     -     * care about packet payload, so we skip the option field.
>     +     * if ppkt and spkt are exactly same except ack, and ack of
>     +     * ppkt greater than spkt, at this time if ppkt is sent out,
>     +     * secondary guest will mistakenly assume that its data has
>     +     * been sent to the value of ppkt's ack, which can lead to
>     +     * missing part of data. So here we get the smaller max_ack
>     +     * in primary and secondary queue as the max_ack, sending
>     +     * ppkt only if the payload is same and ack is less than the
>     +     * max_ack.
>
>
>
> The syntax of the comment is not fluent， please fix it.

OK, I will, thanks.
>
>
>
>           */
>     -    if (ppkt->size - ptcp_offset == spkt->size - stcp_offset) {
>     -        res = colo_compare_packet_payload(ppkt, spkt,
>     -                                          ptcp_offset, stcp_offset,
>     -                                          ppkt->size - ptcp_offset);
>     -    } else {
>     -        trace_colo_compare_main("TCP: the size of packets are different");
>     -        res = -1;
>     -    }
>     +    uint32_t min_ack = conn->pack > conn->sack ? conn->sack : conn->pack;
>
>     -    if (res != 0 &&
>     -        trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
>     -        char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
>     +pri:
>     +    if (g_queue_is_empty(&conn->primary_list)) {
>     +        return;
>     +    }
>     +    ppkt = g_queue_pop_head(&conn->primary_list);
>     +sec:
>     +    if (g_queue_is_empty(&conn->secondary_list)) {
>     +        g_queue_push_head(&conn->primary_list, ppkt);
>     +        return;
>     +    }
>     +    spkt = g_queue_pop_head(&conn->secondary_list);
>
>     -        strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
>     -        strcpy(pri_ip_dst, inet_ntoa(ppkt->ip->ip_dst));
>     -        strcpy(sec_ip_src, inet_ntoa(spkt->ip->ip_src));
>     -        strcpy(sec_ip_dst, inet_ntoa(spkt->ip->ip_dst));
>     +    if (ppkt->tcp_seq == ppkt->seq_end) {
>     +        colo_release_primary_pkt(s, ppkt);
>     +        ppkt = NULL;
>     +    }
>
>     -        trace_colo_compare_ip_info(ppkt->size, pri_ip_src,
>     -                                   pri_ip_dst, spkt->size,
>     -                                   sec_ip_src, sec_ip_dst);
>     +    if (ppkt && conn->compare_seq && !after(ppkt->seq_end, conn->compare_seq)) {
>     +        trace_colo_compare_main("pri: pkt has compared & posted, destroy");
>     +        packet_destroy(ppkt, NULL);
>     +        ppkt = NULL;
>     +    }
>
>     -        trace_colo_compare_tcp_info("pri tcp packet",
>     -                                    ntohl(ptcp->th_seq),
>     -                                    ntohl(ptcp->th_ack),
>     -                                    res, ptcp->th_flags,
>     -                                    ppkt->size);
>
>
> Why remove the trace event?
> In the new way of TCP comparison, we should print more debug info to user for better understand like that:
>
> "primary(seq/ack) payload size xxx is bigger than secondary(seq/ack) payload size xxx, update the offset to xxx"
>
>
>
>     +    if (spkt->tcp_seq == spkt->seq_end) {
>     +        packet_destroy(spkt, NULL);
>     +        if (!ppkt) {
>     +            goto pri;
>     +        } else {
>     +            goto sec;
>     +        }
>     +    } else {
>     +        if (conn->compare_seq && !after(spkt->seq_end, conn->compare_seq)) {
>     +            trace_colo_compare_main("sec: pkt has compared & posted, destroy");
>     +            packet_destroy(spkt, NULL);
>     +            if (!ppkt) {
>     +                goto pri;
>     +            } else {
>     +                goto sec;
>     +            }
>     +        }
>     +        if (!ppkt) {
>     +            g_queue_push_head(&conn->secondary_list, spkt);
>     +            goto pri;
>     +        }
>     +    }
>
>     -        trace_colo_compare_tcp_info("sec tcp packet",
>     -                                    ntohl(stcp->th_seq),
>     -                                    ntohl(stcp->th_ack),
>     -                                    res, stcp->th_flags,
>     -                                    spkt->size);
>     +    if (colo_mark_tcp_pkt(ppkt, spkt, &mark, min_ack)) {
>     +        if (mark == COLO_COMPARE_FREE_PRIMARY) {
>     +            conn->compare_seq = ppkt->seq_end;
>     +            colo_release_primary_pkt(s, ppkt);
>     +            g_queue_push_head(&conn->secondary_list, spkt);
>     +            goto pri;
>     +        }
>     +        if (mark == COLO_COMPARE_FREE_SECONDARY) {
>     +            conn->compare_seq = spkt->seq_end;
>     +            packet_destroy(spkt, NULL);
>     +            goto sec;
>     +        }
>     +        if (mark == (COLO_COMPARE_FREE_PRIMARY | COLO_COMPARE_FREE_SECONDARY)) {
>     +            conn->compare_seq = ppkt->seq_end;
>     +            colo_release_primary_pkt(s, ppkt);
>     +            packet_destroy(spkt, NULL);
>     +            goto pri;
>     +        }
>     +    } else {
>     +        g_queue_push_head(&conn->primary_list, ppkt);
>     +        g_queue_push_head(&conn->secondary_list, spkt);
>
>     -        qemu_hexdump((char *)ppkt->data, stderr,
>     -                     "colo-compare ppkt", ppkt->size);
>     -        qemu_hexdump((char *)spkt->data, stderr,
>     -                     "colo-compare spkt", spkt->size);
>     +        /*
>     +         * colo_compare_inconsistent_notify();
>     +         * TODO: notice to checkpoint();
>     +         */
>          }
>     -
>     -    return res;
>      }
>
>      /*
>     @@ -490,16 +570,25 @@ static void colo_compare_connection(void *opaque, void *user_data)
>          Connection *conn = opaque;
>          Packet *pkt = NULL;
>          GList *result = NULL;
>     -    int ret;
>     +
>     +    /* It doesn't look very sociable, in theory they should in a
>     +     * common loop, fix old loop make it suit the tcp comparison
>     +     * is the best way. But, given the performence of tcp comparison,
>     +     * the method of tcp comparison is completely different to the
>     +     * queue processing with others, so there is no way they can merge
>     +     * into a loop. Then split tcp in a single route. If possible, in
>     +     * the future, icmp and udp should be implemented use the same
>     +     * way to keep the code processing process consistent.
>     +     */
>
>
> Why no way can merge all comparison function in one loop?
>
> I think you can try this way :
>
>  static void colo_compare_connection(void *opaque, void *user_data)
> {
>     ....
>     pri:
>     if (g_queue_is_empty(&conn->primary_list)) {
>         return;
>     }
>     ppkt = g_queue_pop_head(&conn->primary_list);
>
>     sec:
>      if (g_queue_is_empty(&conn->secondary_list)) {
>          g_queue_push_head(&conn->primary_list, ppkt);
>          return;
>      }
>
>      switch (conn->ip_proto) {
>             case IPPROTO_TCP:
>                  if (colo_compare_tcp(s, conn)) {
>                         goto pri;
>                  } else {
>                         goto sec;
>                  }
>             case IPPROTO_UDP:
>                  if (colo_packet_compare_udp()) {
>                        goto pri;
>                  } else {
>                        goto sec;
>                  }
>             case ........
>              ....
>       }
>  }

Thanks for the clarification.

In this way, it will reduce the performance of udp & icmp in my
multiple test if we implement the udp & icmp comparison method
with the same way of tcp.

I have had a similar implementation locally:

colo_compare_comnon(arg1, arg2, callback)
{
pri:
      if (g_queue_is_empty(&conn->primary_list)) {
          return;
      }
      ppkt = g_queue_pop_head(&conn->primary_list);

sec:
       if (g_queue_is_empty(&conn->secondary_list)) {
           g_queue_push_head(&conn->primary_list, ppkt);
           return;
       }
     ....
}

colo_compare_connection(void *opaque, void *user_data)
{
       switch (conn->ip_proto) {
              case IPPROTO_TCP:
                   colo_compare_common(s, conn, colo_comapre_tcp)
              case IPPROTO_UDP:
                   colo_compare_common(s, conn, colo_comapre_udp)
              case IPPROTO_ICMP:
                   colo_compare_common(s, conn, colo_comapre_icmp)
              case ........
               ....
       }
}


> Thanks
> Zhang Chen
>
>
>
>
>
>     +    if (conn->ip_proto == IPPROTO_TCP) {
>     +        colo_compare_tcp(s, conn);
>     +        return;
>     +    }
>
>          while (!g_queue_is_empty(&conn->primary_list) &&
>                 !g_queue_is_empty(&conn->secondary_list)) {
>              pkt = g_queue_pop_head(&conn->primary_list);
>              switch (conn->ip_proto) {
>     -        case IPPROTO_TCP:
>     -            result = g_queue_find_custom(&conn->secondary_list,
>     -                     pkt, (GCompareFunc)colo_packet_compare_tcp);
>     -            break;
>              case IPPROTO_UDP:
>                  result = g_queue_find_custom(&conn->secondary_list,
>                           pkt, (GCompareFunc)colo_packet_compare_udp);
>     @@ -515,16 +604,8 @@ static void colo_compare_connection(void *opaque, void *user_data)
>              }
>
>              if (result) {
>     -            ret = compare_chr_send(s,
>     -                                   pkt->data,
>     -                                   pkt->size,
>     -                                   pkt->vnet_hdr_len);
>     -            if (ret < 0) {
>     -                error_report("colo_send_primary_packet failed");
>     -            }
>     -            trace_colo_compare_main("packet same and release packet");
>     +            colo_release_primary_pkt(s, pkt);
>                  g_queue_remove(&conn->secondary_list, result->data);
>     -            packet_destroy(pkt, NULL);
>              } else {
>                  /*
>                   * If one packet arrive late, the secondary_list or
>     diff --git a/net/colo.c b/net/colo.c
>     index a39d600..a7a7117 100644
>     --- a/net/colo.c
>     +++ b/net/colo.c
>     @@ -138,6 +138,8 @@ Connection *connection_new(ConnectionKey *key)
>          conn->processing = false;
>          conn->offset = 0;
>          conn->syn_flag = 0;
>     +    conn->pack = 0;
>     +    conn->sack = 0;
>          g_queue_init(&conn->primary_list);
>          g_queue_init(&conn->secondary_list);
>
>     @@ -163,6 +165,12 @@ Packet *packet_new(const void *data, int size, int vnet_hdr_len)
>          pkt->size = size;
>          pkt->creation_ms = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>          pkt->vnet_hdr_len = vnet_hdr_len;
>     +    pkt->tcp_seq = 0;
>     +    pkt->tcp_ack = 0;
>     +    pkt->seq_end = 0;
>     +    pkt->header_size = 0;
>     +    pkt->payload_size = 0;
>     +    pkt->offset = 0;
>
>          return pkt;
>      }
>     diff --git a/net/colo.h b/net/colo.h
>     index 0658e86..aa08374 100644
>     --- a/net/colo.h
>     +++ b/net/colo.h
>     @@ -45,6 +45,14 @@ typedef struct Packet {
>          int64_t creation_ms;
>          /* Get vnet_hdr_len from filter */
>          uint32_t vnet_hdr_len;
>     +    uint32_t tcp_seq; /* sequence number */
>     +    uint32_t tcp_ack; /* acknowledgement number */
>     +    /* the sequence number of the last byte of the packet */
>     +    uint32_t seq_end;
>     +    uint8_t header_size;  /* the header length */
>     +    uint16_t payload_size; /* the payload length */
>     +    /* record the payload offset(the length that has been compared) */
>     +    uint16_t offset;
>      } Packet;
>
>      typedef struct ConnectionKey {
>     @@ -64,6 +72,12 @@ typedef struct Connection {
>          /* flag to enqueue unprocessed_connections */
>          bool processing;
>          uint8_t ip_proto;
>     +    /* record the sequence number that has been compared */
>     +    uint32_t compare_seq;
>     +    /* the maximum of acknowledgement number in primary_list queue */
>     +    uint32_t pack;
>     +    /* the maximum of acknowledgement number in secondary_list queue */
>     +    uint32_t sack;
>          /* offset = secondary_seq - primary_seq */
>          tcp_seq  offset;
>          /*
>     diff --git a/net/trace-events b/net/trace-events
>     index 938263d..7b7cae5 100644
>     --- a/net/trace-events
>     +++ b/net/trace-events
>     @@ -13,7 +13,6 @@ colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
>      colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
>      colo_old_packet_check_found(int64_t old_time) "%" PRId64
>      colo_compare_miscompare(void) ""
>     -colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int res, uint32_t flag, int size) "side: %s seq/ack= %u/%u res= %d flags= 0x%x pkt_size: %d\n"
>
>      # net/filter-rewriter.c
>      colo_filter_rewriter_debug(void) ""
>     --
>     2.9.4
>
>
>
>
