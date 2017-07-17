Received: from eggs.gnu.org ([2001:4830:134:3::10]:55400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX9G0-0006Q6-RD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX9G0-0000yS-2V
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:52:28 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 17:52:21 +0100
Message-Id: <1500310341-28931-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.10] integratorcp: Don't migrate flash
 using vmstate_register_ram_global()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Instead of migrating the flash by creating the memory region
with memory_region_init_ram_nomigrate() and then calling
vmstate_register_ram_global(), just use memory_region_init_ram(),
which now handles migration registration automatically.

This is a migration compatibility break for the integratorcp
board, because the RAM region's migration name changes to
include the device path. This is OK because we don't guarantee
migration compatibility for this board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/integratorcp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index d79221d..d9530ed 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -276,9 +276,8 @@ static void integratorcm_init(Object *obj)
     s->cm_init = 0x00000112;
     s->cm_refcnt_offset = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), 24,
                                    1000);
-    memory_region_init_ram_nomigrate(&s->flash, obj, "integrator.flash", 0x100000,
+    memory_region_init_ram(&s->flash, obj, "integrator.flash", 0x100000,
                            &error_fatal);
-    vmstate_register_ram_global(&s->flash);
 
     memory_region_init_io(&s->iomem, obj, &integratorcm_ops, s,
                           "integratorcm", 0x00800000);
-- 
2.7.4
