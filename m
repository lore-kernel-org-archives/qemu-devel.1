Received: from eggs.gnu.org ([2001:4830:134:3::10]:59307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFo-0004t2-BY
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFl-0003Nr-4Q
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35991)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFk-00035X-CS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:00 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:16 -0400
Message-Id: <20181019010625.25294-48-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 47/56] cpu: call .cpu_has_work with the CPU
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
Cc: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index cd66b8828a..ca7d92c360 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -784,9 +784,16 @@ const char *parse_cpu_model(const char *cpu_model);
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
