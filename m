Received: from eggs.gnu.org ([2001:4830:134:3::10]:56061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKBFI-0005GI-Js
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKBF7-0000h0-Rh
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:58:51 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gKBF6-0007ZB-Qo
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:58:45 -0500
Received: by mail-pl1-x643.google.com with SMTP id t6-v6so6978595plo.9
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 15:58:29 -0800 (PST)
Date: Tue, 06 Nov 2018 15:58:27 -0800 (PST)
In-Reply-To: <3988cd7b9d292017537f75c2eed70295a3a84718.1541447021.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-88725c82-3433-4a1b-afdf-7baa657a6be0@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] riscv: spike: Fix memory leak in
 the board init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair23@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>, Peter Maydell <peter.maydell@linaro.org>

On Mon, 05 Nov 2018 11:44:41 PST (-0800), Alistair Francis wrote:
> Coverity caught a malloc() call that was never freed. This patch ensures
> that we free the memory but also updates the allocation to use
> g_strdup_printf() instead of malloc().
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/riscv/spike.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 8a712ed490..268df04c3c 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -316,9 +316,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>  
>      /* build config string with supplied memory size */
>      char *isa = riscv_isa_string(&s->soc.harts[0]);
> -    size_t config_string_size = strlen(config_string_tmpl) + 48;
> -    char *config_string = malloc(config_string_size);
> -    snprintf(config_string, config_string_size, config_string_tmpl,
> +    char *config_string = g_strdup_printf(config_string_tmpl,
>          (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIME_BASE,
>          (uint64_t)memmap[SPIKE_DRAM].base,
>          (uint64_t)ram_size, isa,
> @@ -345,6 +343,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>      /* Core Local Interruptor (timer and IPI) */
>      sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
>          smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
> +
> +    g_free(config_string);
>  }
>  
>  static void spike_v1_09_1_machine_init(MachineClass *mc)

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
