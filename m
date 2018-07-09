Received: from eggs.gnu.org ([2001:4830:134:3::10]:44343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQqB-00056D-AJ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQqA-0002HP-8Z
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:11 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:50 +1000
Message-Id: <20180709074350.27086-17-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/16] sam460ex: Make
 sam460ex_load_device_tree() handle all errors internally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

sam460ex_load_device_tree() handles nearly all possible errors by simply
exiting (within helper functions and macros).  It handles two early error
cases by returning an error.

There's no particular point to this, so make it handle those directly as
well, removing the need for the caller to handle a failure.  As a bonus it
gives us more specific error messages.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/sam460ex.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 8194f32cd3..e2b7028843 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -255,7 +255,6 @@ static int sam460ex_load_device_tree(hwaddr addr,
                                      hwaddr initrd_size,
                                      const char *kernel_cmdline)
 {
-    int ret = -1;
     uint32_t mem_reg_property[] = { 0, 0, cpu_to_be32(ramsize) };
     char *filename;
     int fdt_size;
@@ -266,12 +265,14 @@ static int sam460ex_load_device_tree(hwaddr addr,
 
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_FILE);
     if (!filename) {
-        goto out;
+        error_report("Couldn't find dtb file `%s'", BINARY_DEVICE_TREE_FILE);
+        exit(1);
     }
     fdt = load_device_tree(filename, &fdt_size);
     g_free(filename);
-    if (fdt == NULL) {
-        goto out;
+    if (!fdt) {
+        error_report("Couldn't load dtb file `%s'", filename);
+        exit(1);
     }
 
     /* Manipulate device tree in memory. */
@@ -325,11 +326,8 @@ static int sam460ex_load_device_tree(hwaddr addr,
 
     rom_add_blob_fixed(BINARY_DEVICE_TREE_FILE, fdt, fdt_size, addr);
     g_free(fdt);
-    ret = fdt_size;
-
-out:
 
-    return ret;
+    return fdt_size;
 }
 
 /* Create reset TLB entries for BookE, mapping only the flash memory.  */
@@ -599,10 +597,6 @@ static void sam460ex_init(MachineState *machine)
         dt_size = sam460ex_load_device_tree(FDT_ADDR, machine->ram_size,
                                     RAMDISK_ADDR, initrd_size,
                                     machine->kernel_cmdline);
-        if (dt_size < 0) {
-            error_report("couldn't load device tree");
-            exit(1);
-        }
 
         boot_info->dt_base = FDT_ADDR;
         boot_info->dt_size = dt_size;
-- 
2.17.1
