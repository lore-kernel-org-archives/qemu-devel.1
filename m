Received: from eggs.gnu.org ([2001:4830:134:3::10]:34496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fCEzg-000241-E3
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 21:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fCEzc-000391-E5
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 21:49:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fCEzc-00038e-8K
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 21:49:40 -0400
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-9-peterx@redhat.com>
	<2b05e076-0af9-0ee9-c076-7acc29714913@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113B5D2@SHSMSX101.ccr.corp.intel.com>
	<20180427072810.GB13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113C1C9@SHSMSX101.ccr.corp.intel.com>
	<20180427095527.GE13269@xz-mi> <20180427114029.GF13269@xz-mi>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b622b7f9-e7bf-20a3-6c1f-623a91c753f4@redhat.com>
Date: Sat, 28 Apr 2018 09:49:28 +0800
MIME-Version: 1.0
In-Reply-To: <20180427114029.GF13269@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] intel-iommu: maintain per-device
 iova ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>



On 2018=E5=B9=B404=E6=9C=8827=E6=97=A5 19:40, Peter Xu wrote:
> On Fri, Apr 27, 2018 at 05:55:27PM +0800, Peter Xu wrote:
>> On Fri, Apr 27, 2018 at 07:44:07AM +0000, Tian, Kevin wrote:
>>>> From: Peter Xu [mailto:peterx@redhat.com]
>>>> Sent: Friday, April 27, 2018 3:28 PM
>>>>
>>>> On Fri, Apr 27, 2018 at 07:02:14AM +0000, Tian, Kevin wrote:
>>>>>> From: Jason Wang [mailto:jasowang@redhat.com]
>>>>>> Sent: Friday, April 27, 2018 2:08 PM
>>>>>>
>>>>>> On 2018=E5=B9=B404=E6=9C=8825=E6=97=A5 12:51, Peter Xu wrote:
>>>>>>> For each VTDAddressSpace, now we maintain what IOVA ranges we
>>>> have
>>>>>>> mapped and what we have not.  With that information, now we only
>>>>>> send
>>>>>>> MAP or UNMAP when necessary.  Say, we don't send MAP notifies if
>>>> we
>>>>>> know
>>>>>>> we have already mapped the range, meanwhile we don't send
>>>> UNMAP
>>>>>> notifies
>>>>>>> if we know we never mapped the range at all.
>>>>>>>
>>>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>>>> ---
>>>>>>>    include/hw/i386/intel_iommu.h |  2 ++
>>>>>>>    hw/i386/intel_iommu.c         | 28 +++++++++++++++++++++++++++=
+
>>>>>>>    hw/i386/trace-events          |  2 ++
>>>>>>>    3 files changed, 32 insertions(+)
>>>>>>>
>>>>>>> diff --git a/include/hw/i386/intel_iommu.h
>>>>>> b/include/hw/i386/intel_iommu.h
>>>>>>> index 486e205e79..09a2e94404 100644
>>>>>>> --- a/include/hw/i386/intel_iommu.h
>>>>>>> +++ b/include/hw/i386/intel_iommu.h
>>>>>>> @@ -27,6 +27,7 @@
>>>>>>>    #include "hw/i386/ioapic.h"
>>>>>>>    #include "hw/pci/msi.h"
>>>>>>>    #include "hw/sysbus.h"
>>>>>>> +#include "qemu/interval-tree.h"
>>>>>>>
>>>>>>>    #define TYPE_INTEL_IOMMU_DEVICE "intel-iommu"
>>>>>>>    #define INTEL_IOMMU_DEVICE(obj) \
>>>>>>> @@ -95,6 +96,7 @@ struct VTDAddressSpace {
>>>>>>>        QLIST_ENTRY(VTDAddressSpace) next;
>>>>>>>        /* Superset of notifier flags that this address space has =
*/
>>>>>>>        IOMMUNotifierFlag notifier_flags;
>>>>>>> +    ITTree *iova_tree;          /* Traces mapped IOVA ranges */
>>>>>>>    };
>>>>>>>
>>>>>>>    struct VTDBus {
>>>>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>>>>> index a19c18b8d4..8f396a5d13 100644
>>>>>>> --- a/hw/i386/intel_iommu.c
>>>>>>> +++ b/hw/i386/intel_iommu.c
>>>>>>> @@ -768,12 +768,37 @@ typedef struct {
>>>>>>>    static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
>>>>>>>                                 vtd_page_walk_info *info)
>>>>>>>    {
>>>>>>> +    VTDAddressSpace *as =3D info->as;
>>>>>>>        vtd_page_walk_hook hook_fn =3D info->hook_fn;
>>>>>>>        void *private =3D info->private;
>>>>>>> +    ITRange *mapped =3D it_tree_find(as->iova_tree, entry->iova,
>>>>>>> +                                   entry->iova + entry->addr_mas=
k);
>>>>>>>
>>>>>>>        assert(hook_fn);
>>>>>>> +
>>>>>>> +    /* Update local IOVA mapped ranges */
>>>>>>> +    if (entry->perm) {
>>>>>>> +        if (mapped) {
>>>>>>> +            /* Skip since we have already mapped this range */
>>>>>>> +            trace_vtd_page_walk_one_skip_map(entry->iova, entry-
>>>>>>> addr_mask,
>>>>>>> +                                             mapped->start, mapp=
ed->end);
>>>>>>> +            return 0;
>>>>>>> +        }
>>>>>>> +        it_tree_insert(as->iova_tree, entry->iova,
>>>>>>> +                       entry->iova + entry->addr_mask);
>>>>>> I was consider a case e.g:
>>>>>>
>>>>>> 1) map A (iova) to B (pa)
>>>>>> 2) invalidate A
>>>>>> 3) map A (iova) to C (pa)
>>>>>> 4) invalidate A
>>>>>>
>>>>>> In this case, we will probably miss a walk here. But I'm not sure =
it was
>>>>>> allowed by the spec (though I think so).
>>>>>>
>>>> Hi, Kevin,
>>>>
>>>> Thanks for joining the discussion.
>>>>
>>>>> I thought it was wrong in a glimpse, but then changed my mind after
>>>>> another thinking. As long as device driver can quiescent the device
>>>>> to not access A (iova) within above window, then above sequence
>>>>> has no problem since any stale mappings (A->B) added before step 4)
>>>>> won't be used and then will get flushed after step 4). Regarding to
>>>>> that actually the 1st invalidation can be skipped:
>>>>>
>>>>> 1) map A (iova) to B (pa)
>>>>> 2) driver programs device to use A
>>>>> 3) driver programs device to not use A
>>>>> 4) map A (iova) to C (pa)
>>>>> 	A->B may be still valid in IOTLB
>>>>> 5) invalidate A
>>>>> 6) driver programs device to use A
>>>> Note that IMHO this is a bit different from Jason's example, and it'=
ll
>>>> be fine.  Current code should work well with this scenario since the
>>>> emulation code will not aware of the map A until step (5).  Then we'=
ll
>>>> have the correct mapping.
>>> you are right. we still need the extra PSI otherwise the 1st mapping
>>> is problematic for use. So back to Jason's example.
>>>
>>>> While for Jason's example it's exactly the extra PSI that might caus=
e
>>>> stale mappings (though again I think it's still problematic...).
>>> problematic in software side (e.g. that way IOMMU core relies on
>>> device drivers which conflict with the value of using IOMMU) but
>>> it is OK from hardware p.o.v. btw the extra PSI itself doesn't cause
>>> stale mapping. Instead it is device activity after that PSI may cause=
 it.
>>>
>>>> Actually I think I can just fix up the code even if Jason's case
>>>> happens by unmapping that first then remap:
>>>>
>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>> index 31e9b52452..2a9584f9d8 100644
>>>> --- a/hw/i386/intel_iommu.c
>>>> +++ b/hw/i386/intel_iommu.c
>>>> @@ -778,13 +778,21 @@ static int vtd_page_walk_one(IOMMUTLBEntry
>>>> *entry, int level,
>>>>       /* Update local IOVA mapped ranges */
>>>>       if (entry->perm) {
>>>>           if (mapped) {
>>>> -            /* Skip since we have already mapped this range */
>>>> -            trace_vtd_page_walk_one_skip_map(entry->iova, entry-
>>>>> addr_mask,
>>>> -                                             mapped->start, mapped-=
>end);
>>>> -            return 0;
>>>> +            int ret;
>>>> +            /* Cache the write permission */
>>>> +            IOMMUAccessFlags flags =3D entry->perm;
>>>> +
>>>> +            /* UNMAP the old first then remap.  No need to touch IO=
VA tree */
>>>> +            entry->perm =3D IOMMU_NONE;
>>>> +            ret =3D hook_fn(entry, private);
>>>> +            if (ret) {
>>>> +                return ret;
>>>> +            }
>>>> +            entry->perm =3D flags;
>>>> +        } else {
>>>> +            it_tree_insert(as->iova_tree, entry->iova,
>>>> +                           entry->iova + entry->addr_mask);
>>>>           }
>>>> -        it_tree_insert(as->iova_tree, entry->iova,
>>>> -                       entry->iova + entry->addr_mask);
>>>>       } else {
>>>>           if (!mapped) {
>>>>               /* Skip since we didn't map this range at all */
>>>>
>>>> If we really think it necessary, I can squash this in, though this i=
s
>>>> a bit ugly.  But I just want to confirm whether this would be anythi=
ng
>>>> we want...
>>>>
>>> I didn=E2=80=99t look into your actual code yet. If others think abov=
e
>>> change is OK then it's definitely good as we conform to hardware
>>> behavior here. Otherwise if there is a way to detect such unusual
>>> usage and then adopt some action (say kill the VM), it's also fine
>>> since user knows he runs a bad OS which is not supported by
>>> Qemu. It's just not good if such situation is not handled, which
>>> leads to some undefined behavior which nobody knows the reason
>>> w/o hard debug into. :-)
>> Yeah, then let me do this. :)
>>
>> Jason, would you be good with above change squashed?
> Self NAK on this...
>
> More than half of the whole series tries to solve the solo problem
> that we unmapped some pages that were already mapped, which proved to
> be wrong.  Now if we squash the change we will do the same wrong
> thing, so we'll still have a very small window that the remapped page
> be missing from a device's POV.
>
> Now to solve this I suppose we'll need to cache every translation then
> we can know whether a mapping has changed, and we only remap when it
> really has changed.  But I'm afraid that can be a big amount of data
> for nested guests.  For a most common 4G L2 guest, I think the worst
> case (e.g., no huge page at all, no continuous pages) is 4G/4K=3D1M
> entries in that tree.
>
> Is it really worth it to solve this possibly-buggy-guest-OS problem
> with such a overhead?  I don't know..
>
> I'm not sure whether it's still acceptable that we put this issue
> aside.  We should know that normal OSs should not do this, and if they
> do, IMHO it proves a buggy OS already (so even from hardware POV we
> allow this, from software POV it should still be problematic), then
> it'll have problem for sure, but only within the VM itself, and it
> won't affect other VMs or the host.  That sounds still reasonable to
> me so far.
>
> Of course I'm always willing to listen to more advice on this.
>
> Thanks,
>

I think as qemu, we need to emulate exactly the behavior of hardware,=20
otherwise there's will be bugs that is too hard to debug. Looking at the=20
history of e1000 emulation code, we even try to emulate undocumented=20
behavior of hardware to unbreak some non-popular operating systems.

Thanks
