Received: from eggs.gnu.org ([2001:4830:134:3::10]:45334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYD6A-0007Js-6q
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYD66-0004Is-TV
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:15:14 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:42657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYD66-0004Hv-N8
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:15:10 -0400
Received: by mail-qk0-x241.google.com with SMTP id u62-v6so1341280qkf.9
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 09:15:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180627111936.31019-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <980ced5f-cf5d-6a2b-067e-522276f9c5bd@amsat.org>
Date: Wed, 27 Jun 2018 13:15:06 -0300
MIME-Version: 1.0
In-Reply-To: <20180627111936.31019-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] audio/hda: drop atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On 06/27/2018 08:19 AM, Gerd Hoffmann wrote:
> Doesn't build on 32bit clang.  And because we run under qemu mutex
> anyway they are not needed.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/audio/hda-codec.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index 8a8214de74..a4e24b919d 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -18,7 +18,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/atomic.h"
>  #include "hw/hw.h"
>  #include "hw/pci/pci.h"
>  #include "intel-hda.h"
> @@ -212,7 +211,7 @@ static inline void hda_timer_sync_adjust(HDAAudioStream *st, int64_t target_pos)
>      }
>  
>      trace_hda_audio_adjust(st->node->name, target_pos);
> -    atomic_fetch_add(&st->buft_start, corr);
> +    st->buft_start += corr;
>  }
>  
>  static void hda_audio_input_timer(void *opaque)
> @@ -221,9 +220,9 @@ static void hda_audio_input_timer(void *opaque)
>  
>      int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>  
> -    int64_t buft_start = atomic_fetch_add(&st->buft_start, 0);
> -    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
> -    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
> +    int64_t buft_start = st->buft_start;
> +    int64_t wpos = st->wpos;
> +    int64_t rpos = st->rpos;
>  
>      int64_t wanted_rpos = hda_bytes_per_second(st) * (now - buft_start)
>                            / NANOSECONDS_PER_SECOND;
> @@ -245,7 +244,7 @@ static void hda_audio_input_timer(void *opaque)
>          }
>          rpos += chunk;
>          to_transfer -= chunk;
> -        atomic_fetch_add(&st->rpos, chunk);
> +        st->rpos += chunk;
>      }
>  
>  out_timer:
> @@ -259,8 +258,8 @@ static void hda_audio_input_cb(void *opaque, int avail)
>  {
>      HDAAudioStream *st = opaque;
>  
> -    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
> -    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
> +    int64_t wpos = st->wpos;
> +    int64_t rpos = st->rpos;
>  
>      int64_t to_transfer = audio_MIN(B_SIZE - (wpos - rpos), avail);
>  
> @@ -272,7 +271,7 @@ static void hda_audio_input_cb(void *opaque, int avail)
>          uint32_t read = AUD_read(st->voice.in, st->buf + start, chunk);
>          wpos += read;
>          to_transfer -= read;
> -        atomic_fetch_add(&st->wpos, read);
> +        st->wpos += read;
>          if (chunk != read) {
>              break;
>          }
> @@ -285,9 +284,9 @@ static void hda_audio_output_timer(void *opaque)
>  
>      int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>  
> -    int64_t buft_start = atomic_fetch_add(&st->buft_start, 0);
> -    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
> -    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
> +    int64_t buft_start = st->buft_start;
> +    int64_t wpos = st->wpos;
> +    int64_t rpos = st->rpos;
>  
>      int64_t wanted_wpos = hda_bytes_per_second(st) * (now - buft_start)
>                            / NANOSECONDS_PER_SECOND;
> @@ -309,7 +308,7 @@ static void hda_audio_output_timer(void *opaque)
>          }
>          wpos += chunk;
>          to_transfer -= chunk;
> -        atomic_fetch_add(&st->wpos, chunk);
> +        st->wpos += chunk;
>      }
>  
>  out_timer:
> @@ -323,8 +322,8 @@ static void hda_audio_output_cb(void *opaque, int avail)
>  {
>      HDAAudioStream *st = opaque;
>  
> -    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
> -    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
> +    int64_t wpos = st->wpos;
> +    int64_t rpos = st->rpos;
>  
>      int64_t to_transfer = audio_MIN(wpos - rpos, avail);
>  
> @@ -345,7 +344,7 @@ static void hda_audio_output_cb(void *opaque, int avail)
>          uint32_t written = AUD_write(st->voice.out, st->buf + start, chunk);
>          rpos += written;
>          to_transfer -= written;
> -        atomic_fetch_add(&st->rpos, written);
> +        st->rpos += written;
>          if (chunk != written) {
>              break;
>          }
> 
