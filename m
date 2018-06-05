Received: from eggs.gnu.org ([2001:4830:134:3::10]:46109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQD6m-0003Oq-T3
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQD6j-0004sI-KN
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:38:48 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:46762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQD6j-0004rY-Dx
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:38:45 -0400
Received: from player787.ha.ovh.net (unknown [10.109.105.119])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 96890CC09F
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 16:38:43 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 05 Jun 2018 16:38:30 +0200
Message-ID: <152820951004.885713.15116723374602433120.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3] target/ppc: migrate VPA related state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

QEMU implements the "Shared Processor LPAR" (SPLPAR) option, which allows
the hypervisor to time-slice a physical processor into multiple virtual
processor. The intent is to allow more guests to run, and to optimize
processor utilization.

The guest OS can cede idle VCPUs, so that their processing capacity may
be used by other VCPUs, with the H_CEDE hcall. The guest OS can also
optimize spinlocks, by confering the time-slice of a spinning VCPU to the
spinlock holder if it's currently notrunning, with the H_CONFER hcall.

Both hcalls depend on a "Virtual Processor Area" (VPA) to be registered
by the guest OS, generally during early boot. Other per-VCPU areas can
be registered: the "SLB Shadow Buffer" which allows a more efficient
dispatching of VCPUs, and the "Dispatch Trace Log Buffer" (DTL) which
is used to compute time stolen by the hypervisor. Both DTL and SLB Shadow
areas depend on the VPA to be registered.

The VPA/SLB Shadow/DTL are state that QEMU should migrate, but this doesn't
happen, for no apparent reason other than it was just never coded. This
causes the features listed above to stop working after migration, and it
breaks the logic of the H_REGISTER_VPA hcall in the destination.

This patch fixes it for newer machine types (ie, version > 2.12) by adding
a "cpu/vpa" subsection to the CPU migration stream. It ensures backward
migration to existing QEMU versions.

Since DTL and SLB Shadow are optional and both depend on VPA, they get
their own subsections "cpu/vpa/slb_shadow" and "cpu/vpa/dtl" hanging from
the "cpu/vpa" subsection.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v3: - switched to pre_3_0_migration

v2: - added missing TARGET_PP64 ifdefs (patchew)
---
 target/ppc/machine.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index b2745ec4e519..d439f5cd4961 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -677,6 +677,67 @@ static const VMStateDescription vmstate_compat = {
     }
 };
 
+static bool slb_shadow_needed(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    return cpu->env.slb_shadow_addr != 0;
+}
+
+static const VMStateDescription vmstate_slb_shadow = {
+    .name = "cpu/vpa/slb_shadow",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = slb_shadow_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.slb_shadow_addr, PowerPCCPU),
+        VMSTATE_UINT64(env.slb_shadow_size, PowerPCCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool dtl_needed(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    return cpu->env.dtl_addr != 0;
+}
+
+static const VMStateDescription vmstate_dtl = {
+    .name = "cpu/vpa/dtl",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = dtl_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.dtl_addr, PowerPCCPU),
+        VMSTATE_UINT64(env.dtl_size, PowerPCCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool vpa_needed(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    return !cpu->pre_3_0_migration && cpu->env.vpa_addr != 0;
+}
+
+static const VMStateDescription vmstate_vpa = {
+    .name = "cpu/vpa",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vpa_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.vpa_addr, PowerPCCPU),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_slb_shadow,
+        &vmstate_dtl,
+        NULL
+    }
+};
+
 const VMStateDescription vmstate_ppc_cpu = {
     .name = "cpu",
     .version_id = 5,
@@ -731,6 +792,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         &vmstate_tlbemb,
         &vmstate_tlbmas,
         &vmstate_compat,
+        &vmstate_vpa,
         NULL
     }
 };
