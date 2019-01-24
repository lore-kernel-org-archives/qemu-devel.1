Received: from eggs.gnu.org ([209.51.188.92]:53783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmdBm-0007Pu-BL
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmdBk-0001GC-Cw
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:28:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmdBk-0001Ed-6E
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:28:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so2723175wmh.4
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 03:28:51 -0800 (PST)
References: <20190124110810.1040-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d7cd7d0e-3502-7845-cde7-34aa8a00f66e@redhat.com>
Date: Thu, 24 Jan 2019 12:28:48 +0100
MIME-Version: 1.0
In-Reply-To: <20190124110810.1040-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] audio: fix pc speaker init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Hi Gerd,

On 1/24/19 12:08 PM, Gerd Hoffmann wrote:
> Get rid of the pcspk_state global, allow pc speaker
> be added using "-device isa-pcspk".

It was not easy to figure what you changed since the discussion on the
v1, but I finally got it: 2 spaces were removed to please
checkpatch/patchew.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/audio/pcspk.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> index 908696d483..b80a62ce90 100644
> --- a/hw/audio/pcspk.c
> +++ b/hw/audio/pcspk.c
> @@ -57,7 +57,6 @@ typedef struct {
>  } PCSpkState;
>  
>  static const char *s_spk = "pcspk";
> -static PCSpkState *pcspk_state;
>  
>  static inline void generate_samples(PCSpkState *s)
>  {
> @@ -111,22 +110,6 @@ static void pcspk_callback(void *opaque, int free)
>      }
>  }
>  
> -static int pcspk_audio_init(ISABus *bus)
> -{
> -    PCSpkState *s = pcspk_state;
> -    struct audsettings as = {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0};
> -
> -    AUD_register_card(s_spk, &s->card);
> -
> -    s->voice = AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback, &as);
> -    if (!s->voice) {
> -        AUD_log(s_spk, "Could not open voice\n");
> -        return -1;
> -    }
> -
> -    return 0;
> -}
> -
>  static uint64_t pcspk_io_read(void *opaque, hwaddr addr,
>                                unsigned size)
>  {
> @@ -179,12 +162,20 @@ static void pcspk_initfn(Object *obj)
>  
>  static void pcspk_realizefn(DeviceState *dev, Error **errp)
>  {
> +    struct audsettings as = {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0};
>      ISADevice *isadev = ISA_DEVICE(dev);
>      PCSpkState *s = PC_SPEAKER(dev);
>  
>      isa_register_ioport(isadev, &s->ioport, s->iobase);
>  
> -    pcspk_state = s;
> +    AUD_register_card(s_spk, &s->card);
> +
> +    s->voice = AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback, &as);
> +    if (!s->voice) {
> +        error_setg(errp, "Initializing audio voice failed");
> +        AUD_remove_card(&s->card);
> +        return;
> +    }
>  }
>  
>  static bool migrate_needed(void *opaque)
> @@ -221,8 +212,6 @@ static void pcspk_class_initfn(ObjectClass *klass, void *data)
>      set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
>      dc->vmsd = &vmstate_spk;
>      dc->props = pcspk_properties;
> -    /* Reason: realize sets global pcspk_state */
> -    dc->user_creatable = false;
>  }
>  
>  static const TypeInfo pcspk_info = {
> @@ -233,6 +222,12 @@ static const TypeInfo pcspk_info = {
>      .class_init     = pcspk_class_initfn,
>  };
>  
> +static int pcspk_audio_init(ISABus *bus)
> +{
> +    isa_create_simple(bus, TYPE_PC_SPEAKER);
> +    return 0;
> +}
> +
>  static void pcspk_register(void)
>  {
>      type_register_static(&pcspk_info);
> 
