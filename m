Received: from eggs.gnu.org ([2001:4830:134:3::10]:41047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRaqH-0008DE-Cf
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRaqG-0003OY-Gz
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:43:45 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRaqG-0003OA-CK
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:43:44 -0500
Received: by mail-ot1-x341.google.com with SMTP id u16so19654089otk.8
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 02:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20181126191454.9455-1-ricardo.perez_blanco@nokia.com>
In-Reply-To: <20181126191454.9455-1-ricardo.perez_blanco@nokia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 10:43:31 +0000
Message-ID: <CAFEAcA9vDyVhj06oKDf=eFn_AkQk4MNRmeUf86OH3xJFaKNEqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] [PATCH] Allow AArch64 processors to boot
 from a kernel placed over 4GB.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ricardo.perez_blanco@nokia.com
Cc: ricardoperezblanco@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 26 Nov 2018 at 19:15, Perez Blanco, Ricardo (Nokia -
BE/Antwerp) <ricardo.perez_blanco@nokia.com> wrote:
>
> Some machine based on AArch64 can have its main memory over 4GBs. With
> the current path, these machines can support "-kernel" in qemu
>
> Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>

Hi; I think it would be worth noting in the commit message that
this doesn't affect any machines QEMU currently emulates.

> ---
>  hw/arm/boot.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 586baa9b64..183c5860bd 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -64,7 +64,9 @@ typedef enum {
>      FIXUP_BOARDID,      /* overwrite with board ID number */
>      FIXUP_BOARD_SETUP,  /* overwrite with board specific setup code address */
>      FIXUP_ARGPTR,       /* overwrite with pointer to kernel args */
> +    FIXUP_ARGPTR_HIGHER_32BITS,       /* overwrite with pointer to kernel args (higher 32 bits) */
>      FIXUP_ENTRYPOINT,   /* overwrite with kernel entry point */
> +    FIXUP_ENTRYPOINT_HIGHER_32BITS,   /* overwrite with kernel entry point (higher 32 bits) */

I recommend naming these FIXUP_ARGPTR_HI and FIXUP_ENTRYPOINT_HI.
As a second followup patch we can then rename FIXUP_ARGPTR and
FIXUP_ENTRYPOINT to FIXUP_ARGPTR_LO and FIXUP_ENTRYPOINT_LO.

>      FIXUP_GIC_CPU_IF,   /* overwrite with GIC CPU interface address */
>      FIXUP_BOOTREG,      /* overwrite with boot register address */
>      FIXUP_DSB,          /* overwrite with correct DSB insn for cpu */
> @@ -84,9 +86,9 @@ static const ARMInsnFixup bootloader_aarch64[] = {
>      { 0x58000084 }, /* ldr x4, entry ; Load the lower 32-bits of kernel entry */
>      { 0xd61f0080 }, /* br x4      ; Jump to the kernel entry point */
>      { 0, FIXUP_ARGPTR }, /* arg: .word @DTB Lower 32-bits */
> -    { 0 }, /* .word @DTB Higher 32-bits */
> +    { 0, FIXUP_ARGPTR_HIGHER_32BITS}, /* .word @DTB Higher 32-bits */
>      { 0, FIXUP_ENTRYPOINT }, /* entry: .word @Kernel Entry Lower 32-bits */
> -    { 0 }, /* .word @Kernel Entry Higher 32-bits */
> +    { 0, FIXUP_ENTRYPOINT_HIGHER_32BITS }, /* .word @Kernel Entry Higher 32-bits */
>      { 0, FIXUP_TERMINATOR }
>  };
>
> @@ -175,7 +177,9 @@ static void write_bootloader(const char *name, hwaddr addr,
>          case FIXUP_BOARDID:
>          case FIXUP_BOARD_SETUP:
>          case FIXUP_ARGPTR:
> +        case FIXUP_ARGPTR_HIGHER_32BITS:
>          case FIXUP_ENTRYPOINT:
> +        case FIXUP_ENTRYPOINT_HIGHER_32BITS:
>          case FIXUP_GIC_CPU_IF:
>          case FIXUP_BOOTREG:
>          case FIXUP_DSB:
> @@ -939,7 +943,6 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
>              }
>          }
>      }
> -
>      *entry = mem_base + kernel_load_offset;
>      rom_add_blob_fixed_as(filename, buffer, size, *entry, as);
>

Stray whitespace change.

> @@ -1153,8 +1156,10 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
>              info->dtb_start = QEMU_ALIGN_UP(info->initrd_start + initrd_size,
>                                             align);
>              fixupcontext[FIXUP_ARGPTR] = info->dtb_start;
> +            fixupcontext[FIXUP_ARGPTR_HIGHER_32BITS] = info->dtb_start >> 32;
>          } else {
>              fixupcontext[FIXUP_ARGPTR] = info->loader_start + KERNEL_ARGS_ADDR;
> +            fixupcontext[FIXUP_ARGPTR_HIGHER_32BITS] = (info->loader_start + KERNEL_ARGS_ADDR) >> 32;
>              if (info->ram_size >= (1ULL << 32)) {
>                  error_report("RAM size must be less than 4GB to boot"
>                               " Linux kernel using ATAGS (try passing a device tree"
> @@ -1163,6 +1168,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
>              }
>          }
>          fixupcontext[FIXUP_ENTRYPOINT] = entry;
> +        fixupcontext[FIXUP_ENTRYPOINT_HIGHER_32BITS] = entry >> 32;
>
>          write_bootloader("bootloader", info->loader_start,
>                           primary_loader, fixupcontext, as);
> --

Otherwise the patch looks good.

thanks
-- PMM
