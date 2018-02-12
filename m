Received: from eggs.gnu.org ([2001:4830:134:3::10]:44887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zJ-0007gp-5J
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zH-00067b-UU
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Feb 2018 14:40:47 +1100
Message-Id: <20180212034054.23441-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180212034054.23441-1-david@gibson.dropbear.id.au>
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/12] spapr: set vsmt to MAX(8, smp_threads)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

We ignore silently the value of smp_threads when we set
the default VSMT value, and if smp_threads is greater than VSMT
kernel is going into trouble later.

Fixes: 8904e5a750
("spapr: Adjust default VSMT value for better migration compatibility")

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 96515036e6..9f29434819 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2310,7 +2310,7 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
          * the value that we'd get with KVM on POWER8, the
          * overwhelmingly common case in production systems.
          */
-        spapr->vsmt = 8;
+        spapr->vsmt = MAX(8, smp_threads);
     }
 
     /* KVM: If necessary, set the SMT mode: */
-- 
2.14.3
