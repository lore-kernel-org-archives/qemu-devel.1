Received: from eggs.gnu.org ([2001:4830:134:3::10]:36158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dD7JG-0008OD-Ru
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dD7JD-0006NX-Qt
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:45:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dD7JD-0006NC-Kn
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:44:59 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 23 May 2017 07:44:54 -0300
Message-Id: <20170523104454.31309-2-ehabkost@redhat.com>
In-Reply-To: <20170523104454.31309-1-ehabkost@redhat.com>
References: <20170523104454.31309-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] numa: Silence incomplete mapping warning
 under qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

Silence "make check" warnings triggered by the numa/mon/cpus/partial
test case.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1495094971-177754-4-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index fd6a436064..3adebf14c4 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -21,6 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "sysemu/numa.h"
+#include "sysemu/qtest.h"
 
 static char *machine_get_accel(Object *obj, Error **errp)
 {
@@ -722,7 +723,7 @@ static void machine_numa_validate(MachineState *machine)
             g_free(cpu_str);
         }
     }
-    if (s->len) {
+    if (s->len && !qtest_enabled()) {
         error_report("warning: CPU(s) not present in any NUMA nodes: %s",
                      s->str);
         error_report("warning: All CPU(s) up to maxcpus should be described "
-- 
2.11.0.259.g40922b1
