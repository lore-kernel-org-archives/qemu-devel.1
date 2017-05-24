Received: from eggs.gnu.org ([2001:4830:134:3::10]:45394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsJ-0001vw-Fu
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsI-0001GS-Lq
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:15 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDbsI-0001GN-Hd
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:14 -0400
Received: by mail-qt0-x243.google.com with SMTP id j13so27554267qta.3
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:23:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 12:22:30 -0700
Message-Id: <20170524192246.15905-18-rth@twiddle.net>
In-Reply-To: <20170524192246.15905-1-rth@twiddle.net>
References: <20170524192246.15905-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 17/33] target/s390x: Use unwind data for
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
Cc: thuth@redhat.com, aurelien@aurel32.net

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
