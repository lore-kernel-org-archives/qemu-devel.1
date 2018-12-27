Received: from eggs.gnu.org ([208.118.235.92]:52235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gcUoe-0001nb-Dl
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 07:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gcUob-0005Dd-5W
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 07:31:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1gcUoa-0005Cl-Rn
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 07:31:05 -0500
References: <099db937-3fa3-465e-9a23-a900df9adb7c@default>
	<20181201122937.222f66da@x1.home>
	<8f06611d-7b1e-5934-648c-f4cd7626fe63@oracle.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <55d8a52e-7c0e-aa5b-ced2-176619e5c661@oracle.com>
Date: Thu, 27 Dec 2018 20:30:48 +0800
MIME-Version: 1.0
In-Reply-To: <8f06611d-7b1e-5934-648c-f4cd7626fe63@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] vfio failure with intel 760p 128GB nvme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: keith.busch@intel.com, qemu-devel@nongnu.org, coffmaker@gmail.com, maximlevitsky@gmail.com

Hi Alex,

On 12/02/2018 09:29 AM, Dongli Zhang wrote:
> Hi Alex,
> 
> On 12/02/2018 03:29 AM, Alex Williamson wrote:
>> On Sat, 1 Dec 2018 10:52:21 -0800 (PST)
>> Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>
>>> Hi,
>>>
>>> I obtained below error when assigning an intel 760p 128GB nvme to guest via
>>> vfio on my desktop:
>>>
>>> qemu-system-x86_64: -device vfio-pci,host=0000:01:00.0: vfio 0000:01:00.0: failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or they don't fit in BARs, or don't align
>>>
>>>
>>> This is because the msix table is overlapping with pba. According to below
>>> 'lspci -vv' from host, the distance between msix table offset and pba offset is
>>> only 0x100, although there are 22 entries supported (22 entries need 0x160).
>>> Looks qemu supports at most 0x800.
>>>
>>> # sudo lspci -vv
>>> ... ...
>>> 01:00.0 Non-Volatile memory controller: Intel Corporation Device f1a6 (rev 03) (prog-if 02 [NVM Express])
>>> 	Subsystem: Intel Corporation Device 390b
>>> ... ...
>>> 	Capabilities: [b0] MSI-X: Enable- Count=22 Masked-
>>> 		Vector table: BAR=0 offset=00002000
>>> 		PBA: BAR=0 offset=00002100
>>>
>>>
>>>
>>> A patch below could workaround the issue and passthrough nvme successfully.
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 5c7bd96..54fc25e 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -1510,6 +1510,11 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>>>      msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
>>>      msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
>>>  
>>> +    if (msix->table_bar == msix->pba_bar &&
>>> +        msix->table_offset + msix->entries * PCI_MSIX_ENTRY_SIZE > msix->pba_offset) {
>>> +        msix->entries = (msix->pba_offset - msix->table_offset) / PCI_MSIX_ENTRY_SIZE;
>>> +    }
>>> +
>>>      /*
>>>       * Test the size of the pba_offset variable and catch if it extends outside
>>>       * of the specified BAR. If it is the case, we need to apply a hardware
>>>
>>>
>>> Would you please help confirm if this can be regarded as bug in qemu, or issue
>>> with nvme hardware? Should we fix thin in qemu, or we should never use such buggy
>>> hardware with vfio?
>>
>> It's a hardware bug, is there perhaps a firmware update for the device
>> that resolves it?  It's curious that a vector table size of 0x100 gives
>> us 16 entries and 22 in hex is 0x16 (table size would be reported as
>> 0x15 for the N-1 algorithm).  I wonder if there's a hex vs decimal
>> mismatch going on.  We don't really know if the workaround above is
>> correct, are there really 16 entries or maybe does the PBA actually
>> start at a different offset?  We wouldn't want to generically assume
>> one or the other.  I think we need Intel to tell us in which way their
>> hardware is broken and whether it can or is already fixed in a firmware
>> update.  Thanks,
> 
> Thank you very much for the confirmation.
> 
> Just realized looks this would make trouble to my desktop as well when 17
> vectors are used.
> 
> I will report to intel and confirm how this can happen and if there is any
> firmware update available for this issue.
> 

I found there is similar issue reported to kvm:

https://bugzilla.kernel.org/show_bug.cgi?id=202055


I confirmed with my env again. By default, the msi-x count is 16.

	Capabilities: [b0] MSI-X: Enable+ Count=16 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00002100


The count is still 16 after the device is assigned to vfio (Enable- now):

# echo 0000:01:00.0 > /sys/bus/pci/devices/0000\:01\:00.0/driver/unbind
# echo "8086 f1a6" > /sys/bus/pci/drivers/vfio-pci/new_id

Capabilities: [b0] MSI-X: Enable- Count=16 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00002100


After I boot qemu with "-device vfio-pci,host=0000:01:00.0", count becomes 22.

Capabilities: [b0] MSI-X: Enable- Count=22 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00002100



Another interesting observation is, vfio-based userspace nvme also changes count
from 16 to 22.

I reboot host and the count is reset to 16. Then I boot VM with "-drive
file=nvme://0000:01:00.0/1,if=none,id=nvmedrive0 -device
virtio-blk,drive=nvmedrive0,id=nvmevirtio0". As userspace nvme uses different
vfio path, it boots successfully without issue.

However, the count becomes 22 then:

Capabilities: [b0] MSI-X: Enable- Count=22 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00002100


Both vfio and userspace nvme (based on vfio) would change the count from 16 to 22.

Dongli Zhang
