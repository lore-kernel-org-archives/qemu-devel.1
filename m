Received: from eggs.gnu.org ([2001:4830:134:3::10]:41632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceMZG-0002Ax-Hl
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceMZF-0001MC-Qf
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:57:54 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 16 Feb 2017 14:57:41 +0100
Message-Id: <1487253461-269218-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/arm/virt: fix cpu object reference leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, drjones@redhat.com

object_new(FOO) returns an object with ref_cnt == 1
and following
  object_property_set_bool(cpuobj, true, "realized", NULL)
set parent of cpuobj to '/machine/unattached' which makes
ref_cnt == 2.

Since machvirt_init() doesn't take ownership of cpuobj
returned by object_new() it should explicitly drop
reference to cpuobj when dangling pointer is about to
go out of scope like it's done pc_new_cpu() to avoid
object leak.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1f216cf..83adf3f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1376,6 +1376,7 @@ static void machvirt_init(MachineState *machine)
         }
 
         object_property_set_bool(cpuobj, true, "realized", NULL);
+        object_unref(cpuobj);
     }
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
-- 
2.7.4
