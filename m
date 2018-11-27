Received: from eggs.gnu.org ([2001:4830:134:3::10]:44248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRXct-0003nC-H9
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRXco-0005oC-Jv
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:17:43 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:40728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gRXco-0005nj-DK
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:17:38 -0500
Received: by mail-pl1-x62a.google.com with SMTP id u18so2595788plq.7
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 23:17:38 -0800 (PST)
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<20181123110239.GC2373@work-vm>
	<e60f648f-d475-a88b-b0c3-300f18a7d36d@gmail.com>
	<20181126105622.GB2547@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <29851b61-8b9a-eb54-8cb7-dc601136cb9e@gmail.com>
Date: Tue, 27 Nov 2018 15:17:30 +0800
MIME-Version: 1.0
In-Reply-To: <20181126105622.GB2547@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 11/26/18 6:56 PM, Dr. David Alan Gilbert wrote:
> * Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
>>
>>
>> On 11/23/18 7:02 PM, Dr. David Alan Gilbert wrote:
>>
>>>> +#include "qemu/osdep.h"
>>>> +#include "qemu/bitmap.h"
>>>> +#include "qemu/threaded-workqueue.h"
>>>> +
>>>> +#define SMP_CACHE_BYTES 64
>>>
>>> That's architecture dependent isn't it?
>>>
>>
>> Yes, it's arch dependent indeed.
>>
>> I just used 64 for simplification and i think it is <= 64 on most CPU arch-es
>> so that can work.
>>
>> Should i introduce statically defined CACHE LINE SIZE for all arch-es? :(
> 
> I think it depends why you need it; but we shouldn't have a constant
> that is wrong, and we shouldn't define something architecture dependent
> in here.
> 

I see. I will address Emilio's suggestion that rename SMP_CACHE_BYTES to
THREAD_QUEUE_ALIGN and additional comments.

>>>> +   /*
>>>> +     * the bit in these two bitmaps indicates the index of the ＠requests
>>>> +     * respectively. If it's the same, the corresponding request is free
>>>> +     * and owned by the user, i.e, where the user fills a request. Otherwise,
>>>> +     * it is valid and owned by the thread, i.e, where the thread fetches
>>>> +     * the request and write the result.
>>>> +     */
>>>> +
>>>> +    /* after the user fills the request, the bit is flipped. */
>>>> +    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
>>>> +    /* after handles the request, the thread flips the bit. */
>>>> +    uint64_t request_done_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
>>>
>>> Patchew complained about some type mismatches; I think those are because
>>> you're using the bitmap_* functions on these; those functions always
>>> operate on 'long' not on uint64_t - and on some platforms they're
>>> unfortunately not the same.
>>
>> I guess you were taking about this error:
>> ERROR: externs should be avoided in .c files
>> #233: FILE: util/threaded-workqueue.c:65:
>> +    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
>>
>> The complained thing is "QEMU_ALIGNED(SMP_CACHE_BYTES)" as it gone
>> when the aligned thing is removed...
>>
>> The issue you pointed out can be avoid by using type-casting, like:
>> bitmap_xor(..., (void *)&thread->request_fill_bitmap)
>> cannot we?
> 
> I thought the error was just due to long vs uint64_t ratehr than the
> qemu_aligned.  I don't think it's just a casting problem, since I don't
> think the long's are always 64bit.

Well, i made some adjustments that makes check_patch.sh really happy :),
as followings:
$ git diff util/
diff --git a/util/threaded-workqueue.c b/util/threaded-workqueue.c
index 2ab37cee8d..e34c65a8eb 100644
--- a/util/threaded-workqueue.c
+++ b/util/threaded-workqueue.c
@@ -62,21 +62,30 @@ struct ThreadLocal {
       */

      /* after the user fills the request, the bit is flipped. */
-    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
+    struct {
+        uint64_t request_fill_bitmap;
+    } QEMU_ALIGNED(SMP_CACHE_BYTES);
+
      /* after handles the request, the thread flips the bit. */
-    uint64_t request_done_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
+    struct {
+        uint64_t request_done_bitmap;
+    } QEMU_ALIGNED(SMP_CACHE_BYTES);

      /*
       * the event used to wake up the thread whenever a valid request has
       * been submitted
       */
-    QemuEvent request_valid_ev QEMU_ALIGNED(SMP_CACHE_BYTES);
+    struct {
+        QemuEvent request_valid_ev;
+    } QEMU_ALIGNED(SMP_CACHE_BYTES);

      /*
       * the event is notified whenever a request has been completed
       * (i.e, become free), which is used to wake up the user
       */
-    QemuEvent request_free_ev QEMU_ALIGNED(SMP_CACHE_BYTES);
+    struct {
+        QemuEvent request_free_ev;
+    } QEMU_ALIGNED(SMP_CACHE_BYTES);
  };
  typedef struct ThreadLocal ThreadLocal;

$ ./scripts/checkpatch.pl -f util/threaded-workqueue.c
total: 0 errors, 0 warnings, 472 lines checked

util/threaded-workqueue.c has no obvious style problems and is ready for submission.

check_patch.sh somehow treats QEMU_ALIGNED as a function before the modification.

And yes, u64 is not a long type on 32 bit arch, it's long[2] instead. that's fine
when we pass the &(u64) to the function whose parameter is (long *). I thing this
trick is widely used. e.g, the example in kvm that i replied to Emilio:

static inline bool kvm_test_request(int req, struct kvm_vcpu *vcpu)
{
     return test_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
}
