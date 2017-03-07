Received: from eggs.gnu.org ([2001:4830:134:3::10]:53983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1clA30-0004nQ-JJ
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1clA2w-0008Sw-KK
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:00:42 -0500
Received: from [59.151.112.132] (port=8520 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1clA2v-0008QO-Hl
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:00:38 -0500
References: <1488011202-32121-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1488011202-32121-2-git-send-email-caoj.fnst@cn.fujitsu.com>
	<87tw75il8m.fsf@dusky.pond.sub.org>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58BE6A80.7010108@cn.fujitsu.com>
Date: Tue, 7 Mar 2017 16:08:32 +0800
MIME-Version: 1.0
In-Reply-To: <87tw75il8m.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 1/8] msix: Rename and create a wrapper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 03/07/2017 03:44 PM, Markus Armbruster wrote:
> Uh, two weeks since your posted this already.  I apologize for taking so
> long to review.
> 
> Cao jin <caoj.fnst@cn.fujitsu.com> writes:
> 
>> Rename msix_init to msix_validate_and_init, and use it from vfio which
>> might get a reasonable -EINVAL.  New a wrapper msix_init which assert the
>> programming error for debug purpose and use it from other devices.
>>
>> CC: Alex Williamson <alex.williamson@redhat.com>
>> CC: Markus Armbruster <armbru@redhat.com>
>> CC: Marcel Apfelbaum <marcel@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>>  hw/pci/msix.c         | 30 +++++++++++++++++++++---------
>>  hw/vfio/pci.c         | 12 ++++++------
>>  include/hw/pci/msix.h |  5 +++++
>>  3 files changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
>> index bb54e8b0ac37..2b7541ab2c8d 100644
>> --- a/hw/pci/msix.c
>> +++ b/hw/pci/msix.c
>> @@ -239,6 +239,19 @@ static void msix_mask_all(struct PCIDevice *dev, unsigned nentries)
>>      }
>>  }
>>  
>> +/* Just a wrapper to check the return value */
>> +int msix_init(struct PCIDevice *dev, unsigned short nentries,
>> +              MemoryRegion *table_bar, uint8_t table_bar_nr,
>> +              unsigned table_offset, MemoryRegion *pba_bar,
>> +              uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
>> +              Error **errp)
>> +{
>> +    int ret = msix_validate_and_init(dev, nentries, table_bar, table_bar_nr,
>> +            table_offset, pba_bar, pba_bar_nr, pba_offset, cap_pos, errp);
>> +
>> +    assert(ret != -EINVAL);
>> +    return ret;
>> +}
>>  /*
>>   * Make PCI device @dev MSI-X capable
>>   * @nentries is the max number of MSI-X vectors that the device support.
>> @@ -259,11 +272,11 @@ static void msix_mask_all(struct PCIDevice *dev, unsigned nentries)
>>   * also means a programming error, except device assignment, which can check
>>   * if a real HW is broken.
>>   */
>> -int msix_init(struct PCIDevice *dev, unsigned short nentries,
>> -              MemoryRegion *table_bar, uint8_t table_bar_nr,
>> -              unsigned table_offset, MemoryRegion *pba_bar,
>> -              uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
>> -              Error **errp)
>> +int msix_validate_and_init(struct PCIDevice *dev, unsigned short nentries,
>> +                           MemoryRegion *table_bar, uint8_t table_bar_nr,
>> +                           unsigned table_offset, MemoryRegion *pba_bar,
>> +                           uint8_t pba_bar_nr, unsigned pba_offset,
>> +                           uint8_t cap_pos, Error **errp)
>>  {
>>      int cap;
>>      unsigned table_size, pba_size;
>> @@ -361,10 +374,9 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
>>      memory_region_init(&dev->msix_exclusive_bar, OBJECT(dev), name, bar_size);
>>      g_free(name);
>>  
>> -    ret = msix_init(dev, nentries, &dev->msix_exclusive_bar, bar_nr,
>> -                    0, &dev->msix_exclusive_bar,
>> -                    bar_nr, bar_pba_offset,
>> -                    0, errp);
>> +    ret = msix_validate_and_init(dev, nentries, &dev->msix_exclusive_bar,
>> +                                 bar_nr, 0, &dev->msix_exclusive_bar,
>> +                                 bar_nr, bar_pba_offset, 0, errp);
>>      if (ret) {
>>          return ret;
>>      }
> 
> This change assumes that for the callers of msix_exclusive_bar(),
> -EINVAL (capability overlap) is not a programming error.  Is that true?
> 

Oh...it looks as you said. Will revert this part and send a new one
in-reply-to this one.

-- 
Sincerely,
Cao jin
