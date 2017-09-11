Received: from eggs.gnu.org ([2001:4830:134:3::10]:50831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drPaO-0007ZJ-KK
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drPaN-0001q5-OZ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:21:16 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon, 11 Sep 2017 16:20:54 +0200
Message-Id: <20170911142056.15643-2-lvivier@redhat.com>
In-Reply-To: <20170911142056.15643-1-lvivier@redhat.com>
References: <20170911142056.15643-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] hmp: fix "dump-quest-memory" segfault
 (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

Commit fd5d23babf (hmp: fix "dump-quest-memory" segfault)
fixes the problem for i386, do the same for ppc.

Running QEMU with
    qemu-system-ppc64 -M none -nographic -m 256
and executing
    dump-guest-memory /dev/null 0 8192
results in segfault

Fix by checking if we have CPU.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/arch_dump.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 8e9397aa58..dcb7b19950 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -224,17 +224,22 @@ typedef struct NoteFuncDescStruct NoteFuncDesc;
 int cpu_get_dump_info(ArchDumpInfo *info,
                       const struct GuestPhysBlockList *guest_phys_blocks)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-
     info->d_machine = PPC_ELF_MACHINE;
     info->d_class = ELFCLASS;
 
-    if ((*pcc->interrupts_big_endian)(cpu)) {
-        info->d_endian = ELFDATA2MSB;
+    if (first_cpu) {
+        PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+        PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+
+        if ((*pcc->interrupts_big_endian)(cpu)) {
+            info->d_endian = ELFDATA2MSB;
+        } else {
+            info->d_endian = ELFDATA2LSB;
+        }
     } else {
-        info->d_endian = ELFDATA2LSB;
+        info->d_endian = ELFDATA2MSB;
     }
+
     /* 64KB is the max page size for pseries kernel */
     if (strncmp(object_get_typename(qdev_get_machine()),
                 "pseries-", 8) == 0) {
-- 
2.13.5
