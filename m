Received: from eggs.gnu.org ([2001:4830:134:3::10]:33969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4y-0002SZ-50
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4p-0007EP-1W
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:25 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:51295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4o-0006yW-Lh
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:18 -0400
Received: by mail-wm0-x232.google.com with SMTP id y2-v6so3645367wma.1
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:31 +0200
Message-Id: <1534870966-9287-60-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 59/74] util/oslib-win32: indicate alignment for
 qemu_anon_ram_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's set the alignment just like for the posix variant. This will
implicitly set the alignment of the underlying memory region and
therefore make memory_region_get_alignment(mr) return something > 0 for
all memory backends applicable to PCDIMM/NVDIMM.

The allocation granularity is ususally 64k, while the page size is 4k.
The documentation of VirtualAlloc is not really comprehensible in case
only MEM_COMMIT is specified without an address. We'll detect the actual
values and then go for the bigger one. The expection is, that it will
always be 64k aligned. (The assumption is that MEM_COMMIT does an
implicit MEM_RESERVE, so the address will always be aligned to the
allocation granularity. And the allocation granularity is always bigger
than the page size).

This will allow us to drop special handling in pc.c for
memory_region_get_alignment(mr) == 0, as we can then assume that it is
always set (and AFAICS >= getpagesize()).

For pc in pc_memory_plug(), under Windows TARGET_PAGE_SIZE == getpagesize(),
therefore alignment of DIMMs will not change, and therefore also not the
guest physical memory layout.

For spapr in spapr_memory_plug(), an alignment of 0 would have been used
until now. As QEMU_ALIGN_UP will crash with the alignment being 0, this
never worked, so we don't have to care about compatibility handling.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180801133444.11269-3-david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/oslib-win32.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index bb5ad28..25dd159 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -67,15 +67,24 @@ void *qemu_memalign(size_t alignment, size_t size)
     return qemu_oom_check(qemu_try_memalign(alignment, size));
 }
 
+static int get_allocation_granularity(void)
+{
+    SYSTEM_INFO system_info;
+
+    GetSystemInfo(&system_info);
+    return system_info.dwAllocationGranularity;
+}
+
 void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared)
 {
     void *ptr;
 
-    /* FIXME: this is not exactly optimal solution since VirtualAlloc
-       has 64Kb granularity, but at least it guarantees us that the
-       memory is page aligned. */
     ptr = VirtualAlloc(NULL, size, MEM_COMMIT, PAGE_READWRITE);
     trace_qemu_anon_ram_alloc(size, ptr);
+
+    if (ptr && align) {
+        *align = MAX(get_allocation_granularity(), getpagesize());
+    }
     return ptr;
 }
 
-- 
1.8.3.1
