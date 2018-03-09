Received: from eggs.gnu.org ([2001:4830:134:3::10]:59710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmx-0008Tj-Ay
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmv-00069G-Oe
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:39 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmv-00060G-Gd
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:37 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmu-00078O-JT
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:36 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:16 +0000
Message-Id: <20180309172622.4277-20-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/25] hw/arm/virt: Support -machine
 gic-version=max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add support for passing 'max' to -machine gic-version. By analogy
with the -cpu max option, this picks the "best available" GIC version
whether you're using KVM or TCG, so it behaves like 'host' when
using KVM, and gives you GICv3 when using TCG.

Also like '-cpu host', using -machine gic-version=max' means there
is no guarantee of migration compatibility between QEMU versions;
in future 'max' might mean '4'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180308130626.12393-7-peter.maydell@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/arm/virt.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cda4b83586..2c07245047 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1207,16 +1207,23 @@ static void machvirt_init(MachineState *machine)
     /* We can probe only here because during property set
      * KVM is not available yet
      */
-    if (!vms->gic_version) {
+    if (vms->gic_version <= 0) {
+        /* "host" or "max" */
         if (!kvm_enabled()) {
-            error_report("gic-version=host requires KVM");
-            exit(1);
-        }
-
-        vms->gic_version = kvm_arm_vgic_probe();
-        if (!vms->gic_version) {
-            error_report("Unable to determine GIC version supported by host");
-            exit(1);
+            if (vms->gic_version == 0) {
+                error_report("gic-version=host requires KVM");
+                exit(1);
+            } else {
+                /* "max": currently means 3 for TCG */
+                vms->gic_version = 3;
+            }
+        } else {
+            vms->gic_version = kvm_arm_vgic_probe();
+            if (!vms->gic_version) {
+                error_report(
+                    "Unable to determine GIC version supported by host");
+                exit(1);
+            }
         }
     }
 
@@ -1480,9 +1487,11 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
         vms->gic_version = 2;
     } else if (!strcmp(value, "host")) {
         vms->gic_version = 0; /* Will probe later */
+    } else if (!strcmp(value, "max")) {
+        vms->gic_version = -1; /* Will probe later */
     } else {
         error_setg(errp, "Invalid gic-version value");
-        error_append_hint(errp, "Valid values are 3, 2, host.\n");
+        error_append_hint(errp, "Valid values are 3, 2, host, max.\n");
     }
 }
 
-- 
2.16.2
