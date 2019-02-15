Received: from eggs.gnu.org ([209.51.188.92]:33388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugr7-0001pm-OA
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugr5-0005TF-KQ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55158
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugr3-0005Gu-KO
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:49 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FGxni5096149
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:45 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qp0u6spea-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:45 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 17:00:43 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 18:00:22 +0100
In-Reply-To: <20190215170029.15641-1-clg@kaod.org>
References: <20190215170029.15641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215170029.15641-6-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/12] target/ppc: Cleanup 64-bit MMU includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

To enable inlining more things, move #include of mmu-hash64.h and
mmu-radix64.h to mmu-book3s-v3.h

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-book3s-v3.h | 3 +++
 hw/ppc/spapr_hcall.c       | 1 -
 target/ppc/mmu-book3s-v3.c | 2 --
 target/ppc/mmu-hash64.c    | 1 -
 target/ppc/mmu-radix64.c   | 1 -
 5 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 12ec0054c207..4e59742d7eac 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -22,6 +22,9 @@
=20
 #ifndef CONFIG_USER_ONLY
=20
+#include "mmu-hash64.h"
+#include "mmu-radix64.h"
+
 /*
  * Partition table definitions
  */
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b47241ace62a..2f64c69a6abf 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -9,7 +9,6 @@
 #include "helper_regs.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
-#include "mmu-hash64.h"
 #include "cpu-models.h"
 #include "trace.h"
 #include "kvm_ppc.h"
diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index a174e7efc57c..ccbae3213cc1 100644
--- a/target/ppc/mmu-book3s-v3.c
+++ b/target/ppc/mmu-book3s-v3.c
@@ -19,9 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
-#include "mmu-radix64.h"
=20
 int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                               int mmu_idx)
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 1175b991d994..f6c822ef917b 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -24,7 +24,6 @@
 #include "qemu/error-report.h"
 #include "sysemu/hw_accel.h"
 #include "kvm_ppc.h"
-#include "mmu-hash64.h"
 #include "exec/log.h"
 #include "hw/hw.h"
 #include "mmu-book3s-v3.h"
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index ab76cbc83530..5881efeb8598 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -25,7 +25,6 @@
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
 #include "exec/log.h"
-#include "mmu-radix64.h"
 #include "mmu-book3s-v3.h"
=20
 static bool ppc_radix64_get_fully_qualified_addr(CPUPPCState *env, vaddr=
 eaddr,
--=20
2.20.1
