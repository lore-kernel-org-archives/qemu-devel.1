Received: from eggs.gnu.org ([2001:4830:134:3::10]:35943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gNDqk-0002LJ-3c
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gNDqj-0001Pp-9A
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:22:10 -0500
From: Nick Hudson <nicholas.a.hudson@gmail.com>
References: <d9876015-2126-79fe-415f-ca7427ab3059@gmail.com>
Message-ID: <293e1825-5f9d-1e40-85d7-cca1fb16ba94@gmail.com>
Date: Thu, 15 Nov 2018 09:22:01 +0000
MIME-Version: 1.0
In-Reply-To: <d9876015-2126-79fe-415f-ca7427ab3059@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
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
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

ping

On 07/11/2018 13:19, Nick Hudson wrote:
> noload kernels are loaded with the u-boot image header and as a result
> the header size needs adding to the entry point.  Fake up a hdr so the
> kernel image is loaded at the right address and the entry point is
> adjusted appropriately
>
> Signed-off-by: Nick Hudson <skrll@netbsd.org>
> ---
>  hw/arm/boot.c         |  8 +++++---
>  hw/core/loader.c      | 12 +++++++++---
>  hw/core/uboot_image.h |  1 +
>  3 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 586baa9b64..450267566a 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -30,8 +30,9 @@
>   * Documentation/arm/Booting and Documentation/arm64/booting.txt
>   * They have different preferred image load offsets from system RAM 
> base.
>   */
> -#define KERNEL_ARGS_ADDR 0x100
> -#define KERNEL_LOAD_ADDR 0x00010000
> +#define KERNEL_ARGS_ADDR   0x100
> +#define KERNEL_NOLOAD_ADDR 0x00000000
> +#define KERNEL_LOAD_ADDR   0x00010000
>  #define KERNEL64_LOAD_ADDR 0x00080000
>
>  #define ARM64_TEXT_OFFSET_OFFSET    8
> @@ -1078,7 +1079,8 @@ void arm_load_kernel(ARMCPU *cpu, struct 
> arm_boot_info *info)
>      }
>      entry = elf_entry;
>      if (kernel_size < 0) {
> -        kernel_size = load_uimage_as(info->kernel_filename, &entry, 
> NULL,
> +        uint64_t loadaddr = info->loader_start + KERNEL_NOLOAD_ADDR;
> +        kernel_size = load_uimage_as(info->kernel_filename, &entry, 
> &loadaddr,
>                                       &is_linux, NULL, NULL, as);
>      }
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 
> 0) {
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index aa0b3fc867..952562c2da 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -638,13 +638,19 @@ static int load_uboot_image(const char 
> *filename, hwaddr *ep, hwaddr *loadaddr,
>          goto out;
>
>      if (hdr->ih_type != image_type) {
> -        fprintf(stderr, "Wrong image type %d, expected %d\n", 
> hdr->ih_type,
> -                image_type);
> -        goto out;
> +        if (image_type != IH_TYPE_KERNEL && hdr->ih_type != 
> IH_TYPE_KERNEL_NOLOAD) {
> +            fprintf(stderr, "Wrong image type %d, expected %d\n", 
> hdr->ih_type,
> +                    image_type);
> +            goto out;
> +        }
>      }
>
>      /* TODO: Implement other image types.  */
>      switch (hdr->ih_type) {
> +    case IH_TYPE_KERNEL_NOLOAD:
> +        hdr->ih_load = *loadaddr + sizeof(*hdr);
> +        hdr->ih_ep += hdr->ih_load;
> +
>      case IH_TYPE_KERNEL:
>          address = hdr->ih_load;
>          if (translate_fn) {
> diff --git a/hw/core/uboot_image.h b/hw/core/uboot_image.h
> index 34c11a70a6..608022de6e 100644
> --- a/hw/core/uboot_image.h
> +++ b/hw/core/uboot_image.h
> @@ -124,6 +124,7 @@
>  #define IH_TYPE_SCRIPT        6    /* Script file            */
>  #define IH_TYPE_FILESYSTEM    7    /* Filesystem Image (any type)    */
>  #define IH_TYPE_FLATDT        8    /* Binary Flat Device Tree Blob    */
> +#define IH_TYPE_KERNEL_NOLOAD  14    /* OS Kernel Image (noload)    */
>
>  /*
>   * Compression Types
