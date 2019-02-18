Received: from eggs.gnu.org ([209.51.188.92]:58328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvf88-0001x3-U2
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvf88-0002lk-48
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:22:28 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 10:21:58 +0100
Message-Id: <20190218092202.26683-3-david@redhat.com>
In-Reply-To: <20190218092202.26683-1-david@redhat.com>
References: <20190218092202.26683-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/6] spapr: support memory unplug for qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>

Fake availability of OV5_HP_EVT, so we can test memory unplug in qtest.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr_ovec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 318bf33de4..12510b236a 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -16,6 +16,7 @@
 #include "qemu/bitmap.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
+#include "sysemu/qtest.h"
 #include "trace.h"
 #include <libfdt.h>
 
@@ -131,6 +132,11 @@ bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr)
     g_assert(ov);
     g_assert(bitnr < OV_MAXBITS);
 
+    /* support memory unplug for qtest */
+    if (qtest_enabled() && bitnr == OV5_HP_EVT) {
+        return true;
+    }
+
     return test_bit(bitnr, ov->bitmap) ? true : false;
 }
 
-- 
2.17.2
