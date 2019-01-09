Received: from eggs.gnu.org ([209.51.188.92]:55334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ghCH2-0000ur-D1
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ghCH1-0004mf-Fd
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:43:52 -0500
From: David Hildenbrand <david@redhat.com>
References: <1546969050-8884-1-git-send-email-pmorel@linux.ibm.com>
	<1546969050-8884-2-git-send-email-pmorel@linux.ibm.com>
	<be2d1126-45a9-ace2-bf85-18f255815572@redhat.com>
Message-ID: <e5c4fa66-b83d-7f98-4f05-ccf26375a3ac@redhat.com>
Date: Wed, 9 Jan 2019 12:43:43 +0100
MIME-Version: 1.0
In-Reply-To: <be2d1126-45a9-ace2-bf85-18f255815572@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7] s390x/pci: add common function
 measurement block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>, walling@linux.ibm.com
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

On 09.01.19 12:29, David Hildenbrand wrote:
> On 08.01.19 18:37, Pierre Morel wrote:
>> From: Yi Min Zhao <zyimin@linux.ibm.com>
>>
>> Common function measurement block is used to report zPCI internal
>> counters of successful pcilg/stg/stb and rpcit instructions to
>> a memory location provided by the program.
>>
>> This patch introduces a new ZpciFmb structure and schedules a timer
>> callback to copy the zPCI measures to the FMB in the guest memory
>> at an interval time set to 4s.
>>
>> An error while attemping to update the FMB, would generate an error
>> event to the guest.
>>
>> The pcilg/stg/stb and rpcit interception handlers increase the
>> related counter on a successful call.
>> The guest shall pass a null FMBA (FMB address) in the FIB (Function
>> Information Block) when it issues a Modify PCI Function Control
>> instruction to switch off FMB and stop the corresponding timer.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>  hw/s390x/s390-pci-bus.c  |   4 +-
>>  hw/s390x/s390-pci-bus.h  |  29 +++++++++++
>>  hw/s390x/s390-pci-inst.c | 133 +++++++++++++++++++++++++++++++++++++++++++++--
>>  hw/s390x/s390-pci-inst.h |   1 +
>>  4 files changed, 163 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 060ff06..f0d34dd 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -989,6 +989,7 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
>>      bus = pci_get_bus(pci_dev);
>>      devfn = pci_dev->devfn;
>>      object_unparent(OBJECT(pci_dev));
>> +    fmb_timer_free(pbdev);
> 
> I still think this is the wrong place. it has nothing to do with
> hotplug/unplug. This belongs into unrealize/finalize.
> 
> 

... but I see the issue. It boils down to the bad design of zPCI. The
PCI device has no clue about the pbdev. So this has to stay here because
in unrealize of pbdev it would be wrong and into unrealize of pci_dev,
we can't move it.

-- 

Thanks,

David / dhildenb
