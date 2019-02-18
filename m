Received: from eggs.gnu.org ([209.51.188.92]:58706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvrBC-0005eE-EO
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqx7-00054a-Nm
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:59:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqx7-00054B-Gq
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:59:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so565758wmj.0
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:59:53 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2dc24df3-80d4-99ca-891f-31e2f96e5e85@redhat.com>
Date: Mon, 18 Feb 2019 22:59:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/14] hw/char/pl011: Allow use as an
 embedded-struct device
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

On 2/14/19 1:50 PM, Peter Maydell wrote:
> Create a new include file for the pl011's device struct,
> type macros, etc, so that it can be instantiated using
> the "embedded struct" coding style.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/char/pl011.h | 34 ++++++++++++++++++++++++++++++++++
>  hw/char/pl011.c         | 31 ++-----------------------------
>  2 files changed, 36 insertions(+), 29 deletions(-)
> 
> diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
> index 83649324b6a..1b52bfd5c90 100644
> --- a/include/hw/char/pl011.h
> +++ b/include/hw/char/pl011.h
> @@ -15,6 +15,40 @@
>  #ifndef HW_PL011_H
>  #define HW_PL011_H
>  
> +#include "hw/sysbus.h"
> +#include "chardev/char-fe.h"
> +
> +#define TYPE_PL011 "pl011"
> +#define PL011(obj) OBJECT_CHECK(PL011State, (obj), TYPE_PL011)
> +
> +/* This shares the same struct (and cast macro) as the base pl011 device */
> +#define TYPE_PL011_LUMINARY "pl011_luminary"
> +
> +typedef struct PL011State {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    uint32_t readbuff;
> +    uint32_t flags;
> +    uint32_t lcr;
> +    uint32_t rsr;
> +    uint32_t cr;
> +    uint32_t dmacr;
> +    uint32_t int_enabled;
> +    uint32_t int_level;
> +    uint32_t read_fifo[16];
> +    uint32_t ilpr;
> +    uint32_t ibrd;
> +    uint32_t fbrd;
> +    uint32_t ifl;
> +    int read_pos;
> +    int read_count;
> +    int read_trigger;
> +    CharBackend chr;
> +    qemu_irq irq;
> +    const unsigned char *id;
> +} PL011State;
> +
>  static inline DeviceState *pl011_create(hwaddr addr,
>                                          qemu_irq irq,
>                                          Chardev *chr)
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 2aa277fc4f2..0c4711e4027 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -8,39 +8,12 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "hw/char/pl011.h"
>  #include "hw/sysbus.h"
>  #include "chardev/char-fe.h"
>  #include "qemu/log.h"
>  #include "trace.h"
>  
> -#define TYPE_PL011 "pl011"
> -#define PL011(obj) OBJECT_CHECK(PL011State, (obj), TYPE_PL011)
> -
> -typedef struct PL011State {
> -    SysBusDevice parent_obj;
> -
> -    MemoryRegion iomem;
> -    uint32_t readbuff;
> -    uint32_t flags;
> -    uint32_t lcr;
> -    uint32_t rsr;
> -    uint32_t cr;
> -    uint32_t dmacr;
> -    uint32_t int_enabled;
> -    uint32_t int_level;
> -    uint32_t read_fifo[16];
> -    uint32_t ilpr;
> -    uint32_t ibrd;
> -    uint32_t fbrd;
> -    uint32_t ifl;
> -    int read_pos;
> -    int read_count;
> -    int read_trigger;
> -    CharBackend chr;
> -    qemu_irq irq;
> -    const unsigned char *id;
> -} PL011State;
> -
>  #define PL011_INT_TX 0x20
>  #define PL011_INT_RX 0x10
>  
> @@ -357,7 +330,7 @@ static void pl011_luminary_init(Object *obj)
>  }
>  
>  static const TypeInfo pl011_luminary_info = {
> -    .name          = "pl011_luminary",
> +    .name          = TYPE_PL011_LUMINARY,
>      .parent        = TYPE_PL011,
>      .instance_init = pl011_luminary_init,
>  };
> 
