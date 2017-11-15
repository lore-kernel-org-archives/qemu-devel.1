Received: from eggs.gnu.org ([2001:4830:134:3::10]:46769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eF2t5-00088M-NN
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eF2t4-0002Ke-PL
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:58:15 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:42049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eF2t4-0002K1-IB
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:58:14 -0500
Received: by mail-wm0-x242.google.com with SMTP id t139so5049719wmt.1
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 10:58:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510625498-4821-4-git-send-email-jasowang@redhat.com>
References: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
	<1510625498-4821-4-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Nov 2017 18:57:52 +0000
Message-ID: <CAFEAcA_47953-hdHmueXEGXtpxXVOFubJOhzAUh4hsKiYF1ADg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 3/8] colo-compare: compare the packet in a
 specified Connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

On 14 November 2017 at 02:11, Jason Wang <jasowang@redhat.com> wrote:
> From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>
> A package from pri_indev or sec_indev only belongs to a particular
> Connection, so we only need to compare the package in the specified
> Connection's primary_list and secondary_list, rather than for each
> the whole Connection list to compare. This is time-consuming and
> unnecessary.
>
> Less checkpoint more efficiency.
>
> Cc: Zhang Chen <zhangckid@gmail.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  net/colo-compare.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 54b6347..5d2429b 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -136,7 +136,7 @@ static int colo_insert_packet(GQueue *queue, Packet *pkt)
>   * Return 0 on success, if return -1 means the pkt
>   * is unsupported(arp and ipv6) and will be sent later
>   */
> -static int packet_enqueue(CompareState *s, int mode)
> +static int packet_enqueue(CompareState *s, int mode, Connection **con)
>  {
>      ConnectionKey key;
>      Packet *pkt = NULL;
> @@ -179,6 +179,7 @@ static int packet_enqueue(CompareState *s, int mode)
>                           "drop packet");
>          }
>      }
> +    con = &conn;
>
>      return 0;
>  }

Coverity points out that this looks a bit fishy --
presumably you meant
  *con = conn;

? The statement you have now doesn't do anything, since
'con' is unused after you change it.

(CID 1382804.)

thanks
-- PMM
