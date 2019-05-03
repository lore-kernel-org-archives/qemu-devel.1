Received: from eggs.gnu.org ([209.51.188.92]:38764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMc4F-0002Pi-Oc
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMc4E-0003Dc-MS
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:33:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMc4E-0003D2-GE
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:33:50 -0400
Received: by mail-ot1-x341.google.com with SMTP id n15so6028226ota.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190503171347.13747-1-peter.maydell@linaro.org>
	<20190503171347.13747-2-peter.maydell@linaro.org>
In-Reply-To: <20190503171347.13747-2-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 18:33:38 +0100
Message-ID: <CAFEAcA8cG_hd=6+zeYDG5o68Z-62rmXfK4SBLWUz2tVvgPobpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/arm/boot: Avoid placing the initrd
 on top of the kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Mark Rutland <mark.rutland@arm.com>

On Fri, 3 May 2019 at 18:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> We currently put the initrd at the smaller of:
>  * 128MB into RAM
>  * halfway into the RAM
> (with the dtb following it).
>
> However for large kernels this might mean that the kernel
> overlaps the initrd. For some kinds of kernel (self-decompressing
> 32-bit kernels, and ELF images with a BSS section at the end)
> we don't know the exact size, but even there we have a
> minimum size. Put the initrd at least further into RAM than
> that. For image formats that can give us an exact kernel size, this
> will mean that we definitely avoid overlaying kernel and initrd.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/boot.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index a830655e1af..7c978fedde4 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -998,20 +998,6 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
>      if (info->nb_cpus == 0)
>          info->nb_cpus = 1;
>
> -    /*
> -     * We want to put the initrd far enough into RAM that when the
> -     * kernel is uncompressed it will not clobber the initrd. However
> -     * on boards without much RAM we must ensure that we still leave
> -     * enough room for a decent sized initrd, and on boards with large
> -     * amounts of RAM we must avoid the initrd being so far up in RAM
> -     * that it is outside lowmem and inaccessible to the kernel.
> -     * So for boards with less  than 256MB of RAM we put the initrd
> -     * halfway into RAM, and for boards with 256MB of RAM or more we put
> -     * the initrd at 128MB.
> -     */
> -    info->initrd_start = info->loader_start +
> -        MIN(info->ram_size / 2, 128 * 1024 * 1024);
> -
>      /* Assume that raw images are linux kernels, and ELF images are not.  */
>      kernel_size = arm_load_elf(info, &elf_entry, &elf_low_addr,
>                                 &elf_high_addr, elf_machine, as);
> @@ -1056,6 +1042,26 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
>          exit(1);
>      }
>      info->entry = entry;
> +
> +    /*
> +     * We want to put the initrd far enough into RAM that when the
> +     * kernel is uncompressed it will not clobber the initrd. However
> +     * on boards without much RAM we must ensure that we still leave
> +     * enough room for a decent sized initrd, and on boards with large
> +     * amounts of RAM we must avoid the initrd being so far up in RAM
> +     * that it is outside lowmem and inaccessible to the kernel.
> +     * So for boards with less  than 256MB of RAM we put the initrd
> +     * halfway into RAM, and for boards with 256MB of RAM or more we put
> +     * the initrd at 128MB.
> +     * We also refuse to put the initrd somewhere that will definitely
> +     * overlay the kernel we just loaded, though for kernel formats which
> +     * don't tell us their exact size (eg self-decompressing 32-bit kernels)
> +     * we might still make a bad choice here.
> +     */
> +    info->initrd_start = info->loader_start +
> +        MAX(MIN(info->ram_size / 2, 128 * 1024 * 1024), kernel_size);
> +    info->initrd_start = TARGET_PAGE_ALIGN(info->initrd_start);
> +

I belatedly realized that we should probably check here whether
this is off the end of the ram, as otherwise following code
will get an underflow in "info->ram_size - info->initrd_start"
which is unlikely to result in useful behaviour.

thanks
-- PMM
