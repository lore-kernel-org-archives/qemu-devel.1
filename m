Received: from eggs.gnu.org ([209.51.188.92]:47276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wig-0003t6-23
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wie-0000UL-2B
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:33 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:34878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2Wia-0000N4-8X
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:30 -0500
Received: by mail-wm1-x331.google.com with SMTP id y15so14270957wma.0
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:47:58 +0100
Message-Id: <1552117698-12355-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/25] contrib/elf2dmp: add kernel start address
 checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

Before this patch, if elf2dmp failed to find NT kernel PE magic in
allowed virtual address range, then it assumes NULL as NT kernel
address and cause segfault.

This patch fix the problem described above by checking NT kernel address
before futher processing.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-Id: <20190219211936.6466-1-viktor.prutyanov@phystech.edu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/elf2dmp/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 1a45eaf..1bfeb89 100644
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
1.8.3.1
