Received: from eggs.gnu.org ([2001:4830:134:3::10]:40562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gD4dw-0000q0-Kq
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gD4dr-0004WQ-M9
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:31:00 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gD4dr-0004U9-EG
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:30:55 -0400
Received: by mail-pg1-x543.google.com with SMTP id n31-v6so13931991pgm.7
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 02:30:55 -0700 (PDT)
References: <20181016111006.629-1-xiaoguangrong@tencent.com>
	<20181016111006.629-3-xiaoguangrong@tencent.com>
	<873d9b11-3643-28d1-e7d8-44657402fa56@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <fb967d04-d189-5bc4-4747-27ad8342d526@gmail.com>
Date: Thu, 18 Oct 2018 17:30:48 +0800
MIME-Version: 1.0
In-Reply-To: <873d9b11-3643-28d1-e7d8-44657402fa56@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: introduce lockless
 multithreads model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, "Emilio G. Cota" <cota@braap.org>



On 10/17/2018 06:10 PM, Paolo Bonzini wrote:

> 
> An idea: the total number of requests is going to be very small, and a
> PtrRing is not the nicest data structure for multiple producer/single
> consumer.  So you could instead:
> 
> - add the size of one request to the ops structure.  Move the allocation
> in init_requests, so that you can have one single large array that
> stores all requests.  thread_request_init gets the pointer to a single
> request.
> 
> - now that you have a single array (let's call it threads->requests),
> the request index can be found with "(req - threads->requests) /
> threads->ops->request_size".  The thread index, furthermore, is just
> request_index / threads->thread_ring_size and you can remove it from
> ThreadRequest.
> 
> - now that you have request indices, you can replace the completion
> ptr_ring with a bitmap, and set a bit in the bitmap with set_bit_atomic
> to report completion.  On the writer side you use find_next_bit to find
> a completed request and clear_bit_atomic to clear its index.  The index
> passed to find_next_bit is threads->current_thread_index *
> threads->thread_ring_size,  And you also don't need find_free_thread,
> because you can update threads->current_thread_index to
> 
>      threads->current_thread_index =
>         ((free_request_id / threads->thread_ring_size) + 1)
>          % threads->thread_nr;
> 
> after you prepare a request, and threads will then naturally receive
> requests in round-robin order.  (If find_next_bit fails it means you
> have to move the current_thread_index to 0 and retry).
> 
> - you don't need the free requests list and free_requests_nr either: you
> just initialize the completed request bitmap to all-ones, and
> find_next_bit + clear_bit_atomic will do the work of free_requests.
> ThreadRequest goes away completely now!
> 
> The advantage is that you get rid of the spinlock on the consumer side,
> and many auxiliary data structures on the producer side: a bitmap is a
> much nicer data structure for multiple producer/single consumer than the
> PtrRing.  In addition, with this design the entire Threads structure
> becomes read-mostly, which is nice for the cache.  The disadvantage is
> that you add an atomic operation (clear_bit_atomic) to
> threads_submit_request_prepare(*).
> 

All your comments are good to me and you are a GENIUS, the idea
that make the requests be a single array and partitions it like
this way simplifies the thing a lot.

> The PtrRing is still useful for the other direction, because there you
> have single producer/single consumer.
> 
> 	(*) It's probably possible to have two separate bitmaps, e.g.
> 	    where the producer and consumers *flip* bits and the
> 	    producer looks for mismatched bits between the two bitmaps.
> 	    I'm not asking you to flesh out and implement that; it's
> 	    just why I think you can ignore the extra cost of
> 	    clear_bit_atomic.  In fact, if the maintainers think this
> 	    is overkill you can go ahead with just the naming fixes and
> 	    I'll take a look at a rewrite when I have some time for fun
> 	    stuff. :)
> 

LOL! Great minds think alike, the idea, "flipping bitmaps", was in my
mind too. :)

Beside that... i think we get the chance to remove ptr_ring gracefully,
as the bitmap can indicate the ownership of the request as well. If
the bit is 1 (supposing all bits are 1 on default), only the user can
operate it, the bit will be cleared after the user fills the info
to the request. After that, the thread sees the bit is cleared, then
it gets the ownership and finishes the request, then sets bit in
the bitmap. The ownership is returned to the user again.

One thing may be disadvantage is, it can't differentiate the case if the
request is empty or contains the result which need the user call
threads_wait_done(), that will slow threads_wait_done() a little as it
need check all requests, but it is not a big deal as
1) at the point needing flush, it's high possible that all most requests
    have been used.
2) the total number of requests is going to be very small.


It is illustrated by following code by combining the "flip" bitmaps:

struct Threads {
    ......

    /*
     * the bit in these two bitmaps indicates the index of the requests
     * respectively. If it's the same, the request is owned by the user,
     * i.e, only the use can use the request. Otherwise, it is owned by
     * the thread.
     */

    /* after the user fills the request, the bit is flipped. */
    unsigned long *request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);

    /* after handles the request, the thread flips the bit. */
    unsigned long *request_done_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
}

threads_submit_request_prepare()
{
	request_done_bitmap = READ_ONCE(threads->request_done_bitmap);
         result_bitmap = bitmap_xor(&request_done_bitmap, threads->request_fill_bitmap);

	index = find_first_zero_bit(current-thread-to-request-index, &result_bitmap);

	/* make sure we get the data the thread written. */
         smp_rmb();

         thread_request_done(requests[index]);
         ...
}

threads_submit_request_commit()
{
         /* make sure the user have filled the request before we make it be viable to the threads. */
	smp_wmb();

	/* after that, the thread can handle the request. */
         bitmap_change_bit(request-to-index, threads->request_fill_bitmap);
         ......
}

In the thread, it does:
thread_run()
{
	index_start = threads->requests + itself->index * threads->thread_ring_size;
	index_end = index_start + threads->thread_ring_size;

loop:
	request_fill_bitmap = READ_ONCE(threads->request_fill_bitmap);
	request_done_bitmap = READ_ONCE(threads->request_done_bitmap);
	result_bitmap = bitmap_xor(&request_fill_bitmap, &request_done_bitmap);

	index = find_first_bit_set(&result_bitmap, .start = index_start, .end = index_end);

	/*
          * paired with smp_wmb() in threads_submit_request_commit to make sure the
          * thread can get data filled by the user.
          */
	smp_rmb();

	request = threads->requests[index];
	thread_request_handler(request);

	/*
          * updating the request is viable before flip the bitmap, paired
          * with smp_rmb() in threads_submit_request_prepare().
          */
	smp_wmb();

	bitmap_change_bit_atomic(&threads->request_done_bitmap, index);
         ......
}
