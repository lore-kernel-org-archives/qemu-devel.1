Received: from eggs.gnu.org ([209.51.188.92]:57596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUoz-0007JU-IJ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUoy-0002uG-JH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57196
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gkUox-0002oC-Sb
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:32 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0IDxoT2080913
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:27 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q3efncga2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:27 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Fri, 18 Jan 2019 14:08:26 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Fri, 18 Jan 2019 12:07:57 -0200
In-Reply-To: <20190118140758.829-1-farosas@linux.ibm.com>
References: <20190118140758.829-1-farosas@linux.ibm.com>
Message-Id: <20190118140758.829-7-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v3 6/7] target/ppc: Refactor
 kvm_handle_debug
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

There are four scenarios being handled in this function:

- single stepping
- hardware breakpoints
- software breakpoints
- fallback (no debug supported)

A future patch will add code to handle specific single step and
software breakpoints cases so let's split each scenario into its own
function now to avoid hurting readability.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/kvm.c | 86 ++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 96a5895792..c27190d7fb 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1621,52 +1621,66 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
     return handle;
 }
 
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
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     struct kvm_debug_exit_arch *arch_info = &run->debug.arch;
-    int handle = 0;
 
     if (cs->singlestep_enabled) {
-        handle = 1;
-    } else if (arch_info->status) {
-        handle = kvm_handle_hw_breakpoint(cs, arch_info);
-    } else if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
-        handle = 1;
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
+
+    if (arch_info->status) {
+        return kvm_handle_hw_breakpoint(cs, arch_info);
+    }
 
-        cpu_synchronize_state(cs);
-        /* env->nip is PC, so increment this by 4 to use
-         * ppc_cpu_do_interrupt(), which set srr0 = env->nip - 4.
-         */
-        env->nip += 4;
-        cs->exception_index = POWERPC_EXCP_PROGRAM;
-        env->error_code = POWERPC_EXCP_INVAL;
-        ppc_cpu_do_interrupt(cs);
+    if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
+        return kvm_handle_sw_breakpoint();
     }
 
-    return handle;
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
+     * ppc_cpu_do_interrupt(), which set srr0 = env->nip - 4.
+     */
+    env->nip += 4;
+    cs->exception_index = POWERPC_EXCP_PROGRAM;
+    env->error_code = POWERPC_EXCP_INVAL;
+    ppc_cpu_do_interrupt(cs);
+
+    return 0;
 }
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
-- 
2.17.1
