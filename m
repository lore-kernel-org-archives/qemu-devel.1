Received: from eggs.gnu.org ([208.118.235.92]:42924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fuzow-00069q-W9
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fuznn-00033L-T7
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:42:31 -0400
Received: from mail-eopbgr40104.outbound.protection.outlook.com
	([40.107.4.104]:8016
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fuznn-00032U-Ix
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:42:27 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Wed, 29 Aug 2018 15:41:28 +0300
Message-Id: <1535546488-30208-6-git-send-email-viktor.prutyanov@virtuozzo.com>
In-Reply-To: <1535546488-30208-1-git-send-email-viktor.prutyanov@virtuozzo.com>
References: <1535546488-30208-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 5/5] contrib/elf2dmp: add 1GB and 2MB pages
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, armbru@redhat.com, dgilbert@redhat.com, rkagan@virtuozzo.com, viktor.prutyanov@phystech.edu, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

After this patch 1GB and 2MB pages are being correctly processed during
virtual address resolving.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 contrib/elf2dmp/addrspace.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 70f4271..f36e749 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -145,6 +145,21 @@ static bool is_present(uint64_t entry)
     return entry & 0x1;
 }
 
+static bool page_size_flag(uint64_t entry)
+{
+    return entry & (1 << 7);
+}
+
+static uint64_t get_1GB_paddr(uint64_t va, uint64_t pdpte)
+{
+    return (pdpte & 0xfffffc0000000) | (va & 0x3fffffff);
+}
+
+static uint64_t get_2MB_paddr(uint64_t va, uint64_t pgd_entry)
+{
+    return (pgd_entry & 0xfffffffe00000) | (va & 0x00000001fffff);
+}
+
 static uint64_t va_space_va2pa(struct va_space *vs, uint64_t va)
 {
     uint64_t pml4e, pdpe, pgd, pte;
@@ -159,11 +174,19 @@ static uint64_t va_space_va2pa(struct va_space *vs, uint64_t va)
         return INVALID_PA;
     }
 
+    if (page_size_flag(pdpe)) {
+        return get_1GB_paddr(va, pdpe);
+    }
+
     pgd = get_pgd(vs, va, pdpe);
     if (!is_present(pgd)) {
         return INVALID_PA;
     }
 
+    if (page_size_flag(pgd)) {
+        return get_2MB_paddr(va, pgd);
+    }
+
     pte = get_pte(vs, va, pgd);
     if (!is_present(pte)) {
         return INVALID_PA;
-- 
2.7.4
