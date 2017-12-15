Received: from eggs.gnu.org ([2001:4830:134:3::10]:34157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePvw5-0000f3-AH
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePvw4-0003mx-HK
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:46:21 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:47073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePvw4-0003mp-Cw
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:46:20 -0500
Received: by mail-qt0-x243.google.com with SMTP id r39so13413036qtr.13
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 11:46:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
	<20171215184155.2543-7-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <88252cc8-2afa-db11-0a06-1a86c9c93ff0@amsat.org>
Date: Fri, 15 Dec 2017 16:46:17 -0300
MIME-Version: 1.0
In-Reply-To: <20171215184155.2543-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 06/13] sungem: fix multicast filter CRC
 calculation
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
> From the Linux sungem driver, we know that the multicast filter CRC is
> implemented using ether_crc_le() which isn't the same as calling zlib's
> crc32() function (the zlib implementation requires a complemented initial value
> and also returns the complemented result).
> 
> Fix the multicast filter by simply using the new net_crc32_le() function.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/sungem.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/sungem.c b/hw/net/sungem.c
> index 6aa8d1117b..60f1e479f3 100644
> --- a/hw/net/sungem.c
> +++ b/hw/net/sungem.c
> @@ -11,12 +11,11 @@
>  #include "hw/pci/pci.h"
>  #include "qemu/log.h"
>  #include "net/net.h"
> +#include "net/eth.h"
>  #include "net/checksum.h"
>  #include "hw/net/mii.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
> -/* For crc32 */
> -#include <zlib.h>
>  
>  #define TYPE_SUNGEM "sungem"
>  
> @@ -595,7 +594,7 @@ static ssize_t sungem_receive(NetClientState *nc, const uint8_t *buf,
>      }
>  
>      /* Get MAC crc */
> -    mac_crc = crc32(~0, buf, 6);
> +    mac_crc = net_crc32_le(buf, ETH_ALEN);
>  
>      /* Packet isn't for me ? */
>      rx_cond = sungem_check_rx_mac(s, buf, mac_crc);
> 
