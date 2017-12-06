Received: from eggs.gnu.org ([2001:4830:134:3::10]:37810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMQO9-00051K-59
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMQO5-0000LQ-7M
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:28:49 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:40096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMQO5-0000L5-3N
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:28:45 -0500
Received: by mail-qt0-x244.google.com with SMTP id u42so5907188qte.7
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 19:28:45 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
	<20171205081744.6563-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5a3636cb-8bc9-2a6f-c500-bac1af2ab808@amsat.org>
Date: Wed, 6 Dec 2017 00:28:41 -0300
MIME-Version: 1.0
In-Reply-To: <20171205081744.6563-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 4/5] eepro100: switch
 e100_compute_mcast_idx() over to use net_crc32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

On 12/05/2017 05:17 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/eepro100.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index 1c0def555b..4fe94b7471 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -327,26 +327,9 @@ static const uint16_t eepro100_mdi_mask[] = {
>  
>  static E100PCIDeviceInfo *eepro100_get_class(EEPRO100State *s);
>  
> -/* From FreeBSD (locally modified). */
>  static unsigned e100_compute_mcast_idx(const uint8_t *ep)
>  {
> -    uint32_t crc;
> -    int carry, i, j;
> -    uint8_t b;
> -
> -    crc = 0xffffffff;
> -    for (i = 0; i < 6; i++) {
> -        b = *ep++;
> -        for (j = 0; j < 8; j++) {
> -            carry = ((crc & 0x80000000L) ? 1 : 0) ^ (b & 0x01);
> -            crc <<= 1;
> -            b >>= 1;
> -            if (carry) {
> -                crc = ((crc ^ POLYNOMIAL) | carry);
> -            }
> -        }
> -    }
> -    return (crc & BITS(7, 2)) >> 2;
> +    return (net_crc32(ep, 6) & BITS(7, 2)) >> 2;
>  }
>  
>  /* Read a 16 bit control/status (CSR) register. */
> 
