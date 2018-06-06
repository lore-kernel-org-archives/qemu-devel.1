Received: from eggs.gnu.org ([2001:4830:134:3::10]:40587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fQVFC-0007od-7h
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fQVF8-0000KC-5c
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:00:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:43263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fQVF7-0000JL-RI
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:00:38 -0400
Message-ID: <5B17B1A7.8060307@intel.com>
Date: Wed, 06 Jun 2018 18:04:23 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180529181221-mutt-send-email-mst@kernel.org>
	<5B0E6AE9.2030505@intel.com>
	<20180530154325-mutt-send-email-mst@kernel.org>
	<5B14F2A3.9010805@intel.com> <20180605065857.GC9216@xz-mi>
	<5B168EAB.7090607@intel.com> <20180606054227.GA7815@xz-mi>
In-Reply-To: <20180606054227.GA7815@xz-mi>
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

On 06/06/2018 01:42 PM, Peter Xu wrote:
>
> IMHO migration states do not suite here.  IMHO bitmap syncing is too
> frequently an operation, especially at the end of a precopy migration.
> If you really want to introduce some notifiers, I would prefer
> something new rather than fiddling around with migration state.  E.g.,
> maybe a new migration event notifiers, then introduce two new events
> for both start/end of bitmap syncing.

Please see if below aligns to what you meant:

MigrationState {
...
+ int ram_save_state;

}

typedef enum RamSaveState {
     RAM_SAVE_BEGIN = 0,
     RAM_SAVE_END = 1,
     RAM_SAVE_MAX = 2
}

then at the step 1) and 3) you concluded somewhere below, we change the 
state and invoke the callback.


Btw, the migration_state_notifiers is already there, but seems not 
really used (I only tracked spice-core.c called 
add_migration_state_change_notifier). I thought adding new migration 
states can reuse all that we have.
What's your real concern about that? (not sure how defining new events 
would make a difference)

>> I would suggest to focus on the supplied interface and its usage in live
>> migration. That is, now we have two APIs, start() and stop(), to start and
>> stop the optimization.
>>
>> 1) where in the migration code should we use them (do you agree with the
>> step (1), (2), (3) you concluded below?)
>> 2) how should we use them, directly do global call or via notifiers?
> I don't know how Dave and Juan might think; here I tend to agree with
> Michael that some notifier framework should be nicer.
>

What would be the advantages of using notifiers here?



> This is not that obvious to me.  For now I think it's true, since when
> we call stop() we'll take the mutex, meanwhile the mutex is actually
> always held by the iothread (in the big loop in
> virtio_balloon_poll_free_page_hints) until either:
>
> - it sleeps in qemu_cond_wait() [1], or
> - it leaves the big loop [2]
>
> Since I don't see anyone who will set dev->block_iothread to true for
> the balloon device, then [1] cannot happen;

there is a case in virtio_balloon_set_status which sets 
dev->block_iothread to true.

Did you mean the free_page_lock mutex? it is released at the bottom of 
the while() loop in virtio_balloon_poll_free_page_hint. It's actually 
released for every hint. That is,

while(1){
     take the lock;
     process 1 hint from the vq;
     release the lock;
}

>   then I think when stop()
> has taken the mutex then the thread must have quitted the big loop,
> which goes to path [2].  I am not sure my understanding is correct,
> but in all cases "Step(1) guarantees us that the QEMU side
> optimization call has exited" is not obvious to me.  Would you add
> some comment to the code (or even improve the code itself somehow) to
> help people understand that?
>
> For example, I saw that the old github code has a pthread_join() (in
> that old code it was not using iothread at all).  That's a very good
> code example so that people can understand that it's a synchronous
> operations.

>> This is enough. If the guest continues to report after that, that
>> reported hints will be detected as stale hints and dropped in the next start
>> of optimization.
> This is not clear to me too.  Say, stop() only sets the balloon status
> to STOP, AFAIU it does not really modify the cmd_id field immediately,
> then how will the new coming hints be known as stale hints?

Yes, you get that correctly - stop() only sets the status to STOP. On 
the other side, virtio_balloon_poll_free_page_hints will stop when it 
sees the staus is STOP. The free_page_lock guarantees that when stop() 
returns, virtio_balloon_poll_free_page_hints will not proceed. When 
virtio_balloon_poll_free_page_hints exits, the coming hints are not 
processed any more. They just stay in the vq. The next time start() is 
called, virtio_balloon_poll_free_page_hints works again, it will first 
drop all those stale hints.
I'll see where I could add some comments to explain.


Best,
Wei
