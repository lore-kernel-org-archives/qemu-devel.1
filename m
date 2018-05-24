Received: from eggs.gnu.org ([2001:4830:134:3::10]:35654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLrPn-0000fT-2W
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLrPl-0001s1-QR
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:40:27 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLrPl-0001rh-KO
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:40:25 -0400
Received: by mail-ot0-x243.google.com with SMTP id 77-v6so2212434otd.4
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 07:40:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527161340-3200-2-git-send-email-suhang16@mails.ucas.ac.cn>
References: <1527161340-3200-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1527161340-3200-2-git-send-email-suhang16@mails.ucas.ac.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 15:40:04 +0100
Message-ID: <CAFEAcA9Y05BF6iwRuEWQK6G12jxjeWT5F4cxTMTU2bb9MWtS-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 1/2] Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, jim@groklearning.com, Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>

On 24 May 2018 at 12:28, Su Hang <suhang16@mails.ucas.ac.cn> wrote:
> This patch adds Intel Hexadecimal Object File format support to
> the loader.  The file format specification is available here:
> http://www.piclist.com/techref/fileext/hex/intel.htm
>
> The file format is mainly intended for embedded systems
> and microcontrollers, such as Micro:bit Arduino, ARM, STM32, etc.

Could we have some more rationale here, please? For instance,
we could mention who ships binaries in this format, what other
boot loaders handle this, and so on. The idea is to explain
why it's worth our having this code, rather than just having
users convert their hex files to a format we already handle
(ie why there is a significant body of users with hex format
images they want to load).

> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 9496f331a8fa..17fe1a8c287b 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -1038,12 +1038,17 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
>          kernel_size = load_uimage_as(info->kernel_filename, &entry, NULL,
>                                       &is_linux, NULL, NULL, as);
>      }
> +    if (kernel_size < 0) {
> +        /* 32-bit ARM Intel HEX file */
> +        entry = 0;
> +        kernel_size = load_targphys_hex_as(info->kernel_filename, &entry, as);
> +    }
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
>          kernel_size = load_aarch64_image(info->kernel_filename,
>                                           info->loader_start, &entry, as);
>          is_linux = 1;
>      } else if (kernel_size < 0) {
> -        /* 32-bit ARM */
> +        /* 32-bit ARM binary file */
>          entry = info->loader_start + KERNEL_LOAD_ADDR;
>          kernel_size = load_image_targphys_as(info->kernel_filename, entry,
>                                               info->ram_size - KERNEL_LOAD_ADDR,

I don't think it makes sense to add support for this format here.
Who is using hex files to provide A-class Linux kernels?

(Note that hw/arm/boot.c does *not* handle -kernel for M-class cores.)

There might be an argument for wiring up hex file support
in the "generic loader" hw/misc/generic-loader.c
(documentation in docs/generic-loader.txt).

It looks like your implementation calls rom_add_blob_fixed_as()
as it goes along to add chunks of data to guest memory, but
it doesn't do anything to undo that if it detects an error
in the input halfway through and returns a failure code.
That matters if you want to put it in a chain of "try this
format? if that didn't work, try this other format; last
resort, load as binary" calls like you have here.

It's probably worth splitting the "add load_targphys_hex_as()"
patch from the one that wires it up for a specific loader.

thanks
-- PMM
