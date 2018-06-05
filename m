Received: from eggs.gnu.org ([2001:4830:134:3::10]:53257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fQBrg-0007cU-Mf
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fQBrd-0005kV-GA
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:19:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:45628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fQBrd-0005jZ-2U
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:19:05 -0400
Message-ID: <5B168EAB.7090607@intel.com>
Date: Tue, 05 Jun 2018 21:22:51 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180529181221-mutt-send-email-mst@kernel.org>
	<5B0E6AE9.2030505@intel.com>
	<20180530154325-mutt-send-email-mst@kernel.org>
	<5B14F2A3.9010805@intel.com> <20180605065857.GC9216@xz-mi>
In-Reply-To: <20180605065857.GC9216@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, zhang.zhanghailiang@huawei.com

On 06/05/2018 02:58 PM, Peter Xu wrote:
> On Mon, Jun 04, 2018 at 04:04:51PM +0800, Wei Wang wrote:
>> On 05/30/2018 08:47 PM, Michael S. Tsirkin wrote:
>>> On Wed, May 30, 2018 at 05:12:09PM +0800, Wei Wang wrote:
>>>> On 05/29/2018 11:24 PM, Michael S. Tsirkin wrote:
>>>>> On Tue, Apr 24, 2018 at 02:13:47PM +0800, Wei Wang wrote:
>>>>>> +/*
>>>>>> + * Balloon will report pages which were free at the time of this call. As the
>>>>>> + * reporting happens asynchronously, dirty bit logging must be enabled before
>>>>>> + * this call is made.
>>>>>> + */
>>>>>> +void balloon_free_page_start(void)
>>>>>> +{
>>>>>> +    balloon_free_page_start_fn(balloon_opaque);
>>>>>> +}
>>>>> Please create notifier support, not a single global.
>>>> OK. The start is called at the end of bitmap_sync, and the stop is called at
>>>> the beginning of bitmap_sync. In this case, we will need to add two
>>>> migration states, MIGRATION_STATUS_BEFORE_BITMAP_SYNC and
>>>> MIGRATION_STATUS_AFTER_BITMAP_SYNC, right?
>> Peter, do you have any thought about this?
>>
>> Currently, the usage of free page optimization isn't limited to the first
>> stage. It is used in each stage. A global call to start the free page
>> optimization is made after bitmap sync, and another global call to stop the
>> optimization is made before bitmap sync. It is simple to just use global
>> calls.
>>
>> If we change the implementation to use notifiers, I think we will need to
>> add two new MigrationStatus as above. Would you think that is worthwhile for
>> some reason?
> I'm a bit confused.  Could you elaborate why we need those extra
> states?

Sure. Notifiers are used when an event happens. In this case, it would 
be a state change, which invokes the state change callback. So I think 
we probably need to add 2 new states for the start and stop callback.


> Or, to ask a more general question - could you elaborate a bit on how
> you order these operations?  I would be really glad if you can point
> me to some documents for the feature.  Is there any latest virtio
> document that I can refer to (or old cover letter links)?  It'll be
> good if the document could mention about things like:

I haven't made documents to explain it yet. It's planed to be ready 
after this code series is done. But I'm glad to answer the questions below.


>
> - why we need this feature? Is that purely for migration purpose?  Or
>    it can be used somewhere else too?

Yes. Migration is the one that currently benefits a lot from this 
feature. I haven't thought of others so far. It is common that new 
features start with just 1 or 2 typical use cases.


> - high level stuff about how this is implemented, e.g.:
>    - the protocol of the new virtio queues
>    - how we should get the free page hints (please see below)

The high-level introduction would be
1. host sends a start cmd id to the guest;
2. the guest starts a new round of reporting by sending a cmd_id+free 
page hints to host;
3. QEMU side optimization code applies the free page hints (filter them 
from the dirty bitmap) only when the reported cmd id matches the one 
that was just sent.

The protocol was suggested by Michael and has been thoroughly discussed 
when upstreaming the kernel part. It might not be necessary to go over 
that again :)
I would suggest to focus on the supplied interface and its usage in live 
migration. That is, now we have two APIs, start() and stop(), to start 
and stop the optimization.

1) where in the migration code should we use them (do you agree with the 
step (1), (2), (3) you concluded below?)
2) how should we use them, directly do global call or via notifiers?

>
> For now, what I see is that we do:
>
> (1) stop hinting
> (2) sync bitmap
> (3) start hinting
>
> Why this order?

We start to filter out free pages from the dirty bitmap only when all 
the dirty bits are ready there, i.e. after sync bitmap. To some degree, 
the action of synchronizing bitmap indicates the end of the last round 
and the beginning of the new round, so we stop the free page 
optimization for the old round when the old round ends.


>   My understanding is that obviously there is a race
> between the page hinting thread and the dirty bitmap tracking part
> (which is done in KVM).  How do we make sure there is no race?

Could you please explain more about the race you saw? (free page is 
reported from the guest, and the bitmap is tracked in KVM)



>
> An direct question is that, do we need to make sure step (1) must be
> before step (2)?  Asked since I see that currently step (1) is an
> async operation (taking a lock, set status, then return).  Then would
> such an async operation satisfy any ordering requirement after all?

Yes. Step(1) guarantees us that the QEMU side optimization call has 
exited (we don't need to rely on guest side ACK because the guest could 
be in any state). This is enough. If the guest continues to report after 
that, that reported hints will be detected as stale hints and dropped in 
the next start of optimization.


>
> Btw, I would appreciate if you can push your new trees (both QEMU and
> kernel) to the links you mentioned in the cover letter - I noticed
> that they are not the same as what you have posted on the list.
>

Sure.
For kernel part, you can get it from linux-next: 
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
For the v7 QEMU part: 
git://github.com/wei-w-wang/qemu-free-page-hint.git (my connection to 
github is too slow, it would be ready in 24hours, I can also send you 
the raw patches via email if you need)


Best,
Wei
