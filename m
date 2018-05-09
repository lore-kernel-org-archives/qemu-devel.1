Received: from eggs.gnu.org ([2001:4830:134:3::10]:47761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJ1-0004Pu-Vn
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTIz-0005C0-2m
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:11 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTIy-0005Af-QV
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:08 -0400
Received: by mail-pf0-x244.google.com with SMTP id c10so25989251pfi.12
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:34 -0700
Message-Id: <20180509175458.15642-5-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 04/28] target/xtensa: avoid integer overflow in
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
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4f6d03059f..aad496347d 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1061,8 +1061,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     int insn_count = 0;
     int max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     uint32_t pc_start = tb->pc;
-    uint32_t next_page_start =
-        (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    uint32_t page_start = pc_start & TARGET_PAGE_MASK;
 
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
@@ -1162,9 +1161,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         }
     } while (dc.is_jmp == DISAS_NEXT &&
             insn_count < max_insns &&
-            dc.pc < next_page_start &&
-            dc.pc + xtensa_insn_len(env, &dc) <= next_page_start &&
-            !tcg_op_buf_full());
+            dc.pc - page_start < TARGET_PAGE_SIZE &&
+            dc.pc - page_start + xtensa_insn_len(env, &dc) <= TARGET_PAGE_SIZE
+            && !tcg_op_buf_full());
 done:
     reset_sar_tracker(&dc);
     if (dc.icount) {
-- 
2.17.0
