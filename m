Received: from eggs.gnu.org ([2001:4830:134:3::10]:33657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPBqz-00052C-Qn
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPBqy-0007Kg-MZ
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:29:29 -0500
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:34090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPBqy-0007KU-Fx
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:29:28 -0500
Received: by mail-vk0-x236.google.com with SMTP id x186so303490935vkd.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 09:29:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9b13837a216eb358896a11709e7b4befdd5083db.1481121503.git.julian@codesourcery.com>
References: <cover.1481121503.git.julian@codesourcery.com>
	<9b13837a216eb358896a11709e7b4befdd5083db.1481121503.git.julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 17:29:07 +0000
Message-ID: <CAFEAcA_8_muO+-yH4QzdDBdhCLQYAk4c-OmNVgZtXnQ4H-K9kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 2/6] Infer endianness from SCTLR reset
 value.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 December 2016 at 14:48, Julian Brown <julian@codesourcery.com> wrote:
> This patch uses the reset value of the SCTLR register (e.g. as modified
> by the "cfgend" parameter introduced by the previous patch) to set the
> endianness used by QEMU when invoked with a null kernel, e.g. from GDB:
>
>   (gdb) target remote | qemu-arm-system [options] -cpu=cortex-a15,cfgend=yes \
>           -kernel /dev/null
>   (gdb) load
>   (gdb) [...]
>
> In this scenario, the usual method of probing the kernel binary for the
> correct endianness to use will not work.
>
> Signed-off-by: Julian Brown <julian@codesourcery.com>
> ---
>  hw/arm/boot.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 942416d..68a6574 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -894,7 +894,21 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
>          entry = info->loader_start + kernel_load_offset;
>          kernel_size = load_image_targphys(info->kernel_filename, entry,
>                                            info->ram_size - kernel_load_offset);
> -        is_linux = 1;
> +        if (kernel_size > 0) {
> +            is_linux = 1;
> +        } else {
> +            /* We've been launched with a kernel of /dev/null or similar.
> +             * Infer endianness from the reset value of the SCTLR for this
> +             * CPU/board.  (This can be altered using the cfgend parameter.)
> +             */
> +            if (!arm_feature(&cpu->env, ARM_FEATURE_V7) &&
> +                (cpu->reset_sctlr & SCTLR_B) != 0)
> +                info->endianness = ARM_ENDIANNESS_BE32;
> +            else if ((cpu->reset_sctlr & SCTLR_EE) != 0)
> +                info->endianness = ARM_ENDIANNESS_BE8;
> +            else
> +                info->endianness = ARM_ENDIANNESS_LE;
> +        }
>      }
>      if (kernel_size < 0) {
>          fprintf(stderr, "qemu: could not load kernel '%s'\n",
> --
> 2.8.1

This is pretty obscure magic behaviour -- feed -kernel a zero
length file and get magic register setting behaviour ?
I think passing an empty file ought to either
 (a) just be an error, or
 (b) behave like passing a 1 byte file, which is what we
     do currently (ie treat it like a raw Linux kernel image)

If you're starting QEMU from GDB in system mode and not giving
it an image file, then I think the expectation would be that
you get the CPU as it would come out of reset in hardware.

Also, this looks a bit odd -- the purpose of the info->endianness
flag is to mess with the SCTLR values, but here we're setting
info->endianness based on the SCTLR values, which seems
circular. Why aren't the SCTLR values just right to start with?

thanks
-- PMM
