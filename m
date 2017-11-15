Received: from eggs.gnu.org ([2001:4830:134:3::10]:39866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eEvZb-0004u5-VK
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eEvZW-00048o-7g
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:09:39 -0500
Date: Wed, 15 Nov 2017 11:09:22 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171115110922.zm7vn7vc3w37aokp@starbug-vm.ie.oracle.com>
References: <20171114184127.24238-1-mreitz@redhat.com>
	<20171115110419.k5vs4fghfzbu3f2c@starbug-vm.ie.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20171115110419.k5vs4fghfzbu3f2c@starbug-vm.ie.oracle.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.11] qcow2: Fix overly
 broad madvise()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

Should have said that this is subject to the typo that Eric pointed
out, of course.

Thanks,

Darren.

On Wed, Nov 15, 2017 at 11:04:19AM +0000, Darren Kenny wrote:
>FWIW,
>
>Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
>
>Thanks,
>
>Darren.
>
>On Tue, Nov 14, 2017 at 07:41:27PM +0100, Max Reitz wrote:
>>@mem_size and @offset are both size_t, thus subtracting them from one
>>another will just return a big size_t if mem_size < offset -- even more
>>obvious here because the result is stored in another size_t.
>>
>>Checking that result to be positive is therefore not sufficient to
>>excluse the case that offset > mem_size.  Thus, we currently sometimes
>>issue an madvise() over a very large address range.
>>
>>This is triggered by iotest 163, but with -m64, this does not result in
>>tangible problems.  But with -m32, this test produces three segfaults,
>>all of which are fixed by this patch.
>>
>>Signed-off-by: Max Reitz <mreitz@redhat.com>
>>---
>>block/qcow2-cache.c | 2 +-
>>1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
>>index 75746a7f43..5222a7b94d 100644
>>--- a/block/qcow2-cache.c
>>+++ b/block/qcow2-cache.c
>>@@ -73,7 +73,7 @@ static void qcow2_cache_table_release(BlockDriverState *bs, Qcow2Cache *c,
>>    size_t mem_size = (size_t) s->cluster_size * num_tables;
>>    size_t offset = QEMU_ALIGN_UP((uintptr_t) t, align) - (uintptr_t) t;
>>    size_t length = QEMU_ALIGN_DOWN(mem_size - offset, align);
>>-    if (length > 0) {
>>+    if (mem_size > offset && length > 0) {
>>        madvise((uint8_t *) t + offset, length, MADV_DONTNEED);
>>    }
>>#endif
>>-- 
>>2.13.6
>>
>>
