Received: from eggs.gnu.org ([2001:4830:134:3::10]:45478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQG-0007pF-8O
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQF-0001GS-4e
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:52 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jan 2018 13:25:04 +1100
Message-Id: <20180117022525.31767-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180117022525.31767-1-david@gibson.dropbear.id.au>
References: <20180117022525.31767-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/22] target/ppc: Yet another fix for KVM-HV
 HPTE accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, lvivier@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

As stated in the 1ad9f0a464fe commit log, the returned entries are not
a whole PTEG. It was not a problem before 1ad9f0a464fe as it would read
a single record assuming it contains a whole PTEG but now the code tries
reading the entire PTEG and "if ((n - i) < invalid)" produces negative
values which then are converted to size_t for memset() and that throws
seg fault.

This fixes the math.

While here, fix the last @i increment as well.

Fixes: 1ad9f0a464fe "target/ppc: Fix KVM-HV HPTE accessors"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 4664a3ce9d..09fcb082d2 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2667,21 +2667,24 @@ void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, hwaddr ptex, int n)
 
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
2.14.3
