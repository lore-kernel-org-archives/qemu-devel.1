Received: from eggs.gnu.org ([2001:4830:134:3::10]:58654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDWlt-0004Yn-Ud
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDWls-0003Se-Mj
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:00:50 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:39948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDWls-0003Ri-Gc
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:00:48 -0400
Received: by mail-ot0-x234.google.com with SMTP id n1-v6so13201998otf.7
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 08:00:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a660c604-5e6e-29c7-ed3f-47e40de8da1b@redhat.com>
References: <20180501101907.22638-1-peter.maydell@linaro.org>
	<a660c604-5e6e-29c7-ed3f-47e40de8da1b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 May 2018 16:00:26 +0100
Message-ID: <CAFEAcA_+gu3fWW9jNwT9DM5Yh2OFgehVDOnckAVACFPouzp58A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] memory.h: Improve IOMMU related
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "patches@linaro.org" <patches@linaro.org>

On 1 May 2018 at 15:32, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 05/01/2018 12:19 PM, Peter Maydell wrote:
>> Add more detail to the documentation for memory_region_init_iommu()
>> and other IOMMU-related functions and data structures.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> v1 -> v2 changes:
>>  * documented replay method
>>  * added note about wanting RCU or big qemu lock while calling
>>    translate

Hi; thanks for the review. I have some followup questions where
my understanding of the IOMMU is weak...

>>  include/exec/memory.h | 96 +++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 87 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 4402ba6c0d..997598c664 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -194,29 +194,95 @@ enum IOMMUMemoryRegionAttr {
>>      IOMMU_ATTR_SPAPR_TCE_FD
>>  };
>>
>> +/**
>> + * IOMMUMemoryRegionClass:
>> + *
>> + * All IOMMU implementations need to subclass TYPE_IOMMU_MEMORY_REGION
>> + * and provide implementations of at least some of the methods here
>> + * to handle requests to the memory region.
> of at least the @translate method. Others are optional?

Yes, that's probably a bit smoother wording.

>  The minimum requirement
>> + * is a @translate method.

>> + */
>>  typedef struct IOMMUMemoryRegionClass {
>>      /* private */
>>      struct DeviceClass parent_class;
>>
>>      /*
>>       * Return a TLB entry that contains a given address. Flag should
>> -     * be the access permission of this translation operation. We can
>> -     * set flag to IOMMU_NONE to mean that we don't need any
>> -     * read/write permission checks, like, when for region replay.
>> +     * be the access permission of this translation operation. The
>> +     * flag may be set to IOMMU_NONE to mean that we don't need any
>> +     * read/write permission checks; this is used by the default
>> +     * implementation of memory_region_iommu_replay(). (See the documentation
>> +     * of the replay method below for more details.)
>> +     *
>> +     * Once the IOMMU has returned a TLB entry, it must notify
>> +     * the IOMMU's users if that TLB entry changes, using
>> +     * memory_region_notify_iommu() (or, if necessary, by calling
>> +     * memory_region_notify_one() for each registered notifier).
> if caching mode is set (VFIO integration), On the first guest map
> (invalidation on map), the IOMMU must replay the mapping (notify VFIO)
> to get the 1st stage of the physical IOMMU programmed. At that moment
> the IOMMU may not have returned any TLB entry.

I'm afraid you've lost me. What is caching mode, how do you set it,
how does the IOMMU replay the mapping? More concretely, what change
needs to be made to this text?

> Maybe it is worth to define the term "IOMMU user", ie. someone who
> registered an IOMMU notifier? In case the IOMMU is used without
> vhost/VFIO, there is no registered notifier, however the IOMMU is "used".

I was using "IOMMU user" here in a fairly loose sense to mean anybody
using these interfaces (ie the code "outside" of the IOMMU implementation).

Maybe we should fix this by removing this paragraph and putting something
in the introductory "All IOMMU implementations need ..." instead as a
general description of the IOMMU's responsibilities regarding notifiers.

>> +     *
>> +     * The returned information remains valid while the caller is
>> +     * holding the big QEMU lock or is inside an RCU critical section;
>> +     * if the caller wishes to cache the mapping beyond that it must
>> +     * register an IOMMU notifier so it can invalidate its cached
>> +     * information when the IOMMU mapping changes..
>> +     *
>> +     * @iommu: the IOMMUMemoryRegion
>> +     * @hwaddr: address to be translated within the memory region
>> +     * @flag: requested access permissions
>>       */
>>      IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
>>                                 IOMMUAccessFlags flag);
>> -    /* Returns minimum supported page size */
>> +    /* Returns minimum supported page size in bytes.
>> +     * If this method is not provided then the minimum is assumed to
>> +     * be TARGET_PAGE_SIZE.
>> +     *
>> +     * @iommu: the IOMMUMemoryRegion
>> +     */
>>      uint64_t (*get_min_page_size)(IOMMUMemoryRegion *iommu);
>> -    /* Called when IOMMU Notifier flag changed */
>> +    /* Called when IOMMU Notifier flag changes (ie when the set of
>> +     * events which IOMMU users are requesting notification for changes).
>> +     * Optional method -- need not be provided if the IOMMU does not
>> +     * need to know exactly which events must be notified.
>> +     *
>> +     * @iommu: the IOMMUMemoryRegion
>> +     * @old_flags: events which previously needed to be notified
>> +     * @new_flags: events which now need to be notified
>> +     */
>>      void (*notify_flag_changed)(IOMMUMemoryRegion *iommu,
>>                                  IOMMUNotifierFlag old_flags,
>>                                  IOMMUNotifierFlag new_flags);
>> -    /* Set this up to provide customized IOMMU replay function */
>> +    /* Called to handle memory_region_iommu_replay().
>> +     *
>> +     * The default implementation of memory_region_iommu_replay() is to
>> +     * call the IOMMU translate method for every page in the address space
>> +     * with flag == IOMMU_NONE
> generally meaning invalidation?

The flags argument is something I find a bit confusing overall --
what does it mean to put a transaction through an IOMMU that
isn't either a read transaction or a write transaction? Do we
use IOMMU_NONE for anything except this special purpose "I am
the default replay implementation and just want to cause notifiers
to be called" ?

>  and then call the notifier if translate
> I think possibly we could have several notifiers?

This method takes one notifier pointer and is responsible
for notifying it and only it, I think.

>> +     * returns valid mapping
> a valid mapping?

Yes.

> . If this method is implemented then it
>> +     * overrides the default behaviour, and must provide the full semantics
>> +     * of memory_region_iommu_replay(), by calling @notifier for every
>> +     * translation present in the IOMMU.
> by first invalidating the whole range and then calling @notifier for
> every valid mapping?

Wait, why do we have to invalidate anything? I thought replay was
purely a "tell the notifier about the current state of the IOMMU"
function?

>> +     *
>> +     * Optional method -- an IOMMU only needs to provide this method
>> +     * if the default is inefficient or produces undesirable side effects.
>> +     *
>> +     * Note: this is not related to record-and-replay functionality.
> The record-and-replay functionality is not obvious to me.

This is just a note to say "this is not anything to do with what the
rest of the codebase calls 'replay', it's just an in-retrospect
poorly chosen method name, so don't confuse the two".

>> +     */
>>      void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);

thanks
-- PMM
