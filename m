Received: from eggs.gnu.org ([209.51.188.92]:42679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to2-0000rU-AS
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to1-0001Fv-CI
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:17 +1100
Message-Id: <20190310082703.1245-15-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/60] target/ppc: Move handling of hardware
 breakpoints to a separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Fabiano Rosas <farosas@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Fabiano Rosas <farosas@linux.ibm.com>

This is in preparation for a refactoring of the kvm_handle_debug
function in the next patch.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
Message-Id: <20190228225759.21328-4-farosas@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index e0f0de0ce0..996b08a1d3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1597,35 +1597,44 @@ void kvm_arch_update_guest_debug(CPUState *cs, st=
ruct kvm_guest_debug *dbg)
     }
 }
=20
+static int kvm_handle_hw_breakpoint(CPUState *cs,
+                                    struct kvm_debug_exit_arch *arch_inf=
o)
+{
+    int handle =3D 0;
+    int n;
+    int flag =3D 0;
+
+    if (nb_hw_breakpoint + nb_hw_watchpoint > 0) {
+        if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
+            n =3D find_hw_breakpoint(arch_info->address, GDB_BREAKPOINT_=
HW);
+            if (n >=3D 0) {
+                handle =3D 1;
+            }
+        } else if (arch_info->status & (KVMPPC_DEBUG_WATCH_READ |
+                                        KVMPPC_DEBUG_WATCH_WRITE)) {
+            n =3D find_hw_watchpoint(arch_info->address,  &flag);
+            if (n >=3D 0) {
+                handle =3D 1;
+                cs->watchpoint_hit =3D &hw_watchpoint;
+                hw_watchpoint.vaddr =3D hw_debug_points[n].addr;
+                hw_watchpoint.flags =3D flag;
+            }
+        }
+    }
+    return handle;
+}
+
 static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
     struct kvm_debug_exit_arch *arch_info =3D &run->debug.arch;
     int handle =3D 0;
-    int n;
-    int flag =3D 0;
=20
     if (cs->singlestep_enabled) {
         handle =3D 1;
     } else if (arch_info->status) {
-        if (nb_hw_breakpoint + nb_hw_watchpoint > 0) {
-            if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
-                n =3D find_hw_breakpoint(arch_info->address, GDB_BREAKPO=
INT_HW);
-                if (n >=3D 0) {
-                    handle =3D 1;
-                }
-            } else if (arch_info->status & (KVMPPC_DEBUG_WATCH_READ |
-                                            KVMPPC_DEBUG_WATCH_WRITE)) {
-                n =3D find_hw_watchpoint(arch_info->address,  &flag);
-                if (n >=3D 0) {
-                    handle =3D 1;
-                    cs->watchpoint_hit =3D &hw_watchpoint;
-                    hw_watchpoint.vaddr =3D hw_debug_points[n].addr;
-                    hw_watchpoint.flags =3D flag;
-                }
-            }
-        }
+        handle =3D kvm_handle_hw_breakpoint(cs, arch_info);
     } else if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
         handle =3D 1;
     } else {
--=20
2.20.1
