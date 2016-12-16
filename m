Received: from eggs.gnu.org ([2001:4830:134:3::10]:59571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHsyy-0000Fm-7Y
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHsyu-0005ZH-0v
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:55:32 -0500
From: <marcin.krzeminski@nokia.com>
Date: Fri, 16 Dec 2016 14:22:38 +0100
Message-ID: <1481894559-13974-3-git-send-email-marcin.krzeminski@nokia.com>
In-Reply-To: <1481894559-13974-1-git-send-email-marcin.krzeminski@nokia.com>
References: <1481894559-13974-1-git-send-email-marcin.krzeminski@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 2/3] ARM: boot: Add option to skip FDT memory
 node update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, rfsw-patches@mlist.nokia.com

From: Marcin Krzeminski <marcin.krzeminski@nokia.com>

When Qemu boots directly ARM kernel the memory node in device
tree is automatically updated to mach guest RAM size assigned
to Qemu. This commit allow use case when user do not
want to pass all guest RAM to linux kernel by skipping
device tree mmory node update.

Signed-off-by: Marcin Krzeminski <marcin.krzeminski@nokia.com>
---
 hw/arm/boot.c        | 29 ++++++++++++++++-------------
 include/hw/arm/arm.h |  5 +++++
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index ff621e4..0af72bd 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -489,21 +489,24 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     } else {
         Error *err = NULL;
 
-        rc = fdt_path_offset(fdt, "/memory");
-        if (rc < 0) {
-            qemu_fdt_add_subnode(fdt, "/memory");
-        }
+        if (!binfo->skip_fdt_mem_node) {
 
-        if (!qemu_fdt_getprop(fdt, "/memory", "device_type", NULL, &err)) {
-            qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
-        }
+            rc = fdt_path_offset(fdt, "/memory");
+            if (rc < 0) {
+                qemu_fdt_add_subnode(fdt, "/memory");
+            }
 
-        rc = qemu_fdt_setprop_sized_cells(fdt, "/memory", "reg",
-                                          acells, binfo->loader_start,
-                                          scells, binfo->ram_size);
-        if (rc < 0) {
-            fprintf(stderr, "couldn't set /memory/reg\n");
-            goto fail;
+            if (!qemu_fdt_getprop(fdt, "/memory", "device_type", NULL, &err)) {
+                qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
+            }
+
+            rc = qemu_fdt_setprop_sized_cells(fdt, "/memory", "reg",
+                                              acells, binfo->loader_start,
+                                              scells, binfo->ram_size);
+            if (rc < 0) {
+                fprintf(stderr, "couldn't set /memory/reg\n");
+                goto fail;
+            }
         }
     }
 
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index aeeebfe..e237930 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -112,6 +112,11 @@ struct arm_boot_info {
     bool secure_board_setup;
 
     arm_endianness endianness;
+
+    /* Do not override memory node in device tree - useful when
+     * not whole guest memory is under Linux control.
+     */
+    bool skip_fdt_mem_node;
 };
 
 /**
-- 
2.7.4
