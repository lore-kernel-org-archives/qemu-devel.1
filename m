Received: from eggs.gnu.org ([209.51.188.92]:38131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDVuT-0006gH-Tb
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDVuS-0001r2-GR
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:10:09 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDVuR-0001p8-3k
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:10:07 -0400
Received: by mail-oi1-x244.google.com with SMTP id a6so10840290oie.5
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 08:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190408145721.15881-1-sohailalvi2236@gmail.com>
In-Reply-To: <20190408145721.15881-1-sohailalvi2236@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2019 16:09:53 +0100
Message-ID: <CAFEAcA-D0MK_eEs+tvPsdp+2s9YuC=qS=uyhzNtqy3DW9-=rNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qemu_system_reset_request() in hw/
 corresponding to watchdog that has triggered replaced by
 watchdog_perform_action().
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sohailalvi2236@gmail.com
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 8 Apr 2019 at 15:59, <sohailalvi2236@gmail.com> wrote:
>
> From: Sohail Alvi <sohailalvi2236@gmail.com>
>
> ---
>  hw/arm/musicpal.c        | 3 ++-
>  hw/ppc/ppc.c             | 3 ++-
>  hw/s390x/ipl.c           | 3 ++-
>  hw/timer/etraxfs_timer.c | 3 ++-
>  hw/timer/m48t59.c        | 3 ++-
>  hw/timer/pxa2xx_timer.c  | 3 ++-
>  6 files changed, 12 insertions(+), 6 deletions(-)

Hi; thanks for this patch. Unfortunately I think you've
misunderstood the suggestion from the bitesize tasks page.
(This is our fault, because the bitesize tasks list
has accumulated a lot of tasks that really require
some understanding of exactly what is being done, but
don't make it clear in their description.)

In this case the key phrase is "corresponding to a
watchdog that has triggered". Not all calls to
qemu_system_reset_request() are calls made by
watchdog devices when their timer has triggered.
If the call is not a watchdog timer timeout then
it doesn't need changing. Some of the places you've
changed here are watchdog timeouts, but some are not.

I would also suggest that you have one patch per
device you're changing -- all of these devices
are parts of different machines which have different
guest CPU architectures. That means that the people
who can review and test the change are different
for each device. Also if we have a patch per device
it means that if there turns out to be a problem
with the change for one of the devices it's easy
to back that change out without affecting the others.

I would also suggest that your commit message should
have just a short description in the Subject line,
and a more detailed description in the main body
of the commit message. You can look at some of
the commit messages in our git history to get an
idea of our preferred style.

> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 93ec3c5698..84593e61cc 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -28,6 +28,7 @@
>  #include "sysemu/block-backend.h"
>  #include "exec/address-spaces.h"
>  #include "ui/pixel_ops.h"
> +#include "sysemu/watchdog.h"
>
>  #define MP_MISC_BASE            0x80002000
>  #define MP_MISC_SIZE            0x00001000
> @@ -898,7 +899,7 @@ static void mv88w8618_pit_write(void *opaque, hwaddr offset,
>
>      case MP_BOARD_RESET:
>          if (value == MP_BOARD_RESET_MAGIC) {
> -            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +            watchdog_perform_action();
>          }

This isn't a watchdog timeout -- it's just a device
register that allows the guest to request a board
reset.

>          break;
>      }
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index ad20584f26..636d2046f8 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -35,6 +35,7 @@
>  #include "sysemu/kvm.h"
>  #include "kvm_ppc.h"
>  #include "trace.h"
> +#include "sysemu/watchdog.h"
>
>  //#define PPC_DEBUG_IRQ
>  //#define PPC_DEBUG_TB
> @@ -380,7 +381,7 @@ void ppc40x_chip_reset(PowerPCCPU *cpu)
>  void ppc40x_system_reset(PowerPCCPU *cpu)
>  {
>      qemu_log_mask(CPU_LOG_RESET, "Reset PowerPC system\n");
> -    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +    watchdog_perform_action();
>  }

This isn't a watchdog either.

>
>  void store_40x_dbcr0(CPUPPCState *env, uint32_t val)
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 51b272e190..4783b41c57 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -27,6 +27,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/option.h"
>  #include "exec/exec-all.h"
> +#include "sysemu/watchdog.h"
>
>  #define KERN_IMAGE_START                0x010000UL
>  #define LINUX_MAGIC_ADDR                0x010008UL
> @@ -547,7 +548,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>          /* ignore -no-reboot, send no event  */
>          qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
>      } else {
> -        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        watchdog_perform_action();

Nor is this.

>      }
>      /* as this is triggered by a CPU, make sure to exit the loop */
>      if (tcg_enabled()) {
> diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
> index 2280914b1d..9561113d0e 100644
> --- a/hw/timer/etraxfs_timer.c
> +++ b/hw/timer/etraxfs_timer.c
> @@ -26,6 +26,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/timer.h"
>  #include "hw/ptimer.h"
> +#include "sysemu/watchdog.h"
>
>  #define D(x)
>
> @@ -207,7 +208,7 @@ static void watchdog_hit(void *opaque)
>          qemu_irq_raise(t->nmi);
>      }
>      else
> -        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        watchdog_perform_action();

This one really is a watchdog timeout, so this change
is OK. (If you run your patch through scripts/checkpatch.pl
you'll find that checkpatch advises adding some braces to
this if statement, though.)


>      t->wd_hits++;
>  }
> diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
> index ca3ed445de..ebe58e8dc7 100644
> --- a/hw/timer/m48t59.c
> +++ b/hw/timer/m48t59.c
> @@ -30,6 +30,7 @@
>  #include "hw/sysbus.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/bcd.h"
> +#include "sysemu/watchdog.h"
>
>  #include "m48t59-internal.h"
>
> @@ -158,7 +159,7 @@ static void watchdog_cb (void *opaque)
>         NVRAM->buffer[0x1FF7] = 0x00;
>         NVRAM->buffer[0x1FFC] &= ~0x40;
>          /* May it be a hw CPU Reset instead ? */
> -        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        watchdog_perform_action();
>      } else {
>         qemu_set_irq(NVRAM->IRQ, 1);
>         qemu_set_irq(NVRAM->IRQ, 0);

Yes, this is a watchdog.

> diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
> index a489bf5159..2be680b5df 100644
> --- a/hw/timer/pxa2xx_timer.c
> +++ b/hw/timer/pxa2xx_timer.c
> @@ -14,6 +14,7 @@
>  #include "hw/arm/pxa.h"
>  #include "hw/sysbus.h"
>  #include "qemu/log.h"
> +#include "sysemu/watchdog.h"
>
>  #define OSMR0  0x00
>  #define OSMR1  0x04
> @@ -414,7 +415,7 @@ static void pxa2xx_timer_tick(void *opaque)
>      if (t->num == 3)
>          if (i->reset3 & 1) {
>              i->reset3 = 0;
> -            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +            watchdog_perform_action();
>          }

This is a watchdog too.

>  }
>
> --
> 2.17.1

thanks
-- PMM
