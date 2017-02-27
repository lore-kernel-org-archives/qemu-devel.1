Received: from eggs.gnu.org ([2001:4830:134:3::10]:52141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfi-0002PM-MP
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfg-0001wK-Kz
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ciPfg-0001rj-Av
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfT-0002Kk-Rr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:05:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:04:36 +0000
Message-Id: <1488218699-31035-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
References: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/30] hw/arm/virt: fix cpu object reference leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

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
Message-id: 1487253461-269218-1-git-send-email-imammedo@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f3440f2..0c270b8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1378,6 +1378,7 @@ static void machvirt_init(MachineState *machine)
         }
 
         object_property_set_bool(cpuobj, true, "realized", NULL);
+        object_unref(cpuobj);
     }
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
-- 
2.7.4
