Received: from eggs.gnu.org ([2001:4830:134:3::10]:53656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePYQe-0002q7-Vi
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePYQd-0000uz-Td
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:40:21 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAKmqyKOSn_iVVuqF=By8g2wFYG_PeiisepJhYMrK7imETGeE7A@mail.gmail.com>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-7-f4bug@amsat.org>
	<CAKmqyKOSn_iVVuqF=By8g2wFYG_PeiisepJhYMrK7imETGeE7A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Dec 2017 15:40:17 -0300
Message-ID: <CAAdtpL7npoa8Qs5hARn_da39Ctf5eLZ28CMmV=prh63AxCOvYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Alistair Francis <alistair.francis@xilinx.com>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>

>>  /* Capabilities registers provide information on supported features of this
>>   * specific host controller implementation */
>> -static Property sdhci_pci_properties[] = {
>> +static Property sdhci_properties[] = {
>>      DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
>>              SDHC_CAPAB_REG_DEFAULT),
>>      DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
>> +    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
>> +                     false),
>
> I like the reduction of code in this patch, but aren't we now going to
> have device properties that aren't actually connected to anything?

I'm not sure I understand, ar you worried about the PCI_SDHCI will now
have this property but not use it?

I couldn't find any machine using SDHCI via PCI and was tempted to
just remove this code,
the only references to it is the REDHAT_SDHCI from commits ece5e5bfa13
and 224d10ff5ae.

Maybe an attempt to write SDHCI qtests via PCI?

>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>
>> +/* --- qdev PCI --- */
>> +
>>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>>  {
>>      SDHCIState *s = PCI_SDHCI(dev);
>> @@ -1295,7 +1299,7 @@ static void sdhci_pci_class_init(ObjectClass *klass, void *data)
>>      k->class_id = PCI_CLASS_SYSTEM_SDHCI;
>>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>>      dc->vmsd = &sdhci_vmstate;
>> -    dc->props = sdhci_pci_properties;
>> +    dc->props = sdhci_properties;
>>      dc->reset = sdhci_poweron_reset;
>>  }
>>
>> @@ -1310,14 +1314,7 @@ static const TypeInfo sdhci_pci_info = {
>>      },
>>  };
>>
>> -static Property sdhci_sysbus_properties[] = {
>> -    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
>> -            SDHC_CAPAB_REG_DEFAULT),
>> -    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
>> -    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
>> -                     false),
>> -    DEFINE_PROP_END_OF_LIST(),
>> -};
>> +/* --- qdev SysBus --- */
