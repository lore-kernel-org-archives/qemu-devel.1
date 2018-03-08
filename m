Received: from eggs.gnu.org ([2001:4830:134:3::10]:35229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ett8a-0001uQ-O1
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ett8Z-0002bX-Jy
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:51:04 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:33737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ett8Z-0002bA-F2
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:51:03 -0500
Received: by mail-ot0-x22c.google.com with SMTP id y11so5010651otg.0
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 02:51:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520444223-8389-1-git-send-email-linux@roeck-us.net>
References: <1520444223-8389-1-git-send-email-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 10:50:42 +0000
Message-ID: <CAFEAcA8iFYGhzmLm6pyZi6tg=Di1P=vi_Enyw_ia1M34B3t8aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fsl-imx6: Swap Ethernet interrupt defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Jason Wang <jasowang@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Bill Paul <wpaul@windriver.com>

On 7 March 2018 at 17:37, Guenter Roeck <linux@roeck-us.net> wrote:
> The sabrelite machine model used by qemu-system-arm is based on the
> Freescale/NXP i.MX6Q processor. This SoC has an on-board ethernet
> controller which is supported in QEMU using the imx_fec.c module
> (actually called imx.enet for this model.)
>
> The include/hw/arm/fsm-imx6.h file defines the interrupt vectors for the
> imx.enet device like this:
>
>  #define FSL_IMX6_ENET_MAC_1588_IRQ 118
>  #define FSL_IMX6_ENET_MAC_IRQ 119
>
> According to https://www.nxp.com/docs/en/reference-manual/IMX6DQRM.pdf,
> page 225, in Table 3-1. ARM Cortex A9 domain interrupt summary,
> interrupts are as follows.
>
> 150 ENET MAC 0 IRQ
> 151 ENET MAC 0 1588 Timer interrupt
>
> where
>
> 150 - 32 == 118
> 151 - 32 == 119
>
> In other words, the vector definitions in the fsl-imx6.h file are reversed.
>
> This results in lost interrupt warnings when running recent (v4.15+) Linux
> kernels, and the Ethernet interface will fail to probe.
>
> Note that applying this patch will cause problems with older Linux kernels:
> The Ethernet interface will fail to probe with Linux v4.9 and earlier.
> Linux v4.1 and earlier will crash. This is a Linux kernel problem, not a
> qemu problem: the Linux kernel only worked by accident since it requested
> both interrupts.

So do the works-by-accident kernels fail on QEMU because
we don't emulate some bit of the ethernet device ?
Ideally we could fix that so we could boot newer kernels
without breaking the old ones...

thanks
-- PMM
