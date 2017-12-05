Received: from eggs.gnu.org ([2001:4830:134:3::10]:51935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eMEwH-0000UW-1t
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:16:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eMEvG-0007th-1O
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:15:14 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:47983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1eMEvE-0007q1-5l
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:14:13 -0500
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
	<20171205081744.6563-5-mark.cave-ayland@ilande.co.uk>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <2d28f37d-0a34-6a78-4955-d0012a8152c3@weilnetz.de>
Date: Tue, 5 Dec 2017 16:13:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171205081744.6563-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, jasowang@redhat.com, Eric Blake <eblake@redhat.com>

Am 05.12.2017 um 09:17 schrieb Mark Cave-Ayland:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


What about eliminating the intermediate function e100_compute_mcast_idx (and function lnc_mchash, too)?
You did that for lnc_mchash, and I think that is cleaner and saves some lines of code.

With or without that minor change:

Reviewed-by: Stefan Weil <sw@weilnetz.de>

Regards
Stefan
