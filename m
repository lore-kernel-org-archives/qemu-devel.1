Received: from eggs.gnu.org ([2001:4830:134:3::10]:33933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1ctSLZ-0002AX-4P
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 01:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1ctSLW-0006BW-0L
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 01:10:09 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <iwona260909@gmail.com>)
	id 1ctSLV-0006AT-PB
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 01:10:05 -0400
Received: by mail-lf0-x244.google.com with SMTP id v2so3516576lfi.2
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 22:10:05 -0700 (PDT)
From: Iwona Kotlarska <iwona260909@gmail.com>
Date: Thu, 30 Mar 2017 07:09:24 +0200
Message-Id: <20170330050924.22134-1-iwona260909@gmail.com>
Subject: [Qemu-devel] [PATCH v3] hmp: fix "info cpu" segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Iwona Kotlarska <iwona260909@gmail.com>

Running QEMU with "qemu-system-x86_64 -M none -nographic -m 256" and executing
"dump-guest-memory /dev/null 0 8192" results in segfault.
Fix by checking if we have CPU.

Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>
---
 target/i386/arch_dump.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 5a2e4be5d0..fe0aa36932 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -391,8 +391,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
 
 #ifdef TARGET_X86_64
     X86CPU *first_x86_cpu = X86_CPU(first_cpu);
-
-    lma = !!(first_x86_cpu->env.hflags & HF_LMA_MASK);
+    lma = first_cpu && (first_x86_cpu->env.hflags & HF_LMA_MASK);
 #endif
 
     if (lma) {
-- 
2.12.0
