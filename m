Received: from eggs.gnu.org ([2001:4830:134:3::10]:57104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ejijO-0002dc-78
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ejijL-0001jb-2O
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:43:02 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu,  8 Feb 2018 10:42:41 +0100
Message-Id: <20180208094241.13839-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2] spapr: check smp_threads <= vsmt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

We ignore silently the value of smp_threads when we set
the default VSMT value, and if smp_threads is greater than VSMT
kernel is going into trouble later.

Fixes: 8904e5a750
("spapr: Adjust default VSMT value for better migration compatibility")

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2: display a specific error message when the default VSMT is used
        fix subject

 hw/ppc/spapr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 32a876be56..11de276cd5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2311,6 +2311,12 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
          * overwhelmingly common case in production systems.
          */
         spapr->vsmt = 8;
+        if (spapr->vsmt < smp_threads) {
+            error_setg(&local_err, "Cannot support %d threads/core"
+                         " because it must be <= to default VSMT mode (%d)",
+                         smp_threads, spapr->vsmt);
+            goto out;
+        }
     }
 
     /* KVM: If necessary, set the SMT mode: */
-- 
2.14.3
