Received: from eggs.gnu.org ([2001:4830:134:3::10]:54892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eZUAS-0006nH-S7
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 23:08:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eZUAP-0005Gr-ND
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 23:08:40 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 11 Jan 2018 15:08:32 +1100
Message-Id: <20180111040832.28383-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] target/ppc: Yet another fix for KVM-HV
 HPTE accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

As stated in the 1ad9f0a464fe commit log, the returned entries are not
a while PTEG. It was not a problem before 1ad9f0a464fe as it would read
a single record assuming it contains a whole PTEG but now the code tries
reading the entire PTEG and "if ((n - i) < invalid)" produces negative
values which then are converted to size_t for memset() and that throws
seg fault.

This fixes the math.

While here, fix the last @i increment as well.

Fixes: 1ad9f0a464fe "target/ppc: Fix KVM-HV HPTE accessors"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Record #0:
(gdb) p *hdr
$13 = {
  index = <ptr>,
  n_valid = 0x1,
  n_invalid = 0x6
}

Record #1:
(gdb) p *hdr
$18 = {
  index = <ptr>,
  n_valid = 0x2,
  n_invalid = 0x6
}


i.e. in the second iteration of the loop right before
"if ((n - i) < invalid)":
(gdb) p n
$16 = 0x8
(gdb) p i
$17 = 0x9

and @invalid becomes -1.

---
 target/ppc/kvm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 0566af7..c2dea81 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2657,21 +2657,24 @@ void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, hwaddr ptex, int n)
 
         hdr = (struct kvm_get_htab_header *)buf;
         while ((i < n) && ((char *)hdr < (buf + rc))) {
-            int invalid = hdr->n_invalid;
+            int invalid = hdr->n_invalid, valid = hdr->n_valid;
 
             if (hdr->index != (ptex + i)) {
                 hw_error("kvmppc_read_hptes: Unexpected HPTE index %"PRIu32
                          " != (%"HWADDR_PRIu" + %d", hdr->index, ptex, i);
             }
 
-            memcpy(hptes + i, hdr + 1, HASH_PTE_SIZE_64 * hdr->n_valid);
-            i += hdr->n_valid;
+            if (n - i < valid) {
+                valid = n - i;
+            }
+            memcpy(hptes + i, hdr + 1, HASH_PTE_SIZE_64 * valid);
+            i += valid;
 
             if ((n - i) < invalid) {
                 invalid = n - i;
             }
             memset(hptes + i, 0, invalid * HASH_PTE_SIZE_64);
-            i += hdr->n_invalid;
+            i += invalid;
 
             hdr = (struct kvm_get_htab_header *)
                 ((char *)(hdr + 1) + HASH_PTE_SIZE_64 * hdr->n_valid);
-- 
2.11.0
