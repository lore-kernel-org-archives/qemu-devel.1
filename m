Received: from eggs.gnu.org ([2001:4830:134:3::10]:56350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJlM-0005mq-9C
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJl1-0000mg-FV
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:26 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43784 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJkx-0000hl-Az
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:14 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:57:51 +0200
Message-Id: <1534431497-1385-59-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v9 58/84] elf: On elf loading,
 treat both EM_MIPS and EM_NANOMIPS as legal for MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Modify load_elf32()/load_elf64() to treat EM_NANOMIPS as legal as
EM_MIPS is.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 include/hw/elf_ops.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index b6e19e3..81cecaf 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -327,6 +327,14 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                 }
             }
             break;
+        case EM_MIPS:
+        case EM_NANOMIPS:
+            if ((ehdr.e_machine != EM_MIPS) &&
+                (ehdr.e_machine != EM_NANOMIPS)) {
+                ret = ELF_LOAD_WRONG_ARCH;
+                goto fail;
+            }
+            break;
         default:
             if (elf_machine != ehdr.e_machine) {
                 ret = ELF_LOAD_WRONG_ARCH;
-- 
2.7.4
