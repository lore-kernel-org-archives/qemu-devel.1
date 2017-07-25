Received: from eggs.gnu.org ([2001:4830:134:3::10]:51545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZsep-0000Xk-89
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZseo-0006Fo-Cr
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:45:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 25 Jul 2017 15:45:08 +1000
Message-Id: <20170725054510.15177-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170725054510.15177-1-david@gibson.dropbear.id.au>
References: <20170725054510.15177-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 2/4] spapr/htab: fix savevm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, lvivier@redhat.com, groug@kaod.org, bharata@linux.vnet.ibm.com, thuth@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

Commit 3a38429 ("spapr: Add a "no HPT" encoding to HTAB migration stream")
allows to migrate an empty HPT, but doesn't mark correctly the
end of the migration stream.

The end condition (value returned by htab_save_iterate())
should be 1, whereas in 3a38429 it returns 0.

The problem can be reproduced with QEMU monitor command "savevm":
the command never stops and the disk image grows without limit.

Fixes: 3a38429748aa4f74abaecf16c4c087e8a325e12a
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 970093e6b5..1cb09e7c64 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1827,7 +1827,7 @@ static int htab_save_iterate(QEMUFile *f, void *opaque)
     /* Iteration header */
     if (!spapr->htab_shift) {
         qemu_put_be32(f, -1);
-        return 0;
+        return 1;
     } else {
         qemu_put_be32(f, 0);
     }
-- 
2.13.3
