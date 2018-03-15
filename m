Received: from eggs.gnu.org ([2001:4830:134:3::10]:56696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewS2j-0005rs-Ek
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewS2f-00019Q-F1
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:31:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1d6ab08a-c21d-8a8d-abdd-b99a40605787@amsat.org>
Date: Thu, 15 Mar 2018 13:31:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180313153458.26822-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 9/9] hw/arm/raspi: Provide spin-loop code
 for AArch64 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Pekka Enberg <penberg@iki.fi>, Andrew Baumann <Andrew.Baumann@microsoft.com>

On 03/13/2018 04:34 PM, Peter Maydell wrote:
> The raspi3 has AArch64 CPUs, which means that our smpboot
> code for keeping the secondary CPUs in a pen needs to have
> a version for A64 as well as A32. Without this, the
> secondary CPUs go into an infinite loop of taking undefined
> instruction exceptions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/raspi.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index ae15997669..06f1e08ca9 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -27,6 +27,7 @@
>  #define BOARDSETUP_ADDR (MVBAR_ADDR + 0x20) /* board setup code */
>  #define FIRMWARE_ADDR_2 0x8000 /* Pi 2 loads kernel.img here by default */
>  #define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by default */
> +#define SPINTABLE_ADDR  0xd8 /* Pi 3 bootloader spintable */
>  
>  /* Table of Linux board IDs for different Pi versions */
>  static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43, [3] = 0xc44};
> @@ -63,6 +64,40 @@ static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
>                         info->smp_loader_start);
>  }
>  
> +static void write_smpboot64(ARMCPU *cpu, const struct arm_boot_info *info)
> +{
> +    /* Unlike the AArch32 version we don't need to call the board setup hook.
> +     * The mechanism for doing the spin-table is also entirely different.
> +     * We must have four 64-bit fields at absolute addresses
> +     * 0xd8, 0xe0, 0xe8, 0xf0 in RAM, which are the flag variables for
> +     * our CPUs, and which we must ensure are zero initialized before
> +     * the primary CPU goes into the kernel. We put these variables inside
> +     * a rom blob, so that the reset for ROM contents zeroes them for us.
> +     */

Checking with Linux doc/Documentation/arm64/booting.txt and
arch/arm/boot/dts/bcm2837.dtsi.

> +    static const uint32_t smpboot[] = {
> +        0xd2801b05, /*        mov     x5, 0xd8 */

x5 = &spintable;

> +        0xd53800a6, /*        mrs     x6, mpidr_el1 */
> +        0x924004c6, /*        and     x6, x6, #0x3 */

x6 = clusterid;

> +        0xd503205f, /* spin:  wfe */
> +        0xf86678a4, /*        ldr     x4, [x5,x6,lsl #3] */

x4 = &spintable[clusterid];

> +        0xb4ffffc4, /*        cbz     x4, spin */

loop if !x4 ...

> +        0xd2800000, /*        mov     x0, #0x0 */
> +        0xd2800001, /*        mov     x1, #0x0 */
> +        0xd2800002, /*        mov     x2, #0x0 */
> +        0xd2800003, /*        mov     x3, #0x0 */
> +        0xd61f0080, /*        br      x4 */

... else jump()

> +    };
> +
> +    static const uint64_t spintables[] = {
> +        0, 0, 0, 0

the "naturally-aligned 64-bit zero-initalised memory"

> +    };
> +
> +    rom_add_blob_fixed("raspi_smpboot", smpboot, sizeof(smpboot),
> +                       info->smp_loader_start);
> +    rom_add_blob_fixed("raspi_spintables", spintables, sizeof(spintables),
> +                       SPINTABLE_ADDR);

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +}
> +
>  static void write_board_setup(ARMCPU *cpu, const struct arm_boot_info *info)
>  {
>      arm_write_secure_board_setup_dummy_smc(cpu, info, MVBAR_ADDR);
> @@ -99,7 +134,11 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
>      /* Pi2 and Pi3 requires SMP setup */
>      if (version >= 2) {
>          binfo.smp_loader_start = SMPBOOT_ADDR;
> -        binfo.write_secondary_boot = write_smpboot;
> +        if (version == 2) {
> +            binfo.write_secondary_boot = write_smpboot;
> +        } else {
> +            binfo.write_secondary_boot = write_smpboot64;
> +        }
>          binfo.secondary_cpu_reset_hook = reset_secondary;
>      }
>  
> 
