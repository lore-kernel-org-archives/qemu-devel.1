Received: from eggs.gnu.org ([209.51.188.92]:49573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtWXb-0003iw-2F
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtWXZ-0002XY-QS
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:47:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gtWXZ-0001x0-DQ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:47:53 -0500
References: <20190124132020.13571-1-kraxel@redhat.com>
	<20190124132020.13571-2-kraxel@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c0234a17-4e50-5fe2-4b88-6cf133c43347@redhat.com>
Date: Tue, 12 Feb 2019 12:47:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190124132020.13571-2-kraxel@redhat.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>

On 24.01.19 14:20, Gerd Hoffmann wrote:
> Get rid of the pcspk_state global, allow pc speaker
> be added using "-device isa-pcspk".
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-id: 20190124110810.1040-1-kraxel@redhat.com
> ---
>  hw/audio/pcspk.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> index 908696d483..b80a62ce90 100644
> --- a/hw/audio/pcspk.c
> +++ b/hw/audio/pcspk.c
> @@ -57,7 +57,6 @@ typedef struct {
>  } PCSpkState;
> =20
>  static const char *s_spk =3D "pcspk";
> -static PCSpkState *pcspk_state;
> =20
>  static inline void generate_samples(PCSpkState *s)
>  {
> @@ -111,22 +110,6 @@ static void pcspk_callback(void *opaque, int free)
>      }
>  }
> =20
> -static int pcspk_audio_init(ISABus *bus)
> -{
> -    PCSpkState *s =3D pcspk_state;
> -    struct audsettings as =3D {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0};
> -
> -    AUD_register_card(s_spk, &s->card);
> -
> -    s->voice =3D AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_call=
back, &as);
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
> =20
>  static void pcspk_realizefn(DeviceState *dev, Error **errp)
>  {
> +    struct audsettings as =3D {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0};
>      ISADevice *isadev =3D ISA_DEVICE(dev);
>      PCSpkState *s =3D PC_SPEAKER(dev);
> =20
>      isa_register_ioport(isadev, &s->ioport, s->iobase);
> =20
> -    pcspk_state =3D s;
> +    AUD_register_card(s_spk, &s->card);
> +
> +    s->voice =3D AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_call=
back, &as);
> +    if (!s->voice) {
> +        error_setg(errp, "Initializing audio voice failed");
> +        AUD_remove_card(&s->card);
> +        return;
> +    }
>  }
> =20
>  static bool migrate_needed(void *opaque)
> @@ -221,8 +212,6 @@ static void pcspk_class_initfn(ObjectClass *klass, =
void *data)
>      set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
>      dc->vmsd =3D &vmstate_spk;
>      dc->props =3D pcspk_properties;
> -    /* Reason: realize sets global pcspk_state */
> -    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo pcspk_info =3D {
> @@ -233,6 +222,12 @@ static const TypeInfo pcspk_info =3D {
>      .class_init     =3D pcspk_class_initfn,
>  };
> =20
> +static int pcspk_audio_init(ISABus *bus)
> +{
> +    isa_create_simple(bus, TYPE_PC_SPEAKER);
> +    return 0;
> +}
> +
>  static void pcspk_register(void)
>  {
>      type_register_static(&pcspk_info);
>=20

I suddenly get (under fedora 28)

ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
Connection refused

alsa: Could not initialize DAC
alsa: Failed to open `default':
alsa: Reason: Connection refused
ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
Connection refused

alsa: Could not initialize DAC
alsa: Failed to open `default':
alsa: Reason: Connection refused
audio: Failed to create voice `pcspk'
qemu-system-x86_64: Initialization of device isa-pcspk failed:
Initializing audio voice failed


With

sudo x86_64-softmmu/qemu-system-x86_64 \
    --enable-kvm \
    -m 4G,maxmem=3D40G,slots=3D2 \
    -smp sockets=3D2,cores=3D2 \
    -numa node,nodeid=3D0,cpus=3D0-1 -numa node,nodeid=3D1,cpus=3D2-3 \
    -kernel /boot/vmlinuz-4.19.6-200.fc28.x86_64 \
    -append "console=3DttyS0 rd.shell rd.luks=3D0 rd.lvm=3D0 rd.md=3D0 rd=
.dm=3D0" \
    -initrd /boot/initramfs-4.19.6-200.fc28.x86_64.img \
    -machine pc,nvdimm \
    -nographic \
    -nodefaults \
    -chardev stdio,id=3Dserial \
    --trace events=3Dto_trace \
    -device isa-serial,chardev=3Dserial \
    -chardev socket,id=3Dmonitor,path=3D/var/tmp/monitor,server,nowait \
    -mon chardev=3Dmonitor,mode=3Dreadline


Could this be related to this patch? (or is maybe something about my
system messed up? will try rebooting, but other audio - e.g. via firefox
- works fine)

--=20

Thanks,

David / dhildenb
