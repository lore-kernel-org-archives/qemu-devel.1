Received: from eggs.gnu.org ([2001:4830:134:3::10]:39553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC4Bu-00025X-PN
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC4Bt-0002US-Kh
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:17:38 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC4Bt-0002UE-FQ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:17:37 -0400
Received: by mail-oi0-x242.google.com with SMTP id v2-v6so1712806oif.3
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 07:17:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1519998711-73430-19-git-send-email-mjc@sifive.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-19-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 15:17:16 +0100
Message-ID: <CAFEAcA9PQU3EFi2OwZ9=tzj3-59yzGuCrWomUKqCEcuqYP+Z9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 18/23] RISC-V VirtIO Machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 2 March 2018 at 13:51, Michael Clark <mjc@sifive.com> wrote:
> RISC-V machine with device-tree, 16550a UART and VirtIO MMIO.
> The following machine is implemented:
>
> - 'virt'; CLINT, PLIC, 16550A UART, VirtIO MMIO, device-tree
>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Hi; Coverity spots (CID 1390606) that in this function you
leak a little bit of memory:

> +static void riscv_virt_board_init(MachineState *machine)
> +{

> +    /* create PLIC hart topology configuration string */
> +    plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_cpus;
> +    plic_hart_config = g_malloc0(plic_hart_config_len);

Here we allocate memory into plic_hart_config...

> +    for (i = 0; i < smp_cpus; i++) {
> +        if (i != 0) {
> +            strncat(plic_hart_config, ",", plic_hart_config_len);
> +        }
> +        strncat(plic_hart_config, VIRT_PLIC_HART_CONFIG, plic_hart_config_len);
> +        plic_hart_config_len -= (strlen(VIRT_PLIC_HART_CONFIG) + 1);
> +    }
> +
> +    /* MMIO */
> +    s->plic = sifive_plic_create(memmap[VIRT_PLIC].base,
> +        plic_hart_config,

(and this function doesn't take ownership of the string)

> +        VIRT_PLIC_NUM_SOURCES,
> +        VIRT_PLIC_NUM_PRIORITIES,
> +        VIRT_PLIC_PRIORITY_BASE,
> +        VIRT_PLIC_PENDING_BASE,
> +        VIRT_PLIC_ENABLE_BASE,
> +        VIRT_PLIC_ENABLE_STRIDE,
> +        VIRT_PLIC_CONTEXT_BASE,
> +        VIRT_PLIC_CONTEXT_STRIDE,
> +        memmap[VIRT_PLIC].size);
> +    sifive_clint_create(memmap[VIRT_CLINT].base,
> +        memmap[VIRT_CLINT].size, smp_cpus,
> +        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
> +    sifive_test_create(memmap[VIRT_TEST].base);
> +
> +    for (i = 0; i < VIRTIO_COUNT; i++) {
> +        sysbus_create_simple("virtio-mmio",
> +            memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
> +            SIFIVE_PLIC(s->plic)->irqs[VIRTIO_IRQ + i]);
> +    }
> +
> +    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> +        0, SIFIVE_PLIC(s->plic)->irqs[UART0_IRQ], 399193,
> +        serial_hds[0], DEVICE_LITTLE_ENDIAN);

...but we don't free the memory before leaving.

> +}

Not a big deal since this function is only run once, but adding
in the necessary g_free(plic_hart_config) will placate Coverity.

thanks
-- PMM
