Received: from eggs.gnu.org ([2001:4830:134:3::10]:55557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWF-0006rI-SM
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWE-0005pK-Sj
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:15 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWE-0005p1-Ne
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:14 -0500
Received: by mail-pg0-x244.google.com with SMTP id n5so2483365pgh.3
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:14 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.13 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:13 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:12 -0800
Message-Id: <20161224040042.12654-36-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 35/65] target-tricore: Use clz opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Tested-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/tricore/helper.h    |  2 --
 target/tricore/op_helper.c | 10 ----------
 target/tricore/translate.c |  5 +++--
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 9333e16..2cf04e1 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -87,9 +87,7 @@ DEF_HELPER_FLAGS_2(min_hu, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_2(ixmin, TCG_CALL_NO_RWG_SE, i64, i64, i32)
 DEF_HELPER_FLAGS_2(ixmin_u, TCG_CALL_NO_RWG_SE, i64, i64, i32)
 /* count leading ... */
-DEF_HELPER_FLAGS_1(clo, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(clo_h, TCG_CALL_NO_RWG_SE, i32, i32)
-DEF_HELPER_FLAGS_1(clz, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(clz_h, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(cls, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(cls_h, TCG_CALL_NO_RWG_SE, i32, i32)
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index ac02e0a..3731d5e 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -1733,11 +1733,6 @@ EXTREMA_H_B(min, <)
 
 #undef EXTREMA_H_B
 
-uint32_t helper_clo(target_ulong r1)
-{
-    return clo32(r1);
-}
-
 uint32_t helper_clo_h(target_ulong r1)
 {
     uint32_t ret_hw0 = extract32(r1, 0, 16);
@@ -1756,11 +1751,6 @@ uint32_t helper_clo_h(target_ulong r1)
     return ret_hw0 | (ret_hw1 << 16);
 }
 
-uint32_t helper_clz(target_ulong r1)
-{
-    return clz32(r1);
-}
-
 uint32_t helper_clz_h(target_ulong r1)
 {
     uint32_t ret_hw0 = extract32(r1, 0, 16);
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 36f734a..69cdfb9 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6367,7 +6367,8 @@ static void decode_rr_logical_shift(CPUTriCoreState *env, DisasContext *ctx)
         tcg_gen_andc_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_CLO:
-        gen_helper_clo(cpu_gpr_d[r3], cpu_gpr_d[r1]);
+        tcg_gen_not_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
+        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], TARGET_LONG_BITS);
         break;
     case OPC2_32_RR_CLO_H:
         gen_helper_clo_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
@@ -6379,7 +6380,7 @@ static void decode_rr_logical_shift(CPUTriCoreState *env, DisasContext *ctx)
         gen_helper_cls_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_CLZ:
-        gen_helper_clz(cpu_gpr_d[r3], cpu_gpr_d[r1]);
+        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], TARGET_LONG_BITS);
         break;
     case OPC2_32_RR_CLZ_H:
         gen_helper_clz_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
-- 
2.9.3
