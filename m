Received: from eggs.gnu.org ([2001:4830:134:3::10]:34393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fx2QG-0002Ql-F0
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 23:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fx2QC-00038Z-AC
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 23:54:36 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fx2QB-000384-V4
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 23:54:32 -0400
Received: by mail-pl1-x642.google.com with SMTP id e11-v6so967183plb.3
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 20:54:31 -0700 (PDT)
References: <20180903092644.25812-1-xiaoguangrong@tencent.com>
	<20180903092644.25812-2-xiaoguangrong@tencent.com>
	<87ftyq35an.fsf@trasno.org>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <f22690e3-63d0-16e5-b2bc-de29471d3d0b@gmail.com>
Date: Tue, 4 Sep 2018 11:54:25 +0800
MIME-Version: 1.0
In-Reply-To: <87ftyq35an.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: quintela@redhat.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 09/04/2018 12:38 AM, Juan Quintela wrote:
> guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> flush_compressed_data() needs to wait all compression threads to
>> finish their work, after that all threads are free until the
>> migration feeds new request to them, reducing its call can improve
>> the throughput and use CPU resource more effectively
>> We do not need to flush all threads at the end of iteration, the
>> data can be kept locally until the memory block is changed or
>> memory migration starts over in that case we will meet a dirtied
>> page which may still exists in compression threads's ring
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> I am not so sure about this patch.
> 
> Right now, we warantee that after each iteration, all data is written
> before we start a new round.
> 
> This patch changes to only "flush" the compression threads if we have
> "synched" with the kvm migration bitmap.  Idea is good but as far as I
> can see:
> 
> - we already call flush_compressed_data() inside firnd_dirty_block if we
>    synchronize the bitmap. 

The one called in find_dirty_block is as followings:

             if (migrate_use_xbzrle()) {
                 /* If xbzrle is on, stop using the data compression at this
                  * point. In theory, xbzrle can do better than compression.
                  */
                 flush_compressed_data(rs);
             }

We will call it only if xbzrle is also enabled, at this case, we will
disable compression and xbzrle for the following pages, please refer
to save_page_use_compression(). So, it can not help us if we just enabled
compression separately.

> So, at least, we need to update
>    dirty_sync_count there.

I understand this is a optimization that reduces flush_compressed_data
under the if both xbzrle and compression are both enabled. However, we
can avoid it by using save_page_use_compression() to replace
migrate_use_compression().

Furthermore, in our work which will be pushed it out after this patchset
(https://marc.info/?l=kvm&m=152810616708459&w=2), we will made
flush_compressed_data() really light if there is nothing to be flushed.

So, how about just keep it at this patch and let's optimize it in our
next work? :)

> 
> - queued pages are "interesting", but I am not sure if compression and
>    postcopy work well together.
> 

Compression and postcopy can not both be enabled, please refer to the
code in migrate_caps_check()

     if (cap_list[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
         if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
             /* The decompression threads asynchronously write into RAM
              * rather than use the atomic copies needed to avoid
              * userfaulting.  It should be possible to fix the decompression
              * threads for compatibility in future.
              */
             error_setg(errp, "Postcopy is not currently compatible "
                        "with compression");
             return false;
         }

> So, if we don't need to call flush_compressed_data() every round, then
> the one inside find_dirty_block() should be enough.  Otherwise, I can't
> see why we need this other.
> 
> 
> Independent of this patch:
> - We always send data for every compression thread without testing if
> there is any there.
> 

Yes. That's because we will never doubly handle the page in the iteration. :)

> 
>> @@ -3212,7 +3225,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>>           }
>>           i++;
>>       }
>> -    flush_compressed_data(rs);
>>       rcu_read_unlock();
>>   
>>       /*
> 
> Why is not enough just to remove this call to flush_compressed_data?

Consider this case, thanks Dave to point it out. :)

===============

   iteration one:
      thread 1: Save compressed page 'n'

   iteration two:
      thread 2: Save compressed page 'n'

What guarantees that the version of page 'n'
from thread 2 reaches the destination first without
this flush?
===============

If we just remove it, we can not get this guarantee. :)
