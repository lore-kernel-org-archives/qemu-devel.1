Received: from eggs.gnu.org ([2001:4830:134:3::10]:38033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96G-0004LK-PT
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96F-0002JW-Nw
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:12 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:43456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96F-0002Gw-FR
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:11 -0400
Received: by mail-wr0-x22c.google.com with SMTP id c5-v6so10637845wrs.10
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:11 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:20 +0200
Message-Id: <20180630061040.6018-28-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/47] hw/nios2: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180625124238.25339-26-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/nios2/boot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 94f436e..4bb5b60 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "qemu/option.h"
@@ -38,7 +39,6 @@
 #include "sysemu/sysemu.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "qemu/cutils.h"
 
 #include "boot.h"
 
@@ -177,7 +177,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
             high = ddr_base + kernel_size;
         }
 
-        high = ROUND_UP(high, 1024 * 1024);
+        high = ROUND_UP(high, 1 * MiB);
 
         /* If initrd is available, it goes after the kernel, aligned to 1M. */
         if (initrd_filename) {
@@ -213,7 +213,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
         high += fdt_size;
 
         /* Kernel command is at the end, 4k aligned. */
-        boot_info.cmdline = ROUND_UP(high, 4096);
+        boot_info.cmdline = ROUND_UP(high, 4 * KiB);
         if (kernel_cmdline && strlen(kernel_cmdline)) {
             pstrcpy_targphys("cmdline", boot_info.cmdline, 256, kernel_cmdline);
         }
-- 
1.8.3.1
