Received: from eggs.gnu.org ([2001:4830:134:3::10]:39142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d6UcL-0001E2-8W
	for qemu-devel@nongnu.org; Fri, 05 May 2017 00:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d6UcG-0005VS-LT
	for qemu-devel@nongnu.org; Fri, 05 May 2017 00:13:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d6UcG-0005Uw-Bn
	for qemu-devel@nongnu.org; Fri, 05 May 2017 00:13:16 -0400
References: <1493264805-15398-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f9e9e40a-1eab-b0be-2139-4f3483034bda@redhat.com>
Date: Fri, 5 May 2017 12:13:09 +0800
MIME-Version: 1.0
In-Reply-To: <1493264805-15398-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] COLO-compare: Improve tcp compare trace
 event readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>



On 2017=E5=B9=B404=E6=9C=8827=E6=97=A5 11:46, Zhang Chen wrote:
> Because of previous patch's trace arguments over the limit
> of UST backend, so I rewrite the patch.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 33 ++++++++++++++++++++++-----------
>   net/trace-events   |  3 +--
>   2 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 4ab80b1..2639c7f 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -265,17 +265,28 @@ static int colo_packet_compare_tcp(Packet *spkt, =
Packet *ppkt)
>       }
>  =20
>       if (res !=3D 0 && trace_event_get_state(TRACE_COLO_COMPARE_MISCOM=
PARE)) {
> -        trace_colo_compare_pkt_info_src(inet_ntoa(ppkt->ip->ip_src),
> -                                        ntohl(stcp->th_seq),
> -                                        ntohl(stcp->th_ack),
> -                                        res, stcp->th_flags,
> -                                        spkt->size);
> -
> -        trace_colo_compare_pkt_info_dst(inet_ntoa(ppkt->ip->ip_dst),
> -                                        ntohl(ptcp->th_seq),
> -                                        ntohl(ptcp->th_ack),
> -                                        res, ptcp->th_flags,
> -                                        ppkt->size);
> +        char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_ds=
t[20];
> +
> +        strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
> +        strcpy(pri_ip_dst, inet_ntoa(ppkt->ip->ip_dst));
> +        strcpy(sec_ip_src, inet_ntoa(spkt->ip->ip_src));
> +        strcpy(sec_ip_dst, inet_ntoa(spkt->ip->ip_dst));
> +
> +        trace_colo_compare_ip_info(ppkt->size, pri_ip_src,
> +                                   pri_ip_dst, spkt->size,
> +                                   sec_ip_src, sec_ip_dst);
> +
> +        trace_colo_compare_tcp_info("pri tcp packet",
> +                                    ntohl(ptcp->th_seq),
> +                                    ntohl(ptcp->th_ack),
> +                                    res, ptcp->th_flags,
> +                                    ppkt->size);
> +
> +        trace_colo_compare_tcp_info("sec tcp packet",
> +                                    ntohl(stcp->th_seq),
> +                                    ntohl(stcp->th_ack),
> +                                    res, stcp->th_flags,
> +                                    spkt->size);
>  =20
>           qemu_hexdump((char *)ppkt->data, stderr,
>                        "colo-compare ppkt", ppkt->size);
> diff --git a/net/trace-events b/net/trace-events
> index 35198bc..247e5c0 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -13,8 +13,7 @@ colo_compare_icmp_miscompare(const char *sta, int siz=
e) ": %s =3D %d"
>   colo_compare_ip_info(int psize, const char *sta, const char *stb, int=
 ssize, const char *stc, const char *std) "ppkt size =3D %d, ip_src =3D %=
s, ip_dst =3D %s, spkt size =3D %d, ip_src =3D %s, ip_dst =3D %s"
>   colo_old_packet_check_found(int64_t old_time) "%" PRId64
>   colo_compare_miscompare(void) ""
> -colo_compare_pkt_info_src(const char *src, uint32_t sseq, uint32_t sac=
k, int res, uint32_t sflag, int ssize) "src/dst: %s s: seq/ack=3D%u/%u re=
s=3D%d flags=3D%x spkt_size: %d\n"
> -colo_compare_pkt_info_dst(const char *dst, uint32_t dseq, uint32_t dac=
k, int res, uint32_t dflag, int dsize) "src/dst: %s d: seq/ack=3D%u/%u re=
s=3D%d flags=3D%x dpkt_size: %d\n"
> +colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int=
 res, uint32_t flag, int size) "side: %s seq/ack=3D %u/%u res=3D %d flags=
=3D %x pkt_size: %d\n"
>  =20
>   # net/filter-rewriter.c
>   colo_filter_rewriter_debug(void) ""

Applied, thanks.
