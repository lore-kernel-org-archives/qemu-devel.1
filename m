Received: from eggs.gnu.org ([2001:4830:134:3::10]:54016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLEHG-00013a-OB
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLEHF-0008UF-ND
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:48:30 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLEHF-0008U5-Iz
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:48:29 -0400
Received: by mail-qt0-x242.google.com with SMTP id x58so2210363qtc.2
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 12:48:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 14 Jun 2017 12:48:19 -0700
Message-Id: <20170614194821.8754-4-rth@twiddle.net>
In-Reply-To: <20170614194821.8754-1-rth@twiddle.net>
References: <20170614194821.8754-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 3/5] target/mips: Exit after enabling
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, cota@braap.org, pbonzini@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Exit to cpu loop so we reevaluate cpu_mips_hw_interrupts.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/mips/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 559f8fe..891f14b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -13403,9 +13403,11 @@ static void gen_pool32axf (CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
                 save_cpu_state(ctx, 1);
                 gen_helper_ei(t0, cpu_env);
                 gen_store_gpr(t0, rs);
-                /* Stop translation as we may have switched the execution mode */
-                ctx->bstate = BS_STOP;
                 tcg_temp_free(t0);
+                /* BS_STOP isn't good enough here;
+                   reevaluate cpu_mips_hw_interrupts_enabled.  */
+                gen_save_pc(ctx->pc + 4);
+                ctx->bstate = BS_EXCP;
             }
             break;
         default:
-- 
2.9.4
