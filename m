Received: from eggs.gnu.org ([2001:4830:134:3::10]:41553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cRBml-0003BF-UJ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cRBmh-0003Ne-LR
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:49:23 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:32925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1cRBmh-0003LT-Es
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:49:19 -0500
Received: by mail-pg0-x241.google.com with SMTP id 194so8234306pgd.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 21:49:19 -0800 (PST)
References: <efe171ec-dc45-885c-a7a1-b24e1ec48973@wiesinger.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <db9d629b-cd6d-5181-f5ff-9c27f8c98a24@ozlabs.ru>
Date: Wed, 11 Jan 2017 16:49:13 +1100
MIME-Version: 1.0
In-Reply-To: <efe171ec-dc45-885c-a7a1-b24e1ec48973@wiesinger.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Add DOS support for RTL8139
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerhard Wiesinger <lists@wiesinger.com>, qemu-devel@nongnu.org

On 08/01/17 22:54, Gerhard Wiesinger wrote:
> Signed-off-by: Gerhard Wiesinger <lists@wiesinger.com>
> ---
>  hw/net/rtl8139.c | 288
> ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 264 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index f05e59c..5241fea 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -48,6 +48,17 @@
>   *  2011-Mar-22  Benjamin Poirier:  Implemented VLAN offloading
>   */
>  +/*
> + * Testcases and successful regression tests:
> + * 1.) DOS RSET8139.EXE: EEPROM Test successful
> + * 2.) DOS RSET8139.EXE: Local loopback Test (Run Diagnostics On Board)
> + * 3.) DOS RSET8139.EXE: Remote loopback Test as Initiator (Run
> Diagnostics On Network)
> + * 4.) DOS RSET8139.EXE: Remote loopback Test as Responder (Run
> Diagnostics On Network)
> + * 5.) DOS driver: Loads and works
> + * 6.) Linux tests
> + * 7.) Windows tests
> + */
> +
>  /* For crc32 */
>  #include "qemu/osdep.h"
>  #include <zlib.h>
> @@ -130,6 +141,7 @@ enum RTL8139_registers {
>      NWayExpansion = 0x6A,
>      /* Undocumented registers, but required for proper operation. */
>      FIFOTMS = 0x70,        /* FIFO Control and test. */
> +    RX_ER = 0x72,       /* RX_ER Counter */
>      CSCR = 0x74,        /* Chip Status and Configuration Register. */
>      PARA78 = 0x78,
>      PARA7c = 0x7c,        /* Magic transceiver parameter register. */
> @@ -472,6 +484,8 @@ typedef struct RTL8139State {
>      uint16_t NWayLPAR;
>      uint16_t NWayExpansion;
>  +    uint16_t Fifo_TMS;
> +
>      uint16_t CpCmd;
>      uint8_t  TxThresh;
>  @@ -757,15 +771,27 @@ static void rtl8139_write_buffer(RTL8139State *s,
> const void *buf, int size)
>               if (size > wrapped)
>              {
> +                DPRINTF(">>> rx packet pci dma write "
> +                        "RxBuf=0x%x, RxBufAddr=0x%x, RxBuf+RxBufAddr=0x%x, "
> +                        "buf=%p, size=%i, wrapped=%i, size-wrapped=%i\n",
> +                        s->RxBuf, s->RxBufAddr, s->RxBuf + s->RxBufAddr,
> +                        buf, size, wrapped, size - wrapped
> +                       );
>                  pci_dma_write(d, s->RxBuf + s->RxBufAddr,
> -                              buf, size-wrapped);
> +                              buf, size - wrapped);


The patch has lots of cosmetic and unrelated changes like one above, please
post them as a separate patch (if you really have to) and keep functions
changes apart from that.

Also, please use "git send-mail" to make sure the patch was not damaged - I
could not apply this one as thunderbird wrapped long lines. Thanks.


-- 
Alexey
