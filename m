Received: from eggs.gnu.org ([2001:4830:134:3::10]:55331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePmt1-0006Lm-9T
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePmsx-0002Zg-9T
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:06:35 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171214145255.31545-1-andrew.smirnov@gmail.com>
	<20171214145255.31545-3-andrew.smirnov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0f0bb800-af8b-d36e-c8da-10b0f2bd1e09@amsat.org>
Date: Fri, 15 Dec 2017 07:06:25 -0300
MIME-Version: 1.0
In-Reply-To: <20171214145255.31545-3-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/15] imx_fec: Refactor
 imx_eth_enable_rx()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

On 12/14/2017 11:52 AM, Andrey Smirnov wrote:
> Refactor imx_eth_enable_rx() to have more meaningfull variable name
> than 'tmp' and to reduce number of logical negations done.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/imx_fec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 88b4b049d7..8b2e4b8ffe 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -536,19 +536,19 @@ static void imx_eth_do_tx(IMXFECState *s)
>  static void imx_eth_enable_rx(IMXFECState *s)
>  {
>      IMXFECBufDesc bd;
> -    bool tmp;
> +    bool rx_ring_full;
>  
>      imx_fec_read_bd(&bd, s->rx_descriptor);
>  
> -    tmp = ((bd.flags & ENET_BD_E) != 0);
> +    rx_ring_full = !(bd.flags & ENET_BD_E);
>  
> -    if (!tmp) {
> +    if (rx_ring_full) {
>          FEC_PRINTF("RX buffer full\n");
>      } else if (!s->regs[ENET_RDAR]) {
>          qemu_flush_queued_packets(qemu_get_queue(s->nic));
>      }
>  
> -    s->regs[ENET_RDAR] = tmp ? ENET_RDAR_RDAR : 0;
> +    s->regs[ENET_RDAR] = rx_ring_full ? 0 : ENET_RDAR_RDAR;
>  }
>  
>  static void imx_eth_reset(DeviceState *d)
> 
