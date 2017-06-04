Received: from eggs.gnu.org ([2001:4830:134:3::10]:50127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRD-0007Q9-8o
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRC-00030T-Bo
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:39 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRC-0002zI-6G
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:38 -0400
Received: by mail-pg0-x244.google.com with SMTP id v14so3629422pgn.1
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:18 -0700
Message-Id: <20170604173509.29684-19-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 18/69] target/s390x: Use unwind data for
 helper_clcle
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
 target/s390x/mem_helper.c | 6 +++---
 target/s390x/translate.c  | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 8a095ad..f5a3044 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -595,12 +595,12 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
 uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
                        uint32_t r3)
 {
+    uintptr_t ra = GETPC();
     uint64_t destlen = env->regs[r1 + 1];
     uint64_t dest = get_address_31fix(env, r1);
     uint64_t srclen = env->regs[r3 + 1];
     uint64_t src = get_address_31fix(env, r3);
     uint8_t pad = a2 & 0xff;
-    uint8_t v1 = 0, v2 = 0;
     uint32_t cc = 0;
 
     if (!(destlen || srclen)) {
@@ -612,8 +612,8 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     }
 
     for (; destlen || srclen; src++, dest++, destlen--, srclen--) {
-        v1 = srclen ? cpu_ldub_data(env, src) : pad;
-        v2 = destlen ? cpu_ldub_data(env, dest) : pad;
+        uint8_t v1 = srclen ? cpu_ldub_data_ra(env, src, ra) : pad;
+        uint8_t v2 = destlen ? cpu_ldub_data_ra(env, dest, ra) : pad;
         if (v1 != v2) {
             cc = (v1 < v2) ? 1 : 2;
             break;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b42acae..9270067 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1915,7 +1915,6 @@ static ExitStatus op_clcle(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    potential_page_fault(s);
     gen_helper_clcle(cc_op, cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-- 
2.9.4
