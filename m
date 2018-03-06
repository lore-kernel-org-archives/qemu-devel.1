Received: from eggs.gnu.org ([2001:4830:134:3::10]:36227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLZ3-0007UL-A9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLYx-0006sQ-Jj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:00:09 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:56244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLYx-0006sD-BK
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:00:03 -0500
Received: by mail-wm0-x243.google.com with SMTP id q83so1262653wme.5
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 15:00:03 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
	<1520369037-37977-6-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cbb078ea-6339-cf49-1c7f-d61b39b14f64@amsat.org>
Date: Tue, 6 Mar 2018 20:00:00 -0300
MIME-Version: 1.0
In-Reply-To: <1520369037-37977-6-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 05/22] RISC-V: Remove redundant
 identity_translate from
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches load_elf <patches@groups.riscv.org>

On 03/06/2018 05:43 PM, Michael Clark wrote:
> When load_elf is called with NULL as an argument to the
> address translate callback, it does an identity translation.
> This commit removes the redundant identity_translate callback.
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/riscv/sifive_e.c | 7 +------
>  hw/riscv/sifive_u.c | 7 +------
>  hw/riscv/spike.c    | 7 +------
>  hw/riscv/virt.c     | 7 +------
>  4 files changed, 4 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 19eca36..09c9d49 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -82,16 +82,11 @@ static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t len)
>      }
>  }
>  
> -static uint64_t identity_translate(void *opaque, uint64_t addr)
> -{
> -    return addr;
> -}
> -
>  static uint64_t load_kernel(const char *kernel_filename)
>  {
>      uint64_t kernel_entry, kernel_high;
>  
> -    if (load_elf(kernel_filename, identity_translate, NULL,
> +    if (load_elf(kernel_filename, NULL, NULL,
>                   &kernel_entry, NULL, &kernel_high,
>                   0, ELF_MACHINE, 1, 0) < 0) {
>          error_report("qemu: could not load kernel '%s'", kernel_filename);
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index f3f7615..6116c38 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -68,16 +68,11 @@ static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t len)
>      }
>  }
>  
> -static uint64_t identity_translate(void *opaque, uint64_t addr)
> -{
> -    return addr;
> -}
> -
>  static uint64_t load_kernel(const char *kernel_filename)
>  {
>      uint64_t kernel_entry, kernel_high;
>  
> -    if (load_elf(kernel_filename, identity_translate, NULL,
> +    if (load_elf(kernel_filename, NULL, NULL,
>                   &kernel_entry, NULL, &kernel_high,
>                   0, ELF_MACHINE, 1, 0) < 0) {
>          error_report("qemu: could not load kernel '%s'", kernel_filename);
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 4c233ec..7710333 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -59,16 +59,11 @@ static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t len)
>      }
>  }
>  
> -static uint64_t identity_translate(void *opaque, uint64_t addr)
> -{
> -    return addr;
> -}
> -
>  static uint64_t load_kernel(const char *kernel_filename)
>  {
>      uint64_t kernel_entry, kernel_high;
>  
> -    if (load_elf_ram_sym(kernel_filename, identity_translate, NULL,
> +    if (load_elf_ram_sym(kernel_filename, NULL, NULL,
>              &kernel_entry, NULL, &kernel_high, 0, ELF_MACHINE, 1, 0,
>              NULL, true, htif_symbol_callback) < 0) {
>          error_report("qemu: could not load kernel '%s'", kernel_filename);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 0d101fc..f8c19b4 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -62,16 +62,11 @@ static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t len)
>      }
>  }
>  
> -static uint64_t identity_translate(void *opaque, uint64_t addr)
> -{
> -    return addr;
> -}
> -
>  static uint64_t load_kernel(const char *kernel_filename)
>  {
>      uint64_t kernel_entry, kernel_high;
>  
> -    if (load_elf(kernel_filename, identity_translate, NULL,
> +    if (load_elf(kernel_filename, NULL, NULL,
>                   &kernel_entry, NULL, &kernel_high,
>                   0, ELF_MACHINE, 1, 0) < 0) {
>          error_report("qemu: could not load kernel '%s'", kernel_filename);
> 
