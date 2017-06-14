Received: from eggs.gnu.org ([2001:4830:134:3::10]:45038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0m9-0001u1-Vr
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0m8-0007Mp-F5
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:30 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dL0m8-0007MV-BC
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:28 -0400
Received: by mail-qt0-x242.google.com with SMTP id s33so39071569qtg.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 22:23:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 13 Jun 2017 22:23:10 -0700
Message-Id: <20170614052311.13785-10-rth@twiddle.net>
In-Reply-To: <20170614052311.13785-1-rth@twiddle.net>
References: <20170614052311.13785-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 09/10] Revert "target/aarch64: optimize indirect
 branches"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This reverts commit e75449a346bf558296966a44277bfd93412c6da6.

This patch appears to induce lockups, or maybe livelocks, while
booting a Linux kernel.  The assumption is that there is a bug
elsewhere within QEMU, but reverting the patch allows normal work
to continue in the meantime.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 860e279..ab61d96 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11367,7 +11367,8 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
             gen_a64_set_pc_im(dc->pc);
             /* fall through */
         case DISAS_JUMP:
-            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            /* indicate that the hash table must be used to find the next TB */
+            tcg_gen_exit_tb(0);
             break;
         case DISAS_TB_JUMP:
         case DISAS_EXC:
-- 
2.9.4
