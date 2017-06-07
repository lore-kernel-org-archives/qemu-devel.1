Received: from eggs.gnu.org ([2001:4830:134:3::10]:33550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOss-0002Pt-TM
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOsr-0001qk-Tk
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:38 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOsr-0001qg-Pz
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:37 -0400
Received: by mail-qk0-x241.google.com with SMTP id y201so11027924qka.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:31:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:18 -0700
Message-Id: <20170607003119.14778-10-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 09/70] target/s390x: Use unwind data for
 helper_clm
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
 target/s390x/mem_helper.c | 11 ++++++-----
 target/s390x/translate.c  |  1 -
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 50689bb..3e75cae 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -268,16 +268,16 @@ uint32_t HELPER(clc)(CPUS390XState *env, uint32_t l, uint64_t s1, uint64_t s2)
 uint32_t HELPER(clm)(CPUS390XState *env, uint32_t r1, uint32_t mask,
                      uint64_t addr)
 {
-    uint8_t r, d;
-    uint32_t cc;
+    uintptr_t ra = GETPC();
+    uint32_t cc = 0;
 
     HELPER_LOG("%s: r1 0x%x mask 0x%x addr 0x%" PRIx64 "\n", __func__, r1,
                mask, addr);
-    cc = 0;
+
     while (mask) {
         if (mask & 8) {
-            d = cpu_ldub_data(env, addr);
-            r = (r1 & 0xff000000UL) >> 24;
+            uint8_t d = cpu_ldub_data_ra(env, addr, ra);
+            uint8_t r = extract32(r1, 24, 8);
             HELPER_LOG("mask 0x%x %02x/%02x (0x%" PRIx64 ") ", mask, r, d,
                        addr);
             if (r < d) {
@@ -292,6 +292,7 @@ uint32_t HELPER(clm)(CPUS390XState *env, uint32_t r1, uint32_t mask,
         mask = (mask << 1) & 0xf;
         r1 <<= 8;
     }
+
     HELPER_LOG("\n");
     return cc;
 }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index c47b818..d4c5fa3 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1933,7 +1933,6 @@ static ExitStatus op_clm(DisasContext *s, DisasOps *o)
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
     TCGv_i32 t1 = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(t1, o->in1);
-    potential_page_fault(s);
     gen_helper_clm(cc_op, cpu_env, t1, m3, o->in2);
     set_cc_static(s);
     tcg_temp_free_i32(t1);
-- 
2.9.4
