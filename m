Received: from eggs.gnu.org ([2001:4830:134:3::10]:35465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cnVcB-0001EH-T7
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cnVc7-0005Rj-MG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:26:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170313184750.429-1-krzk@kernel.org>
	<20170313184750.429-2-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8147e28b-3f6e-c21a-9b25-d2ce6818d65c@amsat.org>
Date: Mon, 13 Mar 2017 16:26:32 -0300
MIME-Version: 1.0
In-Reply-To: <20170313184750.429-2-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hw/arm/exynos: Convert fprintf to
 qemu_log_mask/error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 03/13/2017 03:47 PM, Krzysztof Kozlowski wrote:
> qemu_log_mask() and error_report() are preferred over fprintf() for
> logging errors.  Also remove square brackets [] and additional new line
> characters in printed messages.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/exynos4_boards.c   |  6 +++---
>  hw/timer/exynos4210_mct.c |  6 ++++--
>  hw/timer/exynos4210_pwm.c | 13 +++++++------
>  hw/timer/exynos4210_rtc.c | 19 ++++++++++---------
>  4 files changed, 24 insertions(+), 20 deletions(-)
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
> index 6069116942a4..e4ef4cfd3625 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -53,6 +53,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/sysbus.h"
>  #include "qemu/timer.h"
>  #include "qemu/main-loop.h"
> @@ -1364,8 +1365,9 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>      case L0_TCNTO: case L1_TCNTO:
>      case L0_ICNTO: case L1_ICNTO:
>      case L0_FRCNTO: case L1_FRCNTO:
> -        fprintf(stderr, "\n[exynos4210.mct: write to RO register "
> -                TARGET_FMT_plx "]\n\n", offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "exynos4210.mct: write to RO register " TARGET_FMT_plx,
> +                      offset);
>          break;
>
>      case L0_INT_CSTAT: case L1_INT_CSTAT:
> diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
> index f5765075c720..87f63f057e14 100644
> --- a/hw/timer/exynos4210_pwm.c
> +++ b/hw/timer/exynos4210_pwm.c
> @@ -21,6 +21,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/sysbus.h"
>  #include "qemu/timer.h"
>  #include "qemu-common.h"
> @@ -252,9 +253,9 @@ static uint64_t exynos4210_pwm_read(void *opaque, hwaddr offset,
>          break;
>
>      default:
> -        fprintf(stderr,
> -                "[exynos4210.pwm: bad read offset " TARGET_FMT_plx "]\n",
> -                offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "exynos4210.pwm: bad read offset " TARGET_FMT_plx,
> +                      offset);
>          break;
>      }
>      return value;
> @@ -343,9 +344,9 @@ static void exynos4210_pwm_write(void *opaque, hwaddr offset,
>          break;
>
>      default:
> -        fprintf(stderr,
> -                "[exynos4210.pwm: bad write offset " TARGET_FMT_plx "]\n",
> -                offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "exynos4210.pwm: bad write offset " TARGET_FMT_plx,
> +                      offset);
>          break;
>
>      }
> diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
> index 1a648c5d9e67..4607833e3e6f 100644
> --- a/hw/timer/exynos4210_rtc.c
> +++ b/hw/timer/exynos4210_rtc.c
> @@ -26,6 +26,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/sysbus.h"
>  #include "qemu/timer.h"
>  #include "qemu-common.h"
> @@ -370,9 +371,9 @@ static uint64_t exynos4210_rtc_read(void *opaque, hwaddr offset,
>          break;
>
>      default:
> -        fprintf(stderr,
> -                "[exynos4210.rtc: bad read offset " TARGET_FMT_plx "]\n",
> -                offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "exynos4210.rtc: bad read offset " TARGET_FMT_plx,
> +                      offset);
>          break;
>      }
>      return value;
> @@ -433,9 +434,9 @@ static void exynos4210_rtc_write(void *opaque, hwaddr offset,
>          if (value > TICNT_THRESHOLD) {
>              s->reg_ticcnt = value;
>          } else {
> -            fprintf(stderr,
> -                    "[exynos4210.rtc: bad TICNT value %u ]\n",
> -                    (uint32_t)value);
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "exynos4210.rtc: bad TICNT value %u",
> +                          (uint32_t)value);
>          }
>          break;
>
> @@ -500,9 +501,9 @@ static void exynos4210_rtc_write(void *opaque, hwaddr offset,
>          break;
>
>      default:
> -        fprintf(stderr,
> -                "[exynos4210.rtc: bad write offset " TARGET_FMT_plx "]\n",
> -                offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "exynos4210.rtc: bad write offset " TARGET_FMT_plx,
> +                      offset);
>          break;
>
>      }
>
