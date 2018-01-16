Received: from eggs.gnu.org ([2001:4830:134:3::10]:36746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebPpX-0000Nk-7j
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebPpW-0003Tt-Hq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:55:03 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebPpW-0003TB-Dw
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:55:02 -0500
Received: by mail-oi0-x242.google.com with SMTP id e144so10434472oib.4
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 03:55:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180114225543.24006-1-frasse.iglesias@gmail.com>
References: <20180114225543.24006-1-frasse.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 11:54:41 +0000
Message-ID: <CAFEAcA8Kp+teMjGgFm8gaZPe6_hYZuRd23AQznUTwY2-rcQ8NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] xilinx_spips: Correct usage of an
 uninitialized local variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>

On 14 January 2018 at 22:55, Francisco Iglesias
<frasse.iglesias@gmail.com> wrote:
> Coverity found that the variable tx_rx in the function
> xilinx_spips_flush_txfifo was being used uninitialized (CID 1383841). This
> patch corrects this by always initializing tx_rx to zeros.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> ---
>  hw/ssi/xilinx_spips.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index d8187fa..77e1bbe 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -210,6 +210,8 @@
>  #define SNOOP_NONE 0xEE
>  #define SNOOP_STRIPING 0
>
> +#define MAX_NUM_EFFECTIVE_BUSSES 2
> +
>  static inline int num_effective_busses(XilinxSPIPS *s)
>  {
>      return (s->regs[R_LQSPI_CFG] & LQSPI_CFG_SEP_BUS &&
> @@ -573,7 +575,7 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
>      for (;;) {
>          int i;
>          uint8_t tx = 0;
> -        uint8_t tx_rx[num_effective_busses(s)];
> +        uint8_t tx_rx[MAX_NUM_EFFECTIVE_BUSSES] = { 0 };
>          uint8_t dummy_cycles = 0;
>          uint8_t addr_length;

It doesn't look like your device's realize method is sanity checking
the num_busses property, so this change means that the user can
make the device model segfault by passing it a num_busses property
value larger than 2...

thanks
-- PMM
