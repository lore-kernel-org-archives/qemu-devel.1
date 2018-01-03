Received: from eggs.gnu.org ([2001:4830:134:3::10]:46588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWdne-0002l2-PR
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 02:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWdna-0003bS-SC
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 02:49:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eWdna-0003b2-Lf
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 02:49:18 -0500
Date: Wed, 3 Jan 2018 15:49:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180103074915.GC25984@localhost.localdomain>
References: <20171229174933.1781-1-f4bug@amsat.org>
	<20171229174933.1781-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171229174933.1781-6-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/42] sdhci: refactor common sysbus/pci
 class_init() into sdhci_class_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Xiaoqiang Zhao <zxq_yx_007@163.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org

On Fri, 12/29 14:48, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index a11469fbca..38d82b4c61 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1275,6 +1275,16 @@ static Property sdhci_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> +static void sdhci_class_init(ObjectClass *klass, void *data)
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
> =20
>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
> @@ -1299,7 +1309,6 @@ static void sdhci_pci_exit(PCIDevice *dev)
> =20
>  static void sdhci_pci_class_init(ObjectClass *klass, void *data)
>  {
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> =20
>      k->realize =3D sdhci_pci_realize;
> @@ -1307,10 +1316,8 @@ static void sdhci_pci_class_init(ObjectClass *kl=
ass, void *data)
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
> =20
>  static const TypeInfo sdhci_pci_info =3D {
> @@ -1356,10 +1363,9 @@ static void sdhci_sysbus_class_init(ObjectClass =
*klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    dc->vmsd =3D &sdhci_vmstate;
> -    dc->props =3D sdhci_properties;
>      dc->realize =3D sdhci_sysbus_realize;
> -    dc->reset =3D sdhci_poweron_reset;
> +
> +    sdhci_class_init(klass, data);

Previously we don't do

    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);

in this function. Again if this is intended it should be mentioned in the=
 commit
message?

Fam

>  }
> =20
>  static const TypeInfo sdhci_sysbus_info =3D {
> --=20
> 2.15.1
>=20
>=20
