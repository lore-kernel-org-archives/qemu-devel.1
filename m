Received: from eggs.gnu.org ([2001:4830:134:3::10]:44501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dYPQ1-0002XM-CM
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 00:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dYPPx-000758-32
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 00:20:01 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 21 Jul 2017 14:19:52 +1000
Message-Id: <20170721041952.45950-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] Revert "elf-loader: warn about invalid
 endianness"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This reverts c8e1158cf611 "elf-loader: warn about invalid endianness"
as it produces a useless message every time an LE kernel image is
passed via -kernel on a ppc64-pseries machine. The pseries machine
already checks for ELF_LOAD_WRONG_ENDIAN and tries with big_endian=0.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/core/loader.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index c17ace0a2e..e5e8cbb638 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -480,7 +480,6 @@ int load_elf_ram(const char *filename,
     }
 
     if (target_data_order != e_ident[EI_DATA]) {
-        fprintf(stderr, "%s: wrong endianness\n", filename);
         ret = ELF_LOAD_WRONG_ENDIAN;
         goto fail;
     }
-- 
2.11.0
