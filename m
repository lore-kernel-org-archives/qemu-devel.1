Received: from eggs.gnu.org ([209.51.188.92]:35918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe44-0000Lm-0P
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe43-0001Ys-3Q
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:15 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe42-0001E5-Qc
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:14 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:59 -0500
Message-Id: <20190130004811.27372-62-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 61/73] cpu: call .cpu_has_work with the CPU
 lock held
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 4a87c1fef7..96a5d0cb94 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -85,7 +85,8 @@ struct TranslationBlock;
  * @parse_features: Callback to parse command line arguments.
  * @reset: Callback to reset the #CPUState to its initial state.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @has_work: Callback for checking if there is work to do.
+ * @has_work: Callback for checking if there is work to do. Called with the
+ * CPU lock held.
  * @do_interrupt: Callback for interrupt handling.
  * @do_unassigned_access: Callback for unassigned access handling.
  * (this is deprecated: new targets should use do_transaction_failed instead)
@@ -795,9 +796,16 @@ const char *parse_cpu_model(const char *cpu_model);
 static inline bool cpu_has_work(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    bool ret;
 
     g_assert(cc->has_work);
-    return cc->has_work(cpu);
+    if (cpu_mutex_locked(cpu)) {
+        return cc->has_work(cpu);
+    }
+    cpu_mutex_lock(cpu);
+    ret = cc->has_work(cpu);
+    cpu_mutex_unlock(cpu);
+    return ret;
 }
 
 /**
-- 
2.17.1
