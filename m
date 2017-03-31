Received: from eggs.gnu.org ([2001:4830:134:3::10]:32901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctuKR-00062z-Fc
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctuKO-0005ry-4p
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:02:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctuKN-0005qy-W1
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:02:48 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 31 Mar 2017 12:02:44 +0100
Message-Id: <20170331110244.9439-2-dgilbert@redhat.com>
In-Reply-To: <20170331110244.9439-1-dgilbert@redhat.com>
References: <20170331110244.9439-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] hmp: fix "dump-quest-memory" segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: iwona260909@gmail.com

From: Iwona Kotlarska <iwona260909@gmail.com>

Running QEMU with "qemu-system-x86_64 -M none -nographic -m 256" and executing
"dump-guest-memory /dev/null 0 8192" results in segfault.
Fix by checking if we have CPU.

Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>
Message-Id: <20170330050924.22134-1-iwona260909@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
   Fixed up title
---
 target/i386/arch_dump.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 5a2e4be..fe0aa36 100644
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
2.9.3
