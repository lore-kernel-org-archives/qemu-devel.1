Received: from eggs.gnu.org ([2001:4830:134:3::10]:46201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daXRC-0006xE-Jz
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daXR9-0007IP-Es
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:18:02 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daXR9-0007IG-9E
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:17:59 -0400
Received: by mail-qt0-x241.google.com with SMTP id c15so3349253qta.3
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 18:17:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170726235614.14687-1-aurelien@aurel32.net>
	<20170726235614.14687-2-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9b508f8d-21dd-1372-6aaa-d72a0d27ba45@amsat.org>
Date: Wed, 26 Jul 2017 22:17:55 -0300
MIME-Version: 1.0
In-Reply-To: <20170726235614.14687-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 1/2] hw/mips: load_elf_strerror to
 report kernel loading failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 07/26/2017 08:56 PM, Aurelien Jarno wrote:
> Emulated MIPS boards bail out with a simple "could not load kernel" when
> a kernel could not be load, without specifying the underlying reason.
> Fix that by calling load_elf_strerror.
> 
> At the same time use error_report to report the error instead of
> fprintf.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Thank you Aurelien :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/mips/mips_fulong2e.c | 15 +++++++++------
>   hw/mips/mips_malta.c    | 14 ++++++++------
>   hw/mips/mips_mipssim.c  |  5 +++--
>   hw/mips/mips_r4k.c      |  6 ++++--
>   4 files changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 3f3cb32651..3532399a13 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -110,16 +110,19 @@ static int64_t load_kernel (CPUMIPSState *env)
>   {
>       int64_t kernel_entry, kernel_low, kernel_high;
>       int index = 0;
> -    long initrd_size;
> +    long kernel_size, initrd_size;
>       ram_addr_t initrd_offset;
>       uint32_t *prom_buf;
>       long prom_size;
>   
> -    if (load_elf(loaderparams.kernel_filename, cpu_mips_kseg0_to_phys, NULL,
> -                 (uint64_t *)&kernel_entry, (uint64_t *)&kernel_low,
> -                 (uint64_t *)&kernel_high, 0, EM_MIPS, 1, 0) < 0) {
> -        fprintf(stderr, "qemu: could not load kernel '%s'\n",
> -                loaderparams.kernel_filename);
> +    kernel_size = load_elf(loaderparams.kernel_filename, cpu_mips_kseg0_to_phys,
> +                           NULL, (uint64_t *)&kernel_entry,
> +                           (uint64_t *)&kernel_low, (uint64_t *)&kernel_high,
> +                           0, EM_MIPS, 1, 0);
> +    if (kernel_size < 0) {
> +        error_report("qemu: could not load kernel '%s': %s",
> +                     loaderparams.kernel_filename,
> +                     load_elf_strerror(kernel_size));
>           exit(1);
>       }
>   
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 3487d16f61..8ecd544baa 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -794,7 +794,7 @@ static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t* prom_buf, int index,
>   static int64_t load_kernel (void)
>   {
>       int64_t kernel_entry, kernel_high;
> -    long initrd_size;
> +    long kernel_size, initrd_size;
>       ram_addr_t initrd_offset;
>       int big_endian;
>       uint32_t *prom_buf;
> @@ -808,11 +808,13 @@ static int64_t load_kernel (void)
>       big_endian = 0;
>   #endif
>   
> -    if (load_elf(loaderparams.kernel_filename, cpu_mips_kseg0_to_phys, NULL,
> -                 (uint64_t *)&kernel_entry, NULL, (uint64_t *)&kernel_high,
> -                 big_endian, EM_MIPS, 1, 0) < 0) {
> -        fprintf(stderr, "qemu: could not load kernel '%s'\n",
> -                loaderparams.kernel_filename);
> +    kernel_size = load_elf(loaderparams.kernel_filename, cpu_mips_kseg0_to_phys,
> +                           NULL, (uint64_t *)&kernel_entry, NULL,
> +                           (uint64_t *)&kernel_high, big_endian, EM_MIPS, 1, 0);
> +    if (kernel_size < 0) {
> +        error_report("qemu: could not load kernel '%s': %s",
> +                     loaderparams.kernel_filename,
> +                     load_elf_strerror(kernel_size));
>           exit(1);
>       }
>   
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 6990b1b0dd..07fc4c2300 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -78,8 +78,9 @@ static int64_t load_kernel(void)
>           if ((entry & ~0x7fffffffULL) == 0x80000000)
>               entry = (int32_t)entry;
>       } else {
> -        fprintf(stderr, "qemu: could not load kernel '%s'\n",
> -                loaderparams.kernel_filename);
> +        error_report("qemu: could not load kernel '%s': %s",
> +                     loaderparams.kernel_filename,
> +                     load_elf_strerror(kernel_size));
>           exit(1);
>       }
>   
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 690874be2b..2f5ced7409 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -31,6 +31,7 @@
>   #include "sysemu/block-backend.h"
>   #include "exec/address-spaces.h"
>   #include "sysemu/qtest.h"
> +#include "qemu/error-report.h"
>   
>   #define MAX_IDE_BUS 2
>   
> @@ -96,8 +97,9 @@ static int64_t load_kernel(void)
>           if ((entry & ~0x7fffffffULL) == 0x80000000)
>               entry = (int32_t)entry;
>       } else {
> -        fprintf(stderr, "qemu: could not load kernel '%s'\n",
> -                loaderparams.kernel_filename);
> +        error_report("qemu: could not load kernel '%s': %s",
> +                     loaderparams.kernel_filename,
> +                     load_elf_strerror(kernel_size));
>           exit(1);
>       }
>   
> 
