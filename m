Received: from eggs.gnu.org ([209.51.188.92]:42734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to4-0000sJ-Ag
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to2-0001Hv-TP
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:18 +1100
Message-Id: <20190310082703.1245-16-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/60] target/ppc: Refactor kvm_handle_debug
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

There are four scenarios being handled in this function:

- single stepping
- hardware breakpoints
- software breakpoints
- fallback (no debug supported)

A future patch will add code to handle specific single step and
software breakpoints cases so let's split each scenario into its own
function now to avoid hurting readability.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20190228225759.21328-5-farosas@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 86 ++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 996b08a1d3..4e3f1e4b78 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1624,52 +1624,66 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
     return handle;
 }
=20
+static int kvm_handle_singlestep(void)
+{
+    return 1;
+}
+
+static int kvm_handle_sw_breakpoint(void)
+{
+    return 1;
+}
+
 static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
     struct kvm_debug_exit_arch *arch_info =3D &run->debug.arch;
-    int handle =3D 0;
=20
     if (cs->singlestep_enabled) {
-        handle =3D 1;
-    } else if (arch_info->status) {
-        handle =3D kvm_handle_hw_breakpoint(cs, arch_info);
-    } else if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
-        handle =3D 1;
-    } else {
-        /* QEMU is not able to handle debug exception, so inject
-         * program exception to guest;
-         * Yes program exception NOT debug exception !!
-         * When QEMU is using debug resources then debug exception must
-         * be always set. To achieve this we set MSR_DE and also set
-         * MSRP_DEP so guest cannot change MSR_DE.
-         * When emulating debug resource for guest we want guest
-         * to control MSR_DE (enable/disable debug interrupt on need).
-         * Supporting both configurations are NOT possible.
-         * So the result is that we cannot share debug resources
-         * between QEMU and Guest on BOOKE architecture.
-         * In the current design QEMU gets the priority over guest,
-         * this means that if QEMU is using debug resources then guest
-         * cannot use them;
-         * For software breakpoint QEMU uses a privileged instruction;
-         * So there cannot be any reason that we are here for guest
-         * set debug exception, only possibility is guest executed a
-         * privileged / illegal instruction and that's why we are
-         * injecting a program interrupt.
-         */
+        return kvm_handle_singlestep();
+    }
=20
-        cpu_synchronize_state(cs);
-        /* env->nip is PC, so increment this by 4 to use
-         * ppc_cpu_do_interrupt(), which set srr0 =3D env->nip - 4.
-         */
-        env->nip +=3D 4;
-        cs->exception_index =3D POWERPC_EXCP_PROGRAM;
-        env->error_code =3D POWERPC_EXCP_INVAL;
-        ppc_cpu_do_interrupt(cs);
+    if (arch_info->status) {
+        return kvm_handle_hw_breakpoint(cs, arch_info);
     }
=20
-    return handle;
+    if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
+        return kvm_handle_sw_breakpoint();
+    }
+
+    /*
+     * QEMU is not able to handle debug exception, so inject
+     * program exception to guest;
+     * Yes program exception NOT debug exception !!
+     * When QEMU is using debug resources then debug exception must
+     * be always set. To achieve this we set MSR_DE and also set
+     * MSRP_DEP so guest cannot change MSR_DE.
+     * When emulating debug resource for guest we want guest
+     * to control MSR_DE (enable/disable debug interrupt on need).
+     * Supporting both configurations are NOT possible.
+     * So the result is that we cannot share debug resources
+     * between QEMU and Guest on BOOKE architecture.
+     * In the current design QEMU gets the priority over guest,
+     * this means that if QEMU is using debug resources then guest
+     * cannot use them;
+     * For software breakpoint QEMU uses a privileged instruction;
+     * So there cannot be any reason that we are here for guest
+     * set debug exception, only possibility is guest executed a
+     * privileged / illegal instruction and that's why we are
+     * injecting a program interrupt.
+     */
+    cpu_synchronize_state(cs);
+    /*
+     * env->nip is PC, so increment this by 4 to use
+     * ppc_cpu_do_interrupt(), which set srr0 =3D env->nip - 4.
+     */
+    env->nip +=3D 4;
+    cs->exception_index =3D POWERPC_EXCP_PROGRAM;
+    env->error_code =3D POWERPC_EXCP_INVAL;
+    ppc_cpu_do_interrupt(cs);
+
+    return 0;
 }
=20
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
--=20
2.20.1
