Received: from eggs.gnu.org ([2001:4830:134:3::10]:55037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYVFo-00023n-II
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYVFm-0008KI-6p
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:38:24 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Jun 2018 13:38:16 +0200
Message-Id: <20180628113817.30814-2-david@redhat.com>
In-Reply-To: <20180628113817.30814-1-david@redhat.com>
References: <20180628113817.30814-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/2] s390x/kvm: legacy_s390_alloc() only
 supports one allocation
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

We always allocate at a fixed address, a second allocation can therefore
of course never work. We would simply overwrite mappings.

This can e.g. happen in s390_memory_init(), if trying to allocate more
than > 8TB. Let's just bail out, as there is no need for supporting it
(legacy handling for z/VM).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ac370da281..bbac3454e3 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -752,12 +752,20 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
  */
 static void *legacy_s390_alloc(size_t size, uint64_t *align, bool shared)
 {
-    void *mem;
+    static void *mem;
+
+    if (mem) {
+        /* we only support one allocation, which is enough for initial ram */
+        return NULL;
+    }
 
     mem = mmap((void *) 0x800000000ULL, size,
                PROT_EXEC|PROT_READ|PROT_WRITE,
                MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
-    return mem == MAP_FAILED ? NULL : mem;
+    if (mem == MAP_FAILED) {
+        mem = NULL;
+    }
+    return mem;
 }
 
 static uint8_t const *sw_bp_inst;
-- 
2.17.1
