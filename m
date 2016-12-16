Received: from eggs.gnu.org ([2001:4830:134:3::10]:37448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cHoKa-0002iw-II
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cHoKZ-0001db-Ks
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:57:32 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:34143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cHoKZ-0001dN-CB
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:57:31 -0500
Received: by mail-yw0-x243.google.com with SMTP id a10so3461789ywa.1
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 00:57:31 -0800 (PST)
MIME-Version: 1.0
References: <585200c9.a968ca0a.1ab80.4c98@mx.google.com>
In-Reply-To: <585200c9.a968ca0a.1ab80.4c98@mx.google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 16 Dec 2016 08:57:20 +0000
Message-ID: <CAJ+F1C+vrhubB0trANKbgn5UvALpUNK0F_6twan7P2rk86dKgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] audio: es1370: add exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

On Thu, Dec 15, 2016 at 5:32 AM Li Qiang <liq3ea@gmail.com> wrote:

> From: Li Qiang <liqiang6-s@360.cn>
>
> Currently the es1370 device emulation doesn't have a exit function,
> hot unplug this device will leak some memory. Add a exit function to
> avoid this.
>
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
>


> ---
>
> Changes since the v2:
> take out of the null check
>
> Changes since the v1:
> close the streams
>
>  hw/audio/es1370.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> index 8449b5f..883ec69 100644
> --- a/hw/audio/es1370.c
> +++ b/hw/audio/es1370.c
> @@ -1041,6 +1041,19 @@ static void es1370_realize(PCIDevice *dev, Error
> **errp)
>      es1370_reset (s);
>  }
>
> +static void es1370_exit(PCIDevice *dev)
> +{
> +    ES1370State *s =3D ES1370(dev);
> +    int i;
> +
> +    for (i =3D 0; i < 2; ++i) {
> +        AUD_close_out(&s->card, s->dac_voice[i]);
>

(I would suggest ARRAY_SIZE instead)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> +    }
> +
> +    AUD_close_in(&s->card, s->adc_voice);
> +    AUD_remove_card(&s->card);
> +}
> +
>  static int es1370_init (PCIBus *bus)
>  {
>      pci_create_simple (bus, -1, TYPE_ES1370);
> @@ -1053,6 +1066,7 @@ static void es1370_class_init (ObjectClass *klass,
> void *data)
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS (klass);
>
>      k->realize =3D es1370_realize;
> +    k->exit =3D es1370_exit;
>      k->vendor_id =3D PCI_VENDOR_ID_ENSONIQ;
>      k->device_id =3D PCI_DEVICE_ID_ENSONIQ_ES1370;
>      k->class_id =3D PCI_CLASS_MULTIMEDIA_AUDIO;
> --
> 1.8.3.1
>
> --
Marc-Andr=C3=A9 Lureau
