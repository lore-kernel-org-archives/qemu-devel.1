Received: from eggs.gnu.org ([2001:4830:134:3::10]:38974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3Br-0004Ie-B8
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3Bm-0002Hw-P5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dq3Bm-0002HU-Il
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:14 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Sep 2017 22:13:25 +0200
Message-Id: <20170907201335.13956-12-david@redhat.com>
In-Reply-To: <20170907201335.13956-1-david@redhat.com>
References: <20170907201335.13956-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/21] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>

Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
guest tries to bring these CPUs up but fails), because we don't support
multiple CPUs on s390x under TCG.

Let's bail out if more than 1 is specified, so we don't raise people's
hope. Make it a define, so we can easily bump it up later.

Tested-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f67b4b5d58..f1198b2745 100644
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
@@ -47,6 +48,8 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
     return cpu_states[cpu_addr];
 }
 
+/* #define S390_TCG_SMP_SUPPORT */
+
 static void s390_init_cpus(MachineState *machine)
 {
     int i;
@@ -55,6 +58,13 @@ static void s390_init_cpus(MachineState *machine)
     if (machine->cpu_model == NULL) {
         machine->cpu_model = s390_default_cpu_model_name();
     }
+#ifndef S390_TCG_SMP_SUPPORT
+    if (tcg_enabled() && max_cpus > 1) {
+        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
+                     "supported by TCG (1) on s390x", max_cpus);
+        exit(1);
+    }
+#endif
 
     cpu_states = g_new0(S390CPU *, max_cpus);
 
-- 
2.13.5
