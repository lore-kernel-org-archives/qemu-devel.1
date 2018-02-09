Received: from eggs.gnu.org ([2001:4830:134:3::10]:52044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ek3tq-0000F4-L1
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ek3tn-000560-Gs
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:19:14 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Fri,  9 Feb 2018 09:18:58 +0100
Message-Id: <20180209081858.27013-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v3] spapr: set vsmt to MAX(8, smp_threads)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

We ignore silently the value of smp_threads when we set
the default VSMT value, and if smp_threads is greater than VSMT
kernel is going into trouble later.

Fixes: 8904e5a750
("spapr: Adjust default VSMT value for better migration compatibility")

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v3: use MAX(8, smp_threads) and let KVM to return an error
        if nb_threads is too big
        update subject to reflect the change
    
    v2: display a specific error message when the default VSMT is used
        fix subject

 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 32a876be56..c8a1eefa17 100644
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
