Received: from eggs.gnu.org ([2001:4830:134:3::10]:38568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdnb-0000iX-9e
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdnZ-000445-Jy
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:07 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  2 Mar 2018 17:03:44 +1100
Message-Id: <20180302060350.24330-19-david@gibson.dropbear.id.au>
In-Reply-To: <20180302060350.24330-1-david@gibson.dropbear.id.au>
References: <20180302060350.24330-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/24] target/ppc: Check mask when setting
 cap_ppc_safe_indirect_branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, surajjs@au1.ibm.com, mark.cave-ayland@ilande.co.uk, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Check the character and character_mask field when setting
cap_ppc_safe_indirect_branch based on the hypervisor response
to KVM_PPC_GET_CPU_CHAR. Previously the mask field wasn't checked
which was incorrect.

Fixes: 8acc2ae5 (target/ppc/kvm: Add cap_ppc_safe_[cache/bounds_check/indirect_branch])

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9842b3bb12..2c183f61e2 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2494,7 +2494,7 @@ static void kvmppc_get_cpu_characteristics(KVMState *s)
         cap_ppc_safe_bounds_check = 1;
     }
     /* Parse and set cap_ppc_safe_indirect_branch */
-    if (c.character & H_CPU_CHAR_BCCTRL_SERIALISED) {
+    if (c.character & c.character_mask & H_CPU_CHAR_BCCTRL_SERIALISED) {
         cap_ppc_safe_indirect_branch = 2;
     }
 }
-- 
2.14.3
