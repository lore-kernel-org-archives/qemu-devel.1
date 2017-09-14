Received: from eggs.gnu.org ([2001:4830:134:3::10]:60132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsVhK-0006F4-06
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsVhI-00029o-Ol
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:04:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dsVhI-00028j-IF
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:04:56 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 14 Sep 2017 16:04:41 +0100
Message-Id: <20170914150447.19352-2-dgilbert@redhat.com>
In-Reply-To: <20170914150447.19352-1-dgilbert@redhat.com>
References: <20170914150447.19352-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] hmp: fix "dump-quest-memory" segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com, cohuck@redhat.com, vadim.galitsyn@profitbricks.com
Cc: imammedo@redhat.com, thuth@redhat.com, peterx@redhat.com, groug@kaod.org

From: Laurent Vivier <lvivier@redhat.com>

Running QEMU with
    qemu-system-ppc64 -M none -nographic -m 256
and executing
    dump-guest-memory /dev/null 0 8192
results in segfault

Fix by checking if we have CPU, and exit with
error if there is no CPU:

    (qemu) dump-guest-memory /dev/null
    this feature or command is not currently supported

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20170913142036.2469-2-lvivier@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 target/ppc/arch_dump.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 8e9397aa58..95b9ab6f29 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -224,8 +224,15 @@ typedef struct NoteFuncDescStruct NoteFuncDesc;
 int cpu_get_dump_info(ArchDumpInfo *info,
                       const struct GuestPhysBlockList *guest_phys_blocks)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    PowerPCCPU *cpu;
+    PowerPCCPUClass *pcc;
+
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    cpu = POWERPC_CPU(first_cpu);
+    pcc = POWERPC_CPU_GET_CLASS(cpu);
 
     info->d_machine = PPC_ELF_MACHINE;
     info->d_class = ELFCLASS;
-- 
2.13.5
