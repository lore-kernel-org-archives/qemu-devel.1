Received: from eggs.gnu.org ([2001:4830:134:3::10]:35777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjqIl-0006Nk-MH
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjqIg-0006vv-Qi
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:43:31 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjqIg-0006vp-Mk
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:43:26 -0500
Received: by mail-qk0-x244.google.com with SMTP id n127so28423727qkf.2
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:43:26 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
	<1487248176-29602-4-git-send-email-dmitry@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d3e30d7f-f684-1d8d-2a90-289f7db41ee8@amsat.org>
Date: Fri, 3 Mar 2017 13:43:22 -0300
MIME-Version: 1.0
In-Reply-To: <1487248176-29602-4-git-send-email-dmitry@daynix.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/5] NetRxPkt: Do not try to pull more data
 than present
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

this seems correct but unit-test would confirm any doubt.

On 02/16/2017 09:29 AM, Dmitry Fleytman wrote:
> In case of VLAN stripping, ETH header put into a
> separate buffer, therefore amont of data copied
> from original IOV should be smaller.
>
> Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/net_rx_pkt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
> index 7c0beac..d38babe 100644
> --- a/hw/net/net_rx_pkt.c
> +++ b/hw/net/net_rx_pkt.c
> @@ -96,7 +96,8 @@ net_rx_pkt_pull_data(struct NetRxPkt *pkt,
>
>          pkt->tot_len = iov_size(iov, iovcnt) - ploff + pkt->ehdr_buf_len;
>          pkt->vec_len = iov_copy(pkt->vec + 1, pkt->vec_len_total - 1,
> -                                iov, iovcnt, ploff, pkt->tot_len);
> +                                iov, iovcnt, ploff,
> +                                pkt->tot_len - pkt->ehdr_buf_len);
>      } else {
>          net_rx_pkt_iovec_realloc(pkt, iovcnt);
>
>
