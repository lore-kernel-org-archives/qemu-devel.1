Received: from eggs.gnu.org ([2001:4830:134:3::10]:47316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeeo-0000mL-An
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeej-0006r1-OX
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gHeej-0006de-G7
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:45 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:45:45 -0300
Message-Id: <20181031004550.15410-3-ehabkost@redhat.com>
In-Reply-To: <20181031004550.15410-1-ehabkost@redhat.com>
References: <20181031004550.15410-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] target/i386: Remove #ifdeffed-out icebp
 debugging hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

Remove a debugging hack which could be used to cause the
undocumented 'icebp' instruction to enable QEMU internal
debug logging. This code has always been #ifdeffed out
since it was introduced in commit aba9d61e34b9 in 2005;
judging by the rest of that commit (which is entirely
unrelated) it may have even been committed by accident.

(Note that WANT_ICEBP is not defined by default anyway.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20181009183314.13416-1-peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/translate.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 83c1ebe491..f8bc7680af 100644
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
2.18.0.rc1.1.g3f1ff2140
