Received: from eggs.gnu.org ([2001:4830:134:3::10]:48988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egSQI-0000G8-Uq
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egSQB-00007P-6j
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:41:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egSQA-00005t-U4
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:41:43 -0500
Date: Tue, 30 Jan 2018 10:41:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180130094140.67xjf26jcymuz2bb@sirius.home.kraxel.org>
References: <20180130051837.8725-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130051837.8725-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/audio/sb16.c: Convert file to new
 logging API
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

> @@ -148,15 +142,16 @@ static int irq_of_magic (int magic)
>  #if 0
>  static void log_dsp (SB16State *dsp)
>  {
> -    ldebug ("%s:%s:%d:%s:dmasize=%d:freq=%d:const=%d:speaker=%d\n",
> -            dsp->fmt_stereo ? "Stereo" : "Mono",
> -            dsp->fmt_signed ? "Signed" : "Unsigned",
> -            dsp->fmt_bits,
> -            dsp->dma_auto ? "Auto" : "Single",
> -            dsp->block_size,
> -            dsp->freq,
> -            dsp->time_const,
> -            dsp->speaker);
> +    qemu_log_mask(LOG_UNIMP, "%s:%s:%d:%s:dmasize=%d:freq=%d:const=%d:"
> +                  "speaker=%d\n",
> +                  dsp->fmt_stereo ? "Stereo" : "Mono",
> +                  dsp->fmt_signed ? "Signed" : "Unsigned",
> +                  dsp->fmt_bits,
> +                  dsp->dma_auto ? "Auto" : "Single",
> +                  dsp->block_size,
> +                  dsp->freq,
> +                  dsp->time_const,
> +                  dsp->speaker);
>  }
>  #endif

Hmm, dead code.  Any places which call log_dsp() ?

>          case 0x42:              /* FT2 sets output freq with this, go figure */
>  #if 0
> -            dolog ("cmd 0x42 might not do what it think it should\n");
> +            qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
> +                          " should\n");
>  #endif

More dead code.

>          case 0xe2:
>  #ifdef DEBUG
>              d0 = dsp_get_data (s);
> -            dolog ("E2 = %#x\n", d0);
> +            qemu_log_mask(LOG_UNIMP, "E2 = %#x\n", d0);
>  #endif

Conditional code.  Enable this unconditionally, now that we can switch
the logging at runtime?

>  #ifndef DEBUG_SB16_MOST
>      if (s->mixer_nreg != 0x82) {
> -        ldebug ("mixer_read[%#x] -> %#x\n",
> -                s->mixer_nreg, s->mixer_regs[s->mixer_nreg]);
> +        qemu_log_mask(LOG_UNIMP, "mixer_read[%#x] -> %#x\n", s->mixer_nreg,
> +                      s->mixer_regs[s->mixer_nreg]);
>      }
>  #else
> -    ldebug ("mixer_read[%#x] -> %#x\n",
> -            s->mixer_nreg, s->mixer_regs[s->mixer_nreg]);
> +    qemu_log_mask(LOG_UNIMP, "mixer_read[%#x] -> %#x\n",
> +                  s->mixer_nreg, s->mixer_regs[s->mixer_nreg]);
>  #endif

Same question here.

>  #ifdef DEBUG_SB16_MOST
> -    dolog ("pos:%06d %d till:%d len:%d\n",
> -           dma_pos, free, till, dma_len);
> +    qemu_log_mask(LOG_UNIMP, "pos:%06d %d till:%d len:%d\n", dma_pos, free,
> +                  till, dma_len);
>  #endif

And here.

>  #ifdef DEBUG_SB16_MOST
> -    ldebug ("pos %5d free %5d size %5d till % 5d copy %5d written %5d size %5d\n",
> -            dma_pos, free, dma_len, s->left_till_irq, copy, written,
> -            s->block_size);
> +    qemu_log_mask(LOG_UNIMP, "pos %5d free %5d size %5d till % 5d copy %5d"
> +                  " written %5d size %5d\n", dma_pos, free, dma_len,
> +                  s->left_till_irq, copy, written, s->block_size);
>  #endif

Again.

cheers,
  Gerd
