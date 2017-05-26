Received: from eggs.gnu.org ([2001:4830:134:3::10]:40765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbk-0000wu-Nj
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbj-0008RX-S5
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:16 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEMbj-0008RS-Nh
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:15 -0400
Received: by mail-qk0-x243.google.com with SMTP id o85so2669601qkh.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 14:17:15 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	u19sm1262380qtc.64.2017.05.26.14.17.13 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 May 2017 14:17:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 26 May 2017 14:16:37 -0700
Message-Id: <20170526211638.32301-26-rth@twiddle.net>
In-Reply-To: <20170526211638.32301-1-rth@twiddle.net>
References: <20170526211638.32301-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v7 25/26] target/alpha: Implement WTINT inline
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
 target/alpha/translate.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index df5d695..4523c4c 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1157,6 +1157,7 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
 #ifndef CONFIG_USER_ONLY
     /* Privileged PAL code */
     if (palcode < 0x40 && (ctx->tb->flags & TB_FLAGS_USER_MODE) == 0) {
+        TCGv tmp;
         switch (palcode) {
         case 0x01:
             /* CFLUSH */
@@ -1182,10 +1183,8 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
                            offsetof(CPUAlphaState, sysval));
             break;
 
-        case 0x35: {
+        case 0x35:
             /* SWPIPL */
-            TCGv tmp;
-
             /* Note that we already know we're in kernel mode, so we know
                that PS only contains the 3 IPL bits.  */
             tcg_gen_ld8u_i64(ctx->ir[IR_V0], cpu_env,
@@ -1197,7 +1196,6 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
             tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, ps));
             tcg_temp_free(tmp);
             break;
-        }
 
         case 0x36:
             /* RDPS */
@@ -1220,6 +1218,14 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
                 -offsetof(AlphaCPU, env) + offsetof(CPUState, cpu_index));
             break;
 
+        case 0x3E:
+            /* WTINT */
+            tmp = tcg_const_i64(1);
+            tcg_gen_st32_i64(tmp, cpu_env, -offsetof(AlphaCPU, env) +
+                                           offsetof(CPUState, halted));
+            tcg_gen_movi_i64(ctx->ir[IR_V0], 0);
+            return gen_excp(ctx, EXCP_HALTED, 0);
+
         default:
             palcode &= 0x3f;
             goto do_call_pal;
@@ -1369,7 +1375,7 @@ static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
         tmp = tcg_const_i64(1);
         tcg_gen_st32_i64(tmp, cpu_env, -offsetof(AlphaCPU, env) +
                                        offsetof(CPUState, halted));
-        return gen_excp(ctx, EXCP_HLT, 0);
+        return gen_excp(ctx, EXCP_HALTED, 0);
 
     case 252:
         /* HALT */
-- 
2.9.4
