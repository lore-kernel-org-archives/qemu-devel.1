Received: from eggs.gnu.org ([2001:4830:134:3::10]:57428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePZJh-0006ML-O8
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePZJg-0008Pq-RN
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:37:13 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAAdtpL7npoa8Qs5hARn_da39Ctf5eLZ28CMmV=prh63AxCOvYg@mail.gmail.com>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-7-f4bug@amsat.org>
	<CAKmqyKOSn_iVVuqF=By8g2wFYG_PeiisepJhYMrK7imETGeE7A@mail.gmail.com>
	<CAAdtpL7npoa8Qs5hARn_da39Ctf5eLZ28CMmV=prh63AxCOvYg@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 11:36:38 -0800
Message-ID: <CAKmqyKPvmcCcxGguzbUpy60KZsRrDpqD5k-BMX9HuW+ANur37Q@mail.gmail.com>
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Sai Pavan Boddu <saipava@xilinx.com>, Andrey Yurovsky <yurovsky@gmail.com>

On Thu, Dec 14, 2017 at 10:40 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
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
>>
>> I like the reduction of code in this patch, but aren't we now going to
>> have device properties that aren't actually connected to anything?
>
> I'm not sure I understand, ar you worried about the PCI_SDHCI will now
> have this property but not use it?
>
> I couldn't find any machine using SDHCI via PCI and was tempted to
> just remove this code,
> the only references to it is the REDHAT_SDHCI from commits ece5e5bfa13
> and 224d10ff5ae.

So it is also possible to set these properties from the command line.

If I'm a user and I see that my device has a property "foo" I expect
that setting that property will have an affect on that device. So
there shouldn't be properties that aren't actually connected to the
device.

Alistair

>
> Maybe an attempt to write SDHCI qtests via PCI?
>
>>>      DEFINE_PROP_END_OF_LIST(),
>>>  };
>>>
>>> +/* --- qdev PCI --- */
>>> +
>>>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>>>  {
>>>      SDHCIState *s =3D PCI_SDHCI(dev);
>>> @@ -1295,7 +1299,7 @@ static void sdhci_pci_class_init(ObjectClass *kla=
ss, void *data)
>>>      k->class_id =3D PCI_CLASS_SYSTEM_SDHCI;
>>>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>>>      dc->vmsd =3D &sdhci_vmstate;
>>> -    dc->props =3D sdhci_pci_properties;
>>> +    dc->props =3D sdhci_properties;
>>>      dc->reset =3D sdhci_poweron_reset;
>>>  }
>>>
>>> @@ -1310,14 +1314,7 @@ static const TypeInfo sdhci_pci_info =3D {
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
>
