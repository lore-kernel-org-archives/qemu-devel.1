Received: from eggs.gnu.org ([209.51.188.92]:42393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnm-0000dO-6L
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnk-000146-Od
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:07 +1100
Message-Id: <20190310082703.1245-5-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/60] Revert "spapr: support memory unplug for
 qtest"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Commit b8165118f52c broke CPU hotplug tests for old machine types:

$ QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 ./tests/cpu-plug-te=
st -m=3Dslow
/ppc64/cpu-plug/pseries-3.1/device-add/2x3x1&maxcpus=3D6: OK
/ppc64/cpu-plug/pseries-2.12-sxxm/device-add/2x3x1&maxcpus=3D6: OK
/ppc64/cpu-plug/pseries-3.0/device-add/2x3x1&maxcpus=3D6: OK
/ppc64/cpu-plug/pseries-2.10/device-add/2x3x1&maxcpus=3D6: OK
/ppc64/cpu-plug/pseries-2.11/device-add/2x3x1&maxcpus=3D6: OK
/ppc64/cpu-plug/pseries-2.12/device-add/2x3x1&maxcpus=3D6: OK
/ppc64/cpu-plug/pseries-2.9/device-add/2x3x1&maxcpus=3D6: OK
/ppc64/cpu-plug/pseries-2.7/device-add/2x3x1&maxcpus=3D6: **
ERROR:/home/thuth/devel/qemu/hw/ppc/spapr_events.c:313:rtas_event_log_to_=
source: assertion failed: (source->enabled)
Broken pipe
/home/thuth/devel/qemu/tests/libqtest.c:143: kill_qemu() detected QEMU de=
ath from signal 6 (Aborted) (core dumped)
Aborted (core dumped)

The approach of faking the availability of OV5_HP_EVT causes the
code to assume the hotplug event source is enabled, which is wrong
for older machines.

This reverts commit b8165118f52ce5ee88565d3cec83d30374efdc96.

A subsequent patch will address the problem of CAS under qtest from
a different angle.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155146875097.147873.1732264036668112686.stgit@bahia.lan>
Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_ovec.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 12510b236a..318bf33de4 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -16,7 +16,6 @@
 #include "qemu/bitmap.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
-#include "sysemu/qtest.h"
 #include "trace.h"
 #include <libfdt.h>
=20
@@ -132,11 +131,6 @@ bool spapr_ovec_test(sPAPROptionVector *ov, long bit=
nr)
     g_assert(ov);
     g_assert(bitnr < OV_MAXBITS);
=20
-    /* support memory unplug for qtest */
-    if (qtest_enabled() && bitnr =3D=3D OV5_HP_EVT) {
-        return true;
-    }
-
     return test_bit(bitnr, ov->bitmap) ? true : false;
 }
=20
--=20
2.20.1
