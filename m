Received: from eggs.gnu.org ([2001:4830:134:3::10]:49008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1aJU-0004A7-Bf
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1aJQ-00036O-DU
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:49:52 -0400
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:35337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e1aJQ-00035n-7Q
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:49:48 -0400
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id AE443D93D6
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 17:49:46 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  9 Oct 2017 17:49:27 +0200
Message-Id: <20171009154930.29095-2-clg@kaod.org>
In-Reply-To: <20171009154930.29095-1-clg@kaod.org>
References: <20171009154930.29095-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/4] target/ppc: export ppc_cpu_pvr_match()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

It will be used to test the family of a CPU.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/ppc.h | 1 +
 target/ppc/machine.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 4e7fe110d67b..01e32fa03d2e 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -107,4 +107,5 @@ enum {
 void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flag=
s);
=20
 void ppc_cpu_parse_features(const char *cpu_model);
+bool ppc_cpu_pvr_match(PowerPCCPU *cpu, uint32_t pvr);
 #endif
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 384caee800e6..6085a8c25fd3 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -4,6 +4,7 @@
 #include "exec/exec-all.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
+#include "hw/ppc/ppc.h"
 #include "sysemu/kvm.h"
 #include "helper_regs.h"
 #include "mmu-hash64.h"
@@ -210,7 +211,7 @@ static int cpu_pre_save(void *opaque)
  * between sufficiently similar PVRs, as determined by the CPU class's
  * pvr_match() hook.
  */
-static bool pvr_match(PowerPCCPU *cpu, uint32_t pvr)
+bool ppc_cpu_pvr_match(PowerPCCPU *cpu, uint32_t pvr)
 {
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
=20
@@ -247,7 +248,7 @@ static int cpu_post_load(void *opaque, int version_id=
)
     } else
 #endif
     {
-        if (!pvr_match(cpu, env->spr[SPR_PVR])) {
+        if (!ppc_cpu_pvr_match(cpu, env->spr[SPR_PVR])) {
             return -1;
         }
     }
--=20
2.13.6
