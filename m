Received: from eggs.gnu.org ([2001:4830:134:3::10]:37056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fc3-0006sj-Ty
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fbz-00016A-Ut
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:17:55 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:56381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fbz-000165-Qr
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:17:51 -0400
Received: by mail-qt0-x244.google.com with SMTP id z28so20202385qtz.13
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 15:17:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508513949-15680-1-git-send-email-gabriel291075@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <52e67cee-c6e6-4df0-6882-6a39fdef473d@amsat.org>
Date: Fri, 20 Oct 2017 19:17:48 -0300
MIME-Version: 1.0
In-Reply-To: <1508513949-15680-1-git-send-email-gabriel291075@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 04/11] kinetis_k64_sim.h has been added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gabriel Augusto Costa <gabriel291075@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hi Gabriel,

On 10/20/2017 12:39 PM, Gabriel Augusto Costa wrote:
> I made a new arm machine with some peripherals. The machine is mk64fn1m0, a
> cortex-m4 microcontroller from NXP Kinetis family. The machine can run a
> simple arm binary file using UART0 in polling mode.
> I have prepared a series of patchs to include this machine:
> PATCH v3 n/11: It adds the machine and peripherals devices;
> PATCH v4 n/2: It changes the Make files to compile this machine.
> 
> Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
> ---
>  include/hw/misc/kinetis_k64_sim.h | 56 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 include/hw/misc/kinetis_k64_sim.h
> 
> diff --git a/include/hw/misc/kinetis_k64_sim.h b/include/hw/misc/kinetis_k64_sim.h
> new file mode 100644
> index 0000000..2eb1f5c
> --- /dev/null
> +++ b/include/hw/misc/kinetis_k64_sim.h

I'd rather name it kinetis_k64_system.h or kinetis_k64_sysctl.h

> @@ -0,0 +1,56 @@
> +/*
> + * Kinetis K64 peripheral microcontroller emulation.
> + *
> + * Copyright (c) 2017 Advantech Wireless
> + * Written by Gabriel Costa <gabriel291075@gmail.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or
> + *  (at your option) any later version.
> + */
> +
> +/* Kinetis K64 series SIM controller.  */
> +
> +#ifndef KINETIS_SIM_H
> +#define KINETIS_SIM_H
> +
> +#include "hw/sysbus.h"
> +#include "chardev/char-fe.h"

not used

> +#include "chardev/char-mux.h"

not used

> +#include "hw/hw.h"
> +
> +#define TYPE_KINETIS_K64_SIM "kinetis_k64_sim"
> +#define KINETIS_K64_SIM(obj) \
> +    OBJECT_CHECK(kinetis_k64_sim_state, (obj), TYPE_KINETIS_K64_SIM)
> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +
> +    uint32_t SOPT1;     /**< System Options Register 1, offset: 0x0 */
> +    uint32_t SOPT1CFG;  /**< SOPT1 Configuration Register, offset: 0x4 */
> +    uint32_t SOPT2;     /**< System Options Register 2, offset: 0x1004 */
> +    uint32_t SOPT4;     /**< System Options Register 4, offset: 0x100C */
> +    uint32_t SOPT5;     /**< System Options Register 5, offset: 0x1010 */
> +    uint32_t SOPT7;     /**< System Options Register 7, offset: 0x1018 */

could be uint32_t SOPT[8] ...

> +    uint32_t SDID;      /**< System Device Id Register, offset: 0x1024 */
> +    uint32_t SCGC1;     /**< System Clock Gating Ctrl Reg 1, offset: 0x1028 */
> +    uint32_t SCGC2;     /**< System Clock Gating Ctrl Reg 2, offset: 0x102C */
> +    uint32_t SCGC3;     /**< System Clock Gating Ctrl Reg 3, offset: 0x1030 */
> +    uint32_t SCGC4;     /**< System Clock Gating Ctrl Reg 4, offset: 0x1034 */
> +    uint32_t SCGC5;     /**< System Clock Gating Ctrl Reg 5, offset: 0x1038 */
> +    uint32_t SCGC6;     /**< System Clock Gating Ctrl Reg 6, offset: 0x103C */
> +    uint32_t SCGC7;     /**< System Clock Gating Ctrl Reg 7, offset: 0x1040 */

... and uint32_t SCGC[8]

Then in the source I'd do:

    case 0x0000:
        value = s->SOPT[0];
        break;

    case 0x0004:
        value = s->SOPTCFG[0];
        break;

    case 0x1004 ... 0x1018:
        value = s->SOPT[(value & 0x1f) >> 2];
        break;

> +    uint32_t CLKDIV1;   /**< System Clock Divider Register 1, offset: 0x1044 */
> +    uint32_t CLKDIV2;   /**< System Clock Divider Register 2, offset: 0x1048 */
> +    uint32_t FCFG1;     /**< Flash Configuration Register 1, offset: 0x104C */
> +    uint32_t FCFG2;     /**< Flash Configuration Register 2, offset: 0x1050 */
> +    uint32_t UIDH;      /**< Unique Id Register High, offset: 0x1054 */
> +    uint32_t UIDMH;     /**< Unique Id Register Mid-High, offset: 0x1058 */
> +    uint32_t UIDML;     /**< Unique Id Register Mid Low, offset: 0x105C */
> +    uint32_t UIDL;      /**< Unique Id Register Low, offset: 0x1060 */
> +
> +} kinetis_k64_sim_state;
> +
> +#endif
> 
