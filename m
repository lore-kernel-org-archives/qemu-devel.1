Received: from eggs.gnu.org ([2001:4830:134:3::10]:58235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cT1sV-0000UV-Kp
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cT1sS-0000hr-HF
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:38:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cT1sS-0000hM-8U
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:38:52 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-10-git-send-email-peterx@redhat.com>
	<11241cc6-139e-ee8f-ff54-e1ab83ecf45d@redhat.com>
	<20170116070826.GB30108@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <615060e2-9330-b150-6676-aabd394275ae@redhat.com>
Date: Mon, 16 Jan 2017 15:38:43 +0800
MIME-Version: 1.0
In-Reply-To: <20170116070826.GB30108@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 09/14] memory: introduce
 memory_region_notify_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 15:08, Peter Xu wrote:
> On Fri, Jan 13, 2017 at 03:58:59PM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 11:06, Peter Xu wrote:
>>> Generalizing the notify logic in memory_region_notify_iommu() into a
>>> single function. This can be further used in customized replay()
>>> functions for IOMMUs.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>   include/exec/memory.h | 15 +++++++++++++++
>>>   memory.c              | 29 ++++++++++++++++++-----------
>>>   2 files changed, 33 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index 2233f99..f367e54 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -669,6 +669,21 @@ void memory_region_notify_iommu(MemoryRegion *mr=
,
>>>                                   IOMMUTLBEntry entry);
>>>   /**
>>> + * memory_region_notify_one: notify a change in an IOMMU translation
>>> + *                           entry to a single notifier
>>> + *
>>> + * This works just like memory_region_notify_iommu(), but it only
>>> + * notifies a specific notifier, not all of them.
>>> + *
>>> + * @notifier: the notifier to be notified
>>> + * @entry: the new entry in the IOMMU translation table.  The entry
>>> + *         replaces all old entries for the same virtual I/O address=
 range.
>>> + *         Deleted entries have .@perm =3D=3D 0.
>>> + */
>>> +void memory_region_notify_one(IOMMUNotifier *notifier,
>>> +                              IOMMUTLBEntry *entry);
>>> +
>>> +/**
>>>    * memory_region_register_iommu_notifier: register a notifier for c=
hanges to
>>>    * IOMMU translation entries.
>>>    *
>>> diff --git a/memory.c b/memory.c
>>> index df62bd1..6e4c872 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -1665,26 +1665,33 @@ void memory_region_unregister_iommu_notifier(=
MemoryRegion *mr,
>>>       memory_region_update_iommu_notify_flags(mr);
>>>   }
>>> -void memory_region_notify_iommu(MemoryRegion *mr,
>>> -                                IOMMUTLBEntry entry)
>>> +void memory_region_notify_one(IOMMUNotifier *notifier,
>>> +                              IOMMUTLBEntry *entry)
>>>   {
>>> -    IOMMUNotifier *iommu_notifier;
>>>       IOMMUNotifierFlag request_flags;
>>> -    assert(memory_region_is_iommu(mr));
>>> -
>>> -    if (entry.perm & IOMMU_RW) {
>>> +    if (entry->perm & IOMMU_RW) {
>>>           request_flags =3D IOMMU_NOTIFIER_MAP;
>>>       } else {
>>>           request_flags =3D IOMMU_NOTIFIER_UNMAP;
>>>       }
>> Nit: you can keep this outside the loop.
> Yes, but this function is used in vtd_replay_hook() as well in latter
> patch. If I keep the above outside loop (IIUC you mean the loop in
> memory_region_notify_iommu()), I'll need to set it up as well in
> future vtd_replay_hook(), then that'll be slightly awkward.
> Considering that the notification will only happen at mapping changes,
> I'll prefer to keep the interface cleaner like what this patch has
> done.
>
> Thanks,
>
> -- peterx

Ok, I see.
