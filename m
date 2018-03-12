Received: from eggs.gnu.org ([2001:4830:134:3::10]:56099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNk6-0005kg-23
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNk5-00035q-0u
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:43:58 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evNk4-000350-QB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:43:56 -0400
Received: by mail-oi0-x241.google.com with SMTP id j79so12306365oib.12
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:43:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520723090-22130-1-git-send-email-linux@roeck-us.net>
References: <1520723090-22130-1-git-send-email-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 13:43:35 +0000
Message-ID: <CAFEAcA_M51Yv-B78uY9NXBYSD02aXf5As+eXNTcyrNxYqtML=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] fsl-imx6: Swap Ethernet interrupt
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Jason Wang <jasowang@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Bill Paul <wpaul@windriver.com>

On 10 March 2018 at 23:04, Guenter Roeck <linux@roeck-us.net> wrote:
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
> Fixing the interrupts alone causes problems with older Linux kernels:
> The Ethernet interface will fail to probe with Linux v4.9 and earlier.
> Linux v4.1 and earlier will crash due to a bug in Ethernet driver probe
> error handling. This is a Linux kernel problem, not a qemu problem:
> the Linux kernel only worked by accident since it requested both interrupts.
>
> For backward compatibility, generate the Ethernet interrupt on both interrupt
> lines. This was shown to work from all Linux kernel releases starting with
> v3.16.
>
> Link: https://bugs.launchpad.net/qemu/+bug/1753309
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to target-arm.next for 2.12.

Thanks to everybody who helped in identifying what the behaviour here
was and coming up with this useful workaround to avoid breaking
previously-working guests.

-- PMM
