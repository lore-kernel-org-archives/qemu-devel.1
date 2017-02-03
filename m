Received: from eggs.gnu.org ([2001:4830:134:3::10]:48801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cZUdF-0004zg-9u
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 22:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cZUdC-0004Bn-5T
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 22:33:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cZUdC-0004Bb-00
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 22:33:50 -0500
References: <1485248026-9628-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c59a3873-b431-522f-d7bd-2c91a12b6735@redhat.com>
Date: Fri, 3 Feb 2017 11:33:44 +0800
MIME-Version: 1.0
In-Reply-To: <1485248026-9628-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] colo-compare: sort TCP packet queue by
 sequence number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 2017=E5=B9=B401=E6=9C=8824=E6=97=A5 16:53, Zhang Chen wrote:
> Improve efficiency of TCP packet comparison.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 9bfc736..5a4f335 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -101,6 +101,15 @@ static int compare_chr_send(CharBackend *out,
>                               const uint8_t *buf,
>                               uint32_t size);
>  =20
> +static gint seq_sorter(Packet *a, Packet *b, gpointer data)
> +{
> +    struct tcphdr *atcp, *btcp;
> +
> +    atcp =3D (struct tcphdr *)(a->transport_header);
> +    btcp =3D (struct tcphdr *)(b->transport_header);
> +    return ntohl(atcp->th_seq) - ntohl(btcp->th_seq);
> +}
> +
>   /*
>    * Return 0 on success, if return -1 means the pkt
>    * is unsupported(arp and ipv6) and will be sent later
> @@ -137,6 +146,11 @@ static int packet_enqueue(CompareState *s, int mod=
e)
>           if (g_queue_get_length(&conn->primary_list) <=3D
>                                  MAX_QUEUE_SIZE) {
>               g_queue_push_tail(&conn->primary_list, pkt);
> +            if (conn->ip_proto =3D=3D IPPROTO_TCP) {
> +                g_queue_sort(&conn->primary_list,
> +                             (GCompareDataFunc)seq_sorter,
> +                             NULL);
> +            }
>           } else {
>               error_report("colo compare primary queue size too big,"
>                            "drop packet");
> @@ -145,6 +159,11 @@ static int packet_enqueue(CompareState *s, int mod=
e)
>           if (g_queue_get_length(&conn->secondary_list) <=3D
>                                  MAX_QUEUE_SIZE) {
>               g_queue_push_tail(&conn->secondary_list, pkt);
> +            if (conn->ip_proto =3D=3D IPPROTO_TCP) {
> +                g_queue_sort(&conn->secondary_list,
> +                             (GCompareDataFunc)seq_sorter,
> +                             NULL);
> +            }
>           } else {
>               error_report("colo compare secondary queue size too big,"
>                            "drop packet");

Applied. Thanks
