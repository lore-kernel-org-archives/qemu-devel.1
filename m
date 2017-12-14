Received: from eggs.gnu.org ([2001:4830:134:3::10]:54555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2N-0008Gl-6b
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2J-0006lw-Sn
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:11 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:31 +0100
Message-Id: <20171214171004.25058-14-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 13/46] s390x/tcg: don't exit the cpu loop in
 s390_cpu_virt_mem_rw()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

s390_cpu_virt_mem_rw() must always return, so callers can react on
an exception (e.g. see ioinst_handle_stcrw()).

Therefore, using program_interrupt() is wrong. Fix that up.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171130162744.25442-9-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/mmu_helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index dbe2f511f8..f477cc006a 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -64,7 +64,9 @@ static void trigger_access_exception(CPUS390XState *env, uint32_t type,
         kvm_s390_access_exception(cpu, type, tec);
     } else {
         CPUState *cs = CPU(cpu);
-        stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code), tec);
+        if (type != PGM_ADDRESSING) {
+            stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code), tec);
+        }
         trigger_pgm_exception(env, type, ilen);
     }
 }
@@ -443,7 +445,8 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
 
 /**
  * translate_pages: Translate a set of consecutive logical page addresses
- * to absolute addresses
+ * to absolute addresses. This function is used for TCG and old KVM without
+ * the MEMOP interface.
  */
 static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
                            target_ulong *pages, bool is_write)
@@ -459,7 +462,7 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
         }
         if (!address_space_access_valid(&address_space_memory, pages[i],
                                         TARGET_PAGE_SIZE, is_write)) {
-            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
+            trigger_access_exception(env, PGM_ADDRESSING, ILEN_AUTO, 0);
             return -EFAULT;
         }
         addr += TARGET_PAGE_SIZE;
-- 
2.13.6
