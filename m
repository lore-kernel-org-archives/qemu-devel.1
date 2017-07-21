Received: from eggs.gnu.org ([2001:4830:134:3::10]:58369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYXTs-0003tR-Gz
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYXTr-0002Nk-Nq
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:56:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dYXTr-0002NV-HC
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:56:31 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 21 Jul 2017 14:56:05 +0200
Message-Id: <20170721125609.11117-3-david@redhat.com>
In-Reply-To: <20170721125609.11117-1-david@redhat.com>
References: <20170721125609.11117-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/6] target/s390x: fix pgm irq ilen in
 translate_pages()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

0 is certainly wrong. Let's use ILEN_AUTO.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index a873dc4..1ad0158 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -440,7 +440,7 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
         }
         if (!address_space_access_valid(&address_space_memory, pages[i],
                                         TARGET_PAGE_SIZE, is_write)) {
-            program_interrupt(env, PGM_ADDRESSING, 0);
+            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
             return -EFAULT;
         }
         addr += TARGET_PAGE_SIZE;
-- 
2.9.4
