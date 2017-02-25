Received: from eggs.gnu.org ([2001:4830:134:3::10]:47448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chTHR-0003Fx-T0
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 22:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chTHN-0006xU-Bk
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 22:44:21 -0500
Received: from [59.151.112.132] (port=53008 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chTHM-0006vY-Cy
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 22:44:17 -0500
References: <1487993530-30875-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1487993530-30875-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <1904fbc3-61f5-b414-6926-c18d4e9b90a2@cn.fujitsu.com>
Date: Sat, 25 Feb 2017 11:43:44 +0800
MIME-Version: 1.0
In-Reply-To: <1487993530-30875-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] COLO-compare: Add packet size check
 and some fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>

Sorry, This patch has been renamed.

please ignore this patch.


Thanks

Zhang Chen


On 02/25/2017 11:32 AM, Zhang Chen wrote:
> Add packet size check in colo_packet_compare_udp()
> and colo_packet_compare_udp(), rename function colo_packet_compare()
> to colo_packet_compare_common() that we will reuse it later.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 300f017..e75f0ae 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -180,7 +180,7 @@ static int packet_enqueue(CompareState *s, int mode)
>    * return:    0  means packet same
>    *            > 0 || < 0 means packet different
>    */
> -static int colo_packet_compare(Packet *ppkt, Packet *spkt)
> +static int colo_packet_compare_common(Packet *ppkt, Packet *spkt)
>   {
>       trace_colo_compare_ip_info(ppkt->size, inet_ntoa(ppkt->ip->ip_src),
>                                  inet_ntoa(ppkt->ip->ip_dst), spkt->size,
> @@ -190,6 +190,7 @@ static int colo_packet_compare(Packet *ppkt, Packet *spkt)
>       if (ppkt->size == spkt->size) {
>           return memcmp(ppkt->data, spkt->data, spkt->size);
>       } else {
> +        trace_colo_compare_main("Net packet size are not the same");
>           return -1;
>       }
>   }
> @@ -202,9 +203,10 @@ static int colo_packet_compare(Packet *ppkt, Packet *spkt)
>   static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
>   {
>       struct tcphdr *ptcp, *stcp;
> -    int res;
> +    int res, network_length;
>   
>       trace_colo_compare_main("compare tcp");
> +
>       if (ppkt->size != spkt->size) {
>           if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
>               trace_colo_compare_main("pkt size not same");
> @@ -212,6 +214,12 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
>           return -1;
>       }
>   
> +    network_length = ppkt->ip->ip_hl * 4;
> +    if (ppkt->size < network_length + ETH_HLEN) {
> +        trace_colo_compare_main("tcp packet size error");
> +        return -1;
> +    }
> +
>       ptcp = (struct tcphdr *)ppkt->transport_header;
>       stcp = (struct tcphdr *)spkt->transport_header;
>   
> @@ -260,10 +268,16 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
>    */
>   static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
>   {
> -    int ret;
> +    int ret, network_length;
>   
>       trace_colo_compare_main("compare udp");
> -    ret = colo_packet_compare(ppkt, spkt);
> +    network_length = ppkt->ip->ip_hl * 4;
> +    if (ppkt->size < network_length + ETH_HLEN) {
> +        trace_colo_compare_main("udp packet size error");
> +        return -1;
> +    }
> +
> +    ret = colo_packet_compare_common(ppkt, spkt);
>   
>       if (ret) {
>           trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
> @@ -285,12 +299,12 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
>   
>       trace_colo_compare_main("compare icmp");
>       network_length = ppkt->ip->ip_hl * 4;
> -    if (ppkt->size != spkt->size ||
> -        ppkt->size < network_length + ETH_HLEN) {
> +    if (ppkt->size < network_length + ETH_HLEN) {
> +        trace_colo_compare_main("icmp packet size error");
>           return -1;
>       }
>   
> -    if (colo_packet_compare(ppkt, spkt)) {
> +    if (colo_packet_compare_common(ppkt, spkt)) {
>           trace_colo_compare_icmp_miscompare("primary pkt size",
>                                              ppkt->size);
>           qemu_hexdump((char *)ppkt->data, stderr, "colo-compare",
> @@ -316,7 +330,7 @@ static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
>                                  inet_ntoa(ppkt->ip->ip_dst), spkt->size,
>                                  inet_ntoa(spkt->ip->ip_src),
>                                  inet_ntoa(spkt->ip->ip_dst));
> -    return colo_packet_compare(ppkt, spkt);
> +    return colo_packet_compare_common(ppkt, spkt);
>   }
>   
>   static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)

-- 
Thanks
Zhang Chen
