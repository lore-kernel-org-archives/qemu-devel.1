Received: from eggs.gnu.org ([2001:4830:134:3::10]:58983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQU-0000Lh-Ic
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQT-0001uU-LT
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:58 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQT-0001to-EB
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:57 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQS-00005E-Fu
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:34:56 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:21 +0100
Message-Id: <20180816133438.17061-14-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/30] loader: extract rom_free() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

The next patch will need to free a rom.  There is already code to do
this in rom_add_file().

Note that rom_add_file() uses:

  rom = g_malloc0(sizeof(*rom));
  ...
  if (rom->fw_dir) {
      g_free(rom->fw_dir);
      g_free(rom->fw_file);
  }

The conditional is unnecessary since g_free(NULL) is a no-op.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180814162739.11814-4-stefanha@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/loader.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index bbb6e65bb51..0c72e7c05af 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -847,6 +847,17 @@ struct Rom {
 static FWCfgState *fw_cfg;
 static QTAILQ_HEAD(, Rom) roms = QTAILQ_HEAD_INITIALIZER(roms);
 
+/* rom->data must be heap-allocated (do not use with rom_add_elf_program()) */
+static void rom_free(Rom *rom)
+{
+    g_free(rom->data);
+    g_free(rom->path);
+    g_free(rom->name);
+    g_free(rom->fw_dir);
+    g_free(rom->fw_file);
+    g_free(rom);
+}
+
 static inline bool rom_order_compare(Rom *rom, Rom *item)
 {
     return ((uintptr_t)(void *)rom->as > (uintptr_t)(void *)item->as) ||
@@ -995,15 +1006,7 @@ err:
     if (fd != -1)
         close(fd);
 
-    g_free(rom->data);
-    g_free(rom->path);
-    g_free(rom->name);
-    if (fw_dir) {
-        g_free(rom->fw_dir);
-        g_free(rom->fw_file);
-    }
-    g_free(rom);
-
+    rom_free(rom);
     return -1;
 }
 
-- 
2.18.0
