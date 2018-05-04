Received: from eggs.gnu.org ([2001:4830:134:3::10]:43351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETkw-00069E-F4
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETku-0007VZ-22
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  4 May 2018 15:59:29 +1000
Message-Id: <20180504055930.3786-17-david@gibson.dropbear.id.au>
In-Reply-To: <20180504055930.3786-1-david@gibson.dropbear.id.au>
References: <20180504055930.3786-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/17] spapr: don't migrate
 "spapr_option_vector_ov5_cas" to pre 2.8 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

a324d6f16697 "spapr: Support ibm,dynamic-memory-v2 property" added
a new feature in the set of CAS-negotiatable options. This causes
the CAS-negotiated options subsection to be migrated, even for old
machine types that don't know about it, and breaks backward migration
to QEMU 2.7 and older versions:

qemu-system-ppc64: error while loading state for instance 0x0 of device
 'spapr'
qemu-system-ppc64: load of migration failed: No such file or directory

Since this feature only affects boot time behaviour, it should be
filtered out when we decide to migrate CAS-negotiated options, like
we already do with OV5_FORM1_AFFINITY and OV5_DRCONF_MEMORY.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 535d8276df..19997f66c0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1849,10 +1849,12 @@ static bool spapr_ov5_cas_needed(void *opaque)
      *
      * Thus, for any cases where the set of available CAS-negotiatable
      * options extends beyond OV5_FORM1_AFFINITY and OV5_DRCONF_MEMORY, we
-     * include the CAS-negotiated options in the migration stream.
+     * include the CAS-negotiated options in the migration stream, unless
+     * if they affect boot time behaviour only.
      */
     spapr_ovec_set(ov5_mask, OV5_FORM1_AFFINITY);
     spapr_ovec_set(ov5_mask, OV5_DRCONF_MEMORY);
+    spapr_ovec_set(ov5_mask, OV5_DRMEM_V2);
 
     /* spapr_ovec_diff returns true if bits were removed. we avoid using
      * the mask itself since in the future it's possible "legacy" bits may be
-- 
2.17.0
