Received: from eggs.gnu.org ([2001:4830:134:3::10]:55038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYVFo-00023o-IR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYVFn-0008OT-OX
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:38:24 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Jun 2018 13:38:17 +0200
Message-Id: <20180628113817.30814-3-david@redhat.com>
In-Reply-To: <20180628113817.30814-1-david@redhat.com>
References: <20180628113817.30814-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/2] s390x/kvm: indicate alignment in
 legacy_s390_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Let's do this for completeness reason, although we don't support e.g.
PCDIMM/NVDIMM, which would use the alignment for placing the memory
region in guest physical memory. But maybe someday we would want to
support something like this - then we don't forget about this if
allowing multiple allocations in legacy_s390_alloc().

Use the same alignment as we would set in qemu_anon_ram_alloc(). Our
fixed address satisfies this alignment (1MB). This implicitly sets the
alignment of the underlying memory region.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index bbac3454e3..22e13080a5 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -765,6 +765,9 @@ static void *legacy_s390_alloc(size_t size, uint64_t *align, bool shared)
     if (mem == MAP_FAILED) {
         mem = NULL;
     }
+    if (mem && align) {
+        *align = QEMU_VMALLOC_ALIGN;
+    }
     return mem;
 }
 
-- 
2.17.1
