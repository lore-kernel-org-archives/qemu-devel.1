Received: from eggs.gnu.org ([2001:4830:134:3::10]:47685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJ0-0004Pn-49
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTIx-00059F-Ab
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:10 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTIx-00057P-2h
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:07 -0400
Received: by mail-pg0-x244.google.com with SMTP id n9-v6so23007485pgq.5
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:33 -0700
Message-Id: <20180509175458.15642-4-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 03/28] target/lm32: avoid integer overflow in
 next_page PC check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>, Michael Clark <mjc@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, qemu-s390x@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

If the PC is in the last page of the address space, next_page_start
overflows to 0. Fix it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Michael Walle <michael@walle.cc>
Cc: Michael Walle <michael@walle.cc>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/lm32/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 2e1c5e6d01..fdd206a860 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1055,7 +1055,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     LM32CPU *cpu = lm32_env_get_cpu(env);
     struct DisasContext ctx, *dc = &ctx;
     uint32_t pc_start;
-    uint32_t next_page_start;
+    uint32_t page_start;
     int num_insns;
     int max_insns;
 
@@ -1075,7 +1075,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         pc_start &= ~3;
     }
 
-    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    page_start = pc_start & TARGET_PAGE_MASK;
     num_insns = 0;
     max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
@@ -1115,7 +1115,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
          && !tcg_op_buf_full()
          && !cs->singlestep_enabled
          && !singlestep
-         && (dc->pc < next_page_start)
+         && (dc->pc - page_start < TARGET_PAGE_SIZE)
          && num_insns < max_insns);
 
     if (tb_cflags(tb) & CF_LAST_IO) {
-- 
2.17.0
