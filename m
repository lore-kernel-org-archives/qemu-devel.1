Received: from eggs.gnu.org ([209.51.188.92]:44431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAZ-0008KP-OB
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAY-000102-TL
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:31 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sAY-0000fj-JC
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:30 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:17:15 -0500
Message-Id: <20190304181813.8075-16-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 15/73] cpu: define cpu_halted helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

cpu->halted will soon be protected by cpu->lock.
We will use these helpers to ease the transition,
since right now cpu->halted has many direct callers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index d826a2852e..9fe74e4392 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -502,6 +502,30 @@ bool cpu_mutex_locked(const CPUState *cpu);
  */
 bool no_cpu_mutex_locked(void);
 
+static inline uint32_t cpu_halted(CPUState *cpu)
+{
+    uint32_t ret;
+
+    if (cpu_mutex_locked(cpu)) {
+        return cpu->halted;
+    }
+    cpu_mutex_lock(cpu);
+    ret = cpu->halted;
+    cpu_mutex_unlock(cpu);
+    return ret;
+}
+
+static inline void cpu_halted_set(CPUState *cpu, uint32_t val)
+{
+    if (cpu_mutex_locked(cpu)) {
+        cpu->halted = val;
+        return;
+    }
+    cpu_mutex_lock(cpu);
+    cpu->halted = val;
+    cpu_mutex_unlock(cpu);
+}
+
 static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
 {
     unsigned int i;
-- 
2.17.1
