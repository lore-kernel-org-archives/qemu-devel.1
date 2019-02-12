Received: from eggs.gnu.org ([209.51.188.92]:42973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtXHF-0005Ht-Ma
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:35:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtX7k-0003jq-Au
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:25:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gtX7j-0003gJ-R0
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:25:16 -0500
From: David Hildenbrand <david@redhat.com>
References: <20190124132020.13571-1-kraxel@redhat.com>
	<20190124132020.13571-2-kraxel@redhat.com>
	<c0234a17-4e50-5fe2-4b88-6cf133c43347@redhat.com>
	<78b29e41-f1fa-9e88-e124-e91f2a3d9dc4@redhat.com>
	<d068cf4a-f191-820c-032d-5e70caa999ce@redhat.com>
Message-ID: <d53d221e-3f5f-3854-c44f-bf310237d1c9@redhat.com>
Date: Tue, 12 Feb 2019 13:25:08 +0100
MIME-Version: 1.0
In-Reply-To: <d068cf4a-f191-820c-032d-5e70caa999ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 1/7] audio: fix pc speaker init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>

On 12.02.19 13:20, David Hildenbrand wrote:
> On 12.02.19 13:08, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi David,
>>
>> On 2/12/19 12:47 PM, David Hildenbrand wrote:
>>> On 24.01.19 14:20, Gerd Hoffmann wrote:
>>>> Get rid of the pcspk_state global, allow pc speaker
>>>> be added using "-device isa-pcspk".
>>>>
>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> Message-id: 20190124110810.1040-1-kraxel@redhat.com
>>>> ---
>>>>  hw/audio/pcspk.c | 35 +++++++++++++++--------------------
>>>>  1 file changed, 15 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
>>>> index 908696d483..b80a62ce90 100644
>>>> --- a/hw/audio/pcspk.c
>>>> +++ b/hw/audio/pcspk.c
>>>> @@ -57,7 +57,6 @@ typedef struct {
>>>>  } PCSpkState;
>>>> =20
>>>>  static const char *s_spk =3D "pcspk";
>>>> -static PCSpkState *pcspk_state;
>>>> =20
>>>>  static inline void generate_samples(PCSpkState *s)
>>>>  {
>>>> @@ -111,22 +110,6 @@ static void pcspk_callback(void *opaque, int fr=
ee)
>>>>      }
>>>>  }
>>>> =20
>>>> -static int pcspk_audio_init(ISABus *bus)
>>>> -{
>>>> -    PCSpkState *s =3D pcspk_state;
>>>> -    struct audsettings as =3D {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0}=
;
>>>> -
>>>> -    AUD_register_card(s_spk, &s->card);
>>>> -
>>>> -    s->voice =3D AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_c=
allback, &as);
>>>> -    if (!s->voice) {
>>>> -        AUD_log(s_spk, "Could not open voice\n");
>>>> -        return -1;
>>>> -    }
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>>  static uint64_t pcspk_io_read(void *opaque, hwaddr addr,
>>>>                                unsigned size)
>>>>  {
>>>> @@ -179,12 +162,20 @@ static void pcspk_initfn(Object *obj)
>>>> =20
>>>>  static void pcspk_realizefn(DeviceState *dev, Error **errp)
>>>>  {
>>>> +    struct audsettings as =3D {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0}=
;
>>>>      ISADevice *isadev =3D ISA_DEVICE(dev);
>>>>      PCSpkState *s =3D PC_SPEAKER(dev);
>>>> =20
>>>>      isa_register_ioport(isadev, &s->ioport, s->iobase);
>>>> =20
>>>> -    pcspk_state =3D s;
>>>> +    AUD_register_card(s_spk, &s->card);
>>>> +
>>>> +    s->voice =3D AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_c=
allback, &as);
>>>> +    if (!s->voice) {
>>>> +        error_setg(errp, "Initializing audio voice failed");
>>>> +        AUD_remove_card(&s->card);
>>>> +        return;
>>>> +    }
>>>>  }
>>>> =20
>>>>  static bool migrate_needed(void *opaque)
>>>> @@ -221,8 +212,6 @@ static void pcspk_class_initfn(ObjectClass *klas=
s, void *data)
>>>>      set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
>>>>      dc->vmsd =3D &vmstate_spk;
>>>>      dc->props =3D pcspk_properties;
>>>> -    /* Reason: realize sets global pcspk_state */
>>>> -    dc->user_creatable =3D false;
>>>>  }
>>>> =20
>>>>  static const TypeInfo pcspk_info =3D {
>>>> @@ -233,6 +222,12 @@ static const TypeInfo pcspk_info =3D {
>>>>      .class_init     =3D pcspk_class_initfn,
>>>>  };
>>>> =20
>>>> +static int pcspk_audio_init(ISABus *bus)
>>>> +{
>>>> +    isa_create_simple(bus, TYPE_PC_SPEAKER);
>>>> +    return 0;
>>>> +}
>>>> +
>>>>  static void pcspk_register(void)
>>>>  {
>>>>      type_register_static(&pcspk_info);
>>>>
>>>
>>> I suddenly get (under fedora 28)
>>>
>>> ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
>>> Connection refused
>>>
>>> alsa: Could not initialize DAC
>>> alsa: Failed to open `default':
>>> alsa: Reason: Connection refused
>>> ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
>>> Connection refused
>>>
>>> alsa: Could not initialize DAC
>>> alsa: Failed to open `default':
>>> alsa: Reason: Connection refused
>>
>> This ALSA problem seems on your side.
>>
>>> audio: Failed to create voice `pcspk'
>>> qemu-system-x86_64: Initialization of device isa-pcspk failed:
>>> Initializing audio voice failed
>>
>> Previously the errors would be ignored and QEMU would start.
>=20
> I just did a fedora 28 uupdate + reboot. Problem still exists. Would be
> strange if only I would be hitting this problem with stock alsa librari=
es.
>=20
>>
>>>
>>>
>>> With
>>>
>>> sudo x86_64-softmmu/qemu-system-x86_64 \
>>>     --enable-kvm \
>>>     -m 4G,maxmem=3D40G,slots=3D2 \
>>>     -smp sockets=3D2,cores=3D2 \
>>>     -numa node,nodeid=3D0,cpus=3D0-1 -numa node,nodeid=3D1,cpus=3D2-3=
 \
>>>     -kernel /boot/vmlinuz-4.19.6-200.fc28.x86_64 \
>>>     -append "console=3DttyS0 rd.shell rd.luks=3D0 rd.lvm=3D0 rd.md=3D=
0 rd.dm=3D0" \
>>>     -initrd /boot/initramfs-4.19.6-200.fc28.x86_64.img \
>>>     -machine pc,nvdimm \
>>>     -nographic \
>>>     -nodefaults \
>>>     -chardev stdio,id=3Dserial \
>>>     --trace events=3Dto_trace \
>>>     -device isa-serial,chardev=3Dserial \
>>>     -chardev socket,id=3Dmonitor,path=3D/var/tmp/monitor,server,nowai=
t \
>>>     -mon chardev=3Dmonitor,mode=3Dreadline
>>>
>>>
>>> Could this be related to this patch? (or is maybe something about my
>>> system messed up? will try rebooting, but other audio - e.g. via fire=
fox
>>> - works fine)
>>
>> Does your Firefox uses ALSA? The default install uses PulseAudio.
>=20
> Yes, I think so. I will try to find another tool to test ALSA.
>=20
>>
>> I think the behavior change you are experiencing comes from the patch =
7
>> of this series "audio: probe audio drivers by default":
>>
>> @@ -879,7 +879,7 @@
>>  Linux)
>> -  audio_drv_list=3D"oss"
>> +  audio_drv_list=3D"try-pa try-alsa try-sdl oss"
>>
>> Previously you were using OSS, and how the ./configure found via
>> pkg-config that you have the ALSA libs installed, and use ALSA first.
>>
>> Can you share the relevant part of the ./configure output?
>=20
> ./configure
> --target-list=3Ds390x-linux-user,s390x-softmmu,s390x-linux-user,x86_64-=
softmmu,ppc-softmmu,ppc64-softmmu
>  --enable-sdl --enable-spice --enable-kvm  --enable-trace-backends=3Dlo=
g
> --enable-debug-tcg
>=20
> Gives me
>=20
> Audio drivers      alsa sdl oss
>=20
> Thanks!
>=20
>>
>> Thanks,
>>
>> Phil.
>>
>=20
>=20

Using speaker-test

t460s: ~  $  aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
pulse
    PulseAudio Sound Server
default
    Default ALSA Output (currently PulseAudio Sound Server)
sysdefault:CARD=3DPCH
    HDA Intel PCH, ALC293 Analog
    Default Audio Device


t460s: ~  $ LANG=3DC speaker-test -c 2 -d default

speaker-test 1.1.6

Playback device is default
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 96 to 1048576
Period size range from 32 to 349526
Using max buffer size 1048576
Periods =3D 4
was set period_size =3D 262144
was set buffer_size =3D 1048576
ALSA <-> PulseAudio PCM I/O Plugin
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 1048576
  period_size  : 262144
  period_time  : 5461333
  tstamp_mode  : NONE
  tstamp_type  : GETTIMEOFDAY
  period_step  : 1
  avail_min    : 262144
  period_event : 0
  start_threshold  : 1048576
  stop_threshold   : 1048576
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904



However, root seems to be the issue

t460s: ~  $ LANG=3DC sudo speaker-test -c 2 -d default

speaker-test 1.1.6

Playback device is default
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
Connection refused

Playback open error: -111,Connection refused


--=20

Thanks,

David / dhildenb
