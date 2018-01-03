Received: from eggs.gnu.org ([2001:4830:134:3::10]:37754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWgUK-0001dS-8Q
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWgUJ-0008OH-Bp
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:41:36 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:36954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWgUJ-0008O7-7t
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:41:35 -0500
Received: by mail-it0-x244.google.com with SMTP id d137so1348122itc.2
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 02:41:35 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <17a6da8e-0760-535c-1e7a-bf245fb12e3c@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
	<20171229174933.1781-8-f4bug@amsat.org>
	<20180103075633.GE25984@localhost.localdomain>
	<17a6da8e-0760-535c-1e7a-bf245fb12e3c@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 3 Jan 2018 07:41:33 -0300
Message-ID: <CAAdtpL4UtqkyqJvdn2BZ23CD6f34_mv_y1MRnFyQq3PKb8x4wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/42] sdhci: refactor common sysbus/pci
 unrealize() into sdhci_unrealizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Xiaoqiang Zhao <zxq_yx_007@163.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

> On 01/03/2018 04:56 AM, Fam Zheng wrote:
>> On Fri, 12/29 14:48, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  hw/sd/sdhci.c | 19 ++++++++++++++++---
>>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>> index ad5853d527..06a1ec6f91 100644
>>> --- a/hw/sd/sdhci.c
>>> +++ b/hw/sd/sdhci.c
>>> @@ -31,6 +31,7 @@
>>>  #include "qemu/bitops.h"
>>>  #include "hw/sd/sdhci.h"
>>>  #include "sdhci-internal.h"
>>> +#include "qapi/error.h"
>>>  #include "qemu/log.h"
>>>
>>>  /* host controller debug messages */
>>> @@ -1203,15 +1204,17 @@ static void sdhci_realizefn(SDHCIState *s, Erro=
r **errp)
>>>                            SDHC_REGISTERS_MAP_SIZE);
>>>  }
>>>
>>> +static void sdhci_unrealizefn(SDHCIState *s, Error **errp)
>>> +{
>>> +    g_free(s->fifo_buffer);
>>
>> Set s->fifo_buffer to NULL to avoid double-free and/or use-after-free?
>> Especially since you call this from both the ->exit and the ->unrealize
>> callbacks.
>
> Yes, I agree this would be safer. I'll also add a comment around.

The sysbus class sets the DeviceClass->unrealize(),
the pci class only sets PCIDeviceClass->exit(),
so in both cases sdhci_unrealizefn() is only called once.

Still, better to set this to NULL to protect any further use/refactor
of this code.

>>> +}
>>> +
>>>  static void sdhci_uninitfn(SDHCIState *s)
>>>  {
>>>      timer_del(s->insert_timer);
>>>      timer_free(s->insert_timer);
>>>      timer_del(s->transfer_timer);
>>>      timer_free(s->transfer_timer);
>>> -
>>> -    g_free(s->fifo_buffer);
>>> -    s->fifo_buffer =3D NULL;
>>>  }
>>>
>>>  static bool sdhci_pending_insert_vmstate_needed(void *opaque)
>>> @@ -1312,6 +1315,8 @@ static void sdhci_pci_realize(PCIDevice *dev, Err=
or **errp)
>>>  static void sdhci_pci_exit(PCIDevice *dev)
>>>  {
>>>      SDHCIState *s =3D PCI_SDHCI(dev);
>>> +
>>> +    sdhci_unrealizefn(s, &error_abort);
>>>      sdhci_uninitfn(s);
>>>  }
>>>
>>> @@ -1365,11 +1370,19 @@ static void sdhci_sysbus_realize(DeviceState *d=
ev, Error ** errp)
>>>      sysbus_init_mmio(sbd, &s->iomem);
>>>  }
>>>
>>> +static void sdhci_sysbus_unrealize(DeviceState *dev, Error **errp)
>>> +{
>>> +    SDHCIState *s =3D SYSBUS_SDHCI(dev);
>>> +
>>> +    sdhci_unrealizefn(s, errp);
>>> +}
>>> +
>>>  static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
>>>  {
>>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>>>
>>>      dc->realize =3D sdhci_sysbus_realize;
>>> +    dc->unrealize =3D sdhci_sysbus_unrealize;
>>>
>>>      sdhci_class_init(klass, data);
>>>  }
>>> --
>>> 2.15.1
>>>
>>>
>>
>> Fam
>>
