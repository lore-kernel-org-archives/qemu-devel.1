Received: from eggs.gnu.org ([2001:4830:134:3::10]:55537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWE-0006rH-Ro
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWE-0005or-4P
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:14 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWD-0005od-Ve
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:14 -0500
Received: by mail-pg0-x241.google.com with SMTP id n5so2483343pgh.3
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:13 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.12 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:12 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:11 -0800
Message-Id: <20161224040042.12654-35-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 34/65] target-tilegx: Use clz and ctz opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/tilegx/helper.c    | 10 ----------
 target/tilegx/helper.h    |  2 --
 target/tilegx/translate.c |  4 ++--
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/target/tilegx/helper.c b/target/tilegx/helper.c
index b4fba9c..b6f5e29 100644
--- a/target/tilegx/helper.c
+++ b/target/tilegx/helper.c
@@ -55,16 +55,6 @@ void helper_ext01_ics(CPUTLGState *env)
     }
 }
 
-uint64_t helper_cntlz(uint64_t arg)
-{
-    return clz64(arg);
-}
-
-uint64_t helper_cnttz(uint64_t arg)
-{
-    return ctz64(arg);
-}
-
 uint64_t helper_pcnt(uint64_t arg)
 {
     return ctpop64(arg);
diff --git a/target/tilegx/helper.h b/target/tilegx/helper.h
index 9281d0f..bab303a 100644
--- a/target/tilegx/helper.h
+++ b/target/tilegx/helper.h
@@ -1,7 +1,5 @@
 DEF_HELPER_2(exception, noreturn, env, i32)
 DEF_HELPER_1(ext01_ics, void, env)
-DEF_HELPER_FLAGS_1(cntlz, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_FLAGS_1(cnttz, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(pcnt, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(revbits, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_3(shufflebytes, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index 9c734ee..8a2df1b 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -608,12 +608,12 @@ static TileExcp gen_rr_opcode(DisasContext *dc, unsigned opext,
     switch (opext) {
     case OE_RR_X0(CNTLZ):
     case OE_RR_Y0(CNTLZ):
-        gen_helper_cntlz(tdest, tsrca);
+        tcg_gen_clzi_tl(tdest, tsrca, TARGET_LONG_BITS);
         mnemonic = "cntlz";
         break;
     case OE_RR_X0(CNTTZ):
     case OE_RR_Y0(CNTTZ):
-        gen_helper_cnttz(tdest, tsrca);
+        tcg_gen_ctzi_tl(tdest, tsrca, TARGET_LONG_BITS);
         mnemonic = "cnttz";
         break;
     case OE_RR_X0(FSINGLE_PACK1):
-- 
2.9.3
