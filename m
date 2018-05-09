Received: from eggs.gnu.org ([2001:4830:134:3::10]:48443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJN-0005Cu-5E
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJK-0005rD-IH
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:32 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJK-0005py-5V
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:30 -0400
Received: by mail-pf0-x242.google.com with SMTP id w129so20577734pfd.3
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:46 -0700
Message-Id: <20180509175458.15642-17-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 16/28] target/mips: use lookup_and_goto_ptr on
 BS_STOP
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

The TB after BS_STOP is not fixed (e.g. helper_mtc0_hwrena
changes hflags, which ends up changing the TB flags via
cpu_get_tb_cpu_state). This requires a full lookup (i.e.
with flags) via lookup_and_goto_ptr instead of gen_goto_tb,
since the latter only looks at the PC for in-page goto's. Fix it.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d8e717dacf..69137d0b3f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20343,7 +20343,8 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     } else {
         switch (ctx.bstate) {
         case BS_STOP:
-            gen_goto_tb(&ctx, 0, ctx.pc);
+            gen_save_pc(ctx.pc);
+            tcg_gen_lookup_and_goto_ptr();
             break;
         case BS_NONE:
             save_cpu_state(&ctx, 0);
-- 
2.17.0
