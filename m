Received: from eggs.gnu.org ([2001:4830:134:3::10]:47067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fWJRR-00023n-Nx
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fWJRN-0004Pe-Pk
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:37:21 -0400
Received: from mail-yb0-x242.google.com ([2607:f8b0:4002:c09::242]:35415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fWJRN-0004PR-L4
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:37:17 -0400
Received: by mail-yb0-x242.google.com with SMTP id a16-v6so2372051ybm.2
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 03:37:17 -0700 (PDT)
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Fri, 22 Jun 2018 18:37:07 +0800
Message-Id: <1529663827-28854-1-git-send-email-hongbo.zhang@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/arm/virt: fix psci conduit in acpi when el3
 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Hongbo Zhang <hongbo.zhang@linaro.org>

When QEMU_PSCI_CONDUIT_DISABLED is set, it doesn't mean all the PSCI
conduits are totally disabled, it only mean the QEMU built-in PSCI
support is disabled, in such a case, e.g. EL3 is enabled and external
firmware (it is usually Arm Trusted Firmware) is loaded, SMC should be
used for the guest to trigger PSCI functions.

Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
---
 hw/arm/virt-acpi-build.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 74f5744..e5b4947 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -715,7 +715,11 @@ static void build_fadt_rev5(GArray *table_data, BIOSLinker *linker,
 
     switch (vms->psci_conduit) {
     case QEMU_PSCI_CONDUIT_DISABLED:
-        fadt.arm_boot_arch = 0;
+        /* This case means QEMU's internal EL3 implementation is disabled,
+         * but when firmware is loaded, the guest can still use SMC as PSCI
+         * conduit to call external firmware PSCI services
+         */ 
+        fadt.arm_boot_arch = ACPI_FADT_ARM_PSCI_COMPLIANT;
         break;
     case QEMU_PSCI_CONDUIT_HVC:
         fadt.arm_boot_arch = ACPI_FADT_ARM_PSCI_COMPLIANT |
-- 
2.7.4
