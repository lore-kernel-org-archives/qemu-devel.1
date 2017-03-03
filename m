Received: from eggs.gnu.org ([2001:4830:134:3::10]:44123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqR-000833-A6
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqQ-0001HZ-Bd
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:27 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:24:51 +1100
Message-Id: <20170303032507.16142-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/17] target/ppc: Add POWER9/ISAv3.00 to
 compat_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

compat_table contains the list of logical pvr compat modes which a cpu can
operate in. It is a list of struct CompatInfo which contains the given pvr
value for a compat mode, the pcr bits which should be set to operate in
that compat mode, the pcr level which must be present in pcr_supported for
a processor to support that compat mode and the max threads possible in
that compat mode.

Add an entry for the POWER9/ISAv3.00 logical pvr which represents a
processor running with support for logical pvr 0x0f000005. A processor
running in this mode should have PCR_COMPAT_3_00 set in the pcr (if
available in pcr_mask) and should have PCR_COMPAT_3_00 in pcr_supported
to indicate that it is capable of running in this compat mode.

Also add PCR_COMPAT_3_00 to the bits which must be set for all previous
compat modes. Since no processor models contain this bit yet in pcr_mask
it will never be set, but this ensures we don't forget to in the future.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/compat.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 458da26..e8ec1e1 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -39,29 +39,35 @@ static const CompatInfo compat_table[] = {
      */
     { /* POWER6, ISA2.05 */
         .pvr = CPU_POWERPC_LOGICAL_2_05,
-        .pcr = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05
-               | PCR_TM_DIS | PCR_VSX_DIS,
+        .pcr = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
+               PCR_COMPAT_2_05 | PCR_TM_DIS | PCR_VSX_DIS,
         .pcr_level = PCR_COMPAT_2_05,
         .max_threads = 2,
     },
     { /* POWER7, ISA2.06 */
         .pvr = CPU_POWERPC_LOGICAL_2_06,
-        .pcr = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
+        .pcr = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
         .pcr_level = PCR_COMPAT_2_06,
         .max_threads = 4,
     },
     {
         .pvr = CPU_POWERPC_LOGICAL_2_06_PLUS,
-        .pcr = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
+        .pcr = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
         .pcr_level = PCR_COMPAT_2_06,
         .max_threads = 4,
     },
     { /* POWER8, ISA2.07 */
         .pvr = CPU_POWERPC_LOGICAL_2_07,
-        .pcr = PCR_COMPAT_2_07,
+        .pcr = PCR_COMPAT_3_00 | PCR_COMPAT_2_07,
         .pcr_level = PCR_COMPAT_2_07,
         .max_threads = 8,
     },
+    { /* POWER9, ISA3.00 */
+        .pvr = CPU_POWERPC_LOGICAL_3_00,
+        .pcr = PCR_COMPAT_3_00,
+        .pcr_level = PCR_COMPAT_3_00,
+        .max_threads = 4,
+    },
 };
 
 static const CompatInfo *compat_by_pvr(uint32_t pvr)
-- 
2.9.3
