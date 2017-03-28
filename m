Received: from eggs.gnu.org ([2001:4830:134:3::10]:35779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csw7q-0008Ey-Bn
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csw7k-00071q-CY
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:45:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1csw7k-00070R-63
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:45:44 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170328171253.GE5740@work-vm> (David Alan Gilbert's message of
	"Tue, 28 Mar 2017 18:12:54 +0100")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-43-quintela@redhat.com>
	<8b10b0bc-909e-d6e8-da76-72b20fbf7e32@huawei.com>
	<87h92j84db.fsf@secure.mitica> <20170328171253.GE5740@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 28 Mar 2017 20:45:41 +0200
Message-ID: <87y3vpp7e2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 42/51] ram: Pass RAMBlock to bitmap_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Yang Hongyang <yanghongyang@huawei.com>, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Yang Hongyang <yanghongyang@huawei.com> wrote:
>> > On 2017/3/24 4:45, Juan Quintela wrote:
>> >> We change the meaning of start to be the offset from the beggining of
>> >> the block.
>> >> 
>> >> @@ -701,7 +701,7 @@ static void migration_bitmap_sync(RAMState *rs)
>> >>      qemu_mutex_lock(&rs->bitmap_mutex);
>> >>      rcu_read_lock();
>> >>      QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> >> -        migration_bitmap_sync_range(rs, block->offset, block->used_length);
>> >> +        migration_bitmap_sync_range(rs, block, 0, block->used_length);
>> If you have several terabytes of RAM that is too ineficient, because
>> when we arrive to the page_send(page), it is possible that it is already
>> dirty again, and we have to send it twice.  So, the idea is to change to
>> something like:
>> 
>> while(true) {
>>             foreach(block)
>>                 bitmap_sync(block)
>>             foreach(block)
>>                 foreach(64pages)
>>                     bitmap_sync(64pages)
>>                     foreach(page of the 64)
>>                        if (dirty)
>>                           page_send(page)
>
> Yes, although it might be best to actually do the sync in a separate thread
> so that the sync is always a bit ahead of the thread doing the writing.

Doing it synchronously shouldn't be a problem.  But we should be able to
in smaller chucks.

Thanks, Juan.
