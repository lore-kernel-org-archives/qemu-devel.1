Received: from eggs.gnu.org ([2001:4830:134:3::10]:37675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUL-0007Mp-Jt
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUG-00084L-2K
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUF-000841-TA
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:32 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 17:59:58 +0200
Message-Id: <20170918160012.4317-14-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 13/27] target/s390x: proper cpu->be
 convertion in s390_store_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Necessary so TCG can also use it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 09468f85fa..e44d54b932 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -267,17 +267,24 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
         cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
     }
     for (i = 0; i < 16; ++i) {
-        *((uint64_t *)mem + i) = get_freg(&cpu->env, i)->ll;
+        *((uint64_t *)mem + i) = cpu_to_be64(get_freg(&cpu->env, i)->ll);
+    }
+    for (i = 0; i < 16; ++i) {
+        *((uint64_t *)(mem + 128) + i) = cpu_to_be64(cpu->env.regs[i]);
+    }
+    *((uint64_t *)(mem + 256)) = cpu_to_be64(get_psw_mask(&cpu->env));
+    *((uint64_t *)(mem + 264)) = cpu_to_be64(cpu->env.psw.addr);
+    *((uint32_t *)(mem + 280)) = cpu_to_be32(cpu->env.psa);
+    *((uint32_t *)(mem + 284)) = cpu_to_be32(cpu->env.fpc);
+    *((uint32_t *)(mem + 292)) = cpu_to_be32(cpu->env.todpr);
+    *((uint64_t *)(mem + 296)) = cpu_to_be64(cpu->env.cputm);
+    *((uint64_t *)(mem + 304)) = cpu_to_be64(ckc);
+    for (i = 0; i < 16; ++i) {
+        *((uint32_t *)(mem + 320) + i) = cpu_to_be32(cpu->env.aregs[i]);
+    }
+    for (i = 0; i < 16; ++i) {
+        *((uint64_t *)(mem + 384) + i) = cpu_to_be64(cpu->env.cregs[i]);
     }
-    memcpy(mem + 128, &cpu->env.regs, 128);
-    memcpy(mem + 256, &cpu->env.psw, 16);
-    memcpy(mem + 280, &cpu->env.psa, 4);
-    memcpy(mem + 284, &cpu->env.fpc, 4);
-    memcpy(mem + 292, &cpu->env.todpr, 4);
-    memcpy(mem + 296, &cpu->env.cputm, 8);
-    memcpy(mem + 304, &ckc, 8);
-    memcpy(mem + 320, &cpu->env.aregs, 64);
-    memcpy(mem + 384, &cpu->env.cregs, 128);
 
     cpu_physical_memory_unmap(mem, len, 1, len);
 
-- 
2.13.5
