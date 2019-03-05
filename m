Received: from eggs.gnu.org ([209.51.188.92]:38636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1AJI-0006tW-RS
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1AJH-0000mw-5C
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:40:44 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1AJG-0000jb-St
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:40:43 -0500
Received: by mail-ot1-x343.google.com with SMTP id z19so7431664otm.2
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 05:40:41 -0800 (PST)
MIME-Version: 1.0
References: <1551741382-31691-1-git-send-email-michelheily@gmail.com>
In-Reply-To: <1551741382-31691-1-git-send-email-michelheily@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 13:40:28 +0000
Message-ID: <CAFEAcA9BLww02=2oXhgp_gYH4WyUqDZDzQZNG5Qgoe+W_Dwg8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] hw/arm/stellaris: Implement watchdog
 timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michel Heily <michelheily@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "open list:Stellaris" <qemu-arm@nongnu.org>

This didn't make it to the mailing lists for some reason (the
server does occasionally eat emails :-(). Sending this as a
reply to see if that makes it through OK...

(I'll also review it in a moment.)

thanks
-- PMM

On Mon, 4 Mar 2019 at 23:16, <michelheily@gmail.com> wrote:
>
> From: Michel Heily <michelheily@gmail.com>
>
> I've added the stellaris watchdog functionality because I needed it for a home project.
> Documentation for the hardware can be found at http://www.ti.com/lit/ds/symlink/lm3s6965.pdf.
>
> Signed-off-by: Michel Heily <michelheily@gmail.com>
> ---
>  hw/arm/stellaris.c                       | 22 ++++++++++-
>  hw/watchdog/cmsdk-apb-watchdog.c         | 66 +++++++++++++++++++++++++++++++-
>  include/hw/watchdog/cmsdk-apb-watchdog.h |  5 +++
>  3 files changed, 89 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 442529c..7918b28 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -22,6 +22,7 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/arm/armv7m.h"
>  #include "hw/char/pl011.h"
> +#include "hw/watchdog/cmsdk-apb-watchdog.h"
>  #include "hw/misc/unimp.h"
>  #include "cpu.h"
>
> @@ -1243,7 +1244,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
>       * Stellaris LM3S6965 Microcontroller Data Sheet (rev I)
>       * http://www.ti.com/lit/ds/symlink/lm3s6965.pdf
>       *
> -     * 40000000 wdtimer (unimplemented)
> +     * 40000000 wdtimer
>       * 40002000 i2c (unimplemented)
>       * 40004000 GPIO
>       * 40005000 GPIO
> @@ -1338,6 +1339,24 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
>      stellaris_sys_init(0x400fe000, qdev_get_gpio_in(nvic, 28),
>                         board, nd_table[0].macaddr.a);
>
> +
> +    if (board->dc1 & (1 << 3)) { /* watchdog present */
> +        dev = qdev_create(NULL, TYPE_LUMINARY_WATCHDOG);
> +
> +        /* system_clock_scale is valid now */
> +        uint32_t mainclk = NANOSECONDS_PER_SECOND / system_clock_scale;
> +        qdev_prop_set_uint32(dev, "wdogclk-frq", mainclk);
> +
> +        qdev_init_nofail(dev);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev),
> +                        0,
> +                        0x40000000u);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev),
> +                           0,
> +                           qdev_get_gpio_in(nvic, 18));
> +    }
> +
> +
>      for (i = 0; i < 7; i++) {
>          if (board->dc4 & (1 << i)) {
>              gpio_dev[i] = sysbus_create_simple("pl061_luminary", gpio_addr[i],
> @@ -1431,7 +1450,6 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
>      /* Add dummy regions for the devices we don't implement yet,
>       * so guest accesses don't cause unlogged crashes.
>       */
> -    create_unimplemented_device("wdtimer", 0x40000000, 0x1000);
>      create_unimplemented_device("i2c-0", 0x40002000, 0x1000);
>      create_unimplemented_device("i2c-2", 0x40021000, 0x1000);
>      create_unimplemented_device("PWM", 0x40028000, 0x1000);
> diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
> index eb79a73..f20f573 100644
> --- a/hw/watchdog/cmsdk-apb-watchdog.c
> +++ b/hw/watchdog/cmsdk-apb-watchdog.c
> @@ -37,6 +37,7 @@ REG32(WDOGINTCLR, 0xc)
>  REG32(WDOGRIS, 0x10)
>      FIELD(WDOGRIS, INT, 0, 1)
>  REG32(WDOGMIS, 0x14)
> +REG32(WDOGTEST, 0x418) /* only in the Stellaris/Luminary version of the device */
>  REG32(WDOGLOCK, 0xc00)
>  #define WDOG_UNLOCK_VALUE 0x1ACCE551
>  REG32(WDOGITCR, 0xf00)
> @@ -61,12 +62,18 @@ REG32(CID2, 0xff8)
>  REG32(CID3, 0xffc)
>
>  /* PID/CID values */
> -static const int watchdog_id[] = {
> +static const uint32_t cmsdk_apb_watchdog_id[] = {
>      0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
>      0x24, 0xb8, 0x1b, 0x00, /* PID0..PID3 */
>      0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
>  };
>
> +static const uint32_t luminary_watchdog_id[] = {
> +    0x00, 0x00, 0x00, 0x00, /* PID4..PID7 */
> +    0x05, 0x18, 0x18, 0x01, /* PID0..PID3 */
> +    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
> +};
> +
>  static bool cmsdk_apb_watchdog_intstatus(CMSDKAPBWatchdog *s)
>  {
>      /* Return masked interrupt status */
> @@ -85,6 +92,10 @@ static void cmsdk_apb_watchdog_update(CMSDKAPBWatchdog *s)
>      bool wdogres;
>
>      if (s->itcr) {
> +        /*
> +         * Not checking that !s->is_luminary since s->itcr can't be written
> +         * when s->is_luminary in the first place.
> +         */
>          wdogint = s->itop & R_WDOGITOP_WDOGINT_MASK;
>          wdogres = s->itop & R_WDOGITOP_WDOGRES_MASK;
>      } else {
> @@ -124,19 +135,34 @@ static uint64_t cmsdk_apb_watchdog_read(void *opaque, hwaddr offset,
>          r = s->lock;
>          break;
>      case A_WDOGITCR:
> +        if (s->is_luminary) {
> +            goto bad_offset;
> +        }
>          r = s->itcr;
>          break;
>      case A_PID4 ... A_CID3:
> -        r = watchdog_id[(offset - A_PID4) / 4];
> +        r = s->id[(offset - A_PID4) / 4];
>          break;
>      case A_WDOGINTCLR:
>      case A_WDOGITOP:
> +        if (s->is_luminary) {
> +            goto bad_offset;
> +        }
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "CMSDK APB watchdog read: read of WO offset %x\n",
>                        (int)offset);
>          r = 0;
>          break;
> +    case A_WDOGTEST:
> +        if (!s->is_luminary) {
> +            goto bad_offset;
> +        }
> +        qemu_log_mask(LOG_UNIMP,
> +                      "Luminary watchdog read: stall not implemented\n");
> +        r = 0;
> +        break;
>      default:
> +bad_offset:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "CMSDK APB watchdog read: bad offset %x\n", (int)offset);
>          r = 0;
> @@ -170,6 +196,10 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
>          ptimer_run(s->timer, 0);
>          break;
>      case A_WDOGCONTROL:
> +        if (s->is_luminary && 0 != (R_WDOGCONTROL_INTEN_MASK & s->control)) {
> +            /* ignore writes to the control register since interrupts were enabled */
> +            break;
> +        }
>          s->control = value & R_WDOGCONTROL_VALID_MASK;
>          cmsdk_apb_watchdog_update(s);
>          break;
> @@ -182,10 +212,16 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
>          s->lock = (value != WDOG_UNLOCK_VALUE);
>          break;
>      case A_WDOGITCR:
> +        if (s->is_luminary) {
> +            goto bad_offset;
> +        }
>          s->itcr = value & R_WDOGITCR_VALID_MASK;
>          cmsdk_apb_watchdog_update(s);
>          break;
>      case A_WDOGITOP:
> +        if (s->is_luminary) {
> +            goto bad_offset;
> +        }
>          s->itop = value & R_WDOGITOP_VALID_MASK;
>          cmsdk_apb_watchdog_update(s);
>          break;
> @@ -197,7 +233,15 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
>                        "CMSDK APB watchdog write: write to RO offset 0x%x\n",
>                        (int)offset);
>          break;
> +    case A_WDOGTEST:
> +        if (!s->is_luminary) {
> +            goto bad_offset;
> +        }
> +        qemu_log_mask(LOG_UNIMP,
> +                      "Luminary watchdog write: stall not implemented\n");
> +        break;
>      default:
> +bad_offset:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "CMSDK APB watchdog write: bad offset 0x%x\n",
>                        (int)offset);
> @@ -256,6 +300,9 @@ static void cmsdk_apb_watchdog_init(Object *obj)
>                            s, "cmsdk-apb-watchdog", 0x1000);
>      sysbus_init_mmio(sbd, &s->iomem);
>      sysbus_init_irq(sbd, &s->wdogint);
> +
> +    s->is_luminary = false;
> +    s->id = cmsdk_apb_watchdog_id;
>  }
>
>  static void cmsdk_apb_watchdog_realize(DeviceState *dev, Error **errp)
> @@ -318,9 +365,24 @@ static const TypeInfo cmsdk_apb_watchdog_info = {
>      .class_init = cmsdk_apb_watchdog_class_init,
>  };
>
> +static void luminary_watchdog_init(Object *obj)
> +{
> +    CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(obj);
> +
> +    s->is_luminary = true;
> +    s->id = luminary_watchdog_id;
> +}
> +
> +static const TypeInfo luminary_watchdog_info = {
> +    .name = TYPE_LUMINARY_WATCHDOG,
> +    .parent = TYPE_CMSDK_APB_WATCHDOG,
> +    .instance_init = luminary_watchdog_init
> +};
> +
>  static void cmsdk_apb_watchdog_register_types(void)
>  {
>      type_register_static(&cmsdk_apb_watchdog_info);
> +    type_register_static(&luminary_watchdog_info);
>  }
>
>  type_init(cmsdk_apb_watchdog_register_types);
> diff --git a/include/hw/watchdog/cmsdk-apb-watchdog.h b/include/hw/watchdog/cmsdk-apb-watchdog.h
> index ab8b598..070b804 100644
> --- a/include/hw/watchdog/cmsdk-apb-watchdog.h
> +++ b/include/hw/watchdog/cmsdk-apb-watchdog.h
> @@ -38,6 +38,9 @@
>  #define CMSDK_APB_WATCHDOG(obj) OBJECT_CHECK(CMSDKAPBWatchdog, (obj), \
>                                                TYPE_CMSDK_APB_WATCHDOG)
>
> +/* This shares the same struct (and cast macro) as the base cmsdk-apb-watchdog device */
> +#define TYPE_LUMINARY_WATCHDOG "luminary-watchdog"
> +
>  typedef struct CMSDKAPBWatchdog {
>      /*< private >*/
>      SysBusDevice parent_obj;
> @@ -46,6 +49,7 @@ typedef struct CMSDKAPBWatchdog {
>      MemoryRegion iomem;
>      qemu_irq wdogint;
>      uint32_t wdogclk_frq;
> +    bool is_luminary;
>      struct ptimer_state *timer;
>
>      uint32_t control;
> @@ -54,6 +58,7 @@ typedef struct CMSDKAPBWatchdog {
>      uint32_t itcr;
>      uint32_t itop;
>      uint32_t resetstatus;
> +    const uint32_t* id;
>  } CMSDKAPBWatchdog;
>
>  #endif
> --
> 2.7.4
>
