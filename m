Received: from eggs.gnu.org ([2001:4830:134:3::10]:41376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYU-00079Q-OD
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYS-0004Gp-Q7
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:26 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:42352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYS-0004F2-Je
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:24 -0500
Received: by mail-wm0-x241.google.com with SMTP id b141so11523629wme.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:27 +0100
Message-Id: <1515756676-3860-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/52] pc: fail memory hot-plug/unplug with
 -no-acpi and Q35 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Haozhong Zhang <haozhong.zhang@intel.com>

From: Haozhong Zhang <haozhong.zhang@intel.com>

When -no-acpi option is used with Q35 machine type, no guest ACPI is
built, but the ACPI device is still created, so only checking the
presence of ACPI device before memory plug/unplug is not enough in
such cases. Check whether ACPI is disabled globally in addition and
fail memory plug/unplug if it's disabled.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Message-Id: <20171222015120.31730-1-haozhong.zhang@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3fcf318..55686bf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1695,9 +1695,14 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
         align = memory_region_get_alignment(mr);
     }
 
-    if (!pcms->acpi_dev) {
+    /*
+     * When -no-acpi is used with Q35 machine type, no ACPI is built,
+     * but pcms->acpi_dev is still created. Check !acpi_enabled in
+     * addition to cover this case.
+     */
+    if (!pcms->acpi_dev || !acpi_enabled) {
         error_setg(&local_err,
-                   "memory hotplug is not enabled: missing acpi device");
+                   "memory hotplug is not enabled: missing acpi device or acpi disabled");
         goto out;
     }
 
@@ -1729,9 +1734,14 @@ static void pc_dimm_unplug_request(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
-    if (!pcms->acpi_dev) {
+    /*
+     * When -no-acpi is used with Q35 machine type, no ACPI is built,
+     * but pcms->acpi_dev is still created. Check !acpi_enabled in
+     * addition to cover this case.
+     */
+    if (!pcms->acpi_dev || !acpi_enabled) {
         error_setg(&local_err,
-                   "memory hotplug is not enabled: missing acpi device");
+                   "memory hotplug is not enabled: missing acpi device or acpi disabled");
         goto out;
     }
 
-- 
1.8.3.1
