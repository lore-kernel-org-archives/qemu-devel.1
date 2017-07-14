Received: from eggs.gnu.org ([2001:4830:134:3::10]:48911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVzdz-00059O-BX
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVzdy-0008FR-9W
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:24:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dVzdy-0008FE-3B
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:24:26 -0400
Date: Fri, 14 Jul 2017 13:24:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170714122420.GD2091@work-vm>
References: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1499925175-21218-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499925175-21218-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
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
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

* Zhang Chen (zhangchen.fnst@cn.fujitsu.com) wrote:
> If primary packet's sequence number not same with secondary packet's
> sequence number, no need to compare the packet other field.
> 
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>  net/colo-compare.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 0f8e198..2caeb80 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -222,6 +222,12 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
>      ptcp = (struct tcphdr *)ppkt->transport_header;
>      stcp = (struct tcphdr *)spkt->transport_header;
>  
> +    if ((ptcp->th_flags & TH_SYN) != TH_SYN &&
> +        ptcp->th_seq != stcp->th_seq) {
> +        trace_colo_compare_main("colo_packet_compare_tcp seq not same");
> +        return -1;
> +    }

Do you need to check that the stcp->th_flags is the same ?

Looking back at patches I had in this area; I was doing
  if (ptcp->th_flags == stcp->th_flags &&

see:
   https://github.com/orbitfp7/qemu/commit/848ca1113aec802dd032fd5b6d6b301931b3e1e0

Dave

>      /*
>       * The 'identification' field in the IP header is *very* random
>       * it almost never matches.  Fudge this by ignoring differences in
> -- 
> 2.7.4
> 
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
