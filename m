Received: from eggs.gnu.org ([2001:4830:134:3::10]:43931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqc-0002Jz-4F
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqb-0006Ht-A9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:18:22 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  2 Jul 2018 13:17:36 +0200
Message-Id: <20180702111737.18970-15-cohuck@redhat.com>
In-Reply-To: <20180702111737.18970-1-cohuck@redhat.com>
References: <20180702111737.18970-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 14/15] s390x/kvm: indicate alignment in
 legacy_s390_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's do this for completeness reason, although we don't support e.g.
PCDIMM/NVDIMM, which would use the alignment for placing the memory
region in guest physical memory. But maybe someday we would want to
support something like this - then we don't forget about this if
allowing multiple allocations in legacy_s390_alloc().

Use the same alignment as we would set in qemu_anon_ram_alloc(). Our
fixed address satisfies this alignment (1MB). This implicitly sets the
alignment of the underlying memory region.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180628113817.30814-3-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index a9d6d606df..d923cf4240 100644
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
2.14.4
