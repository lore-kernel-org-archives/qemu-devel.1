Received: from eggs.gnu.org ([2001:4830:134:3::10]:50378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOT-0008Hp-It
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOR-0006vE-VS
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:17 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:23 +1100
Message-Id: <20171017042152.29443-6-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/34] spapr: sanity check size of the CAS buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The CAS buffer is provided by SLOF. A broken SLOF could pass a silly
size: either smaller than the diff header, in which case the current
code will try to allocate 16 Exabytes of memory and g_malloc0() will
abort, or bigger than the maximum memory provisioned for SLOF (ie,
40 Megabytes), which doesn't make sense. Both cases indicate that
SLOF has a bug.

Let's print out an explicit error message and exit since rebooting as
we do with other errors would only result in a reset loop.

Signed-off-by: Greg Kurz <groug@kaod.org>
[dwg: Fix format specifier that broke 32-bit builds]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b284e0b9d4..079e493ef4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -819,6 +819,13 @@ int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
         return 1;
     }
 
+    if (size < sizeof(hdr) || size > FW_MAX_SIZE) {
+        error_report("SLOF provided an unexpected CAS buffer size "
+                     TARGET_FMT_lu " (min: %zu, max: %u)",
+                     size, sizeof(hdr), FW_MAX_SIZE);
+        exit(EXIT_FAILURE);
+    }
+
     size -= sizeof(hdr);
 
     /* Create skeleton */
-- 
2.13.6
