Received: from eggs.gnu.org ([2001:4830:134:3::10]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFgDj-0007MG-4C
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFgDg-00010B-1M
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:30:27 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:44993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFgDX-0000wk-KH
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:30:23 -0400
Received: by mail-qk0-x244.google.com with SMTP id z8so21826594qki.11
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 06:30:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180507094642.5909-1-kraxel@redhat.com>
	<20180507094642.5909-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d1d6d89c-3692-f84e-8b21-4f3557257045@amsat.org>
Date: Mon, 7 May 2018 10:30:11 -0300
MIME-Version: 1.0
In-Reply-To: <20180507094642.5909-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/4] audio/hda: turn some dprintfs into
 trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: martin@schrodt.org

On 05/07/2018 06:46 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Again:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/audio/hda-codec.c  | 9 ++++-----
>  hw/audio/trace-events | 4 ++++
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index 9ee2f3d55f..13d4473f18 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -24,6 +24,7 @@
>  #include "intel-hda.h"
>  #include "intel-hda-defs.h"
>  #include "audio/audio.h"
> +#include "trace.h"
>  
>  /* -------------------------------------------------------------------------- */
>  
> @@ -394,8 +395,7 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
>          return;
>      }
>      st->running = running;
> -    dprint(st->state, 1, "%s: %s (stream %d)\n", st->node->name,
> -           st->running ? "on" : "off", st->stream);
> +    trace_hda_audio_running(st->node->name, st->stream, st->running);
>      if (st->state->use_timer) {
>          if (running) {
>              int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> @@ -449,9 +449,8 @@ static void hda_audio_setup(HDAAudioStream *st)
>          return;
>      }
>  
> -    dprint(st->state, 1, "%s: format: %d x %s @ %d Hz\n",
> -           st->node->name, st->as.nchannels,
> -           fmt2name[st->as.fmt], st->as.freq);
> +    trace_hda_audio_format(st->node->name, st->as.nchannels,
> +                           fmt2name[st->as.fmt], st->as.freq);
>  
>      if (st->output) {
>          if (use_timer) {
> diff --git a/hw/audio/trace-events b/hw/audio/trace-events
> index fa1646d169..03340b9359 100644
> --- a/hw/audio/trace-events
> +++ b/hw/audio/trace-events
> @@ -17,3 +17,7 @@ milkymist_ac97_in_cb(int avail, uint32_t remaining) "avail %d remaining %u"
>  milkymist_ac97_in_cb_transferred(int transferred) "transferred %d"
>  milkymist_ac97_out_cb(int free, uint32_t remaining) "free %d remaining %u"
>  milkymist_ac97_out_cb_transferred(int transferred) "transferred %d"
> +
> +# hw/audio/hda-codec.c
> +hda_audio_running(const char *stream, int nr, bool running) "st %s, nr %d, run %d"
> +hda_audio_format(const char *stream, int chan, const char *fmt, int freq) "st %s, %d x %s @ %d Hz"
> 
