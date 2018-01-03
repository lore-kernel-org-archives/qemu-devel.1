Received: from eggs.gnu.org ([2001:4830:134:3::10]:43009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWoqn-000593-6Y
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 14:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWoqm-0003Sb-5U
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 14:37:21 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <f261cae0-9026-9ef0-65c5-fb24076564d8@amsat.org>
References: <20171215031547.31006-1-f4bug@amsat.org>
	<20171215031547.31006-5-f4bug@amsat.org>
	<CAKmqyKM-Ar=Ld=6KBvJ1D1T0z2wPhvFR52tvKXKp=SEWoFJ=XQ@mail.gmail.com>
	<f261cae0-9026-9ef0-65c5-fb24076564d8@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 3 Jan 2018 11:36:47 -0800
Message-ID: <CAKmqyKNmr8WcQ1X3aWe4rhRQxwtz68Pm1RicqPdT=2PEqnmnXw@mail.gmail.com>
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, Xiaoqiang Zhao <zxq_yx_007@163.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Sai Pavan Boddu <saipava@xilinx.com>, Michael Walle <michael@walle.cc>, qemu-arm <qemu-arm@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Fri, Dec 29, 2017 at 9:21 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Hi Alistair,
>
> On 12/18/2017 10:13 PM, Alistair Francis wrote:
>> On Thu, Dec 14, 2017 at 7:15 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
>>> add sysbus/pci/sdbus separator comments to keep it clearer
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> I'm still unsure about this. Won't this leave us with properties that
>> have no impact on the device? That seems very confusing to me.
>
> (from previous series)
>> [...] but aren't we now going to
>> have device properties that aren't actually connected to anything?
>
> I'm also confused :)
>
> My understanding is the "pending-insert-quirk" worries you.

Exactly, my worry is having properties that aren't connected. As a
user I expect that if I set a property that will have some effect on
how QEMU runs. A un-connected property is just confusing.

> This property is dependent of the HCI IP, so regardless the HCI is
> accessed through a MMIO sysbus or a PCI bus the quirk might exists (for
> this property, only the BCM implementation).

So it has always been configuration dependent?

Alistair

>
> With v3 series applied, the monitor 'qtree' output is:
>
> $ qemu-system-aarch64 -M xlnx-zcu102 -monitor stdio -S
> (qemu) info qtree
>   dev: generic-sdhci, id ""
>     gpio-out "sysbus-irq" 1
>     sd-spec-version =3D 3 (0x3)
>     timeout-freq =3D 0 (0x0)
>     freq-in-mhz =3D true
>     clock-freq =3D 0 (0x0)
>     max-block-length =3D 512 (0x200)
>     dma =3D true
>     sdma =3D true
>     adma1 =3D false
>     adma2 =3D true
>     suspend =3D true
>     high-speed =3D true
>     3v3 =3D true
>     3v0 =3D false
>     1v8 =3D true
>     64bit =3D true
>     slot-type =3D 0 (0x0)
>     bus-speed =3D 7 (0x7)
>     driver-strength =3D 7 (0x7)
>     maxcurr =3D 0 (0x0)
>     pending-insert-quirk =3D false
>     dma-memory =3D ""
>     mmio 00000000ff170000/0000000000000100
>     bus: sd-bus
>       type sdhci-bus
>       dev: sd-card, id ""
>         drive =3D ""
>         spi =3D false
>
> Are you worried about this output?
>
>>> ---
>>>  hw/sd/sdhci.c | 21 ++++++++++-----------
>>>  1 file changed, 10 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>> index 2823da00da..dbdfd54350 100644
>>> --- a/hw/sd/sdhci.c
>>> +++ b/hw/sd/sdhci.c
>>> @@ -1265,13 +1265,17 @@ const VMStateDescription sdhci_vmstate =3D {
>>>
>>>  /* Capabilities registers provide information on supported features of=
 this
>>>   * specific host controller implementation */
>>> -static Property sdhci_pci_properties[] =3D {
>>> +static Property sdhci_properties[] =3D {
>>>      DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
>>>              SDHC_CAPAB_REG_DEFAULT),
>>>      DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
>>> +    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_inser=
t_quirk,
>>> +                     false),
>>>      DEFINE_PROP_END_OF_LIST(),
>>>  };
>>>
>>> +/* --- qdev PCI --- */
>>> +
>>>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>>>  {
>>>      SDHCIState *s =3D PCI_SDHCI(dev);
>>> @@ -1304,7 +1308,7 @@ static void sdhci_pci_class_init(ObjectClass *kla=
ss, void *data)
>>>      k->class_id =3D PCI_CLASS_SYSTEM_SDHCI;
>>>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>>>      dc->vmsd =3D &sdhci_vmstate;
>>> -    dc->props =3D sdhci_pci_properties;
>>> +    dc->props =3D sdhci_properties;
>>>      dc->reset =3D sdhci_poweron_reset;
>>>  }
>>>
>>> @@ -1319,14 +1323,7 @@ static const TypeInfo sdhci_pci_info =3D {
>>>      },
>>>  };
>>>
>>> -static Property sdhci_sysbus_properties[] =3D {
>>> -    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
>>> -            SDHC_CAPAB_REG_DEFAULT),
>>> -    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
>>> -    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_inser=
t_quirk,
>>> -                     false),
>>> -    DEFINE_PROP_END_OF_LIST(),
>>> -};
>>> +/* --- qdev SysBus --- */
>>>
>>>  static void sdhci_sysbus_init(Object *obj)
>>>  {
>>> @@ -1359,7 +1356,7 @@ static void sdhci_sysbus_class_init(ObjectClass *=
klass, void *data)
>>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>>>
>>>      dc->vmsd =3D &sdhci_vmstate;
>>> -    dc->props =3D sdhci_sysbus_properties;
>>> +    dc->props =3D sdhci_properties;
>>>      dc->realize =3D sdhci_sysbus_realize;
>>>      dc->reset =3D sdhci_poweron_reset;
>>>  }
>>> @@ -1373,6 +1370,8 @@ static const TypeInfo sdhci_sysbus_info =3D {
>>>      .class_init =3D sdhci_sysbus_class_init,
>>>  };
>>>
>>> +/* --- qdev bus master --- */
>>> +
>>>  static void sdhci_bus_class_init(ObjectClass *klass, void *data)
>>>  {
>>>      SDBusClass *sbc =3D SD_BUS_CLASS(klass);
>>> --
>>> 2.15.1
>>>
>>>
>
