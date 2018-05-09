Received: from eggs.gnu.org ([2001:4830:134:3::10]:47852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJ3-0004SV-O7
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJ2-0005IG-DJ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:13 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJ2-0005Gf-3g
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:12 -0400
Received: by mail-pg0-x242.google.com with SMTP id g20-v6so16326547pgv.1
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:36 -0700
Message-Id: <20180509175458.15642-7-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 06/28] target/tilegx: avoid integer overflow in
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
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tilegx/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index d63bf5bba3..6c53c5e767 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2375,7 +2375,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     DisasContext ctx;
     DisasContext *dc = &ctx;
     uint64_t pc_start = tb->pc;
-    uint64_t next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    uint64_t page_start = pc_start & TARGET_PAGE_MASK;
     int num_insns = 0;
     int max_insns = tb_cflags(tb) & CF_COUNT_MASK;
 
@@ -2415,7 +2415,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         }
         dc->pc += TILEGX_BUNDLE_SIZE_IN_BYTES;
         if (num_insns >= max_insns
-            || dc->pc >= next_page_start
+            || (dc->pc - page_start >= TARGET_PAGE_SIZE)
             || tcg_op_buf_full()) {
             /* Ending the TB due to TB size or page boundary.  Set PC.  */
             tcg_gen_movi_tl(cpu_pc, dc->pc);
-- 
2.17.0
