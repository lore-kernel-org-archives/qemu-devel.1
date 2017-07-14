Received: from eggs.gnu.org ([2001:4830:134:3::10]:45339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVrEr-0000nS-Mr
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVrEo-0004sB-K2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:25:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dVrEo-0004s1-Ds
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:25:54 -0400
References: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1499925175-21218-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <174a3db3-6a14-edbb-641a-e93746c51861@redhat.com>
Date: Fri, 14 Jul 2017 11:25:49 +0800
MIME-Version: 1.0
In-Reply-To: <1499925175-21218-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 2/4] net/colo-compare.c: Compare the tcp
 packets that has the same sequence number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 2017=E5=B9=B407=E6=9C=8813=E6=97=A5 13:52, Zhang Chen wrote:
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
> @@ -222,6 +222,12 @@ static int colo_packet_compare_tcp(Packet *spkt, P=
acket *ppkt)
>       ptcp =3D (struct tcphdr *)ppkt->transport_header;
>       stcp =3D (struct tcphdr *)spkt->transport_header;
>  =20
> +    if ((ptcp->th_flags & TH_SYN) !=3D TH_SYN &&
> +        ptcp->th_seq !=3D stcp->th_seq) {
> +        trace_colo_compare_main("colo_packet_compare_tcp seq not same"=
);
> +        return -1;
> +    }
> +
>       /*
>        * The 'identification' field in the IP header is *very* random
>        * it almost never matches.  Fudge this by ignoring differences i=
n

Do we have any statistics numbers for this?

Thanks
