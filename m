Received: from eggs.gnu.org ([2001:4830:134:3::10]:36022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1emlD9-0001vi-Gb
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 13:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1emlD4-0006xS-Kd
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 13:58:19 -0500
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:38406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1emlD4-0006wp-EM
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 13:58:14 -0500
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 0626B14F3D6
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 19:58:11 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 16 Feb 2018 19:58:06 +0100
Message-ID: <151880748615.9544.1095813823117296064.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spapr: fix missing CPU core nodes in DT when
 running with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

Commit 5d0fb1508e2d "spapr: consolidate the VCPU id numbering logic
in a single place" introduced a helper to detect thread0 of a virtual
core based on its VCPU id. This is used to create CPU core nodes in
the DT, but it is broken in TCG.

$ qemu-system-ppc64 -nographic -accel tcg -machine dumpdtb=3Ddtb.bin \
                    -smp cores=3D16,maxcpus=3D16,threads=3D1
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

    spapr_get_vcpu_id(cpu) % spapr->vsmt =3D=3D 0

Actually, there's no real reason to expose cs->cpu_index instead
of the VCPU id, since we also generate it with TCG. Also we already
set it explicitly in spapr_set_vcpu_id(), so there's no real reason
either to call kvm_arch_vcpu_id() with KVM.

This patch unifies spapr_get_vcpu_id() to always return the computed
VCPU id both in TCG and KVM. This is one step forward towards KVM<->TCG
migration.

Fixes: 5d0fb1508e2d
Reported-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 83c9d66dd56f..d6fd0e666e74 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3810,13 +3810,7 @@ static void spapr_pic_print_info(InterruptStatsPro=
vider *obj,
=20
 int spapr_get_vcpu_id(PowerPCCPU *cpu)
 {
-    CPUState *cs =3D CPU(cpu);
-
-    if (kvm_enabled()) {
-        return kvm_arch_vcpu_id(cs);
-    } else {
-        return cs->cpu_index;
-    }
+    return cpu->vcpu_id;
 }
=20
 void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp)
