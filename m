Received: from eggs.gnu.org ([2001:4830:134:3::10]:36785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fC9xy-00040O-Gf
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 16:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fC9xx-0007EK-KJ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 16:27:38 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:39901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fC9xx-0007Db-CO
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 16:27:37 -0400
Received: by mail-lf0-x241.google.com with SMTP id j193-v6so4410938lfg.6
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 13:27:37 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 27 Apr 2018 13:27:23 -0700
Message-Id: <20180427202723.16137-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: check zero overhead loop
 alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

ISA book documents that the first instruction of zero overhead loop
must fit completely into naturally aligned region of an instruction
fetch unit size. Check that condition and log a message if it's
violated.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h          | 1 +
 target/xtensa/overlay_tool.h | 1 +
 target/xtensa/translate.c    | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index e9d2e109f790..51b455146494 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -369,6 +369,7 @@ struct XtensaConfig {
     unsigned nareg;
     int excm_level;
     int ndepc;
+    unsigned inst_fetch_width;
     uint32_t vecbase;
     uint32_t exception_vector[EXC_MAX];
     unsigned ninterrupt;
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index b24ad11fec1c..ee37a04a176c 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -456,6 +456,7 @@
     .options = XTENSA_OPTIONS, \
     .nareg = XCHAL_NUM_AREGS, \
     .ndepc = (XCHAL_XEA_VERSION >= 2), \
+    .inst_fetch_width = XCHAL_INST_FETCH_WIDTH, \
     EXCEPTIONS_SECTION, \
     INTERRUPTS_SECTION, \
     TLB_SECTION, \
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4f6d03059feb..f8331f7104dc 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -970,6 +970,13 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     }
 
     dc->next_pc = dc->pc + len;
+    if (xtensa_option_enabled(dc->config, XTENSA_OPTION_LOOP) &&
+        dc->lbeg == dc->pc &&
+        ((dc->pc ^ (dc->next_pc - 1)) & -dc->config->inst_fetch_width)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "unaligned first instruction of a loop (pc = %08x)\n",
+                      dc->pc);
+    }
     for (i = 1; i < len; ++i) {
         b[i] = cpu_ldub_code(env, dc->pc + i);
     }
-- 
2.11.0
