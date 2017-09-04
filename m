Received: from eggs.gnu.org ([2001:4830:134:3::10]:37725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXW-0004c6-UJ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXS-00015g-CP
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dotXS-00015P-6a
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:50 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Sep 2017 17:43:08 +0200
Message-Id: <20170904154316.4148-12-david@redhat.com>
In-Reply-To: <20170904154316.4148-1-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/19] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
guest tries to bring these CPUs up but fails), because we don't support
multiple CPUs on s390x under TCG.

Let's bail out if more than 1 is specified, so we don't raise people's
hope. Make it a define, so we can easily bump it up later.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 7 +++++++
 target/s390x/cpu.h         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f67b4b5d58..f7ca20d77a 100644
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
@@ -55,6 +56,12 @@ static void s390_init_cpus(MachineState *machine)
     if (machine->cpu_model == NULL) {
         machine->cpu_model = s390_default_cpu_model_name();
     }
+    if (tcg_enabled() && max_cpus > S390_TCG_MAX_CPUS) {
+        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
+                     "supported by TCG (%d) on s390x", max_cpus,
+                     S390_TCG_MAX_CPUS);
+        exit(1);
+    }
 
     cpu_states = g_new0(S390CPU *, max_cpus);
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 147aceba28..dca6aa9aae 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -209,6 +209,8 @@ static inline S390CPU *s390_env_get_cpu(CPUS390XState *env)
 
 #define ENV_OFFSET offsetof(S390CPU, env)
 
+#define S390_TCG_MAX_CPUS 1
+
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_s390_cpu;
 #endif
-- 
2.13.5
