Received: from eggs.gnu.org ([2001:4830:134:3::10]:49432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ejQCk-0006uj-FN
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ejQCh-0007xd-AE
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:56:06 -0500
References: <20180207121027.32466-1-lersek@redhat.com>
	<ca07e122-dedc-91cc-7469-8518618349ae@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ca1c246c-322e-95bd-9f9e-248a8b875d38@redhat.com>
Date: Wed, 7 Feb 2018 14:55:42 +0100
MIME-Version: 1.0
In-Reply-To: <ca07e122-dedc-91cc-7469-8518618349ae@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci-bridge/i82801b11: clear bridge
 registers on platform reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org

On 02/07/18 14:35, Marcel Apfelbaum wrote:
> Hi Laszlo,
> 
> On 07/02/2018 14:10, Laszlo Ersek wrote:
>> The "i82801b11-bridge" device model is a descendant of "base-pci-bridge"
>> (TYPE_PCI_BRIDGE). However, unlike other similar devices, such as
>>
>> - pci-bridge,
>> - pcie-pci-bridge,
>> - PCIE Root Port,
>> - xio3130 switch upstream and downstream ports,
>> - dec-21154-p2p-bridge,
>> - pbm-bridge,
>> - xilinx-pcie-root,
>>
>> "i82801b11-bridge" does not clear the bridge specific registers at
>> platform reset.
>>
>> This is a problem because devices on "i82801b11-bridge" continue to
>> respond to config space cycles after platform reset, when addressed with
>> the bus number that was previously programmed into the secondary bus
>> number register of "i82801b11-bridge". This error breaks OVMF's search for
>> extra (PXB) root buses, for example.
>>
> 
> Now I understand why we didn't catch the error until now. Nobody
> tried to use the pxb device with the dmi-pci bridge.

No, that's not correct:

- first, it's not about using pxb and dmi-pci in a *hierarchical*
(superordinate / subordinate) fashion,

- second, the reason the symptom has not been witnessed with SeaBIOS is
that SeaBIOS *suppresses* the issue.

In more detail:

(1) The setup where the problem shows up (with OVMF) is that dmi-pci and
pxb are *siblings*. (They both live on the root complex.) The breakage
is that OVMF scans for any device on any pxb's secondary bus -- in order
to deduce the pxbs' existence --, but, *before* reaching such a device,
a device that lives on the secondary bus of dmi-pci responds (because
the dmi-pci bridge remembers its 2ndary busnr from before the reboot,
and that bus number is *lower* than a real pxb's 2ndary bus number).
Under the circumstances of the scanning, *only* pxb-hosted devices
should respond, therefore OVMF mistakes dmi-pci for a pxb.

(2) The reason SeaBIOS does not tickle this QEMU issue is that the
pci_bios_init_bus_rec() function, in "src/fw/pciinit.c", preventatively
overwrites, as first step, the secondary and subordinate busnr registers
of all bridge devices (including dmi-pci) that are on the currently
processed bus:

>     /* prevent accidental access to unintended devices */
>     foreachbdf(bdf, bus) {
>         class = pci_config_readw(bdf, PCI_CLASS_DEVICE);
>         if (class == PCI_CLASS_BRIDGE_PCI) {
>             pci_config_writeb(bdf, PCI_SECONDARY_BUS, 255);
>             pci_config_writeb(bdf, PCI_SUBORDINATE_BUS, 0);
>         }
>     }

While this is not a bad idea in SeaBIOS, I honestly think the error
should be fixed in QEMU.

(And, the SeaBIOS approach is not viable in OVMF. When SeaBIOS does the
above, the bus being processed (i.e. the one on which dmi-pci lives) is
already "live"; its parent bridge already has the 2ndary bus number /
subordinate bus number registers set correctly. This is not the case
when OVMF scans for PXB extra root buses -- that search is not
hierarchical and entirely precedes enumeration / resource assignment.
The recursive traversal occurs much later, in a different UEFI driver.)

>> The device class reset method for "i82801b11-bridge" is currently NULL;
> 
> This is sad, the device was always broken.

Well, not extremely sad :) , given that we've encountered this issue
only now (and with OVMF reboot only).

Nonetheless, I did CC "qemu-stable" on the patch; I think it should be
applied to all currently supported stable releases.

> 
>> set it directly to pci_bridge_reset(), like the last three bridge models
>> in the above listing do.
>>
> 
> Thanks for catching it!
> 
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

I hope that the details I added now don't make you retract your R-b :)

Thanks!
Laszlo

>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel@redhat.com>
>> Cc: qemu-stable@nongnu.org
>> Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1541839
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>  hw/pci-bridge/i82801b11.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
>> index cb522bf30c31..ebf7f5f0e81c 100644
>> --- a/hw/pci-bridge/i82801b11.c
>> +++ b/hw/pci-bridge/i82801b11.c
>> @@ -98,6 +98,7 @@ static void i82801b11_bridge_class_init(ObjectClass *klass, void *data)
>>      k->realize = i82801b11_bridge_realize;
>>      k->config_write = pci_bridge_write_config;
>>      dc->vmsd = &i82801b11_bridge_dev_vmstate;
>> +    dc->reset = pci_bridge_reset;
>>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>>  }
>>  
>>
> 
