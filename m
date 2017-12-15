Received: from eggs.gnu.org ([2001:4830:134:3::10]:33914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePvvD-0000DR-Tn
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePvvA-00031l-0c
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:45:27 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePvv9-00031d-Mg
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:45:23 -0500
Received: by mail-qt0-x243.google.com with SMTP id k19so13452814qtj.6
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 11:45:23 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
	<20171215184155.2543-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <99cdd167-f129-a672-b52e-c6dc07c656e3@amsat.org>
Date: Fri, 15 Dec 2017 16:45:20 -0300
MIME-Version: 1.0
In-Reply-To: <20171215184155.2543-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 04/13] eepro100: switch eepro100
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

On 12/15/2017 03:41 PM, Mark Cave-Ayland wrote:
> Instead of e100_compute_mcast_idx() using its own implementation, we can
> simply call net_crc32() directly and apply the bit shift inline.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/eepro100.c | 28 ++++------------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index 71cddfece4..e30fed830b 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -44,6 +44,7 @@
>  #include "hw/hw.h"
>  #include "hw/pci/pci.h"
>  #include "net/net.h"
> +#include "net/eth.h"
>  #include "hw/nvram/eeprom93xx.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/dma.h"
> @@ -325,28 +326,6 @@ static const uint16_t eepro100_mdi_mask[] = {
>  
>  static E100PCIDeviceInfo *eepro100_get_class(EEPRO100State *s);
>  
> -/* From FreeBSD (locally modified). */
> -static unsigned e100_compute_mcast_idx(const uint8_t *ep)
> -{
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
> -                crc = ((crc ^ POLYNOMIAL_BE) | carry);
> -            }
> -        }
> -    }
> -    return (crc & BITS(7, 2)) >> 2;
> -}
> -
>  /* Read a 16 bit control/status (CSR) register. */
>  static uint16_t e100_read_reg2(EEPRO100State *s, E100RegisterOffset addr)
>  {
> @@ -843,7 +822,8 @@ static void set_multicast_list(EEPRO100State *s)
>          uint8_t multicast_addr[6];
>          pci_dma_read(&s->dev, s->cb_address + 10 + i, multicast_addr, 6);
>          TRACE(OTHER, logout("multicast entry %s\n", nic_dump(multicast_addr, 6)));
> -        unsigned mcast_idx = e100_compute_mcast_idx(multicast_addr);
> +        unsigned mcast_idx = (net_crc32(multicast_addr, ETH_ALEN) &
> +                              BITS(7, 2)) >> 2;
>          assert(mcast_idx < 64);
>          s->mult[mcast_idx >> 3] |= (1 << (mcast_idx & 7));
>      }
> @@ -1679,7 +1659,7 @@ static ssize_t nic_receive(NetClientState *nc, const uint8_t * buf, size_t size)
>          if (s->configuration[21] & BIT(3)) {
>            /* Multicast all bit is set, receive all multicast frames. */
>          } else {
> -          unsigned mcast_idx = e100_compute_mcast_idx(buf);
> +          unsigned mcast_idx = (net_crc32(buf, ETH_ALEN) & BITS(7, 2)) >> 2;
>            assert(mcast_idx < 64);
>            if (s->mult[mcast_idx >> 3] & (1 << (mcast_idx & 7))) {
>              /* Multicast frame is allowed in hash table. */
> 
