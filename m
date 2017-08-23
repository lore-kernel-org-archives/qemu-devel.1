Received: from eggs.gnu.org ([2001:4830:134:3::10]:46309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkJFO-0006gv-Nk
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkJFN-0002EF-AY
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:10:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170822214343.31385-1-f4bug@amsat.org>
	<20170823014025-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6661274e-c797-1aac-14b9-43dcf4c2f336@amsat.org>
Date: Tue, 22 Aug 2017 21:10:02 -0300
MIME-Version: 1.0
In-Reply-To: <20170823014025-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.10-rc4?] acpi: pcihp: fix
 use-after-free for machines previous pc-1.7 compat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>

On 08/22/2017 07:42 PM, Michael S. Tsirkin wrote:
> On Tue, Aug 22, 2017 at 06:43:43PM -0300, Philippe Mathieu-Daudé wrote:
>> 9e047b982452 "piix4: add acpi pci hotplug support" introduced a new property
>> 'use_acpi_pci_hotplug' for pc-1.7 and older machines.
>> c24d5e0b91d1 "convert ACPI PCI hotplug to use hotplug-handler API" added the
>> qbus hotplug handlers but forgot to check for the 'use_acpi_pci_hotplug'
>> property.
>>
>> Check for use_acpi_pci_hotplug before calling acpi_pcihp_device_[un]plug_cb().
>>
>> If Xen is enabled, piix4_pm_init() disables use_acpi_pci_hotplug.
>>
>> The following valgrind Trace equivs:
>>
>>    qdev_device_add( "ich9-ahci" )
>>     -> device_set_realized()
>>      -> hotplug_handler_plug()
>>       -> piix4_device_plug_cb()
>>        -> acpi_pcihp_device_plug_cb()
>>         -> acpi_pcihp_get_bsel() "Property ACPI_PCIHP_PROP_BSEL not found"
>>     -> object_unparent()
>>       <- "Bus doesn't have property ACPI_PCIHP_PROP_BSEL set"
>>
>> $ valgrind x86_64-softmmu/qemu-system-x86_64 -M pc-1.2 -nographic -S
>> (qemu) device_add ich9-ahci,id=ich9-ahci
>> ==6604== Invalid read of size 8
>> ==6604==    at 0x609AB0: object_unparent (object.c:445)
>> ==6604==    by 0x4C4478: device_unparent (qdev.c:1095)
>> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
>> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
>> ==6604==    by 0x451728: qdev_device_add (qdev-monitor.c:634)
>> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
>> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
>> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
>> ==6604==    by 0x365439: monitor_command_cb (monitor.c:3922)
>> ==6604==    by 0x6E5D27: readline_handle_byte (readline.c:393)
>> ==6604==    by 0x364311: monitor_read (monitor.c:3905)
>> ==6604==    by 0x67C573: mux_chr_read (char-mux.c:216)
>> ==6604==  Address 0x15fc5448 is 30,328 bytes inside a block of size 36,288 free'd
>> ==6604==    at 0x4C2ACDD: free (vg_replace_malloc.c:530)
>> ==6604==    by 0xA04EBCD: g_free (in /usr/lib64/libglib-2.0.so.0.5000.3)
>> ==6604==    by 0x50100E: pci_ich9_uninit (ich.c:161)
>> ==6604==    by 0x5428AB: pci_qdev_unrealize (pci.c:1083)
>> ==6604==    by 0x4C5EE9: device_set_realized (qdev.c:988)
>> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
>> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
>> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
>> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
>> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
>> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
>> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
>> ==6604==  Block was alloc'd at
>> ==6604==    at 0x4C2B975: calloc (vg_replace_malloc.c:711)
>> ==6604==    by 0xA04EB15: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.5000.3)
>> ==6604==    by 0x50094F: ahci_realize (ahci.c:1468)
>> ==6604==    by 0x501098: pci_ich9_ahci_realize (ich.c:115)
>> ==6604==    by 0x543E6D: pci_qdev_realize (pci.c:2002)
>> ==6604==    by 0x4C5E69: device_set_realized (qdev.c:914)
>> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
>> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
>> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
>> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
>> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
>> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Message-Id: <59a56959-ca12-ea75-33fa-ff07eba1b090@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Looks like this is a very old bug, isn't it?
> Objections to merging this after the release?

Yes, I'm also inclined to delay it so we can release 2.10, I tagged 
"2.10-rc4" since Thomas sent it as a bug within the 2.10 window so I'll 
let him decide if it is worth crying wolf :) It's very likely no-one but 
him used pre-pc-i440fx-1.7 the last 3 years, not even thinking about hot 
plugging AHCI devices :D

> 
>> ---
>>   hw/acpi/piix4.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>> index f276967365..d4df209a2e 100644
>> --- a/hw/acpi/piix4.c
>> +++ b/hw/acpi/piix4.c
>> @@ -385,7 +385,7 @@ static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
>>                                   dev, errp);
>>           }
>>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> -        if (!xen_enabled()) {
>> +        if (s->use_acpi_pci_hotplug) {
>>               acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
>>                                         errp);
>>           }
>> @@ -411,7 +411,7 @@ static void piix4_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>>           acpi_memory_unplug_request_cb(hotplug_dev, &s->acpi_memory_hotplug,
>>                                         dev, errp);
>>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> -        if (!xen_enabled()) {
>> +        if (s->use_acpi_pci_hotplug) {
>>               acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
>>                                           errp);
>>           }
>> -- 
>> 2.14.1
