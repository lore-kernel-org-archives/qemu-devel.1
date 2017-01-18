Received: from eggs.gnu.org ([2001:4830:134:3::10]:48472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cTuti-0000In-El
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cTute-0001zX-GA
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:23:50 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cTute-0001yZ-9M
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:23:46 -0500
Received: by mail-wm0-x243.google.com with SMTP id r144so6011965wme.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 10:23:44 -0800 (PST)
References: <1484751701-2646-1-git-send-email-clg@kaod.org>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <2241df25-42e3-2518-9c1e-1f922343b407@gmail.com>
Date: Wed, 18 Jan 2017 19:23:39 +0100
MIME-Version: 1.0
In-Reply-To: <1484751701-2646-1-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] aspeed/smc: handle dummy bytes when
 doing fast reads in command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

W dniu 18.01.2017 o 16:01, Cédric Le Goater pisze:
> When doing fast read, a certain amount of dummy bytes should be sent
> before the read. This number is configurable in the controler CE0
> Control Register and needs to be modeled using fake transfers to the
> flash module.
>
> This only supports command mode. User mode requires more work and a
> possible extension of the m25p80 device model.
>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>
>   Changes since v2:
>
>   - handled dummies under read routine and removed the test on the spi
>     command READ_FAST (0xb)
>
>   hw/ssi/aspeed_smc.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index a0a816407fc1..fc3cccec0566 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -69,7 +69,9 @@
>   #define R_CTRL0           (0x10 / 4)
>   #define   CTRL_CMD_SHIFT           16
>   #define   CTRL_CMD_MASK            0xff
> +#define   CTRL_DUMMY_HIGH_SHIFT    14
>   #define   CTRL_AST2400_SPI_4BYTE   (1 << 13)
> +#define   CTRL_DUMMY_LOW_SHIFT     6 /* 2 bits [7:6] */
>   #define   CTRL_CE_STOP_ACTIVE      (1 << 2)
>   #define   CTRL_CMD_MODE_MASK       0x3
>   #define     CTRL_READMODE          0x0
> @@ -490,6 +492,16 @@ static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
>       return addr;
>   }
>   
> +static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
> +{
> +    const AspeedSMCState *s = fl->controller;
> +    uint32_t r_ctrl0 = s->regs[s->r_ctrl0 + fl->id];
> +    uint32_t dummy_high = (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
> +    uint32_t dummy_low = (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
> +
> +    return ((dummy_high << 2) | dummy_low) * 8;
> +}
> +
>   static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr)
>   {
>       const AspeedSMCState *s = fl->controller;
> @@ -526,6 +538,15 @@ static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
>           aspeed_smc_flash_select(fl);
>           aspeed_smc_flash_send_addr(fl, addr);
>   
> +        /*
> +         * Use fake transfers to model dummy bytes. The value should
> +         * be configured to some non-zero value in fast read mode and
> +         * zero in read mode.
> +         */
> +        for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
> +            ssi_transfer(fl->controller->spi, 0xFF);
> +        }
> +
>           for (i = 0; i < size; i++) {
>               ret |= ssi_transfer(s->spi, 0x0) << (8 * i);
>           }
If it does not break CTRL_WRITEMODE then:
Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
