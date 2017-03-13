Received: from eggs.gnu.org ([2001:4830:134:3::10]:52363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1cnUso-0007x4-9h
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1cnUsn-0001E0-AG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:39:50 -0400
Date: Mon, 13 Mar 2017 20:39:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170313183937.ony4fukk6iny3gop@kozik-lap>
References: <20170313183557.23195-1-krzk@kernel.org>
	<20170313183557.23195-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170313183557.23195-2-krzk@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] hw/arm/exynos: Convert fprintf to
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Mon, Mar 13, 2017 at 08:35:55PM +0200, Krzysztof Kozlowski wrote:
> error_report() is preferred over fprintf() for logging errors.  Also
> remove square brackets [] and additional new line characters in printed
> messages.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  hw/arm/exynos4_boards.c   |  6 +++---
>  hw/timer/exynos4210_mct.c |  5 +++--
>  hw/timer/exynos4210_pwm.c | 11 +++++------
>  hw/timer/exynos4210_rtc.c | 16 +++++++---------
>  4 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
> index 0efa19405409..0a352815b86d 100644
> --- a/hw/arm/exynos4_boards.c
> +++ b/hw/arm/exynos4_boards.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "sysemu/sysemu.h"
> @@ -101,9 +102,8 @@ static Exynos4210State *exynos4_boards_init_common(MachineState *machine,
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>  
>      if (smp_cpus != EXYNOS4210_NCPUS && !qtest_enabled()) {
> -        fprintf(stderr, "%s board supports only %d CPU cores. Ignoring smp_cpus"
> -                " value.\n",
> -                mc->name, EXYNOS4210_NCPUS);
> +        error_report("%s board supports only %d CPU cores, ignoring smp_cpus value",
> +                     mc->name, EXYNOS4210_NCPUS);
>      }
>  
>      exynos4_board_binfo.ram_size = exynos4_board_ram_size[board_type];
> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> index 6069116942a4..48041ab036a6 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -53,6 +53,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/sysbus.h"
>  #include "qemu/timer.h"
>  #include "qemu/main-loop.h"
> @@ -1364,8 +1365,8 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>      case L0_TCNTO: case L1_TCNTO:
>      case L0_ICNTO: case L1_ICNTO:
>      case L0_FRCNTO: case L1_FRCNTO:
> -        fprintf(stderr, "\n[exynos4210.mct: write to RO register "
> -                TARGET_FMT_plx "]\n\n", offset);
> +        error_report("exynos4210.mct: write to RO register " TARGET_FMT_plx,
> +                     offset);

Ahh, I missed Philippe's suggestions here and other places. Sorry for
the mess, I'll fix it and resend v3.

Best regards,
Krzysztof
