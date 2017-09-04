Received: from eggs.gnu.org ([2001:4830:134:3::10]:52604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqST-00051d-3g
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSF-0004nw-AS
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSF-0004nZ-3a
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:15 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSE-0005Wj-4U
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:48 +0100
Message-Id: <1504527967-29248-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/36] loader: Ignore zero-sized ELF segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Some ELF files have program headers that specify segments that
are of zero size. Ignore them, rather than trying to create
zero-length ROM blobs for them, because the zero-length blob
can falsely trigger the overlapping-ROM-blobs check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Hua Yanghao <huayanghao@gmail.com>
Message-id: 1502116754-18867-3-git-send-email-peter.maydell@linaro.org
---
 include/hw/elf_ops.h | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 2e526d3..d192e7e 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -451,14 +451,24 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                 *pentry = ehdr.e_entry - ph->p_vaddr + ph->p_paddr;
             }
 
-            if (load_rom) {
-                snprintf(label, sizeof(label), "phdr #%d: %s", i, name);
-
-                /* rom_add_elf_program() seize the ownership of 'data' */
-                rom_add_elf_program(label, data, file_size, mem_size, addr, as);
-            } else {
-                cpu_physical_memory_write(addr, data, file_size);
+            if (mem_size == 0) {
+                /* Some ELF files really do have segments of zero size;
+                 * just ignore them rather than trying to create empty
+                 * ROM blobs, because the zero-length blob can falsely
+                 * trigger the overlapping-ROM-blobs check.
+                 */
                 g_free(data);
+            } else {
+                if (load_rom) {
+                    snprintf(label, sizeof(label), "phdr #%d: %s", i, name);
+
+                    /* rom_add_elf_program() seize the ownership of 'data' */
+                    rom_add_elf_program(label, data, file_size, mem_size,
+                                        addr, as);
+                } else {
+                    cpu_physical_memory_write(addr, data, file_size);
+                    g_free(data);
+                }
             }
 
             total_size += mem_size;
-- 
2.7.4
