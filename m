Received: from eggs.gnu.org ([2001:4830:134:3::10]:47223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1of-0006x3-RH
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1oa-0004Np-Tw
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:36:41 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:37563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1oa-0004Nh-OJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:36:36 -0400
Received: by mail-qk0-x22c.google.com with SMTP id t79-v6so8960842qke.4
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:36:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702161524.17268-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3aab127b-e1ad-149c-6949-d2eff312fbff@amsat.org>
Date: Mon, 2 Jul 2018 13:36:30 -0300
MIME-Version: 1.0
In-Reply-To: <20180702161524.17268-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] audio: add audio timer trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 07/02/2018 01:15 PM, Gerd Hoffmann wrote:
> Track audio timer starts and stops.  Also trace delayed audio timer calls.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  audio/audio.c      | 28 +++++++++++++++++++++++++---
>  audio/trace-events |  5 +++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index d6e91901aa..1ace47f510 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -29,6 +29,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/cutils.h"
>  #include "sysemu/replay.h"
> +#include "trace.h"
>  
>  #define AUDIO_CAP "audio"
>  #include "audio_int.h"
> @@ -1129,6 +1130,10 @@ static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
>  /*
>   * Timer
>   */
> +
> +static bool audio_timer_running;
> +static uint64_t audio_timer_last;
> +
>  static int audio_is_timer_needed (void)
>  {
>      HWVoiceIn *hwi = NULL;
> @@ -1148,14 +1153,31 @@ static void audio_reset_timer (AudioState *s)
>      if (audio_is_timer_needed ()) {
>          timer_mod_anticipate_ns(s->ts,
>              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
> -    }
> -    else {
> -        timer_del (s->ts);
> +        if (!audio_timer_running) {
> +            audio_timer_running = true;
> +            audio_timer_last = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +            trace_audio_timer_start(conf.period.ticks / SCALE_MS);

Thanks for the changes.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +        }
> +    } else {
> +        timer_del(s->ts);
> +        if (audio_timer_running) {
> +            audio_timer_running = false;
> +            trace_audio_timer_stop();
> +        }
>      }
>  }
>  
>  static void audio_timer (void *opaque)
>  {
> +    int64_t now, diff;
> +
> +    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    diff = now - audio_timer_last;
> +    if (diff > conf.period.ticks * 3 / 2) {
> +        trace_audio_timer_delayed(diff / SCALE_MS);
> +    }
> +    audio_timer_last = now;
> +
>      audio_run ("timer");
>      audio_reset_timer (opaque);
>  }
> diff --git a/audio/trace-events b/audio/trace-events
> index d37639e611..c986469319 100644
> --- a/audio/trace-events
> +++ b/audio/trace-events
> @@ -15,3 +15,8 @@ alsa_no_frames(int state) "No frames available and ALSA state is %d"
>  # audio/ossaudio.c
>  oss_version(int version) "OSS version = 0x%x"
>  oss_invalid_available_size(int size, int bufsize) "Invalid available size, size=%d bufsize=%d"
> +
> +# audio/audio.c
> +audio_timer_start(int interval) "interval %d ms"
> +audio_timer_stop(void) ""
> +audio_timer_delayed(int interval) "interval %d ms"
> 
