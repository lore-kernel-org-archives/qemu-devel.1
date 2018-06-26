Received: from eggs.gnu.org ([2001:4830:134:3::10]:56748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXrbS-0000zD-Nd
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXrbR-0007lb-Tc
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:18:06 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXrbR-0007lK-Fa
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:18:05 -0400
Received: by mail-oi0-x243.google.com with SMTP id h79-v6so16710015oig.13
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 10:18:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529374119-27015-1-git-send-email-linux@roeck-us.net>
References: <1529374119-27015-1-git-send-email-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 18:17:44 +0100
Message-ID: <CAFEAcA_8TAWdkgTzPPE7eggP4UAHjVPmcXiEa_-RCxDBphJ4HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/char/cmsdk-apb-timer: Correctly
 identify and set one-shot mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 19 June 2018 at 03:08, Guenter Roeck <linux@roeck-us.net> wrote:
> The CMSDK APB timer is currently always configured as periodic timer.
> This results in the following messages when trying to boot Linux.
>
> Timer with delta zero, disabling
>
> If the timer limit set with the RELOAD command is 0, the timer
> needs to be enabled as one-shot timer.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/timer/cmsdk-apb-timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
> index 9878746..79c1b49 100644
> --- a/hw/timer/cmsdk-apb-timer.c
> +++ b/hw/timer/cmsdk-apb-timer.c
> @@ -119,7 +119,7 @@ static void cmsdk_apb_timer_write(void *opaque, hwaddr offset, uint64_t value,
>          }
>          s->ctrl = value & 0xf;
>          if (s->ctrl & R_CTRL_EN_MASK) {
> -            ptimer_run(s->timer, 0);
> +            ptimer_run(s->timer, ptimer_get_limit(s->timer) == 0);
>          } else {
>              ptimer_stop(s->timer);
>          }
> --
> 2.7.4

Thanks for this patch. I was wondering whether it would be better
just to remove the fprintf message instead. I'll either apply
this or send a patch to do that before 3.0, anyway.

I think we also want to make sure we convert back to a
periodic timer if the reload register is written with a nonzero
value before the timer expires (and that if that happens after
the timer expired that we restart the timer). Thinking about
this is also on my todo list.

-- PMM
