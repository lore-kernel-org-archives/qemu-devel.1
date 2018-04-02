Received: from eggs.gnu.org ([2001:4830:134:3::10]:43415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1f36Vx-0005Dd-CU
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 16:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1f36Vu-0008Bz-En
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 16:57:17 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  2 Apr 2018 13:56:54 -0700
Message-Id: <20180402205654.14572-1-andrew.smirnov@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/arm: Allow manually specified /psci node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Change the code to avoid exiting QEMU if user provided DTB contains
manually specified /psci node and skip any /psci related fixups
instead.

Fixes: 4cbca7d9b4 ("hw/arm: Move virt's PSCI DT fixup code to
arm/boot.c")

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Mark:

Sorry about the inconvenience, here's the fix (hopefully) to the
prolem you reported in [1]. Let me know if skipping all PSCI related
DTB fixup if /psic node is present is not the behaviour you had in
mind for your suggested fix.

Thanks,
Andrey Smirnov

[1] http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06914.html

 hw/arm/boot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 6d0c92ab88..d9f9375cdb 100644
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
2.14.3
