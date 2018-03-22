Received: from eggs.gnu.org ([2001:4830:134:3::10]:45632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1eyyqV-0002bR-KO
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1eyyqR-0004XS-A6
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:57:27 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:35631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1eyyqR-0004WE-3f
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:57:23 -0400
Received: by mail-it0-x241.google.com with SMTP id v194-v6so10785835itb.0
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 04:57:22 -0700 (PDT)
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-3-xiaoguangrong@tencent.com>
	<20180321090644.GC20571@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <044788cf-fd00-83b3-6cd2-7df605397418@gmail.com>
Date: Thu, 22 Mar 2018 19:57:54 +0800
MIME-Version: 1.0
In-Reply-To: <20180321090644.GC20571@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/8] migration: stop allocating and freeing
 memory frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org



On 03/21/2018 05:06 PM, Peter Xu wrote:
> On Tue, Mar 13, 2018 at 03:57:33PM +0800, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Current code uses compress2()/uncompress() to compress/decompress
>> memory, these two function manager memory allocation and release
>> internally, that causes huge memory is allocated and freed very
>> frequently
>>
>> More worse, frequently returning memory to kernel will flush TLBs
>> and trigger invalidation callbacks on mmu-notification which
>> interacts with KVM MMU, that dramatically reduce the performance
>> of VM
>>
>> So, we maintain the memory by ourselves and reuse it for each
>> compression and decompression
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>> ---
>>   migration/qemu-file.c |  34 ++++++++++--
>>   migration/qemu-file.h |   6 ++-
>>   migration/ram.c       | 142 +++++++++++++++++++++++++++++++++++++-------------
>>   3 files changed, 140 insertions(+), 42 deletions(-)
>>
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index 2ab2bf362d..1ff33a1ffb 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -658,6 +658,30 @@ uint64_t qemu_get_be64(QEMUFile *f)
>>       return v;
>>   }
>>   
>> +/* return the size after compression, or negative value on error */
>> +static int qemu_compress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
>> +                              const uint8_t *source, size_t source_len)
>> +{
>> +    int err;
>> +
>> +    err = deflateReset(stream);
> 
> I'm not familiar with zlib, but I saw this in manual:
> 
>   https://www.zlib.net/manual.html
> 
>   This function is equivalent to deflateEnd followed by deflateInit,
>   but does not free and reallocate the internal compression state. The
>   stream will leave the compression level and any other attributes that
>   may have been set unchanged.
> 
> I thought it was deflateInit() who is slow?  Can we avoid the reset as

deflateEnd() is worse as it frees memory to kernel which triggers
TLB flush and mmu-notifier.

> long as we make sure to deflateInit() before doing anything else?

Actually, deflateReset() is cheap... :)

> 
> Meanwhile, is there any performance number for this single patch?
> Since I thought the old code is calling compress2() which contains
> deflateInit() and deflateEnd() too, just like what current patch do?

No, after the patch, we just call deflateInit() / deflateEnd() one
time (in _setup() handler and _cleanup handler).

Yes. This is the perf data from our production,
after revert this patch:
+  57.88%  kqemu  [kernel.kallsyms]        [k] queued_spin_lock_slowpath
+  10.55%  kqemu  [kernel.kallsyms]        [k] __lock_acquire
+   4.83%  kqemu  [kernel.kallsyms]        [k] flush_tlb_func_common

-   1.16%  kqemu  [kernel.kallsyms]        [k] lock_acquire                                       ▒
    - lock_acquire                                                                                 ▒
       - 15.68% _raw_spin_lock                                                                     ▒
          + 29.42% __schedule                                                                      ▒
          + 29.14% perf_event_context_sched_out                                                    ▒
          + 23.60% tdp_page_fault                                                                  ▒
          + 10.54% do_anonymous_page                                                               ▒
          + 2.07% kvm_mmu_notifier_invalidate_range_start                                          ▒
          + 1.83% zap_pte_range                                                                    ▒
          + 1.44% kvm_mmu_notifier_invalidate_range_end


apply our work:
+  51.92%  kqemu  [kernel.kallsyms]        [k] queued_spin_lock_slowpath
+  14.82%  kqemu  [kernel.kallsyms]        [k] __lock_acquire
+   1.47%  kqemu  [kernel.kallsyms]        [k] mark_lock.clone.0
+   1.46%  kqemu  [kernel.kallsyms]        [k] native_sched_clock
+   1.31%  kqemu  [kernel.kallsyms]        [k] lock_acquire
+   1.24%  kqemu  libc-2.12.so             [.] __memset_sse2

-  14.82%  kqemu  [kernel.kallsyms]        [k] __lock_acquire                                     ▒
    - __lock_acquire                                                                               ▒
       - 99.75% lock_acquire                                                                       ▒
          - 18.38% _raw_spin_lock                                                                  ▒
             + 39.62% tdp_page_fault                                                               ▒
             + 31.32% __schedule                                                                   ▒
             + 27.53% perf_event_context_sched_out                                                 ▒
             + 0.58% hrtimer_interrupt


You can see the TLB flush and mmu-lock contention have gone after this patch.

> 
> It would be nice too if we can split the patch into two (decode,
> encode) if you want, but that's optional.

That's good to me, thank you, Peter.
