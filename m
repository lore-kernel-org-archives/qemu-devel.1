Received: from eggs.gnu.org ([2001:4830:134:3::10]:45121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWdlJ-0001Sv-MQ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 02:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWdlF-00022p-Oe
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 02:46:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eWdlF-00022V-G5
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 02:46:53 -0500
Date: Wed, 3 Jan 2018 15:46:50 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180103074650.GB25984@localhost.localdomain>
References: <20171229174933.1781-1-f4bug@amsat.org>
	<20171229174933.1781-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171229174933.1781-5-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/42] sdhci: refactor same sysbus/pci
 properties into a common one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Xiaoqiang Zhao <zxq_yx_007@163.com>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Fri, 12/29 14:48, Philippe Mathieu-Daud=E9 wrote:
> add sysbus/pci/sdbus separator comments to keep it clearer
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 365bc80009..a11469fbca 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1266,13 +1266,17 @@ const VMStateDescription sdhci_vmstate =3D {
> =20
>  /* Capabilities registers provide information on supported features of=
 this
>   * specific host controller implementation */
> -static Property sdhci_pci_properties[] =3D {
> +static Property sdhci_properties[] =3D {
>      DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
>              SDHC_CAPAB_REG_DEFAULT),
>      DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
> +    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_inser=
t_quirk,
> +                     false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> +/* --- qdev PCI --- */
> +
>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>  {
>      SDHCIState *s =3D PCI_SDHCI(dev);
> @@ -1305,7 +1309,7 @@ static void sdhci_pci_class_init(ObjectClass *kla=
ss, void *data)
>      k->class_id =3D PCI_CLASS_SYSTEM_SDHCI;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>      dc->vmsd =3D &sdhci_vmstate;
> -    dc->props =3D sdhci_pci_properties;
> +    dc->props =3D sdhci_properties;
>      dc->reset =3D sdhci_poweron_reset;
>  }

This is effectively adding "pending-insert-quirk" property to the class. =
If it
is intended, should this be explained in the commit message?

> =20
> @@ -1320,14 +1324,7 @@ static const TypeInfo sdhci_pci_info =3D {
>      },
>  };
> =20
> -static Property sdhci_sysbus_properties[] =3D {
> -    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
> -            SDHC_CAPAB_REG_DEFAULT),
> -    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
> -    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_inser=
t_quirk,
> -                     false),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> +/* --- qdev SysBus --- */
> =20
>  static void sdhci_sysbus_init(Object *obj)
>  {
> @@ -1360,7 +1357,7 @@ static void sdhci_sysbus_class_init(ObjectClass *=
klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
>      dc->vmsd =3D &sdhci_vmstate;
> -    dc->props =3D sdhci_sysbus_properties;
> +    dc->props =3D sdhci_properties;
>      dc->realize =3D sdhci_sysbus_realize;
>      dc->reset =3D sdhci_poweron_reset;
>  }
> @@ -1374,6 +1371,8 @@ static const TypeInfo sdhci_sysbus_info =3D {
>      .class_init =3D sdhci_sysbus_class_init,
>  };
> =20
> +/* --- qdev bus master --- */
> +
>  static void sdhci_bus_class_init(ObjectClass *klass, void *data)
>  {
>      SDBusClass *sbc =3D SD_BUS_CLASS(klass);
> --=20
> 2.15.1
>=20

Fam
