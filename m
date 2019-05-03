Received: from eggs.gnu.org ([209.51.188.92]:38481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYco-0003yz-AG
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYcn-0002Ub-D3
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:53:18 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYcn-0002Tj-8L
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:53:17 -0400
Received: by mail-ot1-x342.google.com with SMTP id g24so5360385otq.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556774049.git.alistair@alistair23.me>
	<PSXP216MB0277BAE3697B1BBFCE662671DD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0277BAE3697B1BBFCE662671DD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:53:05 +0100
Message-ID: <CAFEAcA_UWXDbzSeGUAx58oOzFnp8gA+TUnVC1CHqMishg9p1ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>

On Thu, 2 May 2019 at 06:41, Alistair Francis <alistair@alistair23.me> wrote:
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  MAINTAINERS                     |  6 +++
>  default-configs/arm-softmmu.mak |  1 +
>  hw/arm/Kconfig                  |  3 ++
>  hw/arm/Makefile.objs            |  1 +
>  hw/arm/netduinoplus2.c          | 77 +++++++++++++++++++++++++++++++++
>  5 files changed, 88 insertions(+)
>  create mode 100644 hw/arm/netduinoplus2.c

> +static void netduinoplus2_init(MachineState *machine)
> +{
> +    DeviceState *dev;
> +    ARMV7MResetArgs reset_args;
> +    uint64_t entry;
> +
> +    dev = qdev_create(NULL, TYPE_STM32F405_SOC);
> +    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
> +    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
> +
> +    entry = armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> +                       FLASH_SIZE);
> +
> +    reset_args = (ARMV7MResetArgs) {
> +        .cpu = ARM_CPU(first_cpu),
> +        .reset_pc = entry,
> +        .reset_sp = (SRAM_BASE_ADDRESS + (SRAM_SIZE * 2) / 3),
> +    };
> +    qemu_register_reset(armv7m_reset,
> +                        g_memdup(&reset_args, sizeof(reset_args)));
> +}

I still don't really like having this board interpret -kernel
in a different way to all the other M-profile boards. I'd be
much happier if it just behaved the same way the others do.

thanks
-- PMM
