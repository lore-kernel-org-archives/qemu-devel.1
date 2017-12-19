Received: from eggs.gnu.org ([2001:4830:134:3::10]:47671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eR6Ti-0005x1-9S
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:13:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eR6Th-0005m3-Af
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:13:54 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171215031547.31006-5-f4bug@amsat.org>
References: <20171215031547.31006-1-f4bug@amsat.org>
	<20171215031547.31006-5-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 18 Dec 2017 17:13:21 -0800
Message-ID: <CAKmqyKM-Ar=Ld=6KBvJ1D1T0z2wPhvFR52tvKXKp=SEWoFJ=XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/20] sdhci: refactor same sysbus/pci
 properties into a common one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Dec 14, 2017 at 7:15 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> add sysbus/pci/sdbus separator comments to keep it clearer
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I'm still unsure about this. Won't this leave us with properties that
have no impact on the device? That seems very confusing to me.

Alistair

> ---
>  hw/sd/sdhci.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 2823da00da..dbdfd54350 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1265,13 +1265,17 @@ const VMStateDescription sdhci_vmstate =3D {
>
>  /* Capabilities registers provide information on supported features of t=
his
>   * specific host controller implementation */
> -static Property sdhci_pci_properties[] =3D {
> +static Property sdhci_properties[] =3D {
>      DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
>              SDHC_CAPAB_REG_DEFAULT),
>      DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
> +    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_=
quirk,
> +                     false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +/* --- qdev PCI --- */
> +
>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>  {
>      SDHCIState *s =3D PCI_SDHCI(dev);
> @@ -1304,7 +1308,7 @@ static void sdhci_pci_class_init(ObjectClass *klass=
, void *data)
>      k->class_id =3D PCI_CLASS_SYSTEM_SDHCI;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>      dc->vmsd =3D &sdhci_vmstate;
> -    dc->props =3D sdhci_pci_properties;
> +    dc->props =3D sdhci_properties;
>      dc->reset =3D sdhci_poweron_reset;
>  }
>
> @@ -1319,14 +1323,7 @@ static const TypeInfo sdhci_pci_info =3D {
>      },
>  };
>
> -static Property sdhci_sysbus_properties[] =3D {
> -    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
> -            SDHC_CAPAB_REG_DEFAULT),
> -    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
> -    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_=
quirk,
> -                     false),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> +/* --- qdev SysBus --- */
>
>  static void sdhci_sysbus_init(Object *obj)
>  {
> @@ -1359,7 +1356,7 @@ static void sdhci_sysbus_class_init(ObjectClass *kl=
ass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->vmsd =3D &sdhci_vmstate;
> -    dc->props =3D sdhci_sysbus_properties;
> +    dc->props =3D sdhci_properties;
>      dc->realize =3D sdhci_sysbus_realize;
>      dc->reset =3D sdhci_poweron_reset;
>  }
> @@ -1373,6 +1370,8 @@ static const TypeInfo sdhci_sysbus_info =3D {
>      .class_init =3D sdhci_sysbus_class_init,
>  };
>
> +/* --- qdev bus master --- */
> +
>  static void sdhci_bus_class_init(ObjectClass *klass, void *data)
>  {
>      SDBusClass *sbc =3D SD_BUS_CLASS(klass);
> --
> 2.15.1
>
>
