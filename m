Received: from eggs.gnu.org ([2001:4830:134:3::10]:36587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cHoHo-0001eF-3G
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cHoHm-0007Os-VW
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:54:40 -0500
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:34044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cHoHm-0007M7-QK
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:54:38 -0500
Received: by mail-yw0-x241.google.com with SMTP id a10so3457297ywa.1
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 00:54:37 -0800 (PST)
MIME-Version: 1.0
References: <58520052.4825ed0a.27a71.6cae@mx.google.com>
In-Reply-To: <58520052.4825ed0a.27a71.6cae@mx.google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 16 Dec 2016 08:54:25 +0000
Message-ID: <CAJ+F1CLfnMq3ucA=KWn9xOR8bzh5fHsYXse750JZz=Enj5pctw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] audio: ac97: add exit function
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

On Thu, Dec 15, 2016 at 5:30 AM Li Qiang <liq3ea@gmail.com> wrote:

> From: Li Qiang <liqiang6-s@360.cn>
>
> Currently the ac97 device emulation doesn't have a exit function,
> hot unplug this device will leak some memory. Add a exit function to
> avoid this.
>
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>
> Changes since the v2:
> take out of the null check
>
> Changes since the v1:
> close the streams
>
>  hw/audio/ac97.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index cbd959e..c306575 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -1387,6 +1387,16 @@ static void ac97_realize(PCIDevice *dev, Error
> **errp)
>      ac97_on_reset (&s->dev.qdev);
>  }
>
> +static void ac97_exit(PCIDevice *dev)
> +{
> +    AC97LinkState *s =3D DO_UPCAST(AC97LinkState, dev, dev);
> +
> +    AUD_close_in(&s->card, s->voice_pi);
> +    AUD_close_out(&s->card, s->voice_po);
> +    AUD_close_in(&s->card, s->voice_mc);
> +    AUD_remove_card(&s->card);
> +}
> +
>  static int ac97_init (PCIBus *bus)
>  {
>      pci_create_simple (bus, -1, "AC97");
> @@ -1404,6 +1414,7 @@ static void ac97_class_init (ObjectClass *klass,
> void *data)
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS (klass);
>
>      k->realize =3D ac97_realize;
> +    k->exit =3D ac97_exit;
>      k->vendor_id =3D PCI_VENDOR_ID_INTEL;
>      k->device_id =3D PCI_DEVICE_ID_INTEL_82801AA_5;
>      k->revision =3D 0x01;
> --
> 1.8.3.1
>
> --
Marc-Andr=C3=A9 Lureau
