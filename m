Received: from eggs.gnu.org ([2001:4830:134:3::10]:55276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyw-0002qn-H0
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyv-0003Ok-Nk
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGyv-0003Of-Id
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:49 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:13 +0800
Message-Id: <1481512100-10380-8-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 07/14] vm/page: provide
 PGDIR_OFFSET() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: drjones@redhat.com, agordeev@redhat.com, jan.kiszka@web.de, rkrcmar@redhat.com, pbonzini@redhat.com, peterx@redhat.com

This can be used in further patches.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/x86/asm/page.h | 3 +++
 lib/x86/vm.c       | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/x86/asm/page.h b/lib/x86/asm/page.h
index 5044a49..c43bab2 100644
--- a/lib/x86/asm/page.h
+++ b/lib/x86/asm/page.h
@@ -41,5 +41,8 @@
 #define	PGDIR_MASK	1023
 #endif
 
+#define PGDIR_BITS(lvl)        (((lvl) - 1) * PGDIR_WIDTH + PAGE_SHIFT)
+#define PGDIR_OFFSET(va, lvl)  (((va) >> PGDIR_BITS(lvl)) & PGDIR_MASK)
+
 #endif /* !__ASSEMBLY__ */
 #endif
diff --git a/lib/x86/vm.c b/lib/x86/vm.c
index f7e778b..cda4c5f 100644
--- a/lib/x86/vm.c
+++ b/lib/x86/vm.c
@@ -48,7 +48,7 @@ unsigned long *install_pte(unsigned long *cr3,
     unsigned offset;
 
     for (level = PAGE_LEVEL; level > pte_level; --level) {
-	offset = ((unsigned long)virt >> ((level-1) * PGDIR_WIDTH + 12)) & PGDIR_MASK;
+	offset = PGDIR_OFFSET((unsigned long)virt, level);
 	if (!(pt[offset] & PT_PRESENT_MASK)) {
 	    unsigned long *new_pt = pt_page;
             if (!new_pt)
@@ -60,7 +60,7 @@ unsigned long *install_pte(unsigned long *cr3,
 	}
 	pt = phys_to_virt(pt[offset] & PT_ADDR_MASK);
     }
-    offset = ((unsigned long)virt >> ((level-1) * PGDIR_WIDTH + 12)) & PGDIR_MASK;
+    offset = PGDIR_OFFSET((unsigned long)virt, level);
     pt[offset] = pte;
     return &pt[offset];
 }
-- 
2.7.4
