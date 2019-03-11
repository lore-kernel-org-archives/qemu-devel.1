Received: from eggs.gnu.org ([209.51.188.92]:60666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODS-0006yQ-Ho
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODQ-0002xd-Fe
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:54 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODM-0002t1-Rb
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:50 -0400
Received: by mail-wr1-x42a.google.com with SMTP id d17so5927533wre.10
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:11 +0100
Message-Id: <1552323335-46779-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 07/31] contrib/elf2dmp: add kernel start
 address checking
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
