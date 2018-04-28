Received: from eggs.gnu.org ([2001:4830:134:3::10]:45298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fCGHg-0005hR-0K
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 23:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fCGHb-0000uz-T3
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 23:12:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60948 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fCGHb-0000uF-Mx
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 23:12:19 -0400
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-4-peterx@redhat.com>
	<2492f7d8-ed63-6f1c-773f-baa223020022@redhat.com>
	<20180427062615.GY9036@xz-mi>
	<ab60c407-12c7-8872-1d7c-d4f933f12979@redhat.com>
	<20180428022407.GG13269@xz-mi>
	<635e37b2-30a6-b204-3005-e3e098cb38f8@redhat.com>
	<20180428030601.GJ13269@xz-mi>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cd0a28a9-2082-9c77-0b72-f2451764bd9e@redhat.com>
Date: Sat, 28 Apr 2018 11:11:53 +0800
MIME-Version: 1.0
In-Reply-To: <20180428030601.GJ13269@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/10] intel-iommu: add iommu lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, David Gibson <david@gibson.dropbear.id.au>



On 2018=E5=B9=B404=E6=9C=8828=E6=97=A5 11:06, Peter Xu wrote:
> On Sat, Apr 28, 2018 at 10:42:11AM +0800, Jason Wang wrote:
>>
>> On 2018=E5=B9=B404=E6=9C=8828=E6=97=A5 10:24, Peter Xu wrote:
>>> On Sat, Apr 28, 2018 at 09:43:54AM +0800, Jason Wang wrote:
>>>> On 2018=E5=B9=B404=E6=9C=8827=E6=97=A5 14:26, Peter Xu wrote:
>>>>> On Fri, Apr 27, 2018 at 01:13:02PM +0800, Jason Wang wrote:
>>>>>> On 2018=E5=B9=B404=E6=9C=8825=E6=97=A5 12:51, Peter Xu wrote:
>>>>>>> Add a per-iommu big lock to protect IOMMU status.  Currently the =
only
>>>>>>> thing to be protected is the IOTLB cache, since that can be acces=
sed
>>>>>>> even without BQL, e.g., in IO dataplane.
>>>>>>>
>>>>>>> Note that device page tables should not need any protection.  The=
 safety
>>>>>>> of that should be provided by guest OS.  E.g., when a page entry =
is
>>>>>>> freed, the guest OS should be responsible to make sure that no de=
vice
>>>>>>> will be using that page any more.
>>>>>>>
>>>>>>> Reported-by: Fam Zheng<famz@redhat.com>
>>>>>>> Signed-off-by: Peter Xu<peterx@redhat.com>
>>>>>>> ---
>>>>>>>      include/hw/i386/intel_iommu.h |  8 ++++++++
>>>>>>>      hw/i386/intel_iommu.c         | 31 +++++++++++++++++++++++++=
++++--
>>>>>>>      2 files changed, 37 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/inte=
l_iommu.h
>>>>>>> index 220697253f..1a8ba8e415 100644
>>>>>>> --- a/include/hw/i386/intel_iommu.h
>>>>>>> +++ b/include/hw/i386/intel_iommu.h
>>>>>>> @@ -262,6 +262,14 @@ struct IntelIOMMUState {
>>>>>>>          uint8_t w1cmask[DMAR_REG_SIZE]; /* RW1C(Write 1 to Clear=
) bytes */
>>>>>>>          uint8_t womask[DMAR_REG_SIZE];  /* WO (write only - read=
 returns 0) */
>>>>>>>          uint32_t version;
>>>>>>> +    /*
>>>>>>> +     * Protects IOMMU states in general.  Normally we don't need=
 to
>>>>>>> +     * take this lock when we are with BQL held.  However we hav=
e code
>>>>>>> +     * paths that may run even without BQL.  In those cases, we =
need
>>>>>>> +     * to take the lock when we have access to IOMMU state
>>>>>>> +     * informations, e.g., the IOTLB.
>>>>>>> +     */
>>>>>>> +    QemuMutex iommu_lock;
>>>>>> Some questions:
>>>>>>
>>>>>> 1) Do we need to protect context cache too?
>>>>> IMHO the context cache entry should work even without lock.  That's=
 a
>>>>> bit trickly since we have two cases that this cache will be updated=
:
>>>>>
>>>>>      (1) first translation of the address space of a device
>>>>>      (2) invalidation of context entries
>>>>>
>>>>> For (2) IMHO we don't need to worry about since guest OS should be
>>>>> controlling that part, say, device should not be doing any translat=
ion
>>>>> (DMA operations) when the context entry is invalidated.
>>>>>
>>>>> For (1) the worst case is that the context entry cache be updated
>>>>> multiple times with the same value by multiple threads.  IMHO that'=
ll
>>>>> be fine too.
>>>>>
>>>>> But yes for sure we can protect that too with the iommu lock.
>>>>>
>>>>>> 2) Can we just reuse qemu BQL here?
>>>>> I would prefer not.  As I mentioned, at least I have spent too much
>>>>> time on fighting BQL already.  I really hope we can start to use
>>>>> isolated locks when capable.  BQL is always the worst choice to me.
>>>> Just a thought, using BQL may greatly simplify the code actually (co=
nsider
>>>> we don't plan to remove BQL now).
>>> Frankly speaking I don't understand why using BQL may greatly simplif=
y
>>> the code... :( IMHO the lock here is really not a complicated one.
>>>
>>> Note that IMO BQL is mostly helpful when we really want something to
>>> be run sequentially with some other things _already_ protected by BQL=
.
>> Except for the translate path from dataplane, I belive all other codes=
 were
>> already protected by BQL.
>>
>>> In this case, all the stuff is inside VT-d code itself (or other
>>> IOMMUs), why bother taking the BQL to make our life harder?
>> It looks to me it was as simple as:
>>
>> @@ -494,6 +494,7 @@ static MemoryRegionSection
>> flatview_do_translate(FlatView *fv,
>>  =C2=A0=C2=A0=C2=A0=C2=A0 IOMMUMemoryRegionClass *imrc;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 hwaddr page_mask =3D (hwaddr)(-1);
>>  =C2=A0=C2=A0=C2=A0=C2=A0 hwaddr plen =3D (hwaddr)(-1);
>> +=C2=A0=C2=A0=C2=A0 int locked =3D false;
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if (plen_out) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 plen =3D *plen_out;
>> @@ -510,8 +511,15 @@ static MemoryRegionSection
>> flatview_do_translate(FlatView *fv,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imrc =3D memory_regi=
on_get_iommu_class_nocheck(iommu_mr);
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!qemu_mutex_iothread_l=
ocked()) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lo=
cked =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_mutex_lock_iothread();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iotlb =3D imrc->tran=
slate(iommu_mr, addr, is_write ?
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IOMMU_WO : IOMMU_RO);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (locked) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_mutex_unlock_iothread();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D ((iotlb.tra=
nslated_addr & ~iotlb.addr_mask)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (addr & iotlb.addr_mask));
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_mask &=3D iotlb=
.addr_mask;
> We'll need to add the flags thing too.  How do we flag-out existing
> thread-safe IOMMUs?

We can let thread safe IOMMU code to choose to set a flag somewhere.

>
>>
>>> So, even if we want to provide a general lock for the translation
>>> procedure, I would prefer we add a per AddressSpace lock but not BQL.
>> It could be, but it needs more work on each specific IOMMU codes.
>>
>>> However still that will need some extra flag showing that whether we
>>> need the protection of not.  For example, we may need to expliclitly
>>> turn that off for Power and s390.  Would that really worth it?
>> It would cost just several lines of code, anything wrong with this?
> It's not about anything wrong; it's just about preference.
>
> I never said BQL won't work here.  It will work.  But if you have
> spent tens of hours working on BQL-related problems maybe you'll have
> the same preference as me... :)
>
> IMHO the point is to decide which might be simpler and more efficient
> in general, really.

So I'm not against your approach. It could be on top of the BQL patch I=20
think.

>
>>> So my final preference is still current patch - we solve thread-safet=
y
>>> problems in VT-d and IOMMU code.  Again, we really should make sure
>>> all IOMMUs work with multithreads.
>>>
>>>>>> 3) I think the issue is common to all other kinds of IOMMU, so can=
 we simply
>>>>>> synchronize before calling ->translate() in memory.c. This seems a=
 more
>>>>>> common solution.
>>>>> I suspect Power and s390 live well with that.  I think it mean at
>>>>> least these platforms won't have problem in concurrency.  I'm addin=
g
>>>>> DavidG in loop in case there is further comment.  IMHO we should ju=
st
>>>>> make sure IOMMU code be thread safe, and we fix problem if there is=
.
>>>>>
>>>>> Thanks,
>>>>>
>>>> Yes, it needs some investigation, but we have other IOMMUs like AMD,=
 and we
>>>> could have a flag to bypass BQL if IOMMU can synchronize by itself.
>>> AMD is still only for experimental.  If we really want to use it in
>>> production IMHO it'll need more testings and tunings not only on
>>> thread-safety but on other stuffs too.  So again, we can just fix the=
m
>>> when needed.  I still don't see it a reason to depend on BQL here.
>> Well, it's not about BQL specifically, it's about whether we have or n=
eed a
>> generic thread safety solution for all IOMMUs.
>>
>> We have more IOMMUs than just AMD, s390 and ppc:
>>
>> # git grep imrc-\>translate\ =3D
>> hw/alpha/typhoon.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D typhoon_tran=
slate_iommu;
>> hw/dma/rc4030.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D rc4030_dma_tran=
slate;
>> hw/i386/amd_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D amdvi_trans=
late;
>> hw/i386/intel_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D vtd_iommu=
_translate;
>> hw/ppc/spapr_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D spapr_tce_=
translate_iommu;
>> hw/s390x/s390-pci-bus.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D s390_tr=
anslate_iommu;
>> hw/sparc/sun4m_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D sun4m_tr=
anslate_iommu;
>> hw/sparc64/sun4u_iommu.c:=C2=A0=C2=A0=C2=A0 imrc->translate =3D sun4u_=
translate_iommu;
>>
>> And we know there will be more in the near future.
> Again - here I would suggest we consider thread-safe when implementing
> new ones.  I suppose it should not be a hard thing to achieve.
>
> I don't have more and new input here since I have had some in previous
> posts already.  If this is still during discussion before the next
> post, I'll pick this patch out of the series since this patch is not
> related to other patches at all, so can be dealt with isolatedly.
>
> Thanks,
>

I fully understand the your motivation, just want to see if we can do=20
something simply for all other IOMMUs. I think this series can go alone=20
without caring other IOMMUs for sure.

Thanks
