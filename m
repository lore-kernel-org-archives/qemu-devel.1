Received: from eggs.gnu.org ([209.51.188.92]:59936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gwCpg-0004bl-T5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:21:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gwCpf-0001N1-QK
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:21:40 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:33998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1gwCpd-0001Aw-P7
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:21:38 -0500
Received: by mail-lf1-x142.google.com with SMTP id u21so15965144lfu.1
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 13:21:12 -0800 (PST)
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Date: Wed, 20 Feb 2019 00:19:36 +0300
Message-Id: <20190219211936.6466-1-viktor.prutyanov@phystech.edu>
Subject: [Qemu-devel] [PATCH] contrib/elf2dmp: add kernel start address
 checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: pbonzini@redhat.com, rkagan@virtuozzo.com, qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>

Before this patch, if elf2dmp failed to find NT kernel PE magic in
allowed virtual address range, then it assumes NULL as NT kernel
address and cause segfault.

This patch fix the problem described above by checking NT kernel address
before futher processing.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
---
 contrib/elf2dmp/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 1a45eaf565..1bfeb89ba7 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -524,6 +524,12 @@ int main(int argc, char *argv[])
         }
     }
 
+    if (!nt_start_addr) {
+        eprintf("Failed to find NT kernel image\n");
+        err = 1;
+        goto out_ps;
+    }
+
     printf("KernBase = 0x%016"PRIx64", signature is \'%.2s\'\n", KernBase,
             (char *)nt_start_addr);
 
-- 
2.17.2
