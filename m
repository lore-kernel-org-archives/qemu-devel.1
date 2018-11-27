Received: from eggs.gnu.org ([2001:4830:134:3::10]:59124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRYk9-00007K-Dn
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRYk6-0005Me-8u
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:29:17 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gRYk6-0005Kx-0c
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:29:14 -0500
Received: by mail-pl1-x642.google.com with SMTP id a14so15230322plm.12
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 00:29:13 -0800 (PST)
References: <20181126184919.GA6688@flamenco>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <fb9e053d-629d-d468-613d-2c695bf686ea@gmail.com>
Date: Tue, 27 Nov 2018 16:29:05 +0800
MIME-Version: 1.0
In-Reply-To: <20181126184919.GA6688@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 11/27/18 2:49 AM, Emilio G. Cota wrote:
> On Mon, Nov 26, 2018 at 16:06:37 +0800, Xiao Guangrong wrote:
>>>> +    /* after the user fills the request, the bit is flipped. */
>>>> +    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
>>>> +    /* after handles the request, the thread flips the bit. */
>>>> +    uint64_t request_done_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
>>>
>>> Use DECLARE_BITMAP, otherwise you'll get type errors as David
>>> pointed out.
>>
>> If we do it, the field becomes a pointer... that complicates the
>> thing.
> 
> Not necessarily, see below.
> 
> On Mon, Nov 26, 2018 at 16:18:24 +0800, Xiao Guangrong wrote:
>> On 11/24/18 8:17 AM, Emilio G. Cota wrote:
>>> On Thu, Nov 22, 2018 at 15:20:25 +0800, guangrong.xiao@gmail.com wrote:
>>>> +static uint64_t get_free_request_bitmap(Threads *threads, ThreadLocal *thread)
>>>> +{
>>>> +    uint64_t request_fill_bitmap, request_done_bitmap, result_bitmap;
>>>> +
>>>> +    request_fill_bitmap = atomic_rcu_read(&thread->request_fill_bitmap);
>>>> +    request_done_bitmap = atomic_rcu_read(&thread->request_done_bitmap);
>>>> +    bitmap_xor(&result_bitmap, &request_fill_bitmap, &request_done_bitmap,
>>>> +               threads->thread_requests_nr);
>>>
>>> This is not wrong, but it's a big ugly. Instead, I would:
>>>
>>> - Introduce bitmap_xor_atomic in a previous patch
>>> - Use bitmap_xor_atomic here, getting rid of the rcu reads
>>
>> Hmm, however, we do not need atomic xor operation here... that should be slower than
>> just two READ_ONCE calls.
> 
> If you use DECLARE_BITMAP, you get an in-place array. On a 64-bit
> host, that'd be
> 	unsigned long foo[1]; /* [2] on 32-bit */
> 
> Then again on 64-bit hosts, bitmap_xor_atomic would reduce
> to 2 atomic reads:
> 
> static inline void bitmap_xor_atomic(unsigned long *dst,
> const unsigned long *src1, const unsigned long *src2, long nbits)
> {
>      if (small_nbits(nbits)) {
>          *dst = atomic_read(src1) ^ atomic_read(&src2);
>      } else {
>          slow_bitmap_xor_atomic(dst, src1, src2, nbits);

We needn't do inplace xor operation. i.e, we just fetch the bitmaps to
the local variables do xor locally.

So we need additional complicity to handle the case that is !small_nbits(nbits)
... but it is really not a big deal as you said, it just couple of codes.

However, use u64 for the purpose that only  64 indexes are allowed is more
straightforward and can be naturally understood. :)
