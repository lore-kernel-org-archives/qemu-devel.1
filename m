Received: from eggs.gnu.org ([2001:4830:134:3::10]:49570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eX9mY-0006Cg-EK
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eX9mX-0007YC-NR
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:58:22 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eX9mX-0007X4-H1
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:58:21 -0500
Received: by mail-wm0-x242.google.com with SMTP id y82so3146527wmg.1
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 09:58:21 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103180805.18140-6-f4bug@amsat.org>
References: <20180103180805.18140-1-f4bug@amsat.org>
	<20180103180805.18140-6-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 4 Jan 2018 09:57:49 -0800
Message-ID: <CAKmqyKNYtHP4MSJzcAZMobSaSAK+F4Lf7xBKnR5N9BC7srt7pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 05/17] sdhci: refactor common sysbus/pci
 class_init() into sdhci_common_class_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jan 3, 2018 at 10:07 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Now both inherited classes appear as DEVICE_CATEGORY_STORAGE.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index a11469fbca..68bcf75478 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1275,6 +1275,16 @@ static Property sdhci_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +static void sdhci_common_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    dc->vmsd =3D &sdhci_vmstate;
> +    dc->props =3D sdhci_properties;
> +    dc->reset =3D sdhci_poweron_reset;
> +}
> +
>  /* --- qdev PCI --- */
>
>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
> @@ -1299,7 +1309,6 @@ static void sdhci_pci_exit(PCIDevice *dev)
>
>  static void sdhci_pci_class_init(ObjectClass *klass, void *data)
>  {
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>
>      k->realize =3D sdhci_pci_realize;
> @@ -1307,10 +1316,8 @@ static void sdhci_pci_class_init(ObjectClass *klas=
s, void *data)
>      k->vendor_id =3D PCI_VENDOR_ID_REDHAT;
>      k->device_id =3D PCI_DEVICE_ID_REDHAT_SDHCI;
>      k->class_id =3D PCI_CLASS_SYSTEM_SDHCI;
> -    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> -    dc->vmsd =3D &sdhci_vmstate;
> -    dc->props =3D sdhci_properties;
> -    dc->reset =3D sdhci_poweron_reset;
> +
> +    sdhci_common_class_init(klass, data);
>  }
>
>  static const TypeInfo sdhci_pci_info =3D {
> @@ -1356,10 +1363,9 @@ static void sdhci_sysbus_class_init(ObjectClass *k=
lass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    dc->vmsd =3D &sdhci_vmstate;
> -    dc->props =3D sdhci_properties;
>      dc->realize =3D sdhci_sysbus_realize;
> -    dc->reset =3D sdhci_poweron_reset;
> +
> +    sdhci_common_class_init(klass, data);
>  }
>
>  static const TypeInfo sdhci_sysbus_info =3D {
> --
> 2.15.1
>
>
