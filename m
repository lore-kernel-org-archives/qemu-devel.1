Received: from eggs.gnu.org ([209.51.188.92]:42513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tns-0000hR-MV
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnr-00018V-25
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:16 +1100
Message-Id: <20190310082703.1245-14-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/60] target/ppc: Move exception vector offset
 computation into a function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Fabiano Rosas <farosas@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Fabiano Rosas <farosas@linux.ibm.com>

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20190228225759.21328-2-farosas@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 39bedbb11d..beafcf1ebd 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -107,6 +107,24 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPC=
State *env, int excp,
     return POWERPC_EXCP_RESET;
 }
=20
+static uint64_t ppc_excp_vector_offset(CPUState *cs, int ail)
+{
+    uint64_t offset =3D 0;
+
+    switch (ail) {
+    case AIL_0001_8000:
+        offset =3D 0x18000;
+        break;
+    case AIL_C000_0000_0000_4000:
+        offset =3D 0xc000000000004000ull;
+        break;
+    default:
+        cpu_abort(cs, "Invalid AIL combination %d\n", ail);
+        break;
+    }
+
+    return offset;
+}
=20
 /* Note that this function should be greatly optimized
  * when called with a constant excp, from ppc_hw_interrupt
@@ -708,17 +726,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
     /* Handle AIL */
     if (ail) {
         new_msr |=3D (1 << MSR_IR) | (1 << MSR_DR);
-        switch(ail) {
-        case AIL_0001_8000:
-            vector |=3D 0x18000;
-            break;
-        case AIL_C000_0000_0000_4000:
-            vector |=3D 0xc000000000004000ull;
-            break;
-        default:
-            cpu_abort(cs, "Invalid AIL combination %d\n", ail);
-            break;
-        }
+        vector |=3D ppc_excp_vector_offset(cs, ail);
     }
=20
 #if defined(TARGET_PPC64)
--=20
2.20.1
