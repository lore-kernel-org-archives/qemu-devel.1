Received: from eggs.gnu.org ([2001:4830:134:3::10]:51940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fESFc-0006UV-HI
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fESFZ-0008Dc-Bs
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:23:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59536
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fESFZ-0008By-6v
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:23:17 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w444K03v031315
	for <qemu-devel@nongnu.org>; Fri, 4 May 2018 00:23:15 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hr894reyn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 00:23:14 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 4 May 2018 00:23:14 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu,  3 May 2018 23:20:44 -0500
Message-Id: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] target/ppc: only save guest timebase once
 after stopping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org

In some cases (e.g. spapr) we record guest timebase after qmp_stop()
via a runstate hook so we can restore it on qmp_cont(). If a migration
occurs in between those events we end up saving it again, this time
based on the current timebase the guest would be seeing had it been
running. This has the effect of advancing the guest timebase while
it is stopped, which is not what the code intends.

Other than simple jumps in time, this has been seen to trigger what
appear to be RCU-related crashes in recent kernels when the advance
exceeds rcu_cpu_stall_timeout, and it can be triggered by fairly
common operations such as `virsh migrate ... --timeout 60`.

Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-ppc@nongnu.org
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/ppc.c         | 12 ++++++++++++
 target/ppc/cpu-qom.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index ec4be25f49..ff0a107864 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -865,6 +865,15 @@ static void timebase_save(PPCTimebase *tb)
     uint64_t ticks = cpu_get_host_ticks();
     PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
 
+    /* since we generally save timebase just after the guest
+     * has stopped, avoid trying to save it again since we will
+     * end up advancing it by the amount of ticks that have
+     * elapsed in the host since the initial save
+     */
+    if (tb->saved) {
+        return;
+    }
+
     if (!first_ppc_cpu->env.tb_env) {
         error_report("No timebase object");
         return;
@@ -877,6 +886,7 @@ static void timebase_save(PPCTimebase *tb)
      * there is no need to update it from KVM here
      */
     tb->guest_timebase = ticks + first_ppc_cpu->env.tb_env->tb_offset;
+    tb->saved = true;
 }
 
 static void timebase_load(PPCTimebase *tb)
@@ -908,6 +918,8 @@ static void timebase_load(PPCTimebase *tb)
                         &pcpu->env.tb_env->tb_offset);
 #endif
     }
+
+    tb->saved = false;
 }
 
 void cpu_ppc_clock_vm_state_change(void *opaque, int running,
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index deaa46a14b..ec2dbcdcae 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -210,6 +210,7 @@ typedef struct PowerPCCPUClass {
 typedef struct PPCTimebase {
     uint64_t guest_timebase;
     int64_t time_of_the_day_ns;
+    bool saved;
 } PPCTimebase;
 
 extern const struct VMStateDescription vmstate_ppc_timebase;
-- 
2.11.0
