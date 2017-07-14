Received: from eggs.gnu.org ([2001:4830:134:3::10]:49768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dW3Eh-0006fs-Jh
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dW3Ed-0004Ah-NY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:14:35 -0400
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:34869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dW3Ed-00048O-Hn
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:14:31 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 29E4E85B4F
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 18:14:22 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 14 Jul 2017 18:13:58 +0200
Message-Id: <1500048838-16802-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] target/ppc: fix CPU hotplug when radix is
 enabled (TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

But when a guest initializes radix mode, it issues a H_REGISTER_PROC_TBL
to update the LPCR of all CPUs. Hot-plugged CPUs inherit from the same
setting under KVM but not under TCG. So, Let's check for radix and update
the default LPCR to keep new CPUs in sync.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/translate_init.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 8b9807665dd5..8776e9b0f8fa 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9014,8 +9014,16 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualH=
ypervisor *vhyp)
         /* By default we choose legacy mode and switch to new hash or ra=
dix
          * when a register process table hcall is made. So disable proce=
ss
          * tables and guest translation shootdown by default
+         *
+         * Hot-plugged CPUs inherit from the guest radix setting under
+         * KVM but not under TCG. Update the default LPCR to keep new
+         * CPUs in sync when radix is enabled.
          */
-        lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
+        if (ppc64_radix_guest(cpu)) {
+            lpcr->default_value |=3D LPCR_UPRT | LPCR_GTSE;
+        } else {
+            lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
+        }
         lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR=
_DEE |
                                LPCR_OEE;
         break;
--=20
2.7.5
