Received: from eggs.gnu.org ([2001:4830:134:3::10]:38742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gTGaB-00039X-IZ
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 20:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gTGa8-00045S-El
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 20:30:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1gTGa8-00044m-5w
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 20:30:00 -0500
References: <099db937-3fa3-465e-9a23-a900df9adb7c@default>
	<20181201122937.222f66da@x1.home>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <8f06611d-7b1e-5934-648c-f4cd7626fe63@oracle.com>
Date: Sun, 2 Dec 2018 09:29:52 +0800
MIME-Version: 1.0
In-Reply-To: <20181201122937.222f66da@x1.home>
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
Cc: keith.busch@intel.com, qemu-devel@nongnu.org

Hi Alex,

On 12/02/2018 03:29 AM, Alex Williamson wrote:
> On Sat, 1 Dec 2018 10:52:21 -0800 (PST)
> Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
>> Hi,
>>
>> I obtained below error when assigning an intel 760p 128GB nvme to guest via
>> vfio on my desktop:
>>
>> qemu-system-x86_64: -device vfio-pci,host=0000:01:00.0: vfio 0000:01:00.0: failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or they don't fit in BARs, or don't align
>>
>>
>> This is because the msix table is overlapping with pba. According to below
>> 'lspci -vv' from host, the distance between msix table offset and pba offset is
>> only 0x100, although there are 22 entries supported (22 entries need 0x160).
>> Looks qemu supports at most 0x800.
>>
>> # sudo lspci -vv
>> ... ...
>> 01:00.0 Non-Volatile memory controller: Intel Corporation Device f1a6 (rev 03) (prog-if 02 [NVM Express])
>> 	Subsystem: Intel Corporation Device 390b
>> ... ...
>> 	Capabilities: [b0] MSI-X: Enable- Count=22 Masked-
>> 		Vector table: BAR=0 offset=00002000
>> 		PBA: BAR=0 offset=00002100
>>
>>
>>
>> A patch below could workaround the issue and passthrough nvme successfully.
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 5c7bd96..54fc25e 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -1510,6 +1510,11 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>>      msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
>>      msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
>>  
>> +    if (msix->table_bar == msix->pba_bar &&
>> +        msix->table_offset + msix->entries * PCI_MSIX_ENTRY_SIZE > msix->pba_offset) {
>> +        msix->entries = (msix->pba_offset - msix->table_offset) / PCI_MSIX_ENTRY_SIZE;
>> +    }
>> +
>>      /*
>>       * Test the size of the pba_offset variable and catch if it extends outside
>>       * of the specified BAR. If it is the case, we need to apply a hardware
>>
>>
>> Would you please help confirm if this can be regarded as bug in qemu, or issue
>> with nvme hardware? Should we fix thin in qemu, or we should never use such buggy
>> hardware with vfio?
> 
> It's a hardware bug, is there perhaps a firmware update for the device
> that resolves it?  It's curious that a vector table size of 0x100 gives
> us 16 entries and 22 in hex is 0x16 (table size would be reported as
> 0x15 for the N-1 algorithm).  I wonder if there's a hex vs decimal
> mismatch going on.  We don't really know if the workaround above is
> correct, are there really 16 entries or maybe does the PBA actually
> start at a different offset?  We wouldn't want to generically assume
> one or the other.  I think we need Intel to tell us in which way their
> hardware is broken and whether it can or is already fixed in a firmware
> update.  Thanks,

Thank you very much for the confirmation.

Just realized looks this would make trouble to my desktop as well when 17
vectors are used.

I will report to intel and confirm how this can happen and if there is any
firmware update available for this issue.

Dongli Zhang
