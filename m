Received: from eggs.gnu.org ([2001:4830:134:3::10]:43914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqa-0002I5-J4
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqZ-0006Gx-Jc
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:18:20 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  2 Jul 2018 13:17:35 +0200
Message-Id: <20180702111737.18970-14-cohuck@redhat.com>
In-Reply-To: <20180702111737.18970-1-cohuck@redhat.com>
References: <20180702111737.18970-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 13/15] s390x/kvm: legacy_s390_alloc() only
 supports one allocation
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

We always allocate at a fixed address, a second allocation can therefore
of course never work. We would simply overwrite mappings.

This can e.g. happen in s390_memory_init(), if trying to allocate more
than > 8TB. Let's just bail out, as there is no need for supporting it
(legacy handling for z/VM).

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180628113817.30814-2-david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 8bcd832123..a9d6d606df 100644
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
2.14.4
