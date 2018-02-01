Received: from eggs.gnu.org ([2001:4830:134:3::10]:50532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehG05-0006aZ-9E
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehG02-0008JM-35
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:38:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehG01-0008IR-Pj
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:38:01 -0500
Date: Thu, 1 Feb 2018 15:37:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180201143725.drfydnbyfpzinsim@sirius.home.kraxel.org>
References: <20180201133347.3146-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201133347.3146-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/audio/sb16.c: change dolog() to
 qemu_log_mask()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, Feb 01, 2018 at 08:33:47AM -0500, John Arbuckle wrote:
> Changes all the occurrances of dolog() to qemu_log_mask().

When looking over them it looks like we should not just switch them over
the same way, but try to categorize them a bit better ...

> +#include "qemu/log.h"
>  
>  #define dolog(...) AUD_log ("sb16", __VA_ARGS__)
>  
> @@ -123,7 +124,7 @@ static int magic_of_irq (int irq)
>      case 10:
>          return 8;
>      default:
> -        dolog ("bad irq %d\n", irq);
> +        qemu_log_mask(LOG_UNIMP, "bad irq %d\n", irq);
>          return 2;
>      }
>  }
> @@ -140,7 +141,7 @@ static int irq_of_magic (int magic)
>      case 8:
>          return 10;
>      default:
> -        dolog ("bad irq magic %d\n", magic);
> +        qemu_log_mask(LOG_UNIMP, "bad irq magic %d\n", magic);

These two look more like a case of LOG_GUEST_ERROR to me.

>      if (s->block_size & s->align) {
> -        dolog ("warning: misaligned block size %d, alignment %d\n",
> -               s->block_size, s->align + 1);
> +        qemu_log_mask(LOG_UNIMP, "warning: misaligned block size %d, alignment"
> +                      " %d\n", s->block_size, s->align + 1);

This too.

> -        dolog ("warning: misaligned block size %d, alignment %d\n",
> -               s->block_size, s->align + 1);
> +        qemu_log_mask(LOG_UNIMP, "warning: misaligned block size %d, alignment"
> +                      " %d\n", s->block_size, s->align + 1);

And this.

>      else {
> -        dolog ("buffer underflow\n");
> +        qemu_log_mask(LOG_UNIMP, "buffer underflow\n");

Trace point?

> -            dolog ("ADC not yet supported (command %#x)\n", cmd);
> +            qemu_log_mask(LOG_UNIMP, "ADC not yet supported (command %#x)\n",
> +                          cmd);

OK, that is a pretty clear case for LOG_UNIMP.

>          default:
> -            dolog ("%#x wrong bits\n", cmd);
> +            qemu_log_mask(LOG_UNIMP, "%#x wrong bits\n", cmd);

LOG_GUEST_ERROR too?

> -            dolog ("0x35 - MIDI command not implemented\n");
> +            qemu_log_mask(LOG_UNIMP, "0x35 - MIDI command not implemented\n");

> -            dolog ("0x75 - DMA DAC, 4-bit ADPCM not implemented\n");
> +            qemu_log_mask(LOG_UNIMP, "0x75 - DMA DAC, 4-bit ADPCM not"
> +                          " implemented\n");

> -            dolog ("0x74 - DMA DAC, 4-bit ADPCM Reference not implemented\n");
> +            qemu_log_mask(LOG_UNIMP, "0x74 - DMA DAC, 4-bit ADPCM Reference not"
> +                          " implemented\n");

> -            dolog ("0x74 - DMA DAC, 2.6-bit ADPCM not implemented\n");
> +            qemu_log_mask(LOG_UNIMP, "0x74 - DMA DAC, 2.6-bit ADPCM not"
> +                          " implemented\n");

> -            dolog ("0x74 - DMA DAC, 2.6-bit ADPCM Reference not implemented\n");
> +            qemu_log_mask(LOG_UNIMP, "0x74 - DMA DAC, 2.6-bit ADPCM Reference"
> +                          " not implemented\n");

> -            dolog ("0x7d - Autio-Initialize DMA DAC, 4-bit ADPCM Reference\n");
> -            dolog ("not implemented\n");
> +            qemu_log_mask(LOG_UNIMP, "0x7d - Autio-Initialize DMA DAC, 4-bit"
> +                          " ADPCM Reference\n");
> +            qemu_log_mask(LOG_UNIMP, "not implemented\n");

> -            dolog (
> -                "0x7d - Autio-Initialize DMA DAC, 2.6-bit ADPCM Reference\n"
> -                );
> -            dolog ("not implemented\n");
> +            qemu_log_mask(LOG_UNIMP, "0x7d - Autio-Initialize DMA DAC, 2.6-bit"
> +                          " ADPCM Reference\n");
> +            qemu_log_mask(LOG_UNIMP, "not implemented\n");

All OK.

>          case 0xe7:
> -            dolog ("Attempt to probe for ESS (0xe7)?\n");
> +            qemu_log_mask(LOG_UNIMP, "Attempt to probe for ESS (0xe7)?\n");

Hmm, not clear whenever qemu warns here because ESS isn't implemented.
I think we can leave it that way for now.

> -            dolog ("Unrecognized command %#x\n", cmd);
> +            qemu_log_mask(LOG_UNIMP, "Unrecognized command %#x\n", cmd);

OK.

> -    dolog ("warning: command %#x,%d is not truly understood yet\n",
> -           cmd, s->needed_bytes);
> +    qemu_log_mask(LOG_UNIMP, "warning: command %#x,%d is not truly understood"
> +                  " yet\n", cmd, s->needed_bytes);

OK.

>          if (s->cmd & 8) {
> -            dolog ("ADC params cmd = %#x d0 = %d, d1 = %d, d2 = %d\n",
> -                   s->cmd, d0, d1, d2);
> +            qemu_log_mask(LOG_UNIMP, "ADC params cmd = %#x d0 = %d, d1 = %d,"
> +                          " d2 = %d\n", s->cmd, d0, d1, d2);

Trace point?

>          case 0x10:
>              d0 = dsp_get_data (s);
> -            dolog ("cmd 0x10 d0=%#x\n", d0);
> +            qemu_log_mask(LOG_UNIMP, "cmd 0x10 d0=%#x\n", d0);

Trace point?

>          case 0x42:              /* FT2 sets output freq with this, go figure */
> -#if 0
> -            dolog ("cmd 0x42 might not do what it think it should\n");
> -#endif
> +            qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
> +                          " should\n");

Also not fully clear what the reason for this cryptic message is.
Could be incomplete emulation, could also be something else.
Lets keep LOG_UNIMP for now.

>          case 0xe2:
> -#ifdef DEBUG
>              d0 = dsp_get_data (s);
> -            dolog ("E2 = %#x\n", d0);
> -#endif
> +            qemu_log_mask(LOG_UNIMP, "E2 = %#x\n", d0);

Trace point?

>          default:
> -            dolog ("complete: unrecognized command %#x\n", s->cmd);
> +            qemu_log_mask(LOG_UNIMP, "complete: unrecognized command %#x\n",
> +                          s->cmd);

OK.

> -                dolog ("in data overrun\n");
> +                qemu_log_mask(LOG_UNIMP, "in data overrun\n");

Trace point?

> -                dolog ("empty output buffer for command %#x\n",
> -                       s->cmd);
> +                qemu_log_mask(LOG_UNIMP, "empty output buffer for command"
> +                              " %#x\n", s->cmd);

Trace point?

> -        /* dolog ("timer interrupt clear\n"); */
> +        /* qemu_log_mask(LOG_UNIMP, "timer interrupt clear\n"); */

Trace point?  Also uncomment ...

> -    dolog ("warning: dsp_read %#x error\n", nport);
> +    qemu_log_mask(LOG_UNIMP, "warning: dsp_read %#x error\n", nport);

Trace point?

> -                dolog (
> -                    "attempt to change DMA "
> -                    "8bit %d(%d), 16bit %d(%d) (val=%#x)\n",
> -                    dma, s->dma, hdma, s->hdma, val);
> +                qemu_log_mask(LOG_UNIMP, "attempt to change DMA 8bit %d(%d),"
> +                              " 16bit %d(%d) (val=%#x)\n", dma, s->dma, hdma,
> +                              s->hdma, val);

Hmm.  Trace point?  Could also be a case of LOG_GUEST_ERROR.

> -        dolog ("attempt to write into IRQ status register (val=%#x)\n",
> -               val);
> +        qemu_log_mask(LOG_UNIMP, "attempt to write into IRQ status register"
> +                      " (val=%#x)\n", val);

Looks like LOG_GUEST_ERROR to me.

>      if (s->block_size <= 0) {
> -        dolog ("invalid block size=%d nchan=%d dma_pos=%d dma_len=%d\n",
> -               s->block_size, nchan, dma_pos, dma_len);
> +        qemu_log_mask(LOG_UNIMP, "invalid block size=%d nchan=%d dma_pos=%d"
> +                      " dma_len=%d\n", s->block_size, nchan, dma_pos, dma_len);

Probably LOG_GUEST_ERROR too.

> -#ifdef DEBUG_SB16_MOST
> -    dolog ("pos:%06d %d till:%d len:%d\n",
> -           dma_pos, free, till, dma_len);
> -#endif
> +    qemu_log_mask(LOG_UNIMP, "pos:%06d %d till:%d len:%d\n", dma_pos, free,
> +                  till, dma_len);

Trace point?

> @@ -1376,7 +1377,7 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
>      reset_mixer (s);
>      s->aux_ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, aux_timer, s);
>      if (!s->aux_ts) {
> -        dolog ("warning: Could not create auxiliary timer\n");
> +        qemu_log_mask(LOG_UNIMP, "warning: Could not create auxiliary timer\n");

That's a case for error_setg().

cheers,
  Gerd
