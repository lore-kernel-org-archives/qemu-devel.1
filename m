Received: from eggs.gnu.org ([2001:4830:134:3::10]:55101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwZ-0005cv-Bc
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwY-0001JM-E8
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:15 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwY-0001IW-8U
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:14 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:04:44 +0200
Message-Id: <20170525210508.4910-3-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 02/26] target/s390x: make IPTE SMP aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/mem_helper.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 4b96c279e3..88e2a0f60d 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1109,8 +1109,6 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pte_addr, uint64_t vaddr)
     uint64_t page = vaddr & TARGET_PAGE_MASK;
     uint64_t pte = 0;
 
-    /* XXX broadcast to other CPUs */
-
     /* XXX Linux is nice enough to give us the exact pte address.
        According to spec we'd have to find it out ourselves */
     /* XXX Linux is fine with overwriting the pte, the spec requires
@@ -1119,13 +1117,13 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pte_addr, uint64_t vaddr)
 
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
-    tlb_flush_page(cs, page);
+    tlb_flush_page_all_cpus_synced(cs, page);
 
     /* XXX 31-bit hack */
     if (page & 0x80000000) {
-        tlb_flush_page(cs, page & ~0x80000000);
+        tlb_flush_page_all_cpus_synced(cs, page & ~0x80000000);
     } else {
-        tlb_flush_page(cs, page | 0x80000000);
+        tlb_flush_page_all_cpus_synced(cs, page | 0x80000000);
     }
 }
 
-- 
2.11.0
