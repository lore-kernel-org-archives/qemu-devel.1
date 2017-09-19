Received: from eggs.gnu.org ([2001:4830:134:3::10]:45848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJzQ-00046F-8s
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJzP-0000bJ-DG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:59:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duJzP-0000b1-7X
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:59:07 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:56:19 +0200
Message-Id: <20170919145636.9389-22-cohuck@redhat.com>
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 21/38] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
guest tries to bring these CPUs up but fails), because we don't support
multiple CPUs on s390x under TCG.

Let's bail out if more than 1 is specified, so we don't raise people's
hope.

Tested-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-12-david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f67b4b5d58..417998ec28 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -23,6 +23,7 @@
 #include "hw/s390x/css.h"
 #include "virtio-ccw.h"
 #include "qemu/config-file.h"
+#include "qemu/error-report.h"
 #include "s390-pci-bus.h"
 #include "hw/s390x/storage-keys.h"
 #include "hw/s390x/storage-attributes.h"
@@ -55,6 +56,11 @@ static void s390_init_cpus(MachineState *machine)
     if (machine->cpu_model == NULL) {
         machine->cpu_model = s390_default_cpu_model_name();
     }
+    if (tcg_enabled() && max_cpus > 1) {
+        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
+                     "supported by TCG (1) on s390x", max_cpus);
+        exit(1);
+    }
 
     cpu_states = g_new0(S390CPU *, max_cpus);
 
-- 
2.13.5
