Received: from eggs.gnu.org ([2001:4830:134:3::10]:60234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5J-00045Y-HD
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgvO-0008Nl-Bg
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50781)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgvO-0008Au-1Q
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:50 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:46:37 -0400
Message-Id: <20181025144644.15464-64-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 64/71] sparc: convert to
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Soon we will call cpu_has_work without the BQL.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sparc/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 88427283c1..54bffc1a6c 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -709,6 +709,8 @@ static bool sparc_cpu_has_work(CPUState *cs)
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     return (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(env);
 }
@@ -870,7 +872,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
-    cc->has_work = sparc_cpu_has_work;
+    cc->has_work_with_iothread_lock = sparc_cpu_has_work;
     cc->do_interrupt = sparc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt;
     cc->dump_state = sparc_cpu_dump_state;
-- 
2.17.1
