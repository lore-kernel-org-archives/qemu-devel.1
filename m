Received: from eggs.gnu.org ([2001:4830:134:3::10]:32848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfCu-00087d-TP
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfCt-0002WK-PF
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:34:52 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNfCt-0002Sp-4M
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:34:51 -0500
Received: by mail-ot1-x342.google.com with SMTP id s5so21470402oth.7
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 06:34:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d9876015-2126-79fe-415f-ca7427ab3059@gmail.com>
References: <d9876015-2126-79fe-415f-ca7427ab3059@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 14:34:24 +0000
Message-ID: <CAFEAcA84aoWNdu1T90iR0uw7emfF1SRF09FjL+gu12yrdAr2yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Support u-boot noload images for arm as
 used by NetBSD/evbarm GENERIC kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Hudson <nicholas.a.hudson@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 7 November 2018 at 13:19, Nick Hudson <nicholas.a.hudson@gmail.com> wrote:
> noload kernels are loaded with the u-boot image header and as a result
> the header size needs adding to the entry point.  Fake up a hdr so the
> kernel image is loaded at the right address and the entry point is
> adjusted appropriately
>
> Signed-off-by: Nick Hudson <skrll@netbsd.org>

Hi; thanks for this patch.

> ---
>  hw/arm/boot.c         |  8 +++++---
>  hw/core/loader.c      | 12 +++++++++---
>  hw/core/uboot_image.h |  1 +
>  3 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 586baa9b64..450267566a 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -30,8 +30,9 @@
>   * Documentation/arm/Booting and Documentation/arm64/booting.txt
>   * They have different preferred image load offsets from system RAM base.
>   */
> -#define KERNEL_ARGS_ADDR 0x100
> -#define KERNEL_LOAD_ADDR 0x00010000
> +#define KERNEL_ARGS_ADDR   0x100
> +#define KERNEL_NOLOAD_ADDR 0x00000000
> +#define KERNEL_LOAD_ADDR   0x00010000
>  #define KERNEL64_LOAD_ADDR 0x00080000
>
>  #define ARM64_TEXT_OFFSET_OFFSET    8
> @@ -1078,7 +1079,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info
> *info)
>      }
>      entry = elf_entry;
>      if (kernel_size < 0) {
> -        kernel_size = load_uimage_as(info->kernel_filename, &entry, NULL,
> +        uint64_t loadaddr = info->loader_start + KERNEL_NOLOAD_ADDR;
> +        kernel_size = load_uimage_as(info->kernel_filename, &entry,
> &loadaddr,
>                                       &is_linux, NULL, NULL, as);

I don't really understand this change. The API for load_uimage_as()
says that the loadaddr argument is an output, not an input, and that
it is ignored if it is NULL. If we're changing the API here then
we need to (a) document that change and (b) check all the callers
can handle it. It would be better if we can avoid having to do that.

>      }
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index aa0b3fc867..952562c2da 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -638,13 +638,19 @@ static int load_uboot_image(const char *filename,
> hwaddr *ep, hwaddr *loadaddr,
>          goto out;
>
>      if (hdr->ih_type != image_type) {
> -        fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type,
> -                image_type);
> -        goto out;
> +        if (image_type != IH_TYPE_KERNEL && hdr->ih_type !=
> IH_TYPE_KERNEL_NOLOAD) {
> +            fprintf(stderr, "Wrong image type %d, expected %d\n",
> hdr->ih_type,
> +                    image_type);
> +            goto out;
> +        }
>      }
>
>      /* TODO: Implement other image types.  */
>      switch (hdr->ih_type) {
> +    case IH_TYPE_KERNEL_NOLOAD:
> +        hdr->ih_load = *loadaddr + sizeof(*hdr);

This will segfault if the user passed in NULL for loadaddr,
as they are allowed to do by the API.

> +        hdr->ih_ep += hdr->ih_load;
> +

Cases which fall through need a specific
     /* fall through */

comment. This tells human readers and static analysis tools that
it was intentional.

>      case IH_TYPE_KERNEL:
>          address = hdr->ih_load;
>          if (translate_fn) {
> diff --git a/hw/core/uboot_image.h b/hw/core/uboot_image.h
> index 34c11a70a6..608022de6e 100644
> --- a/hw/core/uboot_image.h
> +++ b/hw/core/uboot_image.h
> @@ -124,6 +124,7 @@
>  #define IH_TYPE_SCRIPT        6    /* Script file            */
>  #define IH_TYPE_FILESYSTEM    7    /* Filesystem Image (any type)    */
>  #define IH_TYPE_FLATDT        8    /* Binary Flat Device Tree Blob    */
> +#define IH_TYPE_KERNEL_NOLOAD  14    /* OS Kernel Image (noload)    */

thanks
-- PMM
