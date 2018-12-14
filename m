Received: from eggs.gnu.org ([2001:4830:134:3::10]:38369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofg-0008UK-KI
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXoff-0004Pm-Np
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:32 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXoff-0004P9-Gf
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:31 -0500
Received: by mail-wm1-x336.google.com with SMTP id m1so5920534wml.2
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.29
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:03 +0000
Message-Id: <20181214144214.1260-12-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/22] hw/i386/pc.c: Don't use load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The load_image() function is deprecated, as it does not let the
caller specify how large the buffer to read the file into is.
Use the glib g_file_get_contents() function instead, which does
the whole "allocate memory for the file and read it in" operation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20181130151712.2312-6-peter.maydell@linaro.org
---
 hw/i386/pc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4cd2fbca4d5..115bc2825ce 100644
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
+                    initrd_max, (uint64_t)initrd_size);
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
2.19.2
