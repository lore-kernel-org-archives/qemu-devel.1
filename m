Received: from eggs.gnu.org ([2001:4830:134:3::10]:34736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cTB0m-00062X-E8
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cTB0i-0007m1-Cs
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:24:04 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cTB0i-0007lY-4o
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:24:00 -0500
Received: by mail-lf0-x241.google.com with SMTP id q89so13501272lfi.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 09:23:58 -0800 (PST)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-3-git-send-email-clg@kaod.org>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <a4062932-5906-eff0-8931-9da7c1123ddb@gmail.com>
Date: Mon, 16 Jan 2017 18:23:55 +0100
MIME-Version: 1.0
In-Reply-To: <1483979087-32663-3-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/11] aspeed/smc: remove call to
 aspeed_smc_update_cs() in reset function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcin Krzeminski <marcin.krzeminski@nokia.com>

W dniu 09.01.2017 o 17:24, Cédric Le Goater pisze:
> Instead, we can simply set the irq level when unselecting the slave
> devices. This change prepares ground for a subsequent cleanup of the
> aspeed_smc_update_cs() routine which uselessly loops on all slaves to
> update their status.
>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/ssi/aspeed_smc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 8a7217d4df6c..205c0abfae98 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -424,6 +424,7 @@ static void aspeed_smc_reset(DeviceState *d)
>       /* Unselect all slaves */
>       for (i = 0; i < s->num_cs; ++i) {
>           s->regs[s->r_ctrl0 + i] |= CTRL_CE_STOP_ACTIVE;
> +        qemu_set_irq(s->cs_lines[i], true);
Does SMC support only flash chips with CS active LOW?
If yes:
Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
>       }
>   
>       /* setup default segment register values for all */
> @@ -431,8 +432,6 @@ static void aspeed_smc_reset(DeviceState *d)
>           s->regs[R_SEG_ADDR0 + i] =
>               aspeed_smc_segment_to_reg(&s->ctrl->segments[i]);
>       }
> -
> -    aspeed_smc_update_cs(s);
>   }
>   
>   static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
