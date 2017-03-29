Received: from eggs.gnu.org ([2001:4830:134:3::10]:53038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1ctIVe-00076q-Ui
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1ctIVb-0001Ch-Tp
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:39:55 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:33655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <iwona260909@gmail.com>)
	id 1ctIVb-0001CK-Lo
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:39:51 -0400
Received: by mail-lf0-x243.google.com with SMTP id r36so2525226lfi.0
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 11:39:51 -0700 (PDT)
From: Iwona Kotlarska <iwona260909@gmail.com>
Date: Wed, 29 Mar 2017 20:39:14 +0200
Message-Id: <20170329183914.4197-1-iwona260909@gmail.com>
Subject: [Qemu-devel] [PATCH v2] hmp: fix "info cpu" segfault
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
 target/i386/arch_dump.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 5a2e4be5d0..43992a440c 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -390,9 +390,11 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     GuestPhysBlock *block;
 
 #ifdef TARGET_X86_64
-    X86CPU *first_x86_cpu = X86_CPU(first_cpu);
-
-    lma = !!(first_x86_cpu->env.hflags & HF_LMA_MASK);
+    X86CPU *first_x86_cpu = NULL;
+    first_x86_cpu = X86_CPU(first_cpu);
+    if (first_cpu != NULL) {
+        lma = !!(first_x86_cpu->env.hflags & HF_LMA_MASK);
+    }
 #endif
 
     if (lma) {
-- 
2.12.0
