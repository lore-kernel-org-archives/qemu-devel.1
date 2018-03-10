Received: from eggs.gnu.org ([2001:4830:134:3::10]:37949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulBd-0005Qn-Ej
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulBa-000777-AQ
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:33:49 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:51246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulBa-00076R-3u
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:33:46 -0500
Received: by mail-wm0-x244.google.com with SMTP id h21so9643571wmd.1
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 12:33:46 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
	<1520568765-58189-2-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1f4348ae-25cc-83f2-3005-b2bd64dc0924@amsat.org>
Date: Sat, 10 Mar 2018 21:33:43 +0100
MIME-Version: 1.0
In-Reply-To: <1520568765-58189-2-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/23] RISC-V: Make virt create_fdt
 interface consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 03/09/2018 05:12 AM, Michael Clark wrote:
> create_fdt sets the fdt variable on RISCVVirtState and this is
> used to access the fdt. This reverts a change introduced in
> https://github.com/riscv/riscv-qemu/pull/109 which introduced
> a redundant return value, overlooking the RISCVVirtState
> structure member that made create_fdt inconsistent with the
> other RISC-V machines. The other alternative is to change
> the other boards to return the fdt. Note: the RISCVVirtState
> also contains fdt_size.
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/riscv/virt.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index e2c214e..37968d2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -108,7 +108,7 @@ static hwaddr load_initrd(const char *filename, uint64_t mem_size,
>      return *start + size;
>  }
>  
> -static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
> +static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      uint64_t mem_size, const char *cmdline)
>  {
>      void *fdt;
> @@ -264,8 +264,6 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
>      qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      g_free(nodename);
> -
> -    return fdt;
>  }
>  
>  static void riscv_virt_board_init(MachineState *machine)
> @@ -279,7 +277,6 @@ static void riscv_virt_board_init(MachineState *machine)
>      char *plic_hart_config;
>      size_t plic_hart_config_len;
>      int i;
> -    void *fdt;
>  
>      /* Initialize SOC */
>      object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
> @@ -299,7 +296,7 @@ static void riscv_virt_board_init(MachineState *machine)
>          main_mem);
>  
>      /* create device tree */
> -    fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
> +    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>  
>      /* boot rom */
>      memory_region_init_ram(boot_rom, NULL, "riscv_virt_board.bootrom",
> @@ -314,9 +311,9 @@ static void riscv_virt_board_init(MachineState *machine)
>              hwaddr end = load_initrd(machine->initrd_filename,
>                                       machine->ram_size, kernel_entry,
>                                       &start);
> -            qemu_fdt_setprop_cell(fdt, "/chosen",
> -                                  "linux,initrd-start", start);
> -            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
> +            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-start",
> +                                  start);
> +            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
>                                    end);
>          }
>      }
> 
