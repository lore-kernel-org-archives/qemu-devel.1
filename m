Received: from eggs.gnu.org ([2001:4830:134:3::10]:46932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eNN89-0003Yi-JT
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 13:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eNN86-0000wc-Dc
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 13:12:13 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eNN86-0000wG-7e
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 13:12:10 -0500
Received: by mail-wm0-f52.google.com with SMTP id b76so4518272wmg.1
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 10:12:10 -0800 (PST)
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-6-pbonzini@redhat.com>
	<20171208151306.GC8998@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c90d2b3-242e-5ffc-3e48-cf05e6fe85c3@redhat.com>
Date: Fri, 8 Dec 2017 19:12:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171208151306.GC8998@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] thread-pool: convert to use lock guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 08/12/2017 16:13, Stefan Hajnoczi wrote:
>> -    qemu_mutex_lock(&pool->lock);
>> +    QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
>>      if (pool->idle_threads == 0 && pool->cur_threads < pool->max_threads) {
>>          spawn_thread(pool);
>>      }
>>      QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
>> -    qemu_mutex_unlock(&pool->lock);
>> +    qemu_lock_guard_unlock(&pool_guard);
> Why not QEMU_WITH_LOCK()?  Then you can get rid of the explicit unlock.

I agree that QEMU_WITH_LOCK_GUARD is better in this case. (IIRC I wrote
this patch before coming up with the is_taken trick!).

My main question for the series is what you think the balance should be
between a more widely applicable API and a simpler one.

Thanks,

Paolo

>> @@ -330,7 +326,7 @@ void thread_pool_free(ThreadPool *pool)
>>  
>>      assert(QLIST_EMPTY(&pool->head));
>>  
>> -    qemu_mutex_lock(&pool->lock);
>> +    QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
>>  
>>      /* Stop new threads from spawning */
>>      qemu_bh_delete(pool->new_thread_bh);
>> @@ -344,7 +340,7 @@ void thread_pool_free(ThreadPool *pool)
>>          qemu_cond_wait(&pool->worker_stopped, &pool->lock);
>>      }
>>  
>> -    qemu_mutex_unlock(&pool->lock);
>> +    qemu_lock_guard_unlock(&pool_guard);
> Here too.  I don't see the advantage of replacing a single lock/unlock
> with QEMU_LOCK_GUARD/unlock, if it cannot be made shorter/safer then
> it's fine to use QemuMutex directly.
