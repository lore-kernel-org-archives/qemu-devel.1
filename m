Received: from eggs.gnu.org ([2001:4830:134:3::10]:36662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnO3j-0006lE-Of
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 07:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnO3i-00040C-T4
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 07:22:39 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnO3i-0003zo-MF
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 07:22:38 -0400
Received: by mail-wm0-x232.google.com with SMTP id t189so37225779wmt.1
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 04:22:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489079383-11162-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1489079383-11162-1-git-send-email-ard.biesheuvel@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Mar 2017 12:22:17 +0100
Message-ID: <CAFEAcA9UVcoCrAh9WcNCp-F4RPkGtkOrEHJ0LDK4q62+7MwMEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: take Linux/arm64 TEXT_OFFSET
 header field into account
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 March 2017 at 18:09, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> The arm64 boot protocol stipulates that the kernel must be loaded
> TEXT_OFFSET bytes beyond a 2 MB aligned base address, where TEXT_OFFSET
> could be any 4 KB multiple between 0 and 2 MB, and whose value can be
> found in the header of the Image file.
>
> So after attempts to load the kernel image as an ELF file or as a
> U-Boot image (both of which have their own way of specifying the load
> offset) have failed, try to determine the TEXT_OFFSET from the image
> before proceeding with loading it as a gzipped or raw image.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  hw/arm/boot.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index ff621e4b6a4b..0824f74c697f 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -31,6 +31,11 @@
>  #define KERNEL_LOAD_ADDR 0x00010000
>  #define KERNEL64_LOAD_ADDR 0x00080000
>
> +#define ARM64_IMAGE_HEADER_SIZE     64
> +#define ARM64_TEXT_OFFSET_OFFSET    8
> +#define ARM64_IMAGE_SIZE_OFFSET     16
> +#define ARM64_MAGIC_OFFSET          56
> +
>  typedef enum {
>      FIXUP_NONE = 0,     /* do nothing */
>      FIXUP_TERMINATOR,   /* end of insns */
> @@ -768,6 +773,51 @@ static uint64_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
>      return ret;
>  }
>
> +static void aarch64_get_text_offset(struct arm_boot_info *info,
> +                                    hwaddr *text_offset)
> +{

Hmm, this isn't quite what I had in mind when we talked about this.
I think what we want is a function like
static uint64_t load_aarch64_image(const char *filename, hwaddr *entry,
                                   other stuff you need)
which loads the image if it's the right format and writes
the entry point into *entry, and returns a negative value
if the image isn't the right format.

ie whose API is basically parallel to the load_uimage(),
load_image_gzipped(), etc functions. You can make it handle
both gzipped and non-gzipped images (and then drop the code
we currently have to call load_image_gzipped()).

PS: you'll want to use g_file_get_contents() for the load
in the non-compressed image case, and as the patchew
robot points out our coding style preferences mandate braces.

thanks
-- PMM
