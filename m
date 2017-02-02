Received: from eggs.gnu.org ([2001:4830:134:3::10]:52998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kN-00085g-PV
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kF-0004PR-Mc
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:51 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:43 +1100
Message-Id: <20170202051445.5735-106-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 105/107] target/ppc/mmu_hash64: Fix incorrect
 shift value in amr calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

We are calculating the authority mask register key value wrong.

The pte entry contains the key value with the two upper bits and the three
lower bits stored separately. We should use these two portions to get a 5
bit value, not or them together which will only give us a 3 bit value.

Fix this.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index ab5d347..7a0b7fc 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -85,7 +85,7 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
 #define HPTE64_R_C              0x0000000000000080ULL
 #define HPTE64_R_R              0x0000000000000100ULL
 #define HPTE64_R_KEY_LO         0x0000000000000e00ULL
-#define HPTE64_R_KEY(x)         ((((x) & HPTE64_R_KEY_HI) >> 60) | \
+#define HPTE64_R_KEY(x)         ((((x) & HPTE64_R_KEY_HI) >> 57) | \
                                  (((x) & HPTE64_R_KEY_LO) >> 9))
 
 #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
-- 
2.9.3
