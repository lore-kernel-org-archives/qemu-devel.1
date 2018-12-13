Received: from eggs.gnu.org ([2001:4830:134:3::10]:56296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJD0-00082z-R1
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCx-0002Ae-EW
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:50 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCx-0001po-2I
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:47 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:44 -0500
Message-Id: <20181213050453.9677-65-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 64/73] mips: convert to
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

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
