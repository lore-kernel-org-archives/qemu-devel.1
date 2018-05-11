Received: from eggs.gnu.org ([2001:4830:134:3::10]:52296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz6z-0004uq-Dr
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz6y-0006Ai-IO
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:53 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:38221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGz6y-0006AM-Cy
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:52 -0400
Received: by mail-pl0-x243.google.com with SMTP id c11-v6so2507815plr.5
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 20:52:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 20:52:37 -0700
Message-Id: <20180511035240.4016-7-richard.henderson@linaro.org>
In-Reply-To: <20180511035240.4016-1-richard.henderson@linaro.org>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 6/9] target/s390x: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Also do not dump both "fpu" and "vector" registers
as the former overlaps the latter.

Cc: Alexander Graf <agraf@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/helper.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index e8548f340a..fd5791f134 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -327,21 +327,22 @@ void s390_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
         }
     }
 
-    for (i = 0; i < 16; i++) {
-        cpu_fprintf(f, "F%02d=%016" PRIx64, i, get_freg(env, i)->ll);
-        if ((i % 4) == 3) {
-            cpu_fprintf(f, "\n");
+    if (flags & CPU_DUMP_FPU) {
+        if (s390_has_feat(S390_FEAT_VECTOR)) {
+            for (i = 0; i < 32; i++) {
+                cpu_fprintf(f, "V%02d=%016" PRIx64 "%016" PRIx64 "%c",
+                            i, env->vregs[i][0].ll, env->vregs[i][1].ll,
+                            i % 2 ? '\n' : ' ');
+            }
         } else {
-            cpu_fprintf(f, " ");
+            for (i = 0; i < 16; i++) {
+                cpu_fprintf(f, "F%02d=%016" PRIx64 "%c",
+                            i, get_freg(env, i)->ll,
+                            (i % 4) == 3 ? '\n' : ' ');
+            }
         }
     }
 
-    for (i = 0; i < 32; i++) {
-        cpu_fprintf(f, "V%02d=%016" PRIx64 "%016" PRIx64, i,
-                    env->vregs[i][0].ll, env->vregs[i][1].ll);
-        cpu_fprintf(f, (i % 2) ? "\n" : " ");
-    }
-
 #ifndef CONFIG_USER_ONLY
     for (i = 0; i < 16; i++) {
         cpu_fprintf(f, "C%02d=%016" PRIx64, i, env->cregs[i]);
-- 
2.17.0
