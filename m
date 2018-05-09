Received: from eggs.gnu.org ([2001:4830:134:3::10]:48007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJ8-0004fj-It
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJ5-0005OU-P9
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:18 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:45812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJ5-0005NK-IA
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:15 -0400
Received: by mail-pg0-x244.google.com with SMTP id w3-v6so2473370pgv.12
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:38 -0700
Message-Id: <20180509175458.15642-9-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 08/28] target/arm: avoid integer overflow in
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h |  2 +-
 target/arm/translate.c | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 4428c98e2e..37a1bba056 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -9,7 +9,7 @@ typedef struct DisasContext {
     DisasContextBase base;
 
     target_ulong pc;
-    target_ulong next_page_start;
+    target_ulong page_start;
     uint32_t insn;
     /* Nonzero if this instruction has been conditionally skipped.  */
     int condjmp;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ad208867a7..0f6629f745 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9930,7 +9930,7 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t insn)
         return false;
     }
 
-    if ((insn >> 11) == 0x1e && (s->pc < s->next_page_start - 3)) {
+    if ((insn >> 11) == 0x1e && s->pc - s->page_start < TARGET_PAGE_SIZE - 3) {
         /* 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix, and the suffix
          * is not on the next page; we merge this into a 32-bit
          * insn.
@@ -12301,8 +12301,7 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
     dc->is_ldex = false;
     dc->ss_same_el = false; /* Can't be true since EL_d must be AArch64 */
 
-    dc->next_page_start =
-        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    dc->page_start = dc->base.pc_first & TARGET_PAGE_MASK;
 
     /* If architectural single step active, limit to 1.  */
     if (is_singlestepping(dc)) {
@@ -12312,7 +12311,7 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
     /* ARM is a fixed-length ISA.  Bound the number of insns to execute
        to those left on the page.  */
     if (!dc->thumb) {
-        int bound = (dc->next_page_start - dc->base.pc_first) / 4;
+        int bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
         max_insns = MIN(max_insns, bound);
     }
 
@@ -12584,8 +12583,8 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
      * but isn't very efficient).
      */
     if (dc->base.is_jmp == DISAS_NEXT
-        && (dc->pc >= dc->next_page_start
-            || (dc->pc >= dc->next_page_start - 3
+        && (dc->pc - dc->page_start >= TARGET_PAGE_SIZE
+            || (dc->pc - dc->page_start >= TARGET_PAGE_SIZE - 3
                 && insn_crosses_page(env, dc)))) {
         dc->base.is_jmp = DISAS_TOO_MANY;
     }
-- 
2.17.0
