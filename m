Received: from eggs.gnu.org ([2001:4830:134:3::10]:50279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRV-0007gq-JP
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRS-0003JC-Sk
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:57 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRS-0003I2-Hh
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:54 -0400
Received: by mail-pf0-x244.google.com with SMTP id w69so18143457pfk.1
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:30 -0700
Message-Id: <20170604173509.29684-31-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 30/69] target/s390x: Use unwind data for
 helper_mvcs/mvcp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 8 ++++++--
 target/s390x/translate.c  | 2 --
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 17d8257..a73d486 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1082,6 +1082,7 @@ uint32_t HELPER(csp)(CPUS390XState *env, uint32_t r1, uint64_t r2)
 
 uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
 {
+    uintptr_t ra = GETPC();
     int cc = 0, i;
 
     HELPER_LOG("%s: %16" PRIx64 " %16" PRIx64 " %16" PRIx64 "\n",
@@ -1095,7 +1096,8 @@ uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
 
     /* XXX replace w/ memcpy */
     for (i = 0; i < l; i++) {
-        cpu_stb_secondary(env, a1 + i, cpu_ldub_primary(env, a2 + i));
+        uint8_t x = cpu_ldub_primary_ra(env, a2 + i, ra);
+        cpu_stb_secondary_ra(env, a1 + i, x, ra);
     }
 
     return cc;
@@ -1103,6 +1105,7 @@ uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
 
 uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
 {
+    uintptr_t ra = GETPC();
     int cc = 0, i;
 
     HELPER_LOG("%s: %16" PRIx64 " %16" PRIx64 " %16" PRIx64 "\n",
@@ -1116,7 +1119,8 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
 
     /* XXX replace w/ memcpy */
     for (i = 0; i < l; i++) {
-        cpu_stb_primary(env, a1 + i, cpu_ldub_secondary(env, a2 + i));
+        uint8_t x = cpu_ldub_secondary_ra(env, a2 + i, ra);
+        cpu_stb_primary_ra(env, a1 + i, x, ra);
     }
 
     return cc;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 141be22..422bbf1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2889,7 +2889,6 @@ static ExitStatus op_mvcp(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, l1);
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_mvcp(cc_op, cpu_env, regs[r1], o->addr1, o->in2);
     set_cc_static(s);
     return NO_EXIT;
@@ -2899,7 +2898,6 @@ static ExitStatus op_mvcs(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, l1);
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_mvcs(cc_op, cpu_env, regs[r1], o->addr1, o->in2);
     set_cc_static(s);
     return NO_EXIT;
-- 
2.9.4
