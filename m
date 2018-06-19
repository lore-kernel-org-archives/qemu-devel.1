Received: from eggs.gnu.org ([2001:4830:134:3::10]:45042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hB-0000iS-Hq
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hA-0007xg-J8
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:33 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:40 -0500
Message-Id: <20180619014319.28272-15-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 014/113] spapr: fix missing CPU core nodes in
 DT when running with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Commit 5d0fb1508e2d "spapr: consolidate the VCPU id numbering logic
in a single place" introduced a helper to detect thread0 of a virtual
core based on its VCPU id. This is used to create CPU core nodes in
the DT, but it is broken in TCG.

$ qemu-system-ppc64 -nographic -accel tcg -machine dumpdtb=dtb.bin \
                    -smp cores=16,maxcpus=16,threads=1
$ dtc -f -O dts dtb.bin | grep POWER8
                PowerPC,POWER8@0 {
                PowerPC,POWER8@8 {

instead of the expected 16 cores that we get with KVM:

$ dtc -f -O dts dtb.bin | grep POWER8
                PowerPC,POWER8@0 {
                PowerPC,POWER8@8 {
                PowerPC,POWER8@10 {
                PowerPC,POWER8@18 {
                PowerPC,POWER8@20 {
                PowerPC,POWER8@28 {
                PowerPC,POWER8@30 {
                PowerPC,POWER8@38 {
                PowerPC,POWER8@40 {
                PowerPC,POWER8@48 {
                PowerPC,POWER8@50 {
                PowerPC,POWER8@58 {
                PowerPC,POWER8@60 {
                PowerPC,POWER8@68 {
                PowerPC,POWER8@70 {
                PowerPC,POWER8@78 {

This happens because spapr_get_vcpu_id() maps VCPU ids to
cs->cpu_index in TCG mode. This confuses the code in
spapr_is_thread0_in_vcore(), since it assumes thread0 VCPU
ids to have a spapr->vsmt spacing.

    spapr_get_vcpu_id(cpu) % spapr->vsmt == 0

Actually, there's no real reason to expose cs->cpu_index instead
of the VCPU id, since we also generate it with TCG. Also we already
set it explicitly in spapr_set_vcpu_id(), so there's no real reason
either to call kvm_arch_vcpu_id() with KVM.

This patch unifies spapr_get_vcpu_id() to always return the computed
VCPU id both in TCG and KVM. This is one step forward towards KVM<->TCG
migration.

Fixes: 5d0fb1508e2d
Reported-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit b1a568c1c2192f090536b8ac76d135ce1f46a0ee)
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a36494b87b..d53123c127 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3655,13 +3655,7 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj,
 
 int spapr_get_vcpu_id(PowerPCCPU *cpu)
 {
-    CPUState *cs = CPU(cpu);
-
-    if (kvm_enabled()) {
-        return kvm_arch_vcpu_id(cs);
-    } else {
-        return cs->cpu_index;
-    }
+    return cpu->vcpu_id;
 }
 
 void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp)
-- 
2.11.0
