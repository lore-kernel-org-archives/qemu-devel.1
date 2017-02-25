Received: from eggs.gnu.org ([2001:4830:134:3::10]:42837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1chWJb-0000DQ-9s
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1chWJY-0004bS-78
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:58:47 -0500
Received: from [45.249.212.188] (port=2937 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1chWJT-0004b1-HT
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:58:44 -0500
References: <1487993530-30875-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1487993530-30875-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58B12B02.2000202@huawei.com>
Date: Sat, 25 Feb 2017 14:58:10 +0800
MIME-Version: 1.0
In-Reply-To: <1487993530-30875-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] COLO-compare: Optimize
 colo_packet_compare_common
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xuquan8@huawei.com

On 2017/2/25 11:32, Zhang Chen wrote:
> Add offset args for colo_packet_compare_common, optimize
> colo_packet_compare_icmp() and colo_packet_compare_udp()
> just compare the IP payload.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index e75f0ae..9853232 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -180,7 +180,7 @@ static int packet_enqueue(CompareState *s, int mode)
>    * return:    0  means packet same
>    *            > 0 || < 0 means packet different
>    */
> -static int colo_packet_compare_common(Packet *ppkt, Packet *spkt)
> +static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
>   {
>       trace_colo_compare_ip_info(ppkt->size, inet_ntoa(ppkt->ip->ip_src),
>                                  inet_ntoa(ppkt->ip->ip_dst), spkt->size,
> @@ -188,7 +188,8 @@ static int colo_packet_compare_common(Packet *ppkt, Packet *spkt)
>                                  inet_ntoa(spkt->ip->ip_dst));
>
>       if (ppkt->size == spkt->size) {
> -        return memcmp(ppkt->data, spkt->data, spkt->size);
> +        return memcmp(ppkt->data + offset, spkt->data + offset,
> +                      spkt->size - offset);
>       } else {
>           trace_colo_compare_main("Net packet size are not the same");
>           return -1;
> @@ -237,8 +238,7 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
>           spkt->ip->ip_sum = ppkt->ip->ip_sum;
>       }
>
> -    res = memcmp(ppkt->data + ETH_HLEN, spkt->data + ETH_HLEN,
> -                (spkt->size - ETH_HLEN));
> +    res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
>

For tcp packets check, why not ignore the ip headers, just like udp packets check ?
Besides, here, can we compare the checksum stored in headers of tcp and udp
before call colo_packet_compare_common(), which i think will improve the comparing
performance.

Thanks.
Hailiang

>       if (res != 0 && trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
>           trace_colo_compare_pkt_info_src(inet_ntoa(ppkt->ip->ip_src),
> @@ -277,7 +277,14 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
>           return -1;
>       }
>
> -    ret = colo_packet_compare_common(ppkt, spkt);
> +    /*
> +     * Because of ppkt and spkt are both in the same connection,
> +     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
> +     * same with spkt. In addition, IP header's Identification is a random
> +     * field, we can handle it in IP fragmentation function later.
> +     * So we just compare the ip payload here.
> +     */
> +    ret = colo_packet_compare_common(ppkt, spkt, network_length + ETH_HLEN);
>
>       if (ret) {
>           trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
> @@ -304,7 +311,14 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
>           return -1;
>       }
>
> -    if (colo_packet_compare_common(ppkt, spkt)) {
> +    /*
> +     * Because of ppkt and spkt are both in the same connection,
> +     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
> +     * same with spkt. In addition, IP header's Identification is a random
> +     * field, we can handle it in IP fragmentation function later.
> +     * So we just compare the ip payload here.
> +     */
> +    if (colo_packet_compare_common(ppkt, spkt, network_length + ETH_HLEN)) {
>           trace_colo_compare_icmp_miscompare("primary pkt size",
>                                              ppkt->size);
>           qemu_hexdump((char *)ppkt->data, stderr, "colo-compare",
> @@ -330,7 +344,7 @@ static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
>                                  inet_ntoa(ppkt->ip->ip_dst), spkt->size,
>                                  inet_ntoa(spkt->ip->ip_src),
>                                  inet_ntoa(spkt->ip->ip_dst));
> -    return colo_packet_compare_common(ppkt, spkt);
> +    return colo_packet_compare_common(ppkt, spkt, 0);
>   }
>
>   static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
>
