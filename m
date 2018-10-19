Received: from eggs.gnu.org ([2001:4830:134:3::10]:59487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJG4-00058W-3V
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFz-0003am-1g
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:17 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:19 -0400
Message-Id: <20181019010625.25294-51-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 50/56] s390: acquire the BQL in cpu_has_work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org

Soon we will call cpu_has_work without the BQL.

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/s390x/cpu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 1f91df57bc..64c10ad115 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "internal.h"
@@ -55,10 +56,12 @@ static void s390_cpu_set_pc(CPUState *cs, vaddr value)
     cpu->env.psw.addr = value;
 }
 
-static bool s390_cpu_has_work(CPUState *cs)
+static bool s390_cpu_has_work_locked(CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     /* STOPPED cpus can never wake up */
     if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
         s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
@@ -72,6 +75,21 @@ static bool s390_cpu_has_work(CPUState *cs)
     return s390_cpu_has_int(cpu);
 }
 
+static bool s390_cpu_has_work(CPUState *cs)
+{
+    if (!qemu_mutex_iothread_locked()) {
+        bool ret;
+
+        cpu_mutex_unlock(cs);
+        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cs);
+        ret = s390_cpu_has_work_locked(cs);
+        qemu_mutex_unlock_iothread();
+        return ret;
+    }
+    return s390_cpu_has_work_locked(cs);
+}
+
 #if !defined(CONFIG_USER_ONLY)
 /* S390CPUClass::load_normal() */
 static void s390_cpu_load_normal(CPUState *s)
-- 
2.17.1
