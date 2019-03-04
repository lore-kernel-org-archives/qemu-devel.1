Received: from eggs.gnu.org ([209.51.188.92]:44393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAY-0008Jb-Vm
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAY-0000xH-4V
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:30 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55543)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sAX-0000wL-VM
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:30 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:18:04 -0500
Message-Id: <20190304181813.8075-65-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v7 64/73] mips: convert to
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
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

Soon we will call cpu_has_work without the BQL.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/mips/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index fdae8cf440..de1eb771fa 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -58,6 +58,8 @@ static bool mips_cpu_has_work(CPUState *cs)
     bool has_work = false;
     uint32_t interrupt_request = cpu_interrupt_request(cs);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     /* Prior to MIPS Release 6 it is implementation dependent if non-enabled
        interrupts wake-up the CPU, however most of the implementations only
        check for interrupts that can be taken. */
@@ -190,7 +192,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->reset = mips_cpu_reset;
 
     cc->class_by_name = mips_cpu_class_by_name;
-    cc->has_work = mips_cpu_has_work;
+    cc->has_work_with_iothread_lock = mips_cpu_has_work;
     cc->do_interrupt = mips_cpu_do_interrupt;
     cc->cpu_exec_interrupt = mips_cpu_exec_interrupt;
     cc->dump_state = mips_cpu_dump_state;
-- 
2.17.1
