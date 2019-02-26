Received: from eggs.gnu.org ([209.51.188.92]:57408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkE-0004Sq-4t
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUjz-0000fh-8N
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:19 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:18 +1100
Message-Id: <20190226045304.25618-5-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/50] target/ppc: Move "wakeup reset" code to a
 separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This moves the code to handle waking up from the 0x100 vector
from powerpc_excp() to a separate function, as the former is
already way too big as it is.

No functional change.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215161648.9600-5-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c | 75 ++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 97503193ef..489a54f51b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -65,6 +65,46 @@ static inline void dump_syscall(CPUPPCState *env)
                   ppc_dump_gpr(env, 6), env->nip);
 }
=20
+static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp=
,
+                                target_ulong *msr)
+{
+    /* We no longer are in a PM state */
+    env->in_pm_state =3D false;
+
+    /* Pretend to be returning from doze always as we don't lose state *=
/
+    *msr |=3D (0x1ull << (63 - 47));
+
+    /* Machine checks are sent normally */
+    if (excp =3D=3D POWERPC_EXCP_MCHECK) {
+        return excp;
+    }
+    switch (excp) {
+    case POWERPC_EXCP_RESET:
+        *msr |=3D 0x4ull << (63 - 45);
+        break;
+    case POWERPC_EXCP_EXTERNAL:
+        *msr |=3D 0x8ull << (63 - 45);
+        break;
+    case POWERPC_EXCP_DECR:
+        *msr |=3D 0x6ull << (63 - 45);
+        break;
+    case POWERPC_EXCP_SDOOR:
+        *msr |=3D 0x5ull << (63 - 45);
+        break;
+    case POWERPC_EXCP_SDOOR_HV:
+        *msr |=3D 0x3ull << (63 - 45);
+        break;
+    case POWERPC_EXCP_HV_MAINT:
+        *msr |=3D 0xaull << (63 - 45);
+        break;
+    default:
+        cpu_abort(cs, "Unsupported exception %d in Power Save mode\n",
+                  excp);
+    }
+    return POWERPC_EXCP_RESET;
+}
+
+
 /* Note that this function should be greatly optimized
  * when called with a constant excp, from ppc_hw_interrupt
  */
@@ -102,40 +142,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
      * P7/P8/P9
      */
     if (env->in_pm_state) {
-        env->in_pm_state =3D false;
-
-        /* Pretend to be returning from doze always as we don't lose sta=
te */
-        msr |=3D (0x1ull << (63 - 47));
-
-        /* Non-machine check are routed to 0x100 with a wakeup cause
-         * encoded in SRR1
-         */
-        if (excp !=3D POWERPC_EXCP_MCHECK) {
-            switch (excp) {
-            case POWERPC_EXCP_RESET:
-                msr |=3D 0x4ull << (63 - 45);
-                break;
-            case POWERPC_EXCP_EXTERNAL:
-                msr |=3D 0x8ull << (63 - 45);
-                break;
-            case POWERPC_EXCP_DECR:
-                msr |=3D 0x6ull << (63 - 45);
-                break;
-            case POWERPC_EXCP_SDOOR:
-                msr |=3D 0x5ull << (63 - 45);
-                break;
-            case POWERPC_EXCP_SDOOR_HV:
-                msr |=3D 0x3ull << (63 - 45);
-                break;
-            case POWERPC_EXCP_HV_MAINT:
-                msr |=3D 0xaull << (63 - 45);
-                break;
-            default:
-                cpu_abort(cs, "Unsupported exception %d in Power Save mo=
de\n",
-                          excp);
-            }
-            excp =3D POWERPC_EXCP_RESET;
-        }
+        excp =3D powerpc_reset_wakeup(cs, env, excp, &msr);
     }
=20
     /* Exception targetting modifiers
--=20
2.20.1
