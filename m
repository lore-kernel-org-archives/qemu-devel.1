Received: from eggs.gnu.org ([2001:4830:134:3::10]:46184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7g-0007uA-FJ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7d-0008RY-Bp
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:20 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:17 +1100
Message-Id: <20170301044405.1792-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/50] target/ppc: optimize gen_write_xer()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3ba2616..b09e16f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3724,12 +3724,9 @@ static void gen_write_xer(TCGv src)
 {
     tcg_gen_andi_tl(cpu_xer, src,
                     ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA)));
-    tcg_gen_shri_tl(cpu_so, src, XER_SO);
-    tcg_gen_shri_tl(cpu_ov, src, XER_OV);
-    tcg_gen_shri_tl(cpu_ca, src, XER_CA);
-    tcg_gen_andi_tl(cpu_so, cpu_so, 1);
-    tcg_gen_andi_tl(cpu_ov, cpu_ov, 1);
-    tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
+    tcg_gen_extract_tl(cpu_so, src, XER_SO, 1);
+    tcg_gen_extract_tl(cpu_ov, src, XER_OV, 1);
+    tcg_gen_extract_tl(cpu_ca, src, XER_CA, 1);
 }
 
 /* mcrxr */
-- 
2.9.3
