Received: from eggs.gnu.org ([2001:4830:134:3::10]:55450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6CEv-000086-LM
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6CEu-0002Hf-S2
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:35:57 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-13-pbonzini@redhat.com>
	<20170504073058.GE19184@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9462f141-6097-9c4b-cb78-33dbaac69024@redhat.com>
Date: Thu, 4 May 2017 10:35:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170504073058.GE19184@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/17] block: protect tracked_requests and
 flush_queue with reqs_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 04/05/2017 09:30, Fam Zheng wrote:
>> @@ -2302,11 +2308,13 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
>>      current_gen = atomic_read(&bs->write_gen);
>>  
>>      /* Wait until any previous flushes are completed */
>> +    qemu_co_mutex_lock(&bs->reqs_lock);
>>      while (bs->active_flush_req) {
>> -        qemu_co_queue_wait(&bs->flush_queue, NULL);
>> +        qemu_co_queue_wait(&bs->flush_queue, &bs->reqs_lock);
>>      }
>>  
>>      bs->active_flush_req = true;
>> +    qemu_co_mutex_unlock(&bs->reqs_lock);
>>  
>>      /* Write back all layers by calling one driver function */
>>      if (bs->drv->bdrv_co_flush) {
>> @@ -2328,10 +2336,14 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
>>          goto flush_parent;
>>      }
>>  
>> -    /* Check if we really need to flush anything */
>> +    /* Check if we really need to flush anything
>> +     * TODO: use int and atomic access */
>> +    qemu_co_mutex_lock(&bs->reqs_lock);
>>      if (bs->flushed_gen == current_gen) {
> 
> Should the atomic reading of current_gen be moved down here, to avoid TOCTOU?

No, but another change is needed; current_gen needs to be read under the
lock, to ensure that flushes are processed in increasing generation order.

In addition, this access to flushed_gen does not need the lock;
bs->active_flush_req itself acts as a "lock" for bs->flushed_gen, only
the coroutine that set it to true will read it or write it.  I'll adjust
this patch accordingly.

Paolo
