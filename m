Received: from eggs.gnu.org ([2001:4830:134:3::10]:38853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eN0hK-0008GQ-S5
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eN0hJ-0006nI-Jt
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:15:02 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Dec 2017 18:14:53 +0000
Message-Id: <1512670493-18114-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 6/6] hw/arm/virt: Support -machine
 gic-version=max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>

Add support for passing 'max' to -machine gic-version. By analogy
with the -cpu max option, this picks the "best available" GIC version
whether you're using KVM or TCG, so it behaves like 'host' when
using KVM, and gives you GICv3 when using TCG.

Also like '-cpu host', using -machine gic-version=max' means there
is no guarantee of migration compatibility between QEMU versions;
in future 'max' might mean '4'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 92bd776..603ba56 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1265,16 +1265,23 @@ static void machvirt_init(MachineState *machine)
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
 
@@ -1539,9 +1546,11 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
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
2.7.4
