Received: from eggs.gnu.org ([2001:4830:134:3::10]:45461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1dTMdG-0008Q4-2G
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1dTMdB-00086o-Hu
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:20:50 -0400
Received: from [59.151.112.132] (port=6515 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1dTMdB-00085W-4o
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:20:45 -0400
References: <1499406231-3877-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1499406231-3877-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <a860a0c8-ca76-27b9-8990-ea2d5c564887@cn.fujitsu.com>
Date: Fri, 7 Jul 2017 14:20:39 +0800
MIME-Version: 1.0
In-Reply-To: <1499406231-3877-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/4] net/colo-compare.c: compare tcp packet
 base on sequence number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>

this title confused me

i think you want to express "only compare the packets that has the same sequence number"

and i think this optimization can not reduce this checkpoint optimization.

Thanks


On 07/07/2017 01:43 PM, Zhang Chen wrote:
> If primary packet's sequence number not same with secondary packet's
> sequence number, no need to compare the packet other field.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 0f8e198..2caeb80 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -222,6 +222,12 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
>       ptcp = (struct tcphdr *)ppkt->transport_header;
>       stcp = (struct tcphdr *)spkt->transport_header;
>   
> +    if ((ptcp->th_flags & TH_SYN) != TH_SYN &&
> +        ptcp->th_seq != stcp->th_seq) {
> +        trace_colo_compare_main("colo_packet_compare_tcp seq not same");
> +        return -1;
> +    }
> +
>       /*
>        * The 'identification' field in the IP header is *very* random
>        * it almost never matches.  Fudge this by ignoring differences in
