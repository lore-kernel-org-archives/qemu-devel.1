Received: from eggs.gnu.org ([2001:4830:134:3::10]:37457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dXPYV-0001pl-R9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dXPYS-00071t-Ne
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:16:39 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 18 Jul 2017 12:16:32 +0200
Message-Id: <20170718101632.3304-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2] spapr/htab: fix savevm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, sursingh@redhat.com, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, sbobroff@redhat.com

Commit 3a38429 ("spapr: Add a "no HPT" encoding to HTAB migration stream")
allows to migrate an empty HPT, but doesn't mark correctly the
end of the migration stream.

The end condition (value returned by htab_save_iterate())
should be 1, whereas in 3a38429 it returns 0.

The problem can be reproduced with QEMU monitor command "savevm":
the command never stops and the disk image grows without limit.

Fixes: 3a38429748aa4f74abaecf16c4c087e8a325e12a
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
v2: remove change in htab_save_complete() as
    it always return 0 in case of success (Thomas)

 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 970093e..1cb09e7 100644
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
2.9.4
