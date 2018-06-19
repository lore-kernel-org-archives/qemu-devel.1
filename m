Received: from eggs.gnu.org ([2001:4830:134:3::10]:47429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5k4-0003VQ-MH
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5k3-00016k-QS
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:47:32 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:34 -0500
Message-Id: <20180619014319.28272-9-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 008/113] spapr: set vsmt to MAX(8, smp_threads)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

From: Laurent Vivier <lvivier@redhat.com>

We ignore silently the value of smp_threads when we set
the default VSMT value, and if smp_threads is greater than VSMT
kernel is going into trouble later.

Fixes: 8904e5a750
("spapr: Adjust default VSMT value for better migration compatibility")

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 4ad64cbd0c3f9df15be5f7d1c920285551e802ca)
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0c6547faef..6f78c1cf7a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2289,7 +2289,7 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
          * the value that we'd get with KVM on POWER8, the
          * overwhelmingly common case in production systems.
          */
-        spapr->vsmt = 8;
+        spapr->vsmt = MAX(8, smp_threads);
     }
 
     /* KVM: If necessary, set the SMT mode: */
-- 
2.11.0
