Received: from eggs.gnu.org ([2001:4830:134:3::10]:47305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2VY-0005jY-2Y
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2VX-0001O9-7Z
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:12 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dJ2VX-0001Nh-1N
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:11 -0400
Received: by mail-wm0-x244.google.com with SMTP id d17so3821285wme.3
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 11:50:10 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu,  8 Jun 2017 21:49:40 +0300
Message-Id: <20170608184944.19406-6-mrolnik@gmail.com>
In-Reply-To: <20170608184944.19406-1-mrolnik@gmail.com>
References: <20170608184944.19406-1-mrolnik@gmail.com>
Subject: [Qemu-devel] [PATCH RFC v19 05/13] target-avr: adding AVR interrupt
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anichang@protonmail.ch, Michael Rolnik <mrolnik@gmail.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <1471522070-77598-6-git-send-email-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/avr/helper.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index c1871939b3..61255fdff3 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -32,11 +32,66 @@
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     bool ret = false;
+    CPUClass *cc = CPU_GET_CLASS(cs);
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    if (interrupt_request & CPU_INTERRUPT_RESET) {
+        if (cpu_interrupts_enabled(env)) {
+            cs->exception_index = EXCP_RESET;
+            cc->do_interrupt(cs);
+
+            cs->interrupt_request &= ~CPU_INTERRUPT_RESET;
+
+            ret = true;
+        }
+    }
+    if (interrupt_request & CPU_INTERRUPT_HARD) {
+        if (cpu_interrupts_enabled(env) && env->intsrc != 0) {
+            int index = ctz32(env->intsrc);
+            cs->exception_index = EXCP_INT(index);
+            cc->do_interrupt(cs);
+
+            env->intsrc &= env->intsrc - 1; /* clear the interrupt */
+            cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+
+            ret = true;
+        }
+    }
     return ret;
 }
 
 void avr_cpu_do_interrupt(CPUState *cs)
 {
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    uint32_t ret = env->pc_w;
+    int vector = 0;
+    int size = avr_feature(env, AVR_FEATURE_JMP_CALL) ? 2 : 1;
+    int base = 0; /* TODO: where to get it */
+
+    if (cs->exception_index == EXCP_RESET) {
+        vector = 0;
+    } else if (env->intsrc != 0) {
+        vector = ctz32(env->intsrc) + 1;
+    }
+
+    if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
+        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
+        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >>  8);
+        cpu_stb_data(env, env->sp--, (ret & 0xff0000) >> 16);
+    } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
+        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
+        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >>  8);
+    } else {
+        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
+    }
+
+    env->pc_w = base + vector * size;
+    env->sregI = 0; /* clear Global Interrupt Flag */
+
+    cs->exception_index = -1;
 }
 
 int avr_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,
-- 
2.11.0 (Apple Git-81)
