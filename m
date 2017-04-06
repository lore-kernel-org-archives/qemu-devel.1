Received: from eggs.gnu.org ([2001:4830:134:3::10]:48518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cw5dC-0004Kq-9R
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cw5d9-0000iB-5A
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:31:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1cw5d8-0000hh-SM
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:31:11 -0400
References: <1491462524-1617-1-git-send-email-peterx@redhat.com>
	<1491462524-1617-3-git-send-email-peterx@redhat.com>
	<7e00fb5f-fe48-1e8f-3441-eacacf67e931@redhat.com>
	<20170406111227.GB3981@pxdev.xzpeter.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8bbb752a-61b1-e2f9-f4cf-a603ec7fa565@redhat.com>
Date: Thu, 6 Apr 2017 13:30:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170406111227.GB3981@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 2/9] memory: provide
 IOMMU_NOTIFIER_FOREACH macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, bd.aviv@gmail.com, David Gibson <david@gibson.dropbear.id.au>

Hi,

On 06/04/2017 13:12, Peter Xu wrote:
> On Thu, Apr 06, 2017 at 12:45:59PM +0200, Auger Eric wrote:
>> Hi Peter,
>> On 06/04/2017 09:08, Peter Xu wrote:
>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> Even if the commit message is obvious it may be requested?
> 
> Do you mean we'd better provide a commit message?
> 
> How about this:
> 
>   A new macro is provided to iterate all the IOMMU notifiers hooked
>   under specific IOMMU memory region.
yep perfect

Eric
> 
> Thanks,
> 
>>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>
>>> ---
>>>  include/exec/memory.h | 3 +++
>>>  memory.c              | 4 ++--
>>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index 0840c89..07e43da 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -239,6 +239,9 @@ struct MemoryRegion {
>>>      IOMMUNotifierFlag iommu_notify_flags;
>>>  };
>>>  
>>> +#define IOMMU_NOTIFIER_FOREACH(n, mr) \
>>> +    QLIST_FOREACH((n), &(mr)->iommu_notify, node)
>>> +
>>>  /**
>>>   * MemoryListener: callbacks structure for updates to the physical memory map
>>>   *
>>> diff --git a/memory.c b/memory.c
>>> index 75ac595..7496b3d 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -1583,7 +1583,7 @@ static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
>>>      IOMMUNotifierFlag flags = IOMMU_NOTIFIER_NONE;
>>>      IOMMUNotifier *iommu_notifier;
>>>  
>>> -    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
>>> +    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
>>>          flags |= iommu_notifier->notifier_flags;
>>>      }
>>>  
>>> @@ -1667,7 +1667,7 @@ void memory_region_notify_iommu(MemoryRegion *mr,
>>>          request_flags = IOMMU_NOTIFIER_UNMAP;
>>>      }
>>>  
>>> -    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
>>> +    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
>>>          /*
>>>           * Skip the notification if the notification does not overlap
>>>           * with registered range.
>>>
> 
> -- peterx
> 
