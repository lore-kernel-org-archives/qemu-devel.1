Received: from eggs.gnu.org ([2001:4830:134:3::10]:41498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1chW6Z-00034T-Mz
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1chW6W-0000f3-Jr
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:45:19 -0500
Received: from [45.249.212.189] (port=2411 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1chW6V-0000eB-MA
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:45:16 -0500
References: <1487993530-30875-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1487993530-30875-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58B1278E.1090206@huawei.com>
Date: Sat, 25 Feb 2017 14:43:26 +0800
MIME-Version: 1.0
In-Reply-To: <1487993530-30875-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] COLO-compare: Add minimum packet size
 check and some fix
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

Hi,

On 2017/2/25 11:32, Zhang Chen wrote:
> Add packet minimum size check in colo_packet_compare_udp()
> and colo_packet_compare_udp() like colo_packet_compare_icmp(),
> rename function colo_packet_compare() to colo_packet_compare_common()
> that we will reuse it later.
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

I think the check here is useless, because you have such check in
parse_packet_early() which is been called before these helpers.
And what check you need to add is, to check if the packet's size
>= packet's length been record in ip header.

Like:
+++ b/net/colo.c
@@ -78,6 +78,12 @@ int parse_packet_early(Packet *pkt)
          trace_colo_proxy_main("pkt->size < network_header + network_length");
          return 1;
      }
+
+    if (pkt->size < ETH_HLEN + ntohs(pkt->ip->ip_len)) {
+        fprintf(stderr, "pkt->size %d < pkt expect total len %ld\n", pkt->size,
+            pkt_MAChdr_len + ntohs(pkt->ip->ip_len));
+        return -1;
+    }


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
>
