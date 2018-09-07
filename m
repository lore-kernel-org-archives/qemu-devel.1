Received: from eggs.gnu.org ([2001:4830:134:3::10]:45835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFr-0000FY-F5
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFp-0005Je-RC
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  7 Sep 2018 17:31:52 +1000
Message-Id: <20180907073155.26200-12-david@gibson.dropbear.id.au>
In-Reply-To: <20180907073155.26200-1-david@gibson.dropbear.id.au>
References: <20180907073155.26200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/14] spapr: Correct reference count on
 spapr-cpu-core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, mark.cave-ayland@ilande.co.uk, Sam Bobroff <sbobroff@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sbobroff@linux.ibm.com>

spapr_init_cpus() currently creates spapr-cpu-core objects via
object_new() and setting their realized property to true. This leaves
their reference count at two, because object_new() adds an initial
reference and the realization attaches them to a default parent object
which also increments the reference count.

This causes a problem if one of these cores is hot unplugged: no
delete event is generated for it because it's reference count doesn't
reach zero when it is detached from it's parent.

Correct this by adding a call to object_unref() in spapr_init_cpus().

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 505d4c84e5..4a9dd4d9bc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2480,6 +2480,8 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
             object_property_set_int(core, core_id, CPU_CORE_PROP_CORE_ID,
                                     &error_fatal);
             object_property_set_bool(core, true, "realized", &error_fatal);
+
+            object_unref(core);
         }
     }
 }
-- 
2.17.1
