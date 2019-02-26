Received: from eggs.gnu.org ([209.51.188.92]:57470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkM-0004Yj-VZ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkJ-0001A4-9Y
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:37 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:27 +1100
Message-Id: <20190226045304.25618-14-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/50] spapr: support memory unplug for qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: David Hildenbrand <david@redhat.com>

Fake availability of OV5_HP_EVT, so we can test memory unplug in qtest.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190218092202.26683-3-david@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
=20
@@ -131,6 +132,11 @@ bool spapr_ovec_test(sPAPROptionVector *ov, long bit=
nr)
     g_assert(ov);
     g_assert(bitnr < OV_MAXBITS);
=20
+    /* support memory unplug for qtest */
+    if (qtest_enabled() && bitnr =3D=3D OV5_HP_EVT) {
+        return true;
+    }
+
     return test_bit(bitnr, ov->bitmap) ? true : false;
 }
=20
--=20
2.20.1
