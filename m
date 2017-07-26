Received: from eggs.gnu.org ([2001:4830:134:3::10]:45585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1daWAQ-000776-UV
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1daWAM-0003cU-V6
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:56:39 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:39964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1daWAM-0003Y4-Pk
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:56:34 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 27 Jul 2017 01:56:14 +0200
Message-Id: <20170726235614.14687-3-aurelien@aurel32.net>
In-Reply-To: <20170726235614.14687-1-aurelien@aurel32.net>
References: <20170726235614.14687-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH for 2.10 2/2] Revert "elf-loader: warn about
 invalid endianness"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Aurelien Jarno <aurelien@aurel32.net>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This reverts c8e1158cf611 "elf-loader: warn about invalid endianness"
as it produces a useless message every time an LE kernel image is
passed via -kernel on a ppc64-pseries machine. The pseries machine
already checks for ELF_LOAD_WRONG_ENDIAN and tries with big_endian=0.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
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
