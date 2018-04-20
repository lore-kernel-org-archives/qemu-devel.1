Received: from eggs.gnu.org ([2001:4830:134:3::10]:44433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9VT0-0007VZ-P9
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9VT0-0007ty-1J
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:48:42 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 13:48:33 +0100
Message-Id: <20180420124835.7268-2-peter.maydell@linaro.org>
In-Reply-To: <20180420124835.7268-1-peter.maydell@linaro.org>
References: <20180420124835.7268-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] hw/arm/highbank: don't make sysram
 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Rob Herring <robh@kernel.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Currently we use memory_region_init_ram_nomigrate() to create
the "highbank.sysram" memory region, and we don't manually
register it with vmstate_register_ram(). This currently
means that its contents are migrated but as a ram block
whose name is the empty string; in future it may mean they
are not migrated at all. Use memory_region_init_ram() instead.

Note that this is a cross-version migration compatibility
break for the "highbank" and "midway" machines.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/highbank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 1742cf6f6c..88326d1bfd 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -291,7 +291,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     memory_region_add_subregion(sysmem, 0, dram);
 
     sysram = g_new(MemoryRegion, 1);
-    memory_region_init_ram_nomigrate(sysram, NULL, "highbank.sysram", 0x8000,
+    memory_region_init_ram(sysram, NULL, "highbank.sysram", 0x8000,
                            &error_fatal);
     memory_region_add_subregion(sysmem, 0xfff88000, sysram);
     if (bios_name != NULL) {
-- 
2.17.0
