Received: from eggs.gnu.org ([2001:4830:134:3::10]:41025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMQU4-0008ST-78
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMQU0-0004f0-9e
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:34:56 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:32883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMQU0-0004e7-55
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:34:52 -0500
Received: by mail-qt0-x241.google.com with SMTP id e2so5969606qti.0
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 19:34:52 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
	<20171205081744.6563-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8ad8cb9d-9328-5fd2-be8c-99082dfe3fc7@amsat.org>
Date: Wed, 6 Dec 2017 00:34:48 -0300
MIME-Version: 1.0
In-Reply-To: <20171205081744.6563-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 5/5] sunhme: switch sunhme_receive() over
 to use net_crc32_le()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

Hi Mark,

On 12/05/2017 05:17 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/net/sunhme.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
> index b1efa1b88d..df66e2630c 100644
> --- a/hw/net/sunhme.c
> +++ b/hw/net/sunhme.c
> @@ -698,29 +698,6 @@ static inline void sunhme_set_rx_ring_nr(SunHMEState *s, int i)
>      s->erxregs[HME_ERXI_RING >> 2] = ring;
>  }
>  
> -#define POLYNOMIAL_LE 0xedb88320
> -static uint32_t sunhme_crc32_le(const uint8_t *p, int len)
> -{
> -    uint32_t crc;
> -    int carry, i, j;
> -    uint8_t b;
> -
> -    crc = 0xffffffff;
> -    for (i = 0; i < len; i++) {
> -        b = *p++;
> -        for (j = 0; j < 8; j++) {
> -            carry = (crc & 0x1) ^ (b & 0x01);
> -            crc >>= 1;
> -            b >>= 1;
> -            if (carry) {
> -                crc = crc ^ POLYNOMIAL_LE;
> -            }
> -        }
> -    }
> -
> -    return crc;
> -}
> -
>  #define MIN_BUF_SIZE 60
>  
>  static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
> @@ -761,7 +738,7 @@ static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
>              trace_sunhme_rx_filter_bcast_match();
>          } else if (s->macregs[HME_MACI_RXCFG >> 2] & HME_MAC_RXCFG_HENABLE) {
>              /* Didn't match local address, check hash filter */
> -            int mcast_idx = sunhme_crc32_le(buf, 6) >> 26;

This could be:

               int mcast_idx = compute_mcast_idx_le(buf);

With:

unsigned compute_mcast_idx_le(const uint8_t *ep)
{
    return net_crc32(ep, ETH_ALEN) >> 26;
}

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +            int mcast_idx = net_crc32_le(buf, 6) >> 26;
>              if (!(s->macregs[(HME_MACI_HASHTAB0 >> 2) - (mcast_idx >> 4)] &
>                      (1 << (mcast_idx & 0xf)))) {
>                  /* Didn't match hash filter */
> 
