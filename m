Received: from eggs.gnu.org ([2001:4830:134:3::10]:55869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfqlP-00085y-QR
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:24:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfqlL-0002xZ-QL
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:24:35 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
	<1487604965-23220-3-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d1c1bc8f-31e8-0751-ef7b-c1af559bad72@amsat.org>
Date: Mon, 20 Feb 2017 13:24:26 -0300
MIME-Version: 1.0
In-Reply-To: <1487604965-23220-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 02/11] armv7m: Move NVICState
 struct definition into header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>, patches@linaro.org

On 02/20/2017 12:35 PM, Peter Maydell wrote:
> Move the NVICState struct definition into a header, so we can
> embed it into other QOM objects like SoCs.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/arm/armv7m_nvic.h | 66 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/intc/armv7m_nvic.c        | 49 +-------------------------------
>  2 files changed, 67 insertions(+), 48 deletions(-)
>  create mode 100644 include/hw/arm/armv7m_nvic.h
>
> diff --git a/include/hw/arm/armv7m_nvic.h b/include/hw/arm/armv7m_nvic.h
> new file mode 100644
> index 0000000..39b94ee
> --- /dev/null
> +++ b/include/hw/arm/armv7m_nvic.h
> @@ -0,0 +1,66 @@
> +/*
> + * ARMv7M NVIC object
> + *
> + * Copyright (c) 2017 Linaro Ltd
> + * Written by Peter Maydell <peter.maydell@linaro.org>
> + *
> + * This code is licensed under the GPL version 2 or later.
> + */
> +
> +#ifndef HW_ARM_ARMV7M_NVIC_H
> +#define HW_ARM_ARMV7M_NVIC_H
> +
> +#include "target/arm/cpu.h"
> +#include "hw/sysbus.h"
> +
> +#define TYPE_NVIC "armv7m_nvic"
> +
> +#define NVIC(obj) \
> +    OBJECT_CHECK(NVICState, (obj), TYPE_NVIC)
> +
> +/* Highest permitted number of exceptions (architectural limit) */
> +#define NVIC_MAX_VECTORS 512
> +
> +typedef struct VecInfo {
> +    /* Exception priorities can range from -3 to 255; only the unmodifiable
> +     * priority values for RESET, NMI and HardFault can be negative.
> +     */
> +    int16_t prio;
> +    uint8_t enabled;
> +    uint8_t pending;
> +    uint8_t active;
> +    uint8_t level; /* exceptions <=15 never set level */
> +} VecInfo;
> +
> +typedef struct NVICState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    ARMCPU *cpu;
> +
> +    VecInfo vectors[NVIC_MAX_VECTORS];
> +    uint32_t prigroup;
> +
> +    /* vectpending and exception_prio are both cached state that can
> +     * be recalculated from the vectors[] array and the prigroup field.
> +     */
> +    unsigned int vectpending; /* highest prio pending enabled exception */
> +    int exception_prio; /* group prio of the highest prio active exception */
> +
> +    struct {
> +        uint32_t control;
> +        uint32_t reload;
> +        int64_t tick;
> +        QEMUTimer *timer;
> +    } systick;
> +
> +    MemoryRegion sysregmem;
> +    MemoryRegion container;
> +
> +    uint32_t num_irq;
> +    qemu_irq excpout;
> +    qemu_irq sysresetreq;
> +} NVICState;
> +
> +#endif
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 76097b4..f2ada39 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -17,6 +17,7 @@
>  #include "hw/sysbus.h"
>  #include "qemu/timer.h"
>  #include "hw/arm/arm.h"
> +#include "hw/arm/armv7m_nvic.h"
>  #include "target/arm/cpu.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/log.h"
> @@ -47,7 +48,6 @@
>   * "exception" more or less interchangeably.
>   */
>  #define NVIC_FIRST_IRQ 16
> -#define NVIC_MAX_VECTORS 512
>  #define NVIC_MAX_IRQ (NVIC_MAX_VECTORS - NVIC_FIRST_IRQ)
>
>  /* Effective running priority of the CPU when no exception is active
> @@ -55,53 +55,6 @@
>   */
>  #define NVIC_NOEXC_PRIO 0x100
>
> -typedef struct VecInfo {
> -    /* Exception priorities can range from -3 to 255; only the unmodifiable
> -     * priority values for RESET, NMI and HardFault can be negative.
> -     */
> -    int16_t prio;
> -    uint8_t enabled;
> -    uint8_t pending;
> -    uint8_t active;
> -    uint8_t level; /* exceptions <=15 never set level */
> -} VecInfo;
> -
> -typedef struct NVICState {
> -    /*< private >*/
> -    SysBusDevice parent_obj;
> -    /*< public >*/
> -
> -    ARMCPU *cpu;
> -
> -    VecInfo vectors[NVIC_MAX_VECTORS];
> -    uint32_t prigroup;
> -
> -    /* vectpending and exception_prio are both cached state that can
> -     * be recalculated from the vectors[] array and the prigroup field.
> -     */
> -    unsigned int vectpending; /* highest prio pending enabled exception */
> -    int exception_prio; /* group prio of the highest prio active exception */
> -
> -    struct {
> -        uint32_t control;
> -        uint32_t reload;
> -        int64_t tick;
> -        QEMUTimer *timer;
> -    } systick;
> -
> -    MemoryRegion sysregmem;
> -    MemoryRegion container;
> -
> -    uint32_t num_irq;
> -    qemu_irq excpout;
> -    qemu_irq sysresetreq;
> -} NVICState;
> -
> -#define TYPE_NVIC "armv7m_nvic"
> -
> -#define NVIC(obj) \
> -    OBJECT_CHECK(NVICState, (obj), TYPE_NVIC)
> -
>  static const uint8_t nvic_id[] = {
>      0x00, 0xb0, 0x1b, 0x00, 0x0d, 0xe0, 0x05, 0xb1
>  };
>
