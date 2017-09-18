Received: from eggs.gnu.org ([2001:4830:134:3::10]:37208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyTe-0006j5-Uf
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyTZ-0007iQ-7J
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyTZ-0007i8-1O
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:00:49 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 17:59:46 +0200
Message-Id: <20170918160012.4317-2-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 01/27] s390x: raise CPU hotplug irq after
 really hotplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Let's move it into the machine, so we trigger the IRQ after setting
ms->possible_cpus (which SCLP uses to construct the list of
online CPUs).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 ++++
 target/s390x/cpu.c         | 8 --------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 0471407187..d5a12a2472 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -327,6 +327,10 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
 
     g_assert(!ms->possible_cpus->cpus[cpu->env.core_id].cpu);
     ms->possible_cpus->cpus[cpu->env.core_id].cpu = OBJECT(dev);
+
+    if (dev->hotplugged) {
+        raise_irq_cpu_hotplug();
+    }
 }
 
 static void s390_machine_reset(void)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 34538c3ab9..4920da3625 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -41,7 +41,6 @@
 #include "hw/hw.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
-#include "hw/s390x/sclp.h"
 #endif
 
 #define CR0_RESET       0xE0UL
@@ -227,13 +226,6 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
 
     scc->parent_realize(dev, &err);
-
-#if !defined(CONFIG_USER_ONLY)
-    if (dev->hotplugged) {
-        raise_irq_cpu_hotplug();
-    }
-#endif
-
 out:
     error_propagate(errp, err);
 }
-- 
2.13.5
