Received: from eggs.gnu.org ([2001:4830:134:3::10]:50783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkXw-0004jI-SU
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkXv-0005YD-Ql
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:36 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:17:03 +0000
Message-Id: <20181130151712.2312-2-peter.maydell@linaro.org>
In-Reply-To: <20181130151712.2312-1-peter.maydell@linaro.org>
References: <20181130151712.2312-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/10] hw/ppc/mac_newworld,
 mac_oldworld: Don't use load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Philip Li <philip.li@intel.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org

The load_image() function is deprecated, as it does not let the
caller specify how large the buffer to read the file into is.
Use the glib g_file_get_contents() function instead, which does
the whole "allocate memory for the file and read it in" operation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ppc/mac_newworld.c | 10 ++++------
 hw/ppc/mac_oldworld.c | 10 ++++------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 14273a123e5..7e45afae7c5 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -127,8 +127,7 @@ static void ppc_core99_init(MachineState *machine)
     MACIOIDEState *macio_ide;
     BusState *adb_bus;
     MacIONVRAMState *nvr;
-    int bios_size, ndrv_size;
-    uint8_t *ndrv_file;
+    int bios_size;
     int ppc_boot_device;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     void *fw_cfg;
@@ -510,11 +509,10 @@ static void ppc_core99_init(MachineState *machine)
     /* MacOS NDRV VGA driver */
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, NDRV_VGA_FILENAME);
     if (filename) {
-        ndrv_size = get_image_size(filename);
-        if (ndrv_size != -1) {
-            ndrv_file = g_malloc(ndrv_size);
-            ndrv_size = load_image(filename, ndrv_file);
+        gchar *ndrv_file;
+        gsize ndrv_size;
 
+        if (g_file_get_contents(filename, &ndrv_file, &ndrv_size, NULL)) {
             fw_cfg_add_file(fw_cfg, "ndrv/qemu_vga.ndrv", ndrv_file, ndrv_size);
         }
         g_free(filename);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 9891c325a9b..817f70e52cf 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -99,8 +99,7 @@ static void ppc_heathrow_init(MachineState *machine)
     SysBusDevice *s;
     DeviceState *dev, *pic_dev;
     BusState *adb_bus;
-    int bios_size, ndrv_size;
-    uint8_t *ndrv_file;
+    int bios_size;
     uint16_t ppc_boot_device;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     void *fw_cfg;
@@ -361,11 +360,10 @@ static void ppc_heathrow_init(MachineState *machine)
     /* MacOS NDRV VGA driver */
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, NDRV_VGA_FILENAME);
     if (filename) {
-        ndrv_size = get_image_size(filename);
-        if (ndrv_size != -1) {
-            ndrv_file = g_malloc(ndrv_size);
-            ndrv_size = load_image(filename, ndrv_file);
+        gchar *ndrv_file;
+        gsize ndrv_size;
 
+        if (g_file_get_contents(filename, &ndrv_file, &ndrv_size, NULL)) {
             fw_cfg_add_file(fw_cfg, "ndrv/qemu_vga.ndrv", ndrv_file, ndrv_size);
         }
         g_free(filename);
-- 
2.19.1
