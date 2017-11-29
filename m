Received: from eggs.gnu.org ([2001:4830:134:3::10]:46459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK8xA-0006Oi-Jh
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 15:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK8x9-000816-ML
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 15:27:32 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Nov 2017 21:26:53 +0100
Message-Id: <20171129202701.16117-9-david@redhat.com>
In-Reply-To: <20171129202701.16117-1-david@redhat.com>
References: <20171129202701.16117-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.12 08/16] s390x/tcg: don't exit the
 cpu loop in s390_cpu_virt_mem_rw()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

s390_cpu_virt_mem_rw() must always return, so callers can react on
an exception (e.g. see ioinst_handle_stcrw()).

Therefore, using program_interrupt() is wrong. Fix that up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index dbe2f511f8..2c7f3d7d95 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -459,7 +459,7 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
         }
         if (!address_space_access_valid(&address_space_memory, pages[i],
                                         TARGET_PAGE_SIZE, is_write)) {
-            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
+            trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
             return -EFAULT;
         }
         addr += TARGET_PAGE_SIZE;
-- 
2.14.3
