Received: from eggs.gnu.org ([209.51.188.92]:37965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1hB6Je-0002Uo-TG
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 19:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1hB6Jd-0008Uo-LH
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 19:26:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1hB6JS-0008NW-Hs
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 19:26:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id y13so14188814wrd.3
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 16:25:54 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::c9?
	(2a01-036c-0113-47b9-0001-0000-0000-00c9.pool6.digikabel.hu.
	[2a01:36c:113:47b9:1::c9]) by smtp.gmail.com with ESMTPSA id
	61sm41589869wre.50.2019.04.01.16.25.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 01 Apr 2019 16:25:52 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <90b95e4f-39ef-2b01-da6a-857ebaee1ec5@t-online.de>
Message-ID: <c686741e-9dc6-97d4-5587-6fb8b0d0cabc@gmail.com>
Date: Tue, 2 Apr 2019 01:25:50 +0200
MIME-Version: 1.0
In-Reply-To: <90b95e4f-39ef-2b01-da6a-857ebaee1ec5@t-online.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] audio: fix audio timer rate conversion bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 2019-04-01 20:59, Volker Rümelin wrote:
> Currently the default audio timer frequency is 10000Hz instead of
> a period of 10000us. Also the audiodev timer-period property gets
> converted like a frequency. Only handling of the legacy
> QEMU_AUDIO_TIMER_PERIOD environment variable is correct because
> it's actually a frequency.
> 
> With this patch the property timer-period is really a timer period
> and QEMU_AUDIO_TIMER_PERIOD remains a frequency.

Good catch!  The legacy config used Hz, frames, bytes, milliseconds and
microseconds quite randomly to define lengths, this one slipped through
my unification attempts.

> 
> This fixes commit 71830221fb23388b32e6516c2fb7a698453a6c5a
> -audiodev command line option basic implementation.
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Zoltán Kővágó <DirtY.iCE.hu@gmail.com>

> ---
>  audio/audio.c        | 2 +-
>  audio/audio_legacy.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index 5fd9a58a80..2040762fef 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1471,7 +1471,7 @@ static int audio_init(Audiodev *dev)
>      if (dev->timer_period <= 0) {
>          s->period_ticks = 1;
>      } else {
> -        s->period_ticks = NANOSECONDS_PER_SECOND / dev->timer_period;
> +        s->period_ticks = dev->timer_period * SCALE_US;
>      }
>  
>      e = qemu_add_vm_change_state_handler (audio_vm_change_state_handler, s);
> diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
> index 6d140119d9..2fd58cb8ef 100644
> --- a/audio/audio_legacy.c
> +++ b/audio/audio_legacy.c
> @@ -26,6 +26,7 @@
>  #include "audio_int.h"
>  #include "qemu-common.h"
>  #include "qemu/cutils.h"
> +#include "qemu/timer.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-audio.h"
>  #include "qapi/visitor-impl.h"
> @@ -338,8 +339,13 @@ static AudiodevListEntry *legacy_opt(const char *drvname)
>      handle_per_direction(audio_get_pdo_in(e->dev), "QEMU_AUDIO_ADC_");
>      handle_per_direction(audio_get_pdo_out(e->dev), "QEMU_AUDIO_DAC_");
>  
> +    /* Original description: Timer period in HZ (0 - use lowest possible) */
>      get_int("QEMU_AUDIO_TIMER_PERIOD",
>              &e->dev->timer_period, &e->dev->has_timer_period);
> +    if (e->dev->has_timer_period && e->dev->timer_period) {
> +        e->dev->timer_period = NANOSECONDS_PER_SECOND / 1000 /
> +                               e->dev->timer_period;
> +    }

I'd use SCALE_US instead of 1000 here.  If you have
NANOSECONDS_PER_SECOND / SCALE_US / e->dev->timer_period, it's
immediately obvious that if you multiply it with SCALE_US, you get back
the old value of s->period_ticks above.

>  
>      switch (e->dev->driver) {
>      case AUDIODEV_DRIVER_ALSA:
> 

Regards,
Zoltan
