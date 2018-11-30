Received: from eggs.gnu.org ([2001:4830:134:3::10]:50763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkXw-0004ih-Cd
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkXv-0005Xo-CE
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:36 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:17:07 +0000
Message-Id: <20181130151712.2312-6-peter.maydell@linaro.org>
In-Reply-To: <20181130151712.2312-1-peter.maydell@linaro.org>
References: <20181130151712.2312-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/10] hw/i386/pc.c: Don't use load_image()
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
 hw/i386/pc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f095725dbab..067d23a992a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -839,10 +839,9 @@ static void load_linux(PCMachineState *pcms,
 {
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
-    int64_t initrd_size = 0;
     int dtb_size, setup_data_offset;
     uint32_t initrd_max;
-    uint8_t header[8192], *setup, *kernel, *initrd_data;
+    uint8_t header[8192], *setup, *kernel;
     hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0;
     FILE *f;
     char *vmode;
@@ -965,27 +964,30 @@ static void load_linux(PCMachineState *pcms,
 
     /* load initrd */
     if (initrd_filename) {
+        gsize initrd_size;
+        gchar *initrd_data;
+        GError *gerr = NULL;
+
         if (protocol < 0x200) {
             fprintf(stderr, "qemu: linux kernel too old to load a ram disk\n");
             exit(1);
         }
 
-        initrd_size = get_image_size(initrd_filename);
-        if (initrd_size < 0) {
+        if (!g_file_get_contents(initrd_filename, &initrd_data,
+                                 &initrd_size, &gerr)) {
             fprintf(stderr, "qemu: error reading initrd %s: %s\n",
-                    initrd_filename, strerror(errno));
+                    initrd_filename, gerr->message);
             exit(1);
-        } else if (initrd_size >= initrd_max) {
+        }
+        if (initrd_size >= initrd_max) {
             fprintf(stderr, "qemu: initrd is too large, cannot support."
-                    "(max: %"PRIu32", need %"PRId64")\n", initrd_max, initrd_size);
+                    "(max: %"PRIu32", need %"PRId64")\n",
+                    initrd_max, initrd_size);
             exit(1);
         }
 
         initrd_addr = (initrd_max-initrd_size) & ~4095;
 
-        initrd_data = g_malloc(initrd_size);
-        load_image(initrd_filename, initrd_data);
-
         fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
         fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
         fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, initrd_size);
-- 
2.19.1
