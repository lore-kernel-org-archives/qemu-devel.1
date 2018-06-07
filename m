Received: from eggs.gnu.org ([2001:4830:134:3::10]:43628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fQnLt-0007mN-A1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 01:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fQnLq-0000fp-35
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 01:20:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:58257)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fQnLp-0000c5-M8
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 01:20:46 -0400
Message-ID: <5B18C18D.3070007@intel.com>
Date: Thu, 07 Jun 2018 13:24:29 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180529181221-mutt-send-email-mst@kernel.org>
	<5B0E6AE9.2030505@intel.com>
	<20180530154325-mutt-send-email-mst@kernel.org>
	<5B14F2A3.9010805@intel.com> <20180605065857.GC9216@xz-mi>
	<5B168EAB.7090607@intel.com> <20180606054227.GA7815@xz-mi>
	<5B17B1A7.8060307@intel.com> <20180606110217.GF7815@xz-mi>
In-Reply-To: <20180606110217.GF7815@xz-mi>
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

On 06/06/2018 07:02 PM, Peter Xu wrote:
> On Wed, Jun 06, 2018 at 06:04:23PM +0800, Wei Wang wrote:
>> On 06/06/2018 01:42 PM, Peter Xu wrote:
>>> IMHO migration states do not suite here.  IMHO bitmap syncing is too
>>> frequently an operation, especially at the end of a precopy migration.
>>> If you really want to introduce some notifiers, I would prefer
>>> something new rather than fiddling around with migration state.  E.g.,
>>> maybe a new migration event notifiers, then introduce two new events
>>> for both start/end of bitmap syncing.
>> Please see if below aligns to what you meant:
>>
>> MigrationState {
>> ...
>> + int ram_save_state;
>>
>> }
>>
>> typedef enum RamSaveState {
>>      RAM_SAVE_BEGIN = 0,
>>      RAM_SAVE_END = 1,
>>      RAM_SAVE_MAX = 2
>> }
>>
>> then at the step 1) and 3) you concluded somewhere below, we change the
>> state and invoke the callback.
> I mean something like this:
>
> 1693c64c27 ("postcopy: Add notifier chain", 2018-03-20)
>
> That was a postcopy-only notifier.  Maybe we can generalize it into a
> more common notifier for the migration framework so that we can even
> register with non-postcopy events like bitmap syncing?

Precopy already has its own notifiers: git 99a0db9b
If we want to reuse, that one would be more suitable. I think mixing 
non-related events into one notifier list isn't nice.

>>
>> Btw, the migration_state_notifiers is already there, but seems not really
>> used (I only tracked spice-core.c called
>> add_migration_state_change_notifier). I thought adding new migration states
>> can reuse all that we have.
>> What's your real concern about that? (not sure how defining new events would
>> make a difference)
> Migration state is exposed via control path (QMP).  Adding new states
> mean that the QMP clients will see more.  IMO that's not really
> anything that a QMP client will need to know, instead we can keep it
> internally.  That's a reason from compatibility pov.
>
> Meanwhile, it's not really a state-thing at all for me.  It looks
> really more like hook or event (start/stop of sync).

Thanks for sharing your concerns in detail, which are quite helpful for 
the discussion. To reuse 99a0db9b, we can also add sub-states (or say 
events), instead of new migration states.
For example, we can still define "enum RamSaveState" as above, which can 
be an indication for the notifier queued on the 99a0db9b notider_list to 
decide whether to call start or stop.
Does this solve your concern?


>
>>>> I would suggest to focus on the supplied interface and its usage in live
>>>> migration. That is, now we have two APIs, start() and stop(), to start and
>>>> stop the optimization.
>>>>
>>>> 1) where in the migration code should we use them (do you agree with the
>>>> step (1), (2), (3) you concluded below?)
>>>> 2) how should we use them, directly do global call or via notifiers?
>>> I don't know how Dave and Juan might think; here I tend to agree with
>>> Michael that some notifier framework should be nicer.
>>>
>> What would be the advantages of using notifiers here?
> Isolation of modules?  Then migration/ram.c at least won't need to
> include something like "balloon.h".
>
> And I think it's also possible too if some other modules would like to
> hook at these places someday.

OK, I can implement it with notifiers, but this (framework) is usually 
added when someday there is a second user who needs a callback at the 
same place.



>>
>>
>>> This is not that obvious to me.  For now I think it's true, since when
>>> we call stop() we'll take the mutex, meanwhile the mutex is actually
>>> always held by the iothread (in the big loop in
>>> virtio_balloon_poll_free_page_hints) until either:
>>>
>>> - it sleeps in qemu_cond_wait() [1], or
>>> - it leaves the big loop [2]
>>>
>>> Since I don't see anyone who will set dev->block_iothread to true for
>>> the balloon device, then [1] cannot happen;
>> there is a case in virtio_balloon_set_status which sets dev->block_iothread
>> to true.
>>
>> Did you mean the free_page_lock mutex? it is released at the bottom of the
>> while() loop in virtio_balloon_poll_free_page_hint. It's actually released
>> for every hint. That is,
>>
>> while(1){
>>      take the lock;
>>      process 1 hint from the vq;
>>      release the lock;
>> }
> Ah, so now I understand why you need the lock to be inside the loop,
> since the loop is busy polling actually.  Is it possible to do this in
> an async way?

We need to use polling here because of some back story in the guest side 
(due to some locks being held) that makes it a barrier to sending 
notifications for each hints.

> I'm a bit curious on how much time will it use to do
> one round of the free page hints (e.g., an idle guest with 8G mem, or
> any configuration you tested)?  I suppose during that time the
> iothread will be held steady with 100% cpu usage, am I right?

Compared to the time spent by the legacy migration to send free pages, 
that small amount of CPU usage spent on filtering free pages could be 
neglected.
Grinding a chopper will not hold up the work of cutting firewood :)

Best,
Wei
