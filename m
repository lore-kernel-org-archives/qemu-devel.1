Received: from eggs.gnu.org ([2001:4830:134:3::10]:36907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cGisl-0000Om-C1
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cGisi-0008VO-8Y
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:56:19 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:33571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cGisi-0008VE-3A
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:56:16 -0500
Received: by mail-io0-f178.google.com with SMTP id d9so213331387ioe.0
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 00:56:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <583d5d12.8529c80a.4a33a.c6f9@mx.google.com>
References: <583d5d12.8529c80a.4a33a.c6f9@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 13 Dec 2016 16:55:15 +0800
Message-ID: <CAKXe6SJu9=Mr2OL-2LDqwpK_QLdzPhXKD_dSb63uJVF75Li7-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] audio: es1370: add exit function
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

ping!

2016-11-29 18:48 GMT+08:00 Li Qiang <liq3ea@gmail.com>:

> From: Li Qiang <liqiang6-s@360.cn>
>
> Currently the es1370 device emulation doesn't have a exit function,
> hot unplug this device will leak some leak. Add a exit function to
> avoid this.
>
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/audio/es1370.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> index 8449b5f..8f70f72 100644
> --- a/hw/audio/es1370.c
> +++ b/hw/audio/es1370.c
> @@ -1041,6 +1041,13 @@ static void es1370_realize(PCIDevice *dev, Error
> **errp)
>      es1370_reset (s);
>  }
>
> +static void es1370_exit(PCIDevice *dev)
> +{
> +    ES1370State *s = ES1370(dev);
> +
> +    AUD_remove_card(&s->card);
> +}
> +
>  static int es1370_init (PCIBus *bus)
>  {
>      pci_create_simple (bus, -1, TYPE_ES1370);
> @@ -1053,6 +1060,7 @@ static void es1370_class_init (ObjectClass *klass,
> void *data)
>      PCIDeviceClass *k = PCI_DEVICE_CLASS (klass);
>
>      k->realize = es1370_realize;
> +    k->exit = es1370_exit;
>      k->vendor_id = PCI_VENDOR_ID_ENSONIQ;
>      k->device_id = PCI_DEVICE_ID_ENSONIQ_ES1370;
>      k->class_id = PCI_CLASS_MULTIMEDIA_AUDIO;
> --
> 1.8.3.1
>
>
