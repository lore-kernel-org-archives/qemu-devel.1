Received: from eggs.gnu.org ([2001:4830:134:3::10]:38102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNdqG-0006Bw-7p
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNdqD-0007jR-5c
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:35:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180529062838.20556-1-clg@kaod.org>
	<20180529062838.20556-4-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <92180a68-8fb9-dde1-cbce-5ef30eec27b6@amsat.org>
Date: Tue, 29 May 2018 09:34:59 -0300
MIME-Version: 1.0
In-Reply-To: <20180529062838.20556-4-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/6] net/ftgmac100: fix multicast hash
 routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On 05/29/2018 03:28 AM, Cédric Le Goater wrote:
> Based on the multicast hash calculation of the FTGMAC100 Linux driver.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/ftgmac100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 50af1222464a..fd7699b1c05e 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -778,8 +778,8 @@ static int ftgmac100_filter(FTGMAC100State *s, const uint8_t *buf, size_t len)
>                  return 0;
>              }
>  
> -            /* TODO: this does not seem to work for ftgmac100 */
> -            mcast_idx = net_crc32(buf, ETH_ALEN) >> 26;
> +            mcast_idx = net_crc32_le(buf, ETH_ALEN);
> +            mcast_idx = (~(mcast_idx >> 2)) & 0x3f;
>              if (!(s->math[mcast_idx / 32] & (1 << (mcast_idx % 32)))) {
>                  return 0;
>              }
> 
