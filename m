Received: from eggs.gnu.org ([2001:4830:134:3::10]:45817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRBlx-000261-G8
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 02:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRBlu-0001lz-A0
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 02:57:37 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gRBlu-0001kt-2A
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 02:57:34 -0500
Received: by mail-pf1-x444.google.com with SMTP id u6so6166476pfh.11
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 23:57:33 -0800 (PST)
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<20181123110239.GC2373@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <e60f648f-d475-a88b-b0c3-300f18a7d36d@gmail.com>
Date: Mon, 26 Nov 2018 15:57:25 +0800
MIME-Version: 1.0
In-Reply-To: <20181123110239.GC2373@work-vm>
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



On 11/23/18 7:02 PM, Dr. David Alan Gilbert wrote:

>> +#include "qemu/osdep.h"
>> +#include "qemu/bitmap.h"
>> +#include "qemu/threaded-workqueue.h"
>> +
>> +#define SMP_CACHE_BYTES 64
> 
> That's architecture dependent isn't it?
> 

Yes, it's arch dependent indeed.

I just used 64 for simplification and i think it is <= 64 on most CPU arch-es
so that can work.

Should i introduce statically defined CACHE LINE SIZE for all arch-es? :(

>> +   /*
>> +     * the bit in these two bitmaps indicates the index of the ＠requests
>> +     * respectively. If it's the same, the corresponding request is free
>> +     * and owned by the user, i.e, where the user fills a request. Otherwise,
>> +     * it is valid and owned by the thread, i.e, where the thread fetches
>> +     * the request and write the result.
>> +     */
>> +
>> +    /* after the user fills the request, the bit is flipped. */
>> +    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
>> +    /* after handles the request, the thread flips the bit. */
>> +    uint64_t request_done_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
> 
> Patchew complained about some type mismatches; I think those are because
> you're using the bitmap_* functions on these; those functions always
> operate on 'long' not on uint64_t - and on some platforms they're
> unfortunately not the same.

I guess you were taking about this error:
ERROR: externs should be avoided in .c files
#233: FILE: util/threaded-workqueue.c:65:
+    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);

The complained thing is "QEMU_ALIGNED(SMP_CACHE_BYTES)" as it gone
when the aligned thing is removed...

The issue you pointed out can be avoid by using type-casting, like:
bitmap_xor(..., (void *)&thread->request_fill_bitmap)
cannot we?

Thanks!
