Received: from eggs.gnu.org ([2001:4830:134:3::10]:40794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZ9O-0006vL-Rd
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZ9I-0002Qz-Ts
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxZ9I-0002Pc-OQ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:44 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 15:46:06 +0200
Message-Id: <20170928134609.16985-3-david@redhat.com>
In-Reply-To: <20170928134609.16985-1-david@redhat.com>
References: <20170928134609.16985-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/5] s390x: raise CPU hotplug irq after
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
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>

Let's move it into the machine, so we trigger the IRQ after setting
ms->possible_cpus (which SCLP uses to construct the list of
online CPUs).

This also fixes a problem reported by Thomas Huth, whereby qemu can be
crashed using the none machine

qemu-s390x-softmmu -M none -monitor stdio
-> device_add qemu-s390-cpu

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 ++++
 target/s390x/cpu.c         | 8 --------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1bcb7000ab..ab234247f6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -305,6 +305,10 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
 
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
