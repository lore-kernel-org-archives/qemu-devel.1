Received: from eggs.gnu.org ([2001:4830:134:3::10]:59099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRd-0006V1-R0
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRX-0008FX-Ur
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32005)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PRX-0008D7-P2
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:19 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:44 +0200
Message-Id: <20171006095956.27534-22-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 21/33] s390x: raise CPU hotplug irq after really
 hotplugged
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
Message-Id: <20170928134609.16985-3-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 ++++
 target/s390x/cpu.c         | 8 --------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 2c689d50bc..679a1a858c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -307,6 +307,10 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
 
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
2.13.6
