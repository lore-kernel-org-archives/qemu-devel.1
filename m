Received: from eggs.gnu.org ([208.118.235.92]:59842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbkI1-0004VZ-Ek
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 05:50:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbkHv-00007m-PW
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 05:50:21 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbkHu-00005L-Bf
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 05:50:15 -0500
Received: by mail-wm1-x344.google.com with SMTP id f81so13339833wmd.4
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 02:50:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<1415d73f73787a48532cc6cdd3c2a5a0c2e02e2f.1545598229.git.DirtY.iCE.hu@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a2d562e5-99fa-02de-94d3-3b39f78d3148@amsat.org>
Date: Tue, 25 Dec 2018 11:50:11 +0100
MIME-Version: 1.0
In-Reply-To: <1415d73f73787a48532cc6cdd3c2a5a0c2e02e2f.1545598229.git.DirtY.iCE.hu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 52/52] usbaudio: change playback
 counters to 64 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 12/23/18 9:52 PM, Kővágó, Zoltán wrote:
> With stereo playback, they need about 375 minutes of continuous audio
> playback to overflow, which is usually not a problem (as stopping and
> later resuming playback resets the counters).  But with 7.1 audio, they
> only need about 95 minutes to overflow.
> 
> After the overflow, the buf->prod % USBAUDIO_PACKET_SIZE(channels)
> assertion no longer holds true, which will result in overflowing the
> buffer.  With 64 bit variables, it would take about 762000 years to
> overflow.
> 
> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
> ---
>  hw/usb/dev-audio.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
> index 29475a2b70..45ffc3ebb3 100644
> --- a/hw/usb/dev-audio.c
> +++ b/hw/usb/dev-audio.c
> @@ -577,9 +577,9 @@ static const USBDesc desc_audio_multi = {
>  
>  struct streambuf {
>      uint8_t *data;
> -    uint32_t size;
> -    uint32_t prod;
> -    uint32_t cons;
> +    size_t size;
> +    uint64_t prod;
> +    uint64_t cons;

OK.

>  };
>  
>  static void streambuf_init(struct streambuf *buf, uint32_t size,
> @@ -600,12 +600,14 @@ static void streambuf_fini(struct streambuf *buf)
>  
>  static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
>  {
> -    uint32_t free = buf->size - (buf->prod - buf->cons);
> +    uint64_t free = buf->size - (buf->prod - buf->cons);

I'd use ssize_t here.

>  
>      if (free < USBAUDIO_PACKET_SIZE(channels)) {
>          return 0;
>      }
>  
> +    /* can happen if prod overflows */
> +    assert(buf->prod % USBAUDIO_PACKET_SIZE(channels) == 0);
>      usb_packet_copy(p, buf->data + (buf->prod % buf->size),
>                      USBAUDIO_PACKET_SIZE(channels));
>      buf->prod += USBAUDIO_PACKET_SIZE(channels);
> @@ -614,7 +616,7 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
>  
>  static uint8_t *streambuf_get(struct streambuf *buf, size_t *len)
>  {
> -    uint32_t used = buf->prod - buf->cons;
> +    uint64_t used = buf->prod - buf->cons;
>      uint8_t *data;
>  
>      if (!used) {

Eventually here:

    ssize_t used = buf->prod - buf->cons;

    if (used <= 0) {
        return NULL;
    }
