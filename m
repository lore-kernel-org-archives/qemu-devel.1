Received: from eggs.gnu.org ([2001:4830:134:3::10]:33791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumk-0007Pq-33
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumg-0006Ml-43
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumf-00063g-LS
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:01 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumU-0004UR-9I
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:53:50 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:52:54 +0100
Message-Id: <20180629145347.652-3-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/55] hw/arm/sysbus-fdt: Replace
 error_setg(&error_fatal) by error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Use error_report() + exit() instead of error_setg(&error_fatal),
as suggested by the "qapi/error.h" documentation:

   Please don't error_setg(&error_fatal, ...), use error_report() and
   exit(), because that's more obvious.

This fixes CID 1352173:
    "Passing null pointer dt_name to qemu_fdt_node_path, which dereferences it."

And this also fixes:

    hw/arm/sysbus-fdt.c:322:9: warning: Array access (from variable 'node_path') results in a null pointer dereference
        if (node_path[1]) {
            ^~~~~~~~~~~~

Fixes: Coverity CID 1352173 (Dereference after null check)
Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20180625165749.3910-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sysbus-fdt.c | 53 +++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 277ed872e7c..0d4c75702c3 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -92,16 +92,20 @@ static void copy_properties_from_host(HostProperty *props, int nb_props,
         r = qemu_fdt_getprop(host_fdt, node_path,
                              props[i].name,
                              &prop_len,
-                             props[i].optional ? &err : &error_fatal);
+                             &err);
         if (r) {
             qemu_fdt_setprop(guest_fdt, nodename,
                              props[i].name, r, prop_len);
         } else {
-            if (prop_len != -FDT_ERR_NOTFOUND) {
-                /* optional property not returned although property exists */
-                error_report_err(err);
-            } else {
+            if (props[i].optional && prop_len == -FDT_ERR_NOTFOUND) {
+                /* optional property does not exist */
                 error_free(err);
+            } else {
+                error_report_err(err);
+            }
+            if (!props[i].optional) {
+                /* mandatory property not found: bail out */
+                exit(1);
             }
         }
     }
@@ -138,9 +142,9 @@ static void fdt_build_clock_node(void *host_fdt, void *guest_fdt,
 
     node_offset = fdt_node_offset_by_phandle(host_fdt, host_phandle);
     if (node_offset <= 0) {
-        error_setg(&error_fatal,
-                   "not able to locate clock handle %d in host device tree",
-                   host_phandle);
+        error_report("not able to locate clock handle %d in host device tree",
+                     host_phandle);
+        exit(1);
     }
     node_path = g_malloc(path_len);
     while ((ret = fdt_get_path(host_fdt, node_offset, node_path, path_len))
@@ -149,16 +153,16 @@ static void fdt_build_clock_node(void *host_fdt, void *guest_fdt,
         node_path = g_realloc(node_path, path_len);
     }
     if (ret < 0) {
-        error_setg(&error_fatal,
-                   "not able to retrieve node path for clock handle %d",
-                   host_phandle);
+        error_report("not able to retrieve node path for clock handle %d",
+                     host_phandle);
+        exit(1);
     }
 
     r = qemu_fdt_getprop(host_fdt, node_path, "compatible", &prop_len,
                          &error_fatal);
     if (strcmp(r, "fixed-clock")) {
-        error_setg(&error_fatal,
-                   "clock handle %d is not a fixed clock", host_phandle);
+        error_report("clock handle %d is not a fixed clock", host_phandle);
+        exit(1);
     }
 
     nodename = strrchr(node_path, '/');
@@ -301,34 +305,37 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
 
     dt_name = sysfs_to_dt_name(vbasedev->name);
     if (!dt_name) {
-        error_setg(&error_fatal, "%s incorrect sysfs device name %s",
-                    __func__, vbasedev->name);
+        error_report("%s incorrect sysfs device name %s",
+                     __func__, vbasedev->name);
+        exit(1);
     }
     node_path = qemu_fdt_node_path(host_fdt, dt_name, vdev->compat,
                                    &error_fatal);
     if (!node_path || !node_path[0]) {
-        error_setg(&error_fatal, "%s unable to retrieve node path for %s/%s",
-                   __func__, dt_name, vdev->compat);
+        error_report("%s unable to retrieve node path for %s/%s",
+                     __func__, dt_name, vdev->compat);
+        exit(1);
     }
 
     if (node_path[1]) {
-        error_setg(&error_fatal, "%s more than one node matching %s/%s!",
-                   __func__, dt_name, vdev->compat);
+        error_report("%s more than one node matching %s/%s!",
+                     __func__, dt_name, vdev->compat);
+        exit(1);
     }
 
     g_free(dt_name);
 
     if (vbasedev->num_regions != 5) {
-        error_setg(&error_fatal, "%s Does the host dt node combine XGBE/PHY?",
-                   __func__);
+        error_report("%s Does the host dt node combine XGBE/PHY?", __func__);
+        exit(1);
     }
 
     /* generate nodes for DMA_CLK and PTP_CLK */
     r = qemu_fdt_getprop(host_fdt, node_path[0], "clocks",
                          &prop_len, &error_fatal);
     if (prop_len != 8) {
-        error_setg(&error_fatal, "%s clocks property should contain 2 handles",
-                   __func__);
+        error_report("%s clocks property should contain 2 handles", __func__);
+        exit(1);
     }
     host_clock_phandles = (uint32_t *)r;
     guest_clock_phandles[0] = qemu_fdt_alloc_phandle(guest_fdt);
-- 
2.17.1
