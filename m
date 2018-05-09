Received: from eggs.gnu.org ([2001:4830:134:3::10]:48170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJD-0004xg-Hc
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJ9-0005Wx-8V
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:23 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:45813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJ8-0005Uk-Th
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:19 -0400
Received: by mail-pg0-x244.google.com with SMTP id w3-v6so2473432pgv.12
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:40 -0700
Message-Id: <20180509175458.15642-11-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 10/28] target/mips: avoid integer overflow in
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
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d05ee67e63..d8e717dacf 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20202,14 +20202,14 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     CPUMIPSState *env = cs->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
-    target_ulong next_page_start;
+    target_ulong page_start;
     int num_insns;
     int max_insns;
     int insn_bytes;
     int is_slot;
 
     pc_start = tb->pc;
-    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    page_start = pc_start & TARGET_PAGE_MASK;
     ctx.pc = pc_start;
     ctx.saved_pc = -1;
     ctx.singlestep_enabled = cs->singlestep_enabled;
@@ -20320,7 +20320,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             break;
         }
 
-        if (ctx.pc >= next_page_start) {
+        if (ctx.pc - page_start >= TARGET_PAGE_SIZE) {
             break;
         }
 
-- 
2.17.0
