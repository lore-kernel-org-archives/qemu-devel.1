Received: from eggs.gnu.org ([2001:4830:134:3::10]:38887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euhmK-00085j-Jr
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 11:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euhmJ-00067d-Do
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 11:55:28 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euhmJ-00067N-93
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 11:55:27 -0500
Received: by mail-oi0-x241.google.com with SMTP id a207so9266306oii.10
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 08:55:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520632024-31535-1-git-send-email-linux@roeck-us.net>
References: <1520632024-31535-1-git-send-email-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 10 Mar 2018 16:55:06 +0000
Message-ID: <CAFEAcA8_2GLg83JR4NFd6dgF0C4mgy7PTEiLRj35JisCdEA=yQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] fsl-imx6: Swap Ethernet interrupt
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
Cc: Peter Chubb <peter.chubb@nicta.com.au>, Jason Wang <jasowang@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Bill Paul <wpaul@windriver.com>

On 9 March 2018 at 21:47, Guenter Roeck <linux@roeck-us.net> wrote:
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
> ---
> v2: Generate Ethernet interrupts on both interrupt lines
>
>  hw/net/imx_fec.c          | 7 ++++++-
>  include/hw/arm/fsl-imx6.h | 4 ++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 9506f9b..d3ae7db 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -417,7 +417,12 @@ static void imx_enet_write_bd(IMXENETBufDesc *bd, dma_addr_t addr)
>
>  static void imx_eth_update(IMXFECState *s)
>  {
> -    if (s->regs[ENET_EIR] & s->regs[ENET_EIMR] & ENET_INT_TS_TIMER) {
> +    /*
> +     * Generate ENET_INT_MAC interrrupts on both interrupt lines for
> +     * backward compatibility with Linux kernel versions 4.9 and older.
> +     */
> +    if (s->regs[ENET_EIR] & s->regs[ENET_EIMR] &
> +        (ENET_INT_MAC | ENET_INT_TS_TIMER)) {

So if I'm understanding correctly, this is not correct-to-the-hardware
behaviour, right? Can we have a detailed comment explaining
(a) what the hardware does (b) why we're doing it differently
(c) what we would need to fix elsewhere in QEMU to be able to change
this code to match the hardware?

I think most of that information has come out in this email thread,
but it's easy for that kind of thing to get forgotten six months
or a year down the line when somebody's looking at the code and
the h/w spec and wondering why they don't match up...

thanks
-- PMM
