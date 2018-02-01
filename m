Received: from eggs.gnu.org ([2001:4830:134:3::10]:34474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehGmz-0006nD-06
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehGmv-0007IC-5P
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:28:37 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehGmu-0007Hf-UO
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:28:33 -0500
Received: by mail-wm0-f41.google.com with SMTP id v71so6487379wmv.2
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 07:28:32 -0800 (PST)
References: <20180125175949.7780-1-pbonzini@redhat.com>
	<20180125175949.7780-5-pbonzini@redhat.com>
	<20180129132621.GD20446@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ffe6237-61c4-a69a-c9b7-7cb6774410aa@redhat.com>
Date: Thu, 1 Feb 2018 10:28:29 -0500
MIME-Version: 1.0
In-Reply-To: <20180129132621.GD20446@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] coroutine-lock: make
 qemu_co_enter_next thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org

On 29/01/2018 08:26, Stefan Hajnoczi wrote:
>>  /**
>> - * Enter the next coroutine in the queue
>> + * Immediately enter the next coroutine in the queue.  Release the mutex
>> + * while it runs.
> 
> s/mutex/lock/
> 
> Is this doc comment correct?  I see multiple cases due to aio_co_wake():
> 
> 1. Called from coroutine context with current AioContext matching next
>    coroutine's AioContext: arrange for next coroutine to be entered
>    *after* we yield (not "immediately").
> 
> 2. Called from non-coroutine context with current AioContext matching
>    next coroutine's AioContext: immediately enter next coroutine.
> 
> 3. Called from different AioContext than next coroutine: arrange for
>    next coroutine to be entered at some point.

Good point, it needs to be more specific.  Here is the best I could come up
with:

+ * Removes the next coroutine from the CoQueue, and wake it up.
  * Returns true if a coroutine was removed, false if the queue is empty.
  */
 bool coroutine_fn qemu_co_queue_next(CoQueue *queue);

...

+ * Empties the CoQueue; all coroutines are woken up.
  */
 void coroutine_fn qemu_co_queue_restart_all(CoQueue *queue);

...

+ * Removes the next coroutine from the CoQueue, and wake it up.  Unlike
+ * qemu_co_queue_next, this function releases the lock during aio_co_wake
+ * because it is meant to be used outside coroutine context; in that case, the
+ * coroutine is entered immediately, before qemu_co_enter_next returns.
+ *
+ * If used in coroutine context, qemu_co_enter_next is equivalent to
+ * qemu_co_queue_next.
  */
 #define qemu_co_enter_next(queue, lock) \
     qemu_co_enter_next_impl(queue, QEMU_MAKE_LOCKABLE(lock))
