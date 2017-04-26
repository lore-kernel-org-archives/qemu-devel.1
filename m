Received: from eggs.gnu.org ([2001:4830:134:3::10]:53200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d3C3M-0001o0-Ri
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 21:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d3C3J-0000e3-ML
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 21:47:36 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d3C3J-0000dl-GU
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 21:47:33 -0400
Received: by mail-qt0-x242.google.com with SMTP id t52so27851079qtb.3
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 18:47:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170425223739.6703-1-quintela@redhat.com>
	<20170425223739.6703-20-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <08d6f162-7272-3335-85ff-bc123142433f@amsat.org>
Date: Tue, 25 Apr 2017 22:47:28 -0300
MIME-Version: 1.0
In-Reply-To: <20170425223739.6703-20-quintela@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/26] audio: GUSsample is int16_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Hi Juan,

Same here, why not squashing as "Use stdint instead of dead GUSEMU32"?

On 04/25/2017 07:37 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/audio/gus.c          |  2 +-
>  hw/audio/gusemu.h       | 12 +-----------
>  hw/audio/gusemu_hal.c   |  2 +-
>  hw/audio/gusemu_mixer.c |  8 ++++----
>  4 files changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/hw/audio/gus.c b/hw/audio/gus.c
> index 3d08a65..ec103a4 100644
> --- a/hw/audio/gus.c
> +++ b/hw/audio/gus.c
> @@ -53,7 +53,7 @@ typedef struct GUSState {
>      uint32_t freq;
>      uint32_t port;
>      int pos, left, shift, irqs;
> -    GUSsample *mixbuf;
> +    int16_t *mixbuf;
>      uint8_t himem[1024 * 1024 + 32 + 4096];
>      int samples;
>      SWVoiceOut *voice;
> diff --git a/hw/audio/gusemu.h b/hw/audio/gusemu.h
> index 69dadef..ab591ee 100644
> --- a/hw/audio/gusemu.h
> +++ b/hw/audio/gusemu.h
> @@ -25,16 +25,6 @@
>  #ifndef GUSEMU_H
>  #define GUSEMU_H
>
> -/* data types (need to be adjusted if neither a VC6 nor a C99 compatible compiler is used) */
> -
> -#if defined _WIN32 && defined _MSC_VER /* doesn't support other win32 compilers yet, do it yourself... */
> - typedef unsigned int GUSdword;
> - typedef signed short GUSsample;
> -#else
> - typedef uint32_t GUSdword;
> - typedef int16_t GUSsample;
> -#endif
> -
>  typedef struct _GUSEmuState
>  {
>   uint8_t *himemaddr; /* 1024*1024 bytes used for storing uploaded samples (+32 additional bytes for read padding) */
> @@ -86,7 +76,7 @@ void gus_dma_transferdata(GUSEmuState *state, char *dma_addr, unsigned int count
>  /* If the interrupts are asynchronous, it may be needed to use a separate thread mixing into a temporary */
>  /* audio buffer in order to avoid quality loss caused by large numsamples and elapsed_time values. */
>
> -void gus_mixvoices(GUSEmuState *state, unsigned int playback_freq, unsigned int numsamples, GUSsample *bufferpos);
> +void gus_mixvoices(GUSEmuState *state, unsigned int playback_freq, unsigned int numsamples, int16_t *bufferpos);
>  /* recommended range: 10 < numsamples < 100 */
>  /* lower values may result in increased rounding error, higher values often cause audible timing delays */
>
> diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
> index 3dd7239..1150fc4 100644
> --- a/hw/audio/gusemu_hal.c
> +++ b/hw/audio/gusemu_hal.c
> @@ -32,7 +32,7 @@
>
>  #define GUSregb(position) (*            (gusptr+(position)))
>  #define GUSregw(position) (*(uint16_t *) (gusptr+(position)))
> -#define GUSregd(position) (*(GUSdword *)(gusptr+(position)))
> +#define GUSregd(position) (*(uint16_t *)(gusptr+(position)))
>
>  /* size given in bytes */
>  unsigned int gus_read(GUSEmuState * state, int port, int size)
> diff --git a/hw/audio/gusemu_mixer.c b/hw/audio/gusemu_mixer.c
> index 981a9ae..00b9861 100644
> --- a/hw/audio/gusemu_mixer.c
> +++ b/hw/audio/gusemu_mixer.c
> @@ -28,13 +28,13 @@
>
>  #define GUSregb(position)  (*            (gusptr+(position)))
>  #define GUSregw(position)  (*(uint16_t *) (gusptr+(position)))
> -#define GUSregd(position)  (*(GUSdword *)(gusptr+(position)))
> +#define GUSregd(position)  (*(uint16_t *)(gusptr+(position)))
>
>  #define GUSvoice(position) (*(uint16_t *)(voiceptr+(position)))
>
>  /* samples are always 16bit stereo (4 bytes each, first right then left interleaved) */
>  void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int numsamples,
> -                   GUSsample *bufferpos)
> +                   int16_t *bufferpos)
>  {
>      /* note that byte registers are stored in the upper half of each voice register! */
>      uint8_t        *gusptr;
> @@ -171,8 +171,8 @@ void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int
>                  }
>
>                  /* mix samples into buffer */
> -                *(bufferpos + 2 * sample)     += (GUSsample) ((sample1 * PanningPos) >> 4);        /* right */
> -                *(bufferpos + 2 * sample + 1) += (GUSsample) ((sample1 * (15 - PanningPos)) >> 4); /* left */
> +                *(bufferpos + 2 * sample)     += (int16_t) ((sample1 * PanningPos) >> 4);        /* right */
> +                *(bufferpos + 2 * sample + 1) += (int16_t) ((sample1 * (15 - PanningPos)) >> 4); /* left */
>              }
>              /* write back voice and volume */
>              GUSvoice(wVSRCurrVol)   = Volume32 / 32;
>
