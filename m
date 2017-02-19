Received: from eggs.gnu.org ([2001:4830:134:3::10]:54975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIi8-0006Qq-H8
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:02:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIi5-00033Q-Ev
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:02:56 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIi5-00032V-Bf
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:02:53 -0500
Received: by mail-qk0-x244.google.com with SMTP id s186so4449124qkb.1
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 20:02:53 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
	<1487248176-29602-6-git-send-email-dmitry@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2e89988f-a172-20f4-e0b3-83b8d07bb727@amsat.org>
Date: Sun, 19 Feb 2017 01:02:49 -0300
MIME-Version: 1.0
In-Reply-To: <1487248176-29602-6-git-send-email-dmitry@daynix.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5] NetRxPkt: Remove code duplication in
 net_rx_pkt_pull_data()
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

On 02/16/2017 09:29 AM, Dmitry Fleytman wrote:
> This is a refactoring commit that does not change behavior.
>
> Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/net_rx_pkt.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
> index c7ae33d..3899211 100644
> --- a/hw/net/net_rx_pkt.c
> +++ b/hw/net/net_rx_pkt.c
> @@ -88,20 +88,21 @@ net_rx_pkt_pull_data(struct NetRxPkt *pkt,
>                          const struct iovec *iov, int iovcnt,
>                          size_t ploff)
>  {
> +    uint32_t pllen = iov_size(iov, iovcnt) - ploff;
> +
>      if (pkt->ehdr_buf_len) {
>          net_rx_pkt_iovec_realloc(pkt, iovcnt + 1);
>
>          pkt->vec[0].iov_base = pkt->ehdr_buf;
>          pkt->vec[0].iov_len = pkt->ehdr_buf_len;
>
> -        pkt->tot_len = iov_size(iov, iovcnt) - ploff + pkt->ehdr_buf_len;
> +        pkt->tot_len = pllen + pkt->ehdr_buf_len;
>          pkt->vec_len = iov_copy(pkt->vec + 1, pkt->vec_len_total - 1,
> -                                iov, iovcnt, ploff,
> -                                pkt->tot_len - pkt->ehdr_buf_len) + 1;
> +                                iov, iovcnt, ploff, pllen) + 1;
>      } else {
>          net_rx_pkt_iovec_realloc(pkt, iovcnt);
>
> -        pkt->tot_len = iov_size(iov, iovcnt) - ploff;
> +        pkt->tot_len = pllen;
>          pkt->vec_len = iov_copy(pkt->vec, pkt->vec_len_total,
>                                  iov, iovcnt, ploff, pkt->tot_len);
>      }
>
