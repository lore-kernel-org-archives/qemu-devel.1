Received: from eggs.gnu.org ([2001:4830:134:3::10]:36764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cGis6-0008TO-GI
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cGis3-0008G6-9b
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:55:38 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:33017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cGis3-00089o-0P
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:55:35 -0500
Received: by mail-io0-f195.google.com with SMTP id p13so27213732ioi.0
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 00:55:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <583d59a6.dcc6370a.3a361.b5d4@mx.google.com>
References: <583d59a6.dcc6370a.3a361.b5d4@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 13 Dec 2016 16:54:11 +0800
Message-ID: <CAKXe6S+BB_72vZLWDhJk65Qm1Uh-2COKEEwM9YyaCF4aL1x1nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] audio: ac97: add exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

Ping!

2016-11-29 18:33 GMT+08:00 Li Qiang <liq3ea@gmail.com>:

> From: Li Qiang <liqiang6-s@360.cn>
>
> Currently the ac97 device emulation doesn't have a exit function,
> hot unplug this device will leak some leak. Add a exit function to
> avoid this.
>
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/audio/ac97.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index cbd959e..2faed35 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -1387,6 +1387,13 @@ static void ac97_realize(PCIDevice *dev, Error
> **errp)
>      ac97_on_reset (&s->dev.qdev);
>  }
>
> +static void ac97_exit(PCIDevice *dev)
> +{
> +    AC97LinkState *s = DO_UPCAST(AC97LinkState, dev, dev);
> +
> +    AUD_remove_card(&s->card);
> +}
> +
>  static int ac97_init (PCIBus *bus)
>  {
>      pci_create_simple (bus, -1, "AC97");
> @@ -1404,6 +1411,7 @@ static void ac97_class_init (ObjectClass *klass,
> void *data)
>      PCIDeviceClass *k = PCI_DEVICE_CLASS (klass);
>
>      k->realize = ac97_realize;
> +    k->exit = ac97_exit;
>      k->vendor_id = PCI_VENDOR_ID_INTEL;
>      k->device_id = PCI_DEVICE_ID_INTEL_82801AA_5;
>      k->revision = 0x01;
> --
> 1.8.3.1
>
>
