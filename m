Received: from eggs.gnu.org ([2001:4830:134:3::10]:55066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eS4HA-0001ZG-TC
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eS4H4-0007VG-DD
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:04:56 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:42227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eS4H4-0007Ut-88
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:04:50 -0500
Received: by mail-io0-x243.google.com with SMTP id x67so15626170ioi.9
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 09:04:50 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20171221161949-mutt-send-email-mst@kernel.org>
References: <20171218151244.9975-1-f4bug@amsat.org>
	<20171218151244.9975-4-f4bug@amsat.org>
	<20171221161949-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Dec 2017 14:04:48 -0300
Message-ID: <CAAdtpL78hATJrxYbCsw9dooa1S09WENiMb=LP+Y5AFAu_NF2KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] hw/pci-host/xilinx: QOM'ify the
 AXI-PCIe host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, James Hogan <jhogan@kernel.org>

On Thu, Dec 21, 2017 at 11:20 AM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> On Mon, Dec 18, 2017 at 12:12:43PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> v2: use 'pci_dev' variable, replaced hw_error() -> error_setg()
>>
>>  hw/pci-host/xilinx-pcie.c | 20 +++++++++-----------
>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
>> index 7659253090..681fdf486a 100644
>> --- a/hw/pci-host/xilinx-pcie.c
>> +++ b/hw/pci-host/xilinx-pcie.c
>> @@ -267,24 +267,22 @@ static void xilinx_pcie_root_config_write(PCIDevic=
e *d, uint32_t address,
>>      }
>>  }
>>
>> -static int xilinx_pcie_root_init(PCIDevice *dev)
>> +static void xilinx_pcie_root_realize(PCIDevice *pci_dev, Error **errp)
>>  {
>> -    BusState *bus =3D qdev_get_parent_bus(DEVICE(dev));
>> +    BusState *bus =3D qdev_get_parent_bus(DEVICE(pci_dev));
>>      XilinxPCIEHost *s =3D XILINX_PCIE_HOST(bus->parent);
>>
>> -    pci_set_word(dev->config + PCI_COMMAND,
>> +    pci_set_word(pci_dev->config + PCI_COMMAND,
>>                   PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
>> -    pci_set_word(dev->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
>> -    pci_set_word(dev->config + PCI_MEMORY_LIMIT,
>> +    pci_set_word(pci_dev->config + PCI_MEMORY_BASE, s->mmio_base >> 16)=
;
>> +    pci_set_word(pci_dev->config + PCI_MEMORY_LIMIT,
>>                   ((s->mmio_base + s->mmio_size - 1) >> 16) & 0xfff0);
>>
>> -    pci_bridge_initfn(dev, TYPE_PCI_BUS);
>> +    pci_bridge_initfn(pci_dev, TYPE_PCI_BUS);
>>
>> -    if (pcie_endpoint_cap_v1_init(dev, 0x80) < 0) {
>> -        hw_error("Failed to initialize PCIe capability");
>> +    if (pcie_endpoint_cap_v1_init(pci_dev, 0x80) < 0) {
>> +        error_setg(errp, "Failed to initialize PCIe capability");
>>      }
>
> This file doesn't include qapi/error.h so this makes build fail on
> mingw. Fixed it up, pls take care in the future.

Oops :| Thanks for fixing it.
I will.

>> -
>> -    return 0;
>>  }
>>
>>  static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
>> @@ -300,7 +298,7 @@ static void xilinx_pcie_root_class_init(ObjectClass =
*klass, void *data)
>>      k->class_id =3D PCI_CLASS_BRIDGE_HOST;
>>      k->is_express =3D true;
>>      k->is_bridge =3D true;
>> -    k->init =3D xilinx_pcie_root_init;
>> +    k->realize =3D xilinx_pcie_root_realize;
>>      k->exit =3D pci_bridge_exitfn;
>>      dc->reset =3D pci_bridge_reset;
>>      k->config_read =3D xilinx_pcie_root_config_read;
>> --
>> 2.15.1
