Received: from eggs.gnu.org ([2001:4830:134:3::10]:47103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dozD2-0003jn-8T
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dozCx-0002u5-LE
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:08 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:38929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dozCx-0002t7-Ep
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:03 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id F3D394AE24
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 23:46:59 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 04 Sep 2017 23:46:55 +0200
Message-ID: <150456161545.17000.9223127644314285105.stgit@bahia.lan>
In-Reply-To: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
References: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/4] spapr: only update SDR1 once per-cpu
 during CAS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Thomas Huth <thuth@redhat.com>

Commit b55d295e3ec9 added the possibility to support HPT resizing with KVM.
In the case of PR, we need to pass the userspace address of the HPT to KVM
using the SDR1 slot.
This is handled by kvmppc_update_sdr1() which uses CPU_FOREACH() to update
all CPUs. It is hence not needed to call kvmppc_update_sdr1() for each CPU.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_hcall.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8b3c0e17e75c..6ab8c188f381 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1559,20 +1559,16 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         }
 
         if (spapr->htab_shift < maxshift) {
-            CPUState *cs;
-
             /* Guest doesn't know about HPT resizing, so we
              * pre-emptively resize for the maximum permitted RAM.  At
              * the point this is called, nothing should have been
              * entered into the existing HPT */
             spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
-            CPU_FOREACH(cs) {
-                if (kvm_enabled()) {
-                    /* For KVM PR, update the HPT pointer */
-                    target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
-                        | (spapr->htab_shift - 18);
-                    kvmppc_update_sdr1(sdr1);
-                }
+            if (kvm_enabled()) {
+                /* For KVM PR, update the HPT pointer */
+                target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
+                    | (spapr->htab_shift - 18);
+                kvmppc_update_sdr1(sdr1);
             }
         }
     }
