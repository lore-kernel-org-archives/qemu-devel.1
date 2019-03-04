Received: from eggs.gnu.org ([209.51.188.92]:53237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0oza-0004VV-Lo
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0ozY-0008QP-6R
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:54:58 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:36730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0ozW-0008D5-Ap
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:54:54 -0500
Received: by mail-ot1-x332.google.com with SMTP id v62so4426292otb.3
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 06:54:53 -0800 (PST)
MIME-Version: 1.0
References: <1551564698-9922-1-git-send-email-michelheily@gmail.com>
In-Reply-To: <1551564698-9922-1-git-send-email-michelheily@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2019 14:54:40 +0000
Message-ID: <CAFEAcA9Y_ZM0tDuvK+bOO+4+hT8ApLYR9EsKPojL9zGG=LJ-Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/stellaris: Implement watchdog
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

On Sat, 2 Mar 2019 at 22:11, <michelheily@gmail.com> wrote:
>
> From: Michel Heily <michelheily@gmail.com>
>
> I've added the stellaris watchdog functionality because I needed it for a home project.
> Documentation for the hardware can be found at http://www.ti.com/lit/ds/symlink/lm3s6965.pdf.
>
> Signed-off-by: Michel Heily <michelheily@gmail.com>

Thanks; this is looking pretty good. I have some minor
comments below. We're getting quite close to softfreeze now,
but if you can manage to get a v3 to the list some time this
week I should be able to squeeze it into the next release.

> @@ -1338,6 +1339,24 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
>      stellaris_sys_init(0x400fe000, qdev_get_gpio_in(nvic, 28),
>                         board, nd_table[0].macaddr.a);
>
> +
> +    if (board->dc1 & (1  << 3)) { /* watchdog present */

Stray extra space before "<<"

> diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
> index eb79a73..5029838 100644
> --- a/hw/watchdog/cmsdk-apb-watchdog.c
> +++ b/hw/watchdog/cmsdk-apb-watchdog.c
> @@ -37,6 +37,7 @@ REG32(WDOGINTCLR, 0xc)
>  REG32(WDOGRIS, 0x10)
>      FIELD(WDOGRIS, INT, 0, 1)
>  REG32(WDOGMIS, 0x14)
> +REG32(WDOTEST, 0x418)

Typo. This should either be "WDOGTEST" to follow the naming convention
of the other registers, or "WDTTEST" to follow the Stellaris datasheet's
name. I'd go with "WDOGTEST" but it doesn't much matter which.

Also worth a comment
/* only in the Stellaris/Luminary version of the device */

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
> @@ -102,6 +109,7 @@ static uint64_t cmsdk_apb_watchdog_read(void *opaque, hwaddr offset,
>                                          unsigned size)
>  {
>      CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(opaque);
> +    bool _default = false;

Don't name variables with leading underscores.
In any case you don't need this one...

>      uint64_t r;
>
>      switch (offset) {
> @@ -124,24 +132,46 @@ static uint64_t cmsdk_apb_watchdog_read(void *opaque, hwaddr offset,
>          r = s->lock;
>          break;
>      case A_WDOGITCR:
> +        if (s->is_luminary) {
> +            _default = true;
> +            break;
> +        }

Just use
 if (s->is_luminary) {
     goto bad_offset;
 }

and then add the bad_offset: label after default:.
This is clearer than having a flag that modifies the program flow.


> @@ -150,6 +180,7 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
>                                       uint64_t value, unsigned size)
>  {
>      CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(opaque);
> +    bool _default = false;

Similarly here.

> @@ -197,11 +240,23 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
>                        "CMSDK APB watchdog write: write to RO offset 0x%x\n",
>                        (int)offset);
>          break;
> +    case A_WDOTEST:
> +        if (s->is_luminary) {
> +            qemu_log_mask(LOG_UNIMP,
> +                      "Luminary watchdog write: stall not implemented\n");
> +            break;
> +        }
> +        _default = true;
> +        break;
>      default:
> +        _default = true;
> +        break;
> +    }
> +
> +    if (_default) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "CMSDK APB watchdog write: bad offset 0x%x\n",
>                        (int)offset);
> -        break;
>      }
>  }
>
> @@ -256,6 +311,9 @@ static void cmsdk_apb_watchdog_init(Object *obj)
>                            s, "cmsdk-apb-watchdog", 0x1000);
>      sysbus_init_mmio(sbd, &s->iomem);
>      sysbus_init_irq(sbd, &s->wdogint);
> +
> +    s->is_luminary = false;
> +    memcpy(s->id, cmsdk_apb_watchdog_id, sizeof(s->id));

You don't need a memcpy here -- just make s->id a const uint32_t*,
and then you can do "s->id = cmsdk_apb_watchdog_id;"

>  }
>
>  static void cmsdk_apb_watchdog_realize(DeviceState *dev, Error **errp)
> @@ -291,6 +349,7 @@ static const VMStateDescription cmsdk_apb_watchdog_vmstate = {
>          VMSTATE_UINT32(itcr, CMSDKAPBWatchdog),
>          VMSTATE_UINT32(itop, CMSDKAPBWatchdog),
>          VMSTATE_UINT32(resetstatus, CMSDKAPBWatchdog),
> +        VMSTATE_UINT32_ARRAY(id, CMSDKAPBWatchdog, 12),

The ID registers are constant so they don't need to be transferred
as part of the VM migration state, so you don't need to change
anything here.

>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -318,9 +377,24 @@ static const TypeInfo cmsdk_apb_watchdog_info = {
>      .class_init = cmsdk_apb_watchdog_class_init,
>  };
>
> +static void luminary_watchdog_init(Object *obj)
> +{
> +    CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(obj);
> +
> +    s->is_luminary = true;
> +    memcpy(s->id, luminary_watchdog_id, sizeof(s->id));

Similarly this memcpy isn't needed.

thanks
-- PMM
