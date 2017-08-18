Received: from eggs.gnu.org ([2001:4830:134:3::10]:41538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diknV-0006Yv-Q6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diknS-0004jX-KG
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:11:01 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diknS-0004jK-GO
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:10:58 -0400
Received: by mail-qk0-x242.google.com with SMTP id o124so5639804qke.0
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:10:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503065708-28277-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1503065708-28277-5-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <abf0dfdf-d8eb-2be2-0509-0710427ef602@amsat.org>
Date: Fri, 18 Aug 2017 14:10:54 -0300
MIME-Version: 1.0
In-Reply-To: <1503065708-28277-5-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] eepro100: switch
 e100_compute_mcast_idx() over to use net_crc32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, jasowang@redhat.com

On 08/18/2017 11:15 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/net/eepro100.c |   19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index 5a4774a..4226572 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -327,26 +327,9 @@ static const uint16_t eepro100_mdi_mask[] = {
>   
>   static E100PCIDeviceInfo *eepro100_get_class(EEPRO100State *s);
>   
> -/* From FreeBSD (locally modified). */
>   static unsigned e100_compute_mcast_idx(const uint8_t *ep)
>   {
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

with previous suggestion from patch 1/4:

        return (mac_crc32_be(ep) & BITS(7, 2)) >> 2;

then
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   }
>   
>   /* Read a 16 bit control/status (CSR) register. */
> 
