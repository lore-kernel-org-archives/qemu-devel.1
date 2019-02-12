Received: from eggs.gnu.org ([209.51.188.92]:58569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtWs3-0000Xp-8p
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtWs2-0004PL-47
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:09:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtWs1-0004MK-Qt
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:09:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so2363054wrt.13
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 04:09:01 -0800 (PST)
References: <20190124132020.13571-1-kraxel@redhat.com>
	<20190124132020.13571-2-kraxel@redhat.com>
	<c0234a17-4e50-5fe2-4b88-6cf133c43347@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <78b29e41-f1fa-9e88-e124-e91f2a3d9dc4@redhat.com>
Date: Tue, 12 Feb 2019 13:08:58 +0100
MIME-Version: 1.0
In-Reply-To: <c0234a17-4e50-5fe2-4b88-6cf133c43347@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 1/7] audio: fix pc speaker init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>

Hi David,

On 2/12/19 12:47 PM, David Hildenbrand wrote:
> On 24.01.19 14:20, Gerd Hoffmann wrote:
>> Get rid of the pcspk_state global, allow pc speaker
>> be added using "-device isa-pcspk".
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Message-id: 20190124110810.1040-1-kraxel@redhat.com
>> ---
>>  hw/audio/pcspk.c | 35 +++++++++++++++--------------------
>>  1 file changed, 15 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
>> index 908696d483..b80a62ce90 100644
>> --- a/hw/audio/pcspk.c
>> +++ b/hw/audio/pcspk.c
>> @@ -57,7 +57,6 @@ typedef struct {
>>  } PCSpkState;
>>  
>>  static const char *s_spk = "pcspk";
>> -static PCSpkState *pcspk_state;
>>  
>>  static inline void generate_samples(PCSpkState *s)
>>  {
>> @@ -111,22 +110,6 @@ static void pcspk_callback(void *opaque, int free)
>>      }
>>  }
>>  
>> -static int pcspk_audio_init(ISABus *bus)
>> -{
>> -    PCSpkState *s = pcspk_state;
>> -    struct audsettings as = {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0};
>> -
>> -    AUD_register_card(s_spk, &s->card);
>> -
>> -    s->voice = AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback, &as);
>> -    if (!s->voice) {
>> -        AUD_log(s_spk, "Could not open voice\n");
>> -        return -1;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>>  static uint64_t pcspk_io_read(void *opaque, hwaddr addr,
>>                                unsigned size)
>>  {
>> @@ -179,12 +162,20 @@ static void pcspk_initfn(Object *obj)
>>  
>>  static void pcspk_realizefn(DeviceState *dev, Error **errp)
>>  {
>> +    struct audsettings as = {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0};
>>      ISADevice *isadev = ISA_DEVICE(dev);
>>      PCSpkState *s = PC_SPEAKER(dev);
>>  
>>      isa_register_ioport(isadev, &s->ioport, s->iobase);
>>  
>> -    pcspk_state = s;
>> +    AUD_register_card(s_spk, &s->card);
>> +
>> +    s->voice = AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback, &as);
>> +    if (!s->voice) {
>> +        error_setg(errp, "Initializing audio voice failed");
>> +        AUD_remove_card(&s->card);
>> +        return;
>> +    }
>>  }
>>  
>>  static bool migrate_needed(void *opaque)
>> @@ -221,8 +212,6 @@ static void pcspk_class_initfn(ObjectClass *klass, void *data)
>>      set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
>>      dc->vmsd = &vmstate_spk;
>>      dc->props = pcspk_properties;
>> -    /* Reason: realize sets global pcspk_state */
>> -    dc->user_creatable = false;
>>  }
>>  
>>  static const TypeInfo pcspk_info = {
>> @@ -233,6 +222,12 @@ static const TypeInfo pcspk_info = {
>>      .class_init     = pcspk_class_initfn,
>>  };
>>  
>> +static int pcspk_audio_init(ISABus *bus)
>> +{
>> +    isa_create_simple(bus, TYPE_PC_SPEAKER);
>> +    return 0;
>> +}
>> +
>>  static void pcspk_register(void)
>>  {
>>      type_register_static(&pcspk_info);
>>
> 
> I suddenly get (under fedora 28)
> 
> ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
> Connection refused
> 
> alsa: Could not initialize DAC
> alsa: Failed to open `default':
> alsa: Reason: Connection refused
> ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
> Connection refused
> 
> alsa: Could not initialize DAC
> alsa: Failed to open `default':
> alsa: Reason: Connection refused

This ALSA problem seems on your side.

> audio: Failed to create voice `pcspk'
> qemu-system-x86_64: Initialization of device isa-pcspk failed:
> Initializing audio voice failed

Previously the errors would be ignored and QEMU would start.

> 
> 
> With
> 
> sudo x86_64-softmmu/qemu-system-x86_64 \
>     --enable-kvm \
>     -m 4G,maxmem=40G,slots=2 \
>     -smp sockets=2,cores=2 \
>     -numa node,nodeid=0,cpus=0-1 -numa node,nodeid=1,cpus=2-3 \
>     -kernel /boot/vmlinuz-4.19.6-200.fc28.x86_64 \
>     -append "console=ttyS0 rd.shell rd.luks=0 rd.lvm=0 rd.md=0 rd.dm=0" \
>     -initrd /boot/initramfs-4.19.6-200.fc28.x86_64.img \
>     -machine pc,nvdimm \
>     -nographic \
>     -nodefaults \
>     -chardev stdio,id=serial \
>     --trace events=to_trace \
>     -device isa-serial,chardev=serial \
>     -chardev socket,id=monitor,path=/var/tmp/monitor,server,nowait \
>     -mon chardev=monitor,mode=readline
> 
> 
> Could this be related to this patch? (or is maybe something about my
> system messed up? will try rebooting, but other audio - e.g. via firefox
> - works fine)

Does your Firefox uses ALSA? The default install uses PulseAudio.

I think the behavior change you are experiencing comes from the patch 7
of this series "audio: probe audio drivers by default":

@@ -879,7 +879,7 @@
 Linux)
-  audio_drv_list="oss"
+  audio_drv_list="try-pa try-alsa try-sdl oss"

Previously you were using OSS, and how the ./configure found via
pkg-config that you have the ALSA libs installed, and use ALSA first.

Can you share the relevant part of the ./configure output?

Thanks,

Phil.
