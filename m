Received: from eggs.gnu.org ([2001:4830:134:3::10]:35483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chAvx-0007US-4O
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chAvs-0003mO-8x
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:08:57 -0500
Received: from [59.151.112.132] (port=29597 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chAvr-0003m2-SZ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:08:52 -0500
References: <1487735198-127300-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487735198-127300-4-git-send-email-zhang.zhanghailiang@huawei.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <102bbf9b-d0c3-3a38-c7d9-dd037d6cb978@cn.fujitsu.com>
Date: Fri, 24 Feb 2017 16:08:03 +0800
MIME-Version: 1.0
In-Reply-To: <1487735198-127300-4-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] filter-rewriter: skip
 net_checksum_calculate() while offset = 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, jasowang@redhat.com, lizhijian@cn.fujitsu.com
Cc: zhangchen.fnst@cn.fujitsu.com, qemu-devel@nongnu.org, xuquan8@huawei.com, pss.wulizhen@huawei.com



On 02/22/2017 11:46 AM, zhanghailiang wrote:
> While the offset of packets's sequence for primary side and
> secondary side is zero, it is unnecessary to call net_checksum_calculate()
> to recalculate the checksume value of packets.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>   net/filter-rewriter.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index 7e7ec35..c9a6d43 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -93,10 +93,12 @@ static int handle_primary_tcp_pkt(RewriterState *rf,
>               conn->offset -= (ntohl(tcp_pkt->th_ack) - 1);
>               conn->syn_flag = 0;
>           }
> -        /* handle packets to the secondary from the primary */
> -        tcp_pkt->th_ack = htonl(ntohl(tcp_pkt->th_ack) + conn->offset);
> +        if (conn->offset) {

This is wrong, conn->offset maybe is a negative value(like -1000),
So you can change here to  "if (conn->offset == 0) {"


> +            /* handle packets to the secondary from the primary */
> +            tcp_pkt->th_ack = htonl(ntohl(tcp_pkt->th_ack) + conn->offset);
>   
> -        net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
> +            net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
> +        }
>           /*
>            * Case 1:
>            * The *server* side of this connect is VM, *client* tries to close
> @@ -112,7 +114,6 @@ static int handle_primary_tcp_pkt(RewriterState *rf,
>            */
>           if ((conn->tcp_state == TCPS_LAST_ACK) &&
>               (ntohl(tcp_pkt->th_ack) == (conn->fin_ack_seq + 1))) {
> -            fprintf(stderr, "Remove conn "

Here need fix.

>               g_hash_table_remove(rf->connection_track_table, key);
>           }
>       }
> @@ -159,10 +160,13 @@ static int handle_secondary_tcp_pkt(RewriterState *rf,
>       }
>   
>       if ((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) == TH_ACK) {
> -        /* handle packets to the primary from the secondary*/
> -        tcp_pkt->th_seq = htonl(ntohl(tcp_pkt->th_seq) - conn->offset);
> +        /* Only need to adjust seq while offset is Non-zero */
> +        if (conn->offset) {

Refer to the above comments.

Thanks
Zhang Chen

> +            /* handle packets to the primary from the secondary*/
> +            tcp_pkt->th_seq = htonl(ntohl(tcp_pkt->th_seq) - conn->offset);
>   
> -        net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
> +            net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
> +        }
>           /*
>            * Case 2:
>            * The *server* side of this connect is VM, *server* tries to close

-- 
Thanks
Zhang Chen
