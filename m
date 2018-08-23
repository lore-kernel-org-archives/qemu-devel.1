Received: from eggs.gnu.org ([2001:4830:134:3::10]:33780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fsqSO-0005If-3I
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fsqSI-0004t7-9G
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:27 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57136 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fsqSH-0004r3-OX
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:21 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 23 Aug 2018 16:18:56 +0200
Message-Id: <1535033941-861-42-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v5 41/46] elf: On elf loading,
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
Cc: peter.maydell@linaro.org

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Modify load_elf32()/load_elf64() to treat EM_NANOMIPS as legal as
EM_MIPS is.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
