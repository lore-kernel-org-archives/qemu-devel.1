Received: from eggs.gnu.org ([2001:4830:134:3::10]:34482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjqFI-00039A-8W
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjqFD-0005Q1-Ch
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:39:56 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjqFD-0005Pw-8m
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:39:51 -0500
Received: by mail-qk0-x243.google.com with SMTP id n141so4653027qke.3
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:39:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
	<1487248176-29602-5-git-send-email-dmitry@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4fd7a104-e49e-1f3f-c4a9-1572e6db9372@amsat.org>
Date: Fri, 3 Mar 2017 13:39:46 -0300
MIME-Version: 1.0
In-Reply-To: <1487248176-29602-5-git-send-email-dmitry@daynix.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] NetRxPkt: Account buffer with ETH
 header in IOV length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, P J P <ppandit@redhat.com>

Hi Dmitry,

On 02/16/2017 09:29 AM, Dmitry Fleytman wrote:
> In case of VLAN stripping ETH header is stored in a
> separate chunk and length of IOV should take this into
> account.
>
> This patch fixes checksum validation for RX packets
> with VLAN header.
>
> Devices affected by this problem: e1000e and vmxnet3.
>
> Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
> ---
>  hw/net/net_rx_pkt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
> index d38babe..c7ae33d 100644
> --- a/hw/net/net_rx_pkt.c
> +++ b/hw/net/net_rx_pkt.c
> @@ -97,7 +97,7 @@ net_rx_pkt_pull_data(struct NetRxPkt *pkt,
>          pkt->tot_len = iov_size(iov, iovcnt) - ploff + pkt->ehdr_buf_len;
>          pkt->vec_len = iov_copy(pkt->vec + 1, pkt->vec_len_total - 1,
>                                  iov, iovcnt, ploff,
> -                                pkt->tot_len - pkt->ehdr_buf_len);
> +                                pkt->tot_len - pkt->ehdr_buf_len) + 1;

I can not understand the trailing '1', shouldn't it be 'sizeof(struct 
vlan_header)' instead? (=4)
This should be easily unit-testable.

>      } else {
>          net_rx_pkt_iovec_realloc(pkt, iovcnt);
>
>
