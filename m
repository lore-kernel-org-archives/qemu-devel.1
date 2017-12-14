Received: from eggs.gnu.org ([2001:4830:134:3::10]:41693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXO0-0002OP-Lv
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXNz-0003ie-MP
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:33:32 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePXNz-0003hk-GL
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:33:31 -0500
Received: by mail-wm0-x244.google.com with SMTP id y82so27221534wmg.1
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 09:33:31 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213195852.30439-7-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-7-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 09:32:59 -0800
Message-ID: <CAKmqyKOSn_iVVuqF=By8g2wFYG_PeiisepJhYMrK7imETGeE7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/14] sdhci: refactor same sysbus/pci
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> add sysbus/pci/sdbus separator comments to keep it clearer
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index a56c0c273e..c8b7b1ca4c 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1256,13 +1256,17 @@ const VMStateDescription sdhci_vmstate =3D {
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

I like the reduction of code in this patch, but aren't we now going to
have device properties that aren't actually connected to anything?

Alistair

>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +/* --- qdev PCI --- */
> +
>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>  {
>      SDHCIState *s =3D PCI_SDHCI(dev);
> @@ -1295,7 +1299,7 @@ static void sdhci_pci_class_init(ObjectClass *klass=
, void *data)
>      k->class_id =3D PCI_CLASS_SYSTEM_SDHCI;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>      dc->vmsd =3D &sdhci_vmstate;
> -    dc->props =3D sdhci_pci_properties;
> +    dc->props =3D sdhci_properties;
>      dc->reset =3D sdhci_poweron_reset;
>  }
>
> @@ -1310,14 +1314,7 @@ static const TypeInfo sdhci_pci_info =3D {
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
> @@ -1350,7 +1347,7 @@ static void sdhci_sysbus_class_init(ObjectClass *kl=
ass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->vmsd =3D &sdhci_vmstate;
> -    dc->props =3D sdhci_sysbus_properties;
> +    dc->props =3D sdhci_properties;
>      dc->realize =3D sdhci_sysbus_realize;
>      dc->reset =3D sdhci_poweron_reset;
>  }
> @@ -1364,6 +1361,8 @@ static const TypeInfo sdhci_sysbus_info =3D {
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
