Received: from eggs.gnu.org ([2001:4830:134:3::10]:50575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1crM6R-0001Hy-I7
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1crM6O-0000iO-Eo
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:05:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1crM6O-0000iI-67
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:05:48 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <dc72157a-3bf2-645b-ed9c-db5535adfd6e@huawei.com> (Yang
	Hongyang's message of "Fri, 24 Mar 2017 17:11:54 +0800")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-43-quintela@redhat.com>
	<8b10b0bc-909e-d6e8-da76-72b20fbf7e32@huawei.com>
	<87h92j84db.fsf@secure.mitica>
	<dc72157a-3bf2-645b-ed9c-db5535adfd6e@huawei.com>
Reply-To: quintela@redhat.com
Date: Fri, 24 Mar 2017 11:05:45 +0100
Message-ID: <87zigb6lc6.fsf@secure.mitica>
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
To: Yang Hongyang <yanghongyang@huawei.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Yang Hongyang <yanghongyang@huawei.com> wrote:
> Hi Juan,
>
> On 2017/3/24 16:29, Juan Quintela wrote:
>> Yang Hongyang <yanghongyang@huawei.com> wrote:
>>> On 2017/3/24 4:45, Juan Quintela wrote:
>>>> We change the meaning of start to be the offset from the beggining of
>>>> the block.
>>>>
>>>> @@ -701,7 +701,7 @@ static void migration_bitmap_sync(RAMState *rs)
>>>>      qemu_mutex_lock(&rs->bitmap_mutex);
>>>>      rcu_read_lock();
>>>>      QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>>>> -        migration_bitmap_sync_range(rs, block->offset, block->used_length);
>>>> +        migration_bitmap_sync_range(rs, block, 0, block->used_length);
>>>
>>> Since RAMBlock been passed to bitmap_sync, could we remove
>>> param 'block->used_length' either?
>> 
>> Hi
>> 
>> good catch.
>> 
>> I had that removed, and then realized that I want to synchronize parts
>> of the bitmap, not the whole one.  That part of the series is still not
>> done.
>> 
>> Right now we do something like (I have simplified a lot of details):
>> 
>> while(true) {
>>             foreach(block)
>>                 bitmap_sync(block)
>>             foreach(page)
>>                 if(dirty(page))
>>                    page_send(page)
>> }
>> 
>> 
>> If you have several terabytes of RAM that is too ineficient, because
>> when we arrive to the page_send(page), it is possible that it is already
>> dirty again, and we have to send it twice.  So, the idea is to change to
>> something like:
>> 
>> while(true) {
>>             foreach(block)
>>                 bitmap_sync(block)
>
> Do you mean sync with KVM here?
>
>>             foreach(block)
>>                 foreach(64pages)
>>                     bitmap_sync(64pages)
>
> Then here, we will sync with KVM too. For huge MEM,
> it will generates lots of ioctl()...
> Bitmap in KVM is per Memory region IIRC. KVM module currently
> haven't the ability to sync parts of the bitmap. A sync have
> to sync the whole mr. So if we want to do small sync, we might
> need to modify KVM also, but that still won't solve the preblem
> of increased ioctls.

And why I remembered incorrectly that we could sync part of the bitmaps.
Yes, we could have more ioctls, but less pages written twice, it is a
tradeoff, at some point it makes sense to change it.

Problem is that now this is going to be more difficult that I thought to
test for it.

Thanks, Juan.
