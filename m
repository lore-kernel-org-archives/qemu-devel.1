Received: from eggs.gnu.org ([2001:4830:134:3::10]:36984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1ePjGV-0004Sf-03
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1ePjGP-000445-Vl
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:14:34 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61887
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1ePjGP-0003yV-38
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:14:29 -0500
References: <cover.1512552817.git.maozy.fnst@cn.fujitsu.com>
	<9b6c4156006f0c440f11849aa9e70f19d610a29e.1512552817.git.maozy.fnst@cn.fujitsu.com>
	<CAK3tnvLsmgPw=cB-6PGQ_e3PzoNe5jJtrysf2gHDNaq7DMkgdg@mail.gmail.com>
	<ab1dae9f-6bea-7157-7617-b3b72e1582cf@cn.fujitsu.com>
	<CAK3tnvLuwr+Ng0SJiAMpFkuGXT2AGjZ0qqFFup6TDMq4UKPi1g@mail.gmail.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <4b5dcf61-a19d-55cb-d2a3-ff08c673cb61@cn.fujitsu.com>
Date: Fri, 15 Dec 2017 14:09:42 +0800
MIME-Version: 1.0
In-Reply-To: <CAK3tnvLuwr+Ng0SJiAMpFkuGXT2AGjZ0qqFFup6TDMq4UKPi1g@mail.gmail.com>
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

[...]
>             +
>             +    /* It doesn't look very sociable, in theory they should in a
>             +     * common loop, fix old loop make it suit the tcp comparison
>             +     * is the best way. But, given the performence of tcp comparison,
>             +     * the method of tcp comparison is completely different to the
>             +     * queue processing with others, so there is no way they can merge
>             +     * into a loop. Then split tcp in a single route. If possible, in
>             +     * the future, icmp and udp should be implemented use the same
>             +     * way to keep the code processing process consistent.
>             +     */
>
>
>         Why no way can merge all comparison function in one loop?
>
>         I think you can try this way :
>
>          static void colo_compare_connection(void *opaque, void *user_data)
>         {
>             ....
>             pri:
>             if (g_queue_is_empty(&conn->primary_list)) {
>                 return;
>             }
>             ppkt = g_queue_pop_head(&conn->primary_list);
>
>             sec:
>              if (g_queue_is_empty(&conn->secondary_list)) {
>                  g_queue_push_head(&conn->primary_list, ppkt);
>                  return;
>              }
>
>              switch (conn->ip_proto) {
>                     case IPPROTO_TCP:
>                          if (colo_compare_tcp(s, conn)) {
>                                 goto pri;
>                          } else {
>                                 goto sec;
>                          }
>                     case IPPROTO_UDP:
>                          if (colo_packet_compare_udp()) {
>                                goto pri;
>                          } else {
>                                goto sec;
>                          }
>                     case ........
>                      ....
>               }
>          }
>
>
>     Thanks for the clarification.
>
>     In this way, it will reduce the performance of udp & icmp in my
>     multiple test if we implement the udp & icmp comparison method
>     with the same way of tcp.
>
>     I have had a similar implementation locally:
>


Hi, Chen

> I don't think it will sensible reduce the performance of udp & icmp

Actually, from the beginning to implement the tcp pkt comparison based
on the seq I basically determined if the same method to implement udp &
icmp, which performance certainly not as good as the original. Later test
confirmed my idea.

The reason is simple: udp & icmp pkt comparison are based on size, in the
secondary queue to find a packet same as one from primary queue can use
the-off-shelf g_queue_find_custom() directly. However, if you want to use
the same method as tcp to implement it, when a pkt from primary side is
compared with secondary side, the extra pop & push of secondary queue is
costed in each one comparsion, and the extra maintenance is required to
record what position currently compared.

Especially when the pkt of secondary queue same as primary side, it will
be deleted, and when the packet from the head of secondary queue is not
same, it will be pushed to the tail of queue so that to get a new pkt to
continue the next comparison. These factors lead to the secondary queue
constantly changing, increasing the complexity of location records and
reducing the efficiency of icmp & udp.

But, using the original method does not exist this problem. It has good
performance and code readability. Perhaps the code process flow of current
implementation looks a little inconsistent, but it's not worth if over-pursuing
code consistency and to ignore efficiency and readability.

> Do you have already test the new loop?

Yes， I did it in local before the v1 patch was sent.

Thanks,
Mao

>
> But in my mind, your similar implementation is OK for this job.
> So don't easy to say " there is no way.....".
>
> Thanks
> Zhang Chen
>
>
>
>
>     colo_compare_comnon(arg1, arg2, callback)
>     {
>     pri:
>          if (g_queue_is_empty(&conn->primary_list)) {
>              return;
>          }
>          ppkt = g_queue_pop_head(&conn->primary_list);
>
>     sec:
>           if (g_queue_is_empty(&conn->secondary_list)) {
>               g_queue_push_head(&conn->primary_list, ppkt);
>               return;
>           }
>         ....
>     }
>
>     colo_compare_connection(void *opaque, void *user_data)
>     {
>           switch (conn->ip_proto) {
>                  case IPPROTO_TCP:
>                       colo_compare_common(s, conn, colo_comapre_tcp)
>                  case IPPROTO_UDP:
>                       colo_compare_common(s, conn, colo_comapre_udp)
>                  case IPPROTO_ICMP:
>                       colo_compare_common(s, conn, colo_comapre_icmp)
>
>                  case ........
>                   ....
>           }
>     }
>
>
>         Thanks
>         Zhang Chen
>
>
>
>
>
>             +    if (conn->ip_proto == IPPROTO_TCP) {
>             +        colo_compare_tcp(s, conn);
>             +        return;
>             +    }
>
>                  while (!g_queue_is_empty(&conn->primary_list) &&
>                         !g_queue_is_empty(&conn->secondary_list)) {
>                      pkt = g_queue_pop_head(&conn->primary_list);
>                      switch (conn->ip_proto) {
>             -        case IPPROTO_TCP:
>             -            result = g_queue_find_custom(&conn->secondary_list,
>             -                     pkt, (GCompareFunc)colo_packet_compare_tcp);
>             -            break;
>                      case IPPROTO_UDP:
>                          result = g_queue_find_custom(&conn->secondary_list,
>                                   pkt, (GCompareFunc)colo_packet_compare_udp);
>             @@ -515,16 +604,8 @@ static void colo_compare_connection(void *opaque, void *user_data)
>                      }
>
>                      if (result) {
>             -            ret = compare_chr_send(s,
>             -                                   pkt->data,
>             -                                   pkt->size,
>             -                                   pkt->vnet_hdr_len);
>             -            if (ret < 0) {
>             -                error_report("colo_send_primary_packet failed");
>             -            }
>             -            trace_colo_compare_main("packet same and release packet");
>             +            colo_release_primary_pkt(s, pkt);
>                          g_queue_remove(&conn->secondary_list, result->data);
>             -            packet_destroy(pkt, NULL);
>                      } else {
>                          /*
>                           * If one packet arrive late, the secondary_list or

[...]
