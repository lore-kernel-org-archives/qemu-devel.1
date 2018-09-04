Received: from eggs.gnu.org ([2001:4830:134:3::10]:49522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fx7dS-0007Tq-Ez
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fx7dP-0000s0-6a
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:28:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fx7dO-0000ro-W3
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:28:31 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <f22690e3-63d0-16e5-b2bc-de29471d3d0b@gmail.com> (Xiao
	Guangrong's message of "Tue, 4 Sep 2018 11:54:25 +0800")
References: <20180903092644.25812-1-xiaoguangrong@tencent.com>
	<20180903092644.25812-2-xiaoguangrong@tencent.com>
	<87ftyq35an.fsf@trasno.org>
	<f22690e3-63d0-16e5-b2bc-de29471d3d0b@gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 04 Sep 2018 11:28:20 +0200
Message-ID: <87r2i9vcgb.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 1/4] migration: do not
 flush_compressed_data at the end of each iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

Xiao Guangrong <guangrong.xiao@gmail.com> wrote:
> On 09/04/2018 12:38 AM, Juan Quintela wrote:
>> guangrong.xiao@gmail.com wrote:
>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>
>>> flush_compressed_data() needs to wait all compression threads to
>>> finish their work, after that all threads are free until the
>>> migration feeds new request to them, reducing its call can improve
>>> the throughput and use CPU resource more effectively
>>> We do not need to flush all threads at the end of iteration, the
>>> data can be kept locally until the memory block is changed or
>>> memory migration starts over in that case we will meet a dirtied
>>> page which may still exists in compression threads's ring
>>>
>>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> I am not so sure about this patch.
>>
>> Right now, we warantee that after each iteration, all data is written
>> before we start a new round.
>>
>> This patch changes to only "flush" the compression threads if we have
>> "synched" with the kvm migration bitmap.  Idea is good but as far as I
>> can see:
>>
>> - we already call flush_compressed_data() inside firnd_dirty_block if we
>>    synchronize the bitmap. 
>
> The one called in find_dirty_block is as followings:
>
>             if (migrate_use_xbzrle()) {
>                 /* If xbzrle is on, stop using the data compression at this
>                  * point. In theory, xbzrle can do better than compression.
>                  */
>                 flush_compressed_data(rs);
>             }

Ouch.  I didn't notice thet use_xbzrle() there.  I think that the proper
solution is just to call there unconditionally flush_compressed_data().
And then remove the call that I pointed at the end, no?

> We will call it only if xbzrle is also enabled, at this case, we will
> disable compression and xbzrle for the following pages, please refer
> to save_page_use_compression(). So, it can not help us if we just enabled
> compression separately.

Point taken, but I still think that it should be unconditional.

>
>> So, at least, we need to update
>>    dirty_sync_count there.
>
> I understand this is a optimization that reduces flush_compressed_data
> under the if both xbzrle and compression are both enabled. However, we
> can avoid it by using save_page_use_compression() to replace
> migrate_use_compression().
>
> Furthermore, in our work which will be pushed it out after this patchset
> (https://marc.info/?l=kvm&m=152810616708459&w=2), we will made
> flush_compressed_data() really light if there is nothing to be flushed.
>
> So, how about just keep it at this patch and let's optimize it in our
> next work? :)

I still think that it is not needed, and that we can do better just
removing the migrate_use_xbzrle() test and just removing the one in
ram_save_iterate, but we can optimize it later.

>> - queued pages are "interesting", but I am not sure if compression and
>>    postcopy work well together.
>>
>
> Compression and postcopy can not both be enabled, please refer to the
> code in migrate_caps_check()
>
>     if (cap_list[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
>         if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
>             /* The decompression threads asynchronously write into RAM
>              * rather than use the atomic copies needed to avoid
>              * userfaulting.  It should be possible to fix the decompression
>              * threads for compatibility in future.
>              */
>             error_setg(errp, "Postcopy is not currently compatible "
>                        "with compression");
>             return false;
>         }

Ok.


>> So, if we don't need to call flush_compressed_data() every round, then
>> the one inside find_dirty_block() should be enough.  Otherwise, I can't
>> see why we need this other.
>>
>>
>> Independent of this patch:
>> - We always send data for every compression thread without testing if
>> there is any there.
>>
>
> Yes. That's because we will never doubly handle the page in the iteration. :)

I mean something different here.  Think about the case that we have 4
compression threads and only three pages left to send.  We have to call
flush_compressed_data() and it sends data for the four threads, even
when one of them is empty.


>>> @@ -3212,7 +3225,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>>>           }
>>>           i++;
>>>       }
>>> -    flush_compressed_data(rs);
>>>       rcu_read_unlock();
>>>         /*
>>
>> Why is not enough just to remove this call to flush_compressed_data?
>
> Consider this case, thanks Dave to point it out. :)
>
> ===============
>
>   iteration one:
>      thread 1: Save compressed page 'n'
>
>   iteration two:
>      thread 2: Save compressed page 'n'
>
> What guarantees that the version of page 'n'
> from thread 2 reaches the destination first without
> this flush?
> ===============
>
> If we just remove it, we can not get this guarantee. :)

Ok.  I think that the propper fix is to remove the things that you had
previously said, we will wait until you merge the other bits to
optimize.  I agree that there is no harm in the change.

Later, Juan.
