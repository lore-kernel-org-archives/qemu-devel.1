Received: from eggs.gnu.org ([2001:4830:134:3::10]:41053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9wp5-0005Iq-8G
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9wp4-0000vA-Jy
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:33:35 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9wp0-0000nU-4I
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:33:31 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Oct 2018 19:33:14 +0100
Message-Id: <20181009183314.13416-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/i386: Remove #ifdeffed-out icebp
 debugging hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Remove a debugging hack which could be used to cause the
undocumented 'icebp' instruction to enable QEMU internal
debug logging. This code has always been #ifdeffed out
since it was introduced in commit aba9d61e34b9 in 2005;
judging by the rest of that commit (which is entirely
unrelated) it may have even been committed by accident.

(Note that WANT_ICEBP is not defined by default anyway.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Mostly I wanted to get rid of the weird call to tb_flush(),
which is a bit unexpected to find in target frontend code.

 target/i386/translate.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 83c1ebe4917..f8bc7680af5 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -7028,13 +7028,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 #ifdef WANT_ICEBP
     case 0xf1: /* icebp (undocumented, exits to external debugger) */
         gen_svm_check_intercept(s, pc_start, SVM_EXIT_ICEBP);
-#if 1
         gen_debug(s, pc_start - s->cs_base);
-#else
-        /* start debug */
-        tb_flush(CPU(x86_env_get_cpu(env)));
-        qemu_set_log(CPU_LOG_INT | CPU_LOG_TB_IN_ASM);
-#endif
         break;
 #endif
     case 0xfa: /* cli */
-- 
2.19.0
