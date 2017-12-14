Received: from eggs.gnu.org ([2001:4830:134:3::10]:49110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXZ1-0003TT-Vw
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXZ1-000891-1E
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:44:56 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:42005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePXZ0-00087g-RB
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:44:54 -0500
Received: by mail-wr0-x241.google.com with SMTP id s66so5838367wrc.9
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 09:44:54 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213195852.30439-9-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-9-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 09:44:22 -0800
Message-ID: <CAKmqyKN5WBaPAbWuco27oxqcP3Mk6qaJ2JRV5SHNaQ8xurJEQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/14] sdhci: refactor common sysbus/pci
 class_init() into sdhci_class_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index a96cd8a2df..893be0e606 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1274,6 +1274,16 @@ static Property sdhci_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +static void sdhci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);

This changes the sysbus one, does that matter?

Alistair

> +    dc->vmsd =3D &sdhci_vmstate;
> +    dc->props =3D sdhci_properties;
> +    dc->reset =3D sdhci_poweron_reset;
> +}
> +
>  /* --- qdev PCI --- */
>
>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
> @@ -1297,7 +1307,6 @@ static void sdhci_pci_exit(PCIDevice *dev)
>
>  static void sdhci_pci_class_init(ObjectClass *klass, void *data)
>  {
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>
>      k->realize =3D sdhci_pci_realize;
> @@ -1305,10 +1314,8 @@ static void sdhci_pci_class_init(ObjectClass *klas=
s, void *data)
>      k->vendor_id =3D PCI_VENDOR_ID_REDHAT;
>      k->device_id =3D PCI_DEVICE_ID_REDHAT_SDHCI;
>      k->class_id =3D PCI_CLASS_SYSTEM_SDHCI;
> -    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> -    dc->vmsd =3D &sdhci_vmstate;
> -    dc->props =3D sdhci_properties;
> -    dc->reset =3D sdhci_poweron_reset;
> +
> +    sdhci_class_init(klass, data);
>  }
>
>  static const TypeInfo sdhci_pci_info =3D {
> @@ -1352,10 +1359,9 @@ static void sdhci_sysbus_class_init(ObjectClass *k=
lass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    dc->vmsd =3D &sdhci_vmstate;
> -    dc->props =3D sdhci_properties;
>      dc->realize =3D sdhci_sysbus_realize;
> -    dc->reset =3D sdhci_poweron_reset;
> +
> +    sdhci_class_init(klass, data);
>  }
>
>  static const TypeInfo sdhci_sysbus_info =3D {
> --
> 2.15.1
>
>
