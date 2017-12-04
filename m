Received: from eggs.gnu.org ([2001:4830:134:3::10]:46334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eLhdY-0003Bd-Cl
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eLhdV-0007f3-6O
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:41:44 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37826
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eLhdU-0007dH-BM
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:41:41 -0500
References: <20171128120402.22295-1-maozy.fnst@cn.fujitsu.com>
	<20171128120402.22295-3-maozy.fnst@cn.fujitsu.com>
	<CAK3tnvJpsW91gZravkBqyr71WUkFsjCsOte5ODZRSOuucUtw1Q@mail.gmail.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <59da95fc-3c23-b4cc-b0e6-6bf705b64d5b@cn.fujitsu.com>
Date: Mon, 4 Dec 2017 11:37:22 +0800
MIME-Version: 1.0
In-Reply-To: <CAK3tnvJpsW91gZravkBqyr71WUkFsjCsOte5ODZRSOuucUtw1Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] colo: add trace for the tcp packet
 comparison
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



On 12/04/2017 09:53 AM, Zhang Chen wrote:
>
>
> On Tue, Nov 28, 2017 at 8:04 PM, Mao Zhongyi <maozy.fnst@cn.fujitsu.com <mailto:maozy.fnst@cn.fujitsu.com>> wrote:
>
>     Cc: Zhang Chen <zhangckid@gmail.com <mailto:zhangckid@gmail.com>>
>     Cc: Li Zhijian <lizhijian@cn.fujitsu.com <mailto:lizhijian@cn.fujitsu.com>>
>     Cc: Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>>
>
>     Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com <mailto:maozy.fnst@cn.fujitsu.com>>
>     ---
>      net/colo-compare.c | 16 ++++++++++++++++
>      net/colo.c         |  1 +
>      net/colo.h         |  1 +
>      net/trace-events   |  2 +-
>      4 files changed, 19 insertions(+), 1 deletion(-)
>
>     diff --git a/net/colo-compare.c b/net/colo-compare.c
>     index 0752e9f..4c0a1d8 100644
>     --- a/net/colo-compare.c
>     +++ b/net/colo-compare.c
>     @@ -129,6 +129,7 @@ static void fill_pkt_seq(void *data, uint32_t *max_ack)
>                        + (tcphd->th_off << 2) - pkt->vnet_hdr_len;
>          pkt->pdsize = pkt->size - pkt->hdsize;
>          pkt->seq_end = pkt->tcp_seq + pkt->pdsize;
>     +    pkt->flags = tcphd->th_flags;
>      }
>
>      /*
>     @@ -337,6 +338,16 @@ sec:
>          }
>
>          if (colo_mark_tcp_pkt(ppkt, spkt, &mark, max_ack)) {
>     +        trace_colo_compare_tcp_info("pri",
>     +                                    ppkt->tcp_seq, ppkt->tcp_ack,
>     +                                    ppkt->hdsize, ppkt->pdsize,
>     +                                    ppkt->offset, ppkt->flags);
>     +
>     +        trace_colo_compare_tcp_info("sec",
>     +                                    spkt->tcp_seq, spkt->tcp_ack,
>     +                                    spkt->hdsize, spkt->pdsize,
>     +                                    spkt->offset, spkt->flags);
>     +
>              if (mark == COLO_COMPARE_FREE_PRIMARY) {
>                  conn->compare_seq = ppkt->seq_end;
>                  colo_release_primary_pkt(s, ppkt);
>     @@ -355,6 +366,11 @@ sec:
>                  goto pri;
>              }
>          } else {
>     +        qemu_hexdump((char *)ppkt->data, stderr,
>     +                     "colo-compare ppkt", ppkt->size);
>     +        qemu_hexdump((char *)spkt->data, stderr,
>     +                     "colo-compare spkt", spkt->size);
>     +
>              g_queue_push_head(&conn->primary_list, ppkt);
>              g_queue_push_head(&conn->secondary_list, spkt);
>
>     diff --git a/net/colo.c b/net/colo.c
>     index 1743522..0b469f2 100644
>     --- a/net/colo.c
>     +++ b/net/colo.c
>     @@ -171,6 +171,7 @@ Packet *packet_new(const void *data, int size, int vnet_hdr_len)
>          pkt->hdsize = 0;
>          pkt->pdsize = 0;
>          pkt->offset = 0;
>     +    pkt->flags = 0;
>
>          return pkt;
>      }
>     diff --git a/net/colo.h b/net/colo.h
>     index 97bc41e..0530dd0 100644
>     --- a/net/colo.h
>     +++ b/net/colo.h
>     @@ -53,6 +53,7 @@ typedef struct Packet {
>          uint16_t pdsize; /* the payload length */
>          /* record the payload offset(the length that has been compared) */
>          uint16_t offset;
>     +    uint8_t flags; /* Flags(aka Control bits) */
>      } Packet;
>
>      typedef struct ConnectionKey {
>     diff --git a/net/trace-events b/net/trace-events
>     index 938263d..7b594cf 100644
>     --- a/net/trace-events
>     +++ b/net/trace-events
>     @@ -13,7 +13,7 @@ colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
>      colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
>      colo_old_packet_check_found(int64_t old_time) "%" PRId64
>      colo_compare_miscompare(void) ""
>     -colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int res, uint32_t flag, int size) "side: %s seq/ack= %u/%u res= %d flags= 0x%x pkt_size: %d\n"
>     +colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int hdlen, int pdlen, int offset, int flags) "%s: seq/ack= %u/%u hdlen= %d pdlen= %d offset= %d flags=%d\n"
>
>
>
> In patch 1/2 you have removed where they have been used, so you should remove this definition in patch 1 firstly.

Well, Thanks for the clarification, I will fix it in the next.

Thanks,
Mao

>
>
> Thanks
> Zhang Chen
>
>
>
>      # net/filter-rewriter.c
>      colo_filter_rewriter_debug(void) ""
>     --
>     2.9.4
>
>
>
>
