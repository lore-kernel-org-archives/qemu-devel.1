Received: from eggs.gnu.org ([2001:4830:134:3::10]:55354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNi-0000H4-Pz
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNh-0003YU-Os
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:46 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:46842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJnNh-0003YF-J0
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:45 -0400
Received: by mail-pl0-x242.google.com with SMTP id 30-v6so5293553pld.13
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 14:57:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 18 May 2018 14:57:31 -0700
Message-Id: <20180518215734.18833-6-richard.henderson@linaro.org>
In-Reply-To: <20180518215734.18833-1-richard.henderson@linaro.org>
References: <20180518215734.18833-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 5/8] target/s390x: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alexander Graf <agraf@suse.de>

Also do not dump both "fpu" and "vector" registers
as the former overlaps the latter.

Cc: Alexander Graf <agraf@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
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
