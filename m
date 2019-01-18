Received: from eggs.gnu.org ([209.51.188.92]:57536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUou-0007Ed-R2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUor-0002l7-48
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47298
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gkUoq-0002jx-Vu
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:25 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0IDwjvA034589
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:24 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q3e5k5b9q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:24 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Fri, 18 Jan 2019 14:08:23 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Fri, 18 Jan 2019 12:07:56 -0200
In-Reply-To: <20190118140758.829-1-farosas@linux.ibm.com>
References: <20190118140758.829-1-farosas@linux.ibm.com>
Message-Id: <20190118140758.829-6-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v3 5/7] target/ppc: Move handling of
 hardware breakpoints to a separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, david@gibson.dropbear.id.au, cohuck@redhat.com, aik@ozlabs.ru

This is in preparation for a refactoring of the kvm_handle_debug
function in the next patch.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/kvm.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index ebbb48c42f..96a5895792 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1594,35 +1594,44 @@ void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
     }
 }
 
+static int kvm_handle_hw_breakpoint(CPUState *cs,
+                                    struct kvm_debug_exit_arch *arch_info)
+{
+    int handle = 0;
+    int n;
+    int flag = 0;
+
+    if (nb_hw_breakpoint + nb_hw_watchpoint > 0) {
+        if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
+            n = find_hw_breakpoint(arch_info->address, GDB_BREAKPOINT_HW);
+            if (n >= 0) {
+                handle = 1;
+            }
+        } else if (arch_info->status & (KVMPPC_DEBUG_WATCH_READ |
+                                        KVMPPC_DEBUG_WATCH_WRITE)) {
+            n = find_hw_watchpoint(arch_info->address,  &flag);
+            if (n >= 0) {
+                handle = 1;
+                cs->watchpoint_hit = &hw_watchpoint;
+                hw_watchpoint.vaddr = hw_debug_points[n].addr;
+                hw_watchpoint.flags = flag;
+            }
+        }
+    }
+    return handle;
+}
+
 static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     struct kvm_debug_exit_arch *arch_info = &run->debug.arch;
     int handle = 0;
-    int n;
-    int flag = 0;
 
     if (cs->singlestep_enabled) {
         handle = 1;
     } else if (arch_info->status) {
-        if (nb_hw_breakpoint + nb_hw_watchpoint > 0) {
-            if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
-                n = find_hw_breakpoint(arch_info->address, GDB_BREAKPOINT_HW);
-                if (n >= 0) {
-                    handle = 1;
-                }
-            } else if (arch_info->status & (KVMPPC_DEBUG_WATCH_READ |
-                                            KVMPPC_DEBUG_WATCH_WRITE)) {
-                n = find_hw_watchpoint(arch_info->address,  &flag);
-                if (n >= 0) {
-                    handle = 1;
-                    cs->watchpoint_hit = &hw_watchpoint;
-                    hw_watchpoint.vaddr = hw_debug_points[n].addr;
-                    hw_watchpoint.flags = flag;
-                }
-            }
-        }
+        handle = kvm_handle_hw_breakpoint(cs, arch_info);
     } else if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
         handle = 1;
     } else {
-- 
2.17.1
