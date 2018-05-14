Received: from eggs.gnu.org ([2001:4830:134:3::10]:60185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIGg1-00047H-DK
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIGg0-00020C-Ni
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:50:21 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:40178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIGg0-0001zM-51
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:50:20 -0400
Received: by mail-oi0-x244.google.com with SMTP id c203-v6so11297256oib.7
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 09:50:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1519998711-73430-17-git-send-email-mjc@sifive.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-17-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 17:49:58 +0100
Message-ID: <CAFEAcA8Jf0TFey2oRPaGa_Nvne-PpfWcZ4f77JOr-cTJAMpkNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 16/23] RISC-V Spike Machines
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
> RISC-V machines compatble with Spike aka riscv-isa-sim, the RISC-V
> Instruction Set Simulator. The following machines are implemented:
>
> - 'spike_v1.9.1'; HTIF console, config-string, Privileged ISA Version 1.9.1
> - 'spike_v1.10'; HTIF console, device-tree, Privileged ISA Version 1.10
>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Hi; Coverity (CID 1391015) thinks there's a memory leak here:

> +    /* part one of config string - before memory size specified */
> +    const char *config_string_tmpl =
> +        "platform {\n"
> +        "  vendor ucb;\n"
> +        "  arch spike;\n"
> +        "};\n"
> +        "rtc {\n"
> +        "  addr 0x%" PRIx64 "x;\n"
> +        "};\n"
> +        "ram {\n"
> +        "  0 {\n"
> +        "    addr 0x%" PRIx64 "x;\n"
> +        "    size 0x%" PRIx64 "x;\n"
> +        "  };\n"
> +        "};\n"
> +        "core {\n"
> +        "  0" " {\n"
> +        "    " "0 {\n"
> +        "      isa %s;\n"
> +        "      timecmp 0x%" PRIx64 "x;\n"
> +        "      ipi 0x%" PRIx64 "x;\n"
> +        "    };\n"
> +        "  };\n"
> +        "};\n";
> +
> +    /* build config string with supplied memory size */
> +    char *isa = riscv_isa_string(&s->soc.harts[0]);
> +    size_t config_string_size = strlen(config_string_tmpl) + 48;
> +    char *config_string = malloc(config_string_size);

We malloc() config_string here...

> +    snprintf(config_string, config_string_size, config_string_tmpl,
> +        (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIME_BASE,
> +        (uint64_t)memmap[SPIKE_DRAM].base,
> +        (uint64_t)ram_size, isa,
> +        (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIMECMP_BASE,
> +        (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_SIP_BASE);
> +    g_free(isa);
> +    size_t config_string_len = strlen(config_string);
> +
> +    /* copy in the reset vector */
> +    copy_le32_to_phys(memmap[SPIKE_MROM].base, reset_vec, sizeof(reset_vec));
> +
> +    /* copy in the config string */
> +    cpu_physical_memory_write(memmap[SPIKE_MROM].base + sizeof(reset_vec),
> +        config_string, config_string_len);

...and finish using it here, but we never free it.

We also don't check that malloc() succeeded, so we'll crash if it
returns NULL. The recommended fix for this is to use g_malloc()
instead.

thanks
-- PMM
