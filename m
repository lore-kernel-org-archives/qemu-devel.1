Received: from eggs.gnu.org ([2001:4830:134:3::10]:44817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eLfwk-00070X-JI
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eLfwj-00012A-9e
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:53:26 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:39153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eLfwi-00011X-Um
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:53:25 -0500
Received: by mail-wm0-x235.google.com with SMTP id i11so11589717wmf.4
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 17:53:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171128120402.22295-3-maozy.fnst@cn.fujitsu.com>
References: <20171128120402.22295-1-maozy.fnst@cn.fujitsu.com>
	<20171128120402.22295-3-maozy.fnst@cn.fujitsu.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 4 Dec 2017 09:53:23 +0800
Message-ID: <CAK3tnvJpsW91gZravkBqyr71WUkFsjCsOte5ODZRSOuucUtw1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

On Tue, Nov 28, 2017 at 8:04 PM, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
wrote:

> Cc: Zhang Chen <zhangckid@gmail.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Jason Wang <jasowang@redhat.com>
>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  net/colo-compare.c | 16 ++++++++++++++++
>  net/colo.c         |  1 +
>  net/colo.h         |  1 +
>  net/trace-events   |  2 +-
>  4 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 0752e9f..4c0a1d8 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -129,6 +129,7 @@ static void fill_pkt_seq(void *data, uint32_t *max_ack)
>                    + (tcphd->th_off << 2) - pkt->vnet_hdr_len;
>      pkt->pdsize = pkt->size - pkt->hdsize;
>      pkt->seq_end = pkt->tcp_seq + pkt->pdsize;
> +    pkt->flags = tcphd->th_flags;
>  }
>
>  /*
> @@ -337,6 +338,16 @@ sec:
>      }
>
>      if (colo_mark_tcp_pkt(ppkt, spkt, &mark, max_ack)) {
> +        trace_colo_compare_tcp_info("pri",
> +                                    ppkt->tcp_seq, ppkt->tcp_ack,
> +                                    ppkt->hdsize, ppkt->pdsize,
> +                                    ppkt->offset, ppkt->flags);
> +
> +        trace_colo_compare_tcp_info("sec",
> +                                    spkt->tcp_seq, spkt->tcp_ack,
> +                                    spkt->hdsize, spkt->pdsize,
> +                                    spkt->offset, spkt->flags);
> +
>          if (mark == COLO_COMPARE_FREE_PRIMARY) {
>              conn->compare_seq = ppkt->seq_end;
>              colo_release_primary_pkt(s, ppkt);
> @@ -355,6 +366,11 @@ sec:
>              goto pri;
>          }
>      } else {
> +        qemu_hexdump((char *)ppkt->data, stderr,
> +                     "colo-compare ppkt", ppkt->size);
> +        qemu_hexdump((char *)spkt->data, stderr,
> +                     "colo-compare spkt", spkt->size);
> +
>          g_queue_push_head(&conn->primary_list, ppkt);
>          g_queue_push_head(&conn->secondary_list, spkt);
>
> diff --git a/net/colo.c b/net/colo.c
> index 1743522..0b469f2 100644
> --- a/net/colo.c
> +++ b/net/colo.c
> @@ -171,6 +171,7 @@ Packet *packet_new(const void *data, int size, int
> vnet_hdr_len)
>      pkt->hdsize = 0;
>      pkt->pdsize = 0;
>      pkt->offset = 0;
> +    pkt->flags = 0;
>
>      return pkt;
>  }
> diff --git a/net/colo.h b/net/colo.h
> index 97bc41e..0530dd0 100644
> --- a/net/colo.h
> +++ b/net/colo.h
> @@ -53,6 +53,7 @@ typedef struct Packet {
>      uint16_t pdsize; /* the payload length */
>      /* record the payload offset(the length that has been compared) */
>      uint16_t offset;
> +    uint8_t flags; /* Flags(aka Control bits) */
>  } Packet;
>
>  typedef struct ConnectionKey {
> diff --git a/net/trace-events b/net/trace-events
> index 938263d..7b594cf 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -13,7 +13,7 @@ colo_compare_icmp_miscompare(const char *sta, int size)
> ": %s = %d"
>  colo_compare_ip_info(int psize, const char *sta, const char *stb, int
> ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s,
> ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
>  colo_old_packet_check_found(int64_t old_time) "%" PRId64
>  colo_compare_miscompare(void) ""
> -colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int
> res, uint32_t flag, int size) "side: %s seq/ack= %u/%u res= %d flags= 0x%x
> pkt_size: %d\n"
> +colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int
> hdlen, int pdlen, int offset, int flags) "%s: seq/ack= %u/%u hdlen= %d
> pdlen= %d offset= %d flags=%d\n"
>


In patch 1/2 you have removed where they have been used, so you should
remove this definition in patch 1 firstly.


Thanks
Zhang Chen


>
>  # net/filter-rewriter.c
>  colo_filter_rewriter_debug(void) ""
> --
> 2.9.4
>
>
>
>
