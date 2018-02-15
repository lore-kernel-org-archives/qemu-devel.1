Received: from eggs.gnu.org ([2001:4830:134:3::10]:57901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNwP-0000wF-8c
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNwM-0004MD-3H
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:07:29 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215175707.15491-1-peter.maydell@linaro.org>
	<20180215175707.15491-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7745fafb-ddf6-06b0-c6b0-857e846403c0@amsat.org>
Date: Thu, 15 Feb 2018 15:07:20 -0300
MIME-Version: 1.0
In-Reply-To: <20180215175707.15491-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/3] hw/arm/armv7m: Honour CPU's
 address space for image loads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 02/15/2018 02:57 PM, Peter Maydell wrote:
> Instead of loading guest images to the system address space, use the
> CPU's address space.  This is important if we're trying to load the
> file to memory or via an alias memory region that is provided by an
> SoC object and thus not mapped into the system address space.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/armv7m.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 56770a7048..facc536b07 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -270,6 +270,9 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
>      uint64_t entry;
>      uint64_t lowaddr;
>      int big_endian;
> +    AddressSpace *as;
> +    int asidx;
> +    CPUState *cs = CPU(cpu);
>  
>  #ifdef TARGET_WORDS_BIGENDIAN
>      big_endian = 1;
> @@ -282,11 +285,19 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
>          exit(1);
>      }
>  
> +    if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
> +        asidx = ARMASIdx_S;
> +    } else {
> +        asidx = ARMASIdx_NS;
> +    }
> +    as = cpu_get_address_space(cs, asidx);
> +
>      if (kernel_filename) {
> -        image_size = load_elf(kernel_filename, NULL, NULL, &entry, &lowaddr,
> -                              NULL, big_endian, EM_ARM, 1, 0);
> +        image_size = load_elf_as(kernel_filename, NULL, NULL, &entry, &lowaddr,
> +                                 NULL, big_endian, EM_ARM, 1, 0, as);
>          if (image_size < 0) {
> -            image_size = load_image_targphys(kernel_filename, 0, mem_size);
> +            image_size = load_image_targphys_as(kernel_filename, 0,
> +                                                mem_size, as);
>              lowaddr = 0;
>          }
>          if (image_size < 0) {
> 
