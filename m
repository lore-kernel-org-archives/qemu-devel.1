Received: from eggs.gnu.org ([2001:4830:134:3::10]:55912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWX-000797-92
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWW-00065i-K2
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:33 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWW-00064n-FB
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:32 -0500
Received: by mail-pf0-x243.google.com with SMTP id i88so14544325pfk.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:32 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.30 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:30 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:36 -0800
Message-Id: <20161224040042.12654-60-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 59/65] target-tilegx: Use ctpop helper
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
 target/tilegx/helper.c    | 5 -----
 target/tilegx/helper.h    | 1 -
 target/tilegx/translate.c | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/tilegx/helper.c b/target/tilegx/helper.c
index b6f5e29..4964bb9 100644
--- a/target/tilegx/helper.c
+++ b/target/tilegx/helper.c
@@ -55,11 +55,6 @@ void helper_ext01_ics(CPUTLGState *env)
     }
 }
 
-uint64_t helper_pcnt(uint64_t arg)
-{
-    return ctpop64(arg);
-}
-
 uint64_t helper_revbits(uint64_t arg)
 {
     return revbit64(arg);
diff --git a/target/tilegx/helper.h b/target/tilegx/helper.h
index bab303a..16745c2 100644
--- a/target/tilegx/helper.h
+++ b/target/tilegx/helper.h
@@ -1,6 +1,5 @@
 DEF_HELPER_2(exception, noreturn, env, i32)
 DEF_HELPER_1(ext01_ics, void, env)
-DEF_HELPER_FLAGS_1(pcnt, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(revbits, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_3(shufflebytes, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(crc32_8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index 8a2df1b..ff2ef7b 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -697,7 +697,7 @@ static TileExcp gen_rr_opcode(DisasContext *dc, unsigned opext,
         break;
     case OE_RR_X0(PCNT):
     case OE_RR_Y0(PCNT):
-        gen_helper_pcnt(tdest, tsrca);
+        tcg_gen_ctpop_tl(tdest, tsrca);
         mnemonic = "pcnt";
         break;
     case OE_RR_X0(REVBITS):
-- 
2.9.3
