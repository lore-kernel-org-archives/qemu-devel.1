Received: from eggs.gnu.org ([2001:4830:134:3::10]:38425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djbiK-0004ez-CJ
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 21:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djbiH-0007EX-83
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 21:41:12 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47239
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djbiG-0007DF-Sa
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 21:41:09 -0400
References: <1501236190-15177-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <10b93f73-c7a0-f07a-2f94-f2bd860e073c@cn.fujitsu.com>
Date: Mon, 21 Aug 2017 09:42:49 +0800
MIME-Version: 1.0
In-Reply-To: <1501236190-15177-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] net/filter-rewriter.c: Fix rewirter
 checksum bug when use virtio-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

Hi~ All~

Someone can review it? Just a ping for this patch.


Thanks

Zhang Chen


On 07/28/2017 06:03 PM, Zhang Chen wrote:
> Because vnet_hdr have a offset to net packet, we must add it when use
> virtio-net.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/filter-rewriter.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index 55a6cf5..72e4928 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -99,7 +99,8 @@ static int handle_primary_tcp_pkt(NetFilterState *nf,
>               /* handle packets to the secondary from the primary */
>               tcp_pkt->th_ack = htonl(ntohl(tcp_pkt->th_ack) + conn->offset);
>   
> -            net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
> +            net_checksum_calculate((uint8_t *)pkt->data + pkt->vnet_hdr_len,
> +                                   pkt->size - pkt->vnet_hdr_len);
>           }
>       }
>   
> @@ -138,7 +139,8 @@ static int handle_secondary_tcp_pkt(NetFilterState *nf,
>               /* handle packets to the primary from the secondary*/
>               tcp_pkt->th_seq = htonl(ntohl(tcp_pkt->th_seq) - conn->offset);
>   
> -            net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
> +            net_checksum_calculate((uint8_t *)pkt->data + pkt->vnet_hdr_len,
> +                                   pkt->size - pkt->vnet_hdr_len);
>           }
>       }
>   

-- 
Thanks
Zhang Chen
