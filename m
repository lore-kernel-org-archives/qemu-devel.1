Received: from eggs.gnu.org ([2001:4830:134:3::10]:55909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWX-00078t-3D
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWW-00065O-1a
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:33 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWV-00063z-S0
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:31 -0500
Received: by mail-pg0-x241.google.com with SMTP id n5so2483951pgh.3
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:31 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:35 -0800
Message-Id: <20161224040042.12654-59-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 58/65] target-sparc: Use ctpop helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/helper.c    | 5 -----
 target/sparc/helper.h    | 1 -
 target/sparc/translate.c | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 359b0b1..1d85489 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -49,11 +49,6 @@ void helper_debug(CPUSPARCState *env)
 }
 
 #ifdef TARGET_SPARC64
-target_ulong helper_popc(target_ulong val)
-{
-    return ctpop64(val);
-}
-
 void helper_tick_set_count(void *opaque, uint64_t count)
 {
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 0cf1bfb..3ef38b9 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -16,7 +16,6 @@ DEF_HELPER_2(wrccr, void, env, tl)
 DEF_HELPER_1(rdcwp, tl, env)
 DEF_HELPER_2(wrcwp, void, env, tl)
 DEF_HELPER_FLAGS_2(array8, TCG_CALL_NO_RWG_SE, tl, tl, tl)
-DEF_HELPER_FLAGS_1(popc, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(set_softint, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_2(clear_softint, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_2(write_softint, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2205f89..ead585e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4647,7 +4647,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         gen_store_gpr(dc, rd, cpu_dst);
                         break;
                     case 0x2e: /* V9 popc */
-                        gen_helper_popc(cpu_dst, cpu_src2);
+                        tcg_gen_ctpop_tl(cpu_dst, cpu_src2);
                         gen_store_gpr(dc, rd, cpu_dst);
                         break;
                     case 0x2f: /* V9 movr */
-- 
2.9.3
