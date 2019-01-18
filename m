Received: from eggs.gnu.org ([209.51.188.92]:57489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUol-00077t-BX
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUok-0002Zw-4G
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51668
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gkUoj-0002Xp-VR
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:18 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0IDwvXk058816
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:16 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q3e5kwgf9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:14 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Fri, 18 Jan 2019 14:08:12 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Fri, 18 Jan 2019 12:07:53 -0200
In-Reply-To: <20190118140758.829-1-farosas@linux.ibm.com>
References: <20190118140758.829-1-farosas@linux.ibm.com>
Message-Id: <20190118140758.829-3-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v3 2/7] target/ppc: Add
 ppc_get_trace_int_handler_addr
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

The upcoming single step functionality (KVM HV) needs to write to the
Trace Interrupt handler's address for its mechanism to work. The
address is calculated by applying an offset according to the value of
the Alternate Interrupt Location (AIL) bits in the LPCR register.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/cpu.h         |  1 +
 target/ppc/excp_helper.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 486abaf99b..2185ef5e67 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1256,6 +1256,7 @@ struct PPCVirtualHypervisorClass {
     OBJECT_GET_CLASS(PPCVirtualHypervisorClass, (obj), \
                      TYPE_PPC_VIRTUAL_HYPERVISOR)
 
+target_ulong ppc_get_trace_int_handler_addr(CPUState *cs);
 void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 337a3ef8bb..5d13d05c3b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -746,6 +746,18 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     check_tlb_flush(env, false);
 }
 
+target_ulong ppc_get_trace_int_handler_addr(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    int ail;
+
+    ail = (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
+    return env->excp_vectors[POWERPC_EXCP_TRACE] |
+        ppc_excp_vector_offset(cs, ail);
+}
+
+
 void ppc_cpu_do_interrupt(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-- 
2.17.1
