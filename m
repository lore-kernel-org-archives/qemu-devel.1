Received: from eggs.gnu.org ([2001:4830:134:3::10]:39002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ffi4K-0003nT-FX
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ffi4H-0002fL-C1
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:44:20 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:32893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1ffi4H-0002e8-6c
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:44:17 -0400
Received: by mail-it0-x243.google.com with SMTP id y124-v6so16933100itc.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 01:44:17 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-9-xiaoguangrong@tencent.com>
	<20180713180120.GD2434@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <250fa742-5fe5-7701-bfb3-a4302d59b772@gmail.com>
Date: Wed, 18 Jul 2018 16:44:09 +0800
MIME-Version: 1.0
In-Reply-To: <20180713180120.GD2434@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/12] migration: do not
 flush_compressed_data at the end of each iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 07/14/2018 02:01 AM, Dr. David Alan Gilbert wrote:
> * guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> flush_compressed_data() needs to wait all compression threads to
>> finish their work, after that all threads are free until the
>> migration feed new request to them, reducing its call can improve
>> the throughput and use CPU resource more effectively
>>
>> We do not need to flush all threads at the end of iteration, the
>> data can be kept locally until the memory block is changed
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>> ---
>>   migration/ram.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index f9a8646520..0a38c1c61e 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1994,6 +1994,7 @@ static void ram_save_cleanup(void *opaque)
>>       }
>>   
>>       xbzrle_cleanup();
>> +    flush_compressed_data(*rsp);
>>       compress_threads_save_cleanup();
>>       ram_state_cleanup(rsp);
>>   }
> 
> I'm not sure why this change corresponds to the other removal.
> We should already have sent all remaining data in ram_save_complete()'s
> call to flush_compressed_data - so what is this one for?
> 

This is for the error condition, if any error occurred during live migration,
there is no chance to call ram_save_complete. After using the lockless
multithreads model, we assert all requests have been handled before destroy
the work threads.

>> @@ -2690,7 +2691,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>>           }
>>           i++;
>>       }
>> -    flush_compressed_data(rs);
>>       rcu_read_unlock();
> 
> Hmm - are we sure there's no other cases that depend on ordering of all
> of the compressed data being sent out between threads?

Err, i tried think it over carefully, however, still missed the case you mentioned. :(
Anyway, doing flush_compressed_data() for every 50ms hurt us too much.

> I think the one I'd most worry about is the case where:
> 
>    iteration one:
>       thread 1: Save compressed page 'n'
> 
>    iteration two:
>       thread 2: Save compressed page 'n'
> 
> What guarantees that the version of page 'n'
> from thread 2 reaches the destination first without
> this flush?
> 

Hmm... you are right, i missed this case. So how about avoid it by doing this
check at the beginning of ram_save_iterate()：

if (ram_counters.dirty_sync_count != rs.dirty_sync_count) {
     flush_compressed_data(*rsp);
     rs.dirty_sync_count = ram_counters.dirty_sync_count;
}
