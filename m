Received: from eggs.gnu.org ([2001:4830:134:3::10]:53835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dhJUa-0003rz-Fu
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 13:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dhJUX-0006mo-C5
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 13:49:32 -0400
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:36255)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dhJUX-0006lk-6S
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 13:49:29 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9A85511A889
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 19:49:27 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 14 Aug 2017 19:49:16 +0200
Message-ID: <150273295665.11087.17582111045419718285.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] ppc: fix ppc_set_compat() with KVM PR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

When running in KVM PR mode, kvmppc_set_compat() always fail because the
current PR implementation doesn't handle KVM_REG_PPC_ARCH_COMPAT. Now that
the machine code inconditionally calls ppc_set_compat_all() at reset time
to restore the compat mode default value (commit 66d5c492dd3a9), it is
impossible to start a guest with PR:

qemu-system-ppc64: Unable to set CPU compatibility mode in KVM:
 Invalid argument

A tentative patch [1] was recently sent by Suraj to address the issue, but
it would prevent the compat mode to be turned off on reset. And we really
don't want to explicitely check for KVM PR. During the patch's review,
David suggested that we should only call the KVM ioctl() if the compat
PVR changes. This allows at least to run with KVM PR, provided no compat
mode is requested from the command line (which should be the case when
running PR nested). This is what this patch does.

While here, we also fix the side effect where KVM would fail but we would
change the CPU state in QEMU anyway.

[1] http://patchwork.ozlabs.org/patch/782039/

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/compat.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index f1b67faa97e3..f8729fe46d61 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -140,16 +140,17 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
 
     cpu_synchronize_state(CPU(cpu));
 
-    cpu->compat_pvr = compat_pvr;
-    env->spr[SPR_PCR] = pcr & pcc->pcr_mask;
-
-    if (kvm_enabled()) {
+    if (kvm_enabled() && cpu->compat_pvr != compat_pvr) {
         int ret = kvmppc_set_compat(cpu, cpu->compat_pvr);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
                              "Unable to set CPU compatibility mode in KVM");
+            return;
         }
     }
+
+    cpu->compat_pvr = compat_pvr;
+    env->spr[SPR_PCR] = pcr & pcc->pcr_mask;
 }
 
 typedef struct {
