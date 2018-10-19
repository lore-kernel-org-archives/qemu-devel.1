Received: from eggs.gnu.org ([2001:4830:134:3::10]:58570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFP-0004UA-LX
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFN-0002nT-59
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:39 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFM-0002jW-GS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:37 -0400
Message-Id: <20181019010625.25294-9-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 08/56] cpu: define cpu_halted helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

cpu->halted will soon be protected by cpu->lock.
We will use these helpers to ease the transition,
since right now cpu->halted has many direct callers.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 30d1c260dc..3bf6767cb0 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -480,6 +480,30 @@ void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line);
  */
 bool cpu_mutex_locked(const CPUState *cpu);
 
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
