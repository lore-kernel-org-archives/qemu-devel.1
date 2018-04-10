Received: from eggs.gnu.org ([2001:4830:134:3::10]:57009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDV-0007wf-EJ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDU-0000lz-GU
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f5sDU-0000iH-7E
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:40 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDH-0007ZG-58
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:17:27 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 13:17:13 +0100
Message-Id: <20180410121724.8549-2-peter.maydell@linaro.org>
In-Reply-To: <20180410121724.8549-1-peter.maydell@linaro.org>
References: <20180410121724.8549-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/12] hw/arm: Allow manually specified /psci
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Change the code to avoid exiting QEMU if user provided DTB contains
manually specified /psci node and skip any /psci related fixups
instead.

Fixes: 4cbca7d9b4 ("hw/arm: Move virt's PSCI DT fixup code to
arm/boot.c")

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Message-id: 20180402205654.14572-1-andrew.smirnov@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 9319b12fcd..26184bcd7c 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -422,6 +422,7 @@ static void fdt_add_psci_node(void *fdt)
     ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
     const char *psci_method;
     int64_t psci_conduit;
+    int rc;
 
     psci_conduit = object_property_get_int(OBJECT(armcpu),
                                            "psci-conduit",
@@ -439,6 +440,15 @@ static void fdt_add_psci_node(void *fdt)
         g_assert_not_reached();
     }
 
+    /*
+     * If /psci node is present in provided DTB, assume that no fixup
+     * is necessary and all PSCI configuration should be taken as-is
+     */
+    rc = fdt_path_offset(fdt, "/psci");
+    if (rc >= 0) {
+        return;
+    }
+
     qemu_fdt_add_subnode(fdt, "/psci");
     if (armcpu->psci_version == 2) {
         const char comp[] = "arm,psci-0.2\0arm,psci";
-- 
2.16.2
