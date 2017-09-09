Received: from eggs.gnu.org ([2001:4830:134:3::10]:55935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dqbwi-0001x1-Ul
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 05:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dqbwh-0001UD-KO
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 05:21:00 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dqbwh-0001To-Du
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 05:20:59 -0400
Received: by mail-oi0-x243.google.com with SMTP id i6so2128575oih.5
	for <qemu-devel@nongnu.org>; Sat, 09 Sep 2017 02:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20170909083001.17451-1-maozy.fnst@cn.fujitsu.com>
In-Reply-To: <20170909083001.17451-1-maozy.fnst@cn.fujitsu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 09 Sep 2017 09:20:46 +0000
Message-ID: <CAJ+F1CJPnc0OwhzP6_XYzW3L83_UAC_EAVR6A89wtzASTGOUcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb/dev-smartcard-reader: convert to
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hi

On Sat, Sep 9, 2017 at 10:33 AM Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
wrote:

> Convert CCID Device to realize and rename the ccid_card_init()
> to ccid_card_realize().
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  hw/usb/dev-smartcard-reader.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
> index bef1f03..27cd48d 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -1306,27 +1306,25 @@ static int ccid_card_exit(DeviceState *qdev)
>      return 0;
>  }
>
> -static int ccid_card_init(DeviceState *qdev)
> +static void ccid_card_realize(DeviceState *qdev, Error **errp)
>  {
>      CCIDCardState *card =3D CCID_CARD(qdev);
>      USBDevice *dev =3D USB_DEVICE(qdev->parent_bus->parent);
>      USBCCIDState *s =3D USB_CCID_DEV(dev);
> -    int ret =3D 0;
>
>      if (card->slot !=3D 0) {
> -        warn_report("usb-ccid supports one slot, can't add %d",
> +        error_setg(errp, "usb-ccid supports one slot, can't add %d",
>                      card->slot);
> -        return -1;
> +        return;
>      }
>      if (s->card !=3D NULL) {
> -        warn_report("usb-ccid card already full, not adding");
> -        return -1;
> +        error_setg(errp, "usb-ccid card already full, not adding");
> +        return;
>      }
> -    ret =3D ccid_card_initfn(card);
> -    if (ret =3D=3D 0) {
> +
> +    if (!ccid_card_initfn(card)) {
>          s->card =3D card;
>      }
>

You should set an error here, or the caller won't be aware of card init
error anymore. Best would be to convert ccid_card_initfn() and callbacks to
take an Error **.

-    return ret;
>  }
>
>  static void ccid_realize(USBDevice *dev, Error **errp)
> @@ -1496,7 +1494,7 @@ static void ccid_card_class_init(ObjectClass *klass=
,
> void *data)
>  {
>      DeviceClass *k =3D DEVICE_CLASS(klass);
>      k->bus_type =3D TYPE_CCID_BUS;
> -    k->init =3D ccid_card_init;
> +    k->realize =3D ccid_card_realize;
>      k->exit =3D ccid_card_exit;
>      k->props =3D ccid_props;
>  }
> --
> 2.9.4
>
>
>
>
> --
Marc-Andr=C3=A9 Lureau
