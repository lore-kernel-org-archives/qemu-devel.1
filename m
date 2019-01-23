Received: from eggs.gnu.org ([209.51.188.92]:34275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmPec-0000XJ-KP
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmPeY-0000EW-K3
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:01:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmPeW-0000DM-Mv
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:01:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so4147756wrp.3
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:01:39 -0800 (PST)
References: <20190118122210.505-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2f82c614-882d-549d-be23-4a65d6e0d876@redhat.com>
Date: Wed, 23 Jan 2019 22:01:36 +0100
MIME-Version: 1.0
In-Reply-To: <20190118122210.505-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] audio: fix pc speaker init
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

On 1/18/19 1:22 PM, Gerd Hoffmann wrote:
> Get rid of the pcspk_state global, allow pc speaker
> be added using "-device isa-pcspk".
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/audio/pcspk.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> index 908696d483..acd80eb674 100644
> --- a/hw/audio/pcspk.c
> +++ b/hw/audio/pcspk.c
> @@ -57,7 +57,6 @@ typedef struct {
>  } PCSpkState;
>  
>  static const char *s_spk = "pcspk";
> -static PCSpkState *pcspk_state;

Yeah \o/

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

Too bad you fixed this message, it was funny :)

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
> +        error_setg (errp, "Initializing audio voice failed");
> +        AUD_remove_card (&s->card);
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
> +    isa_create_simple (bus, TYPE_PC_SPEAKER);
> +    return 0;

Previously we had soundhw_init() calling pcspk_audio_init() and ignore
failures. Now since you use isa_create_simple() which calls
qdev_init_nofail(), failure will directly exit(1).
Is it the expected behavior?

If not, we can keep the current behavior using:

       if (isa_try_create(bus, TYPE_PC_SPEAKER) == NULL) {
           return -1;
       }
       return 0;

Regards,

Phil.

> +}
> +
>  static void pcspk_register(void)
>  {
>      type_register_static(&pcspk_info);
> 
