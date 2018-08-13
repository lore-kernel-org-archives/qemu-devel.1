Received: from eggs.gnu.org ([2001:4830:134:3::10]:43320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpFs7-0004kP-VB
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpFs3-00011k-0y
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:39:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 13 Aug 2018 12:38:57 -0400
Message-Id: <20180813163859.17964-2-cota@braap.org>
In-Reply-To: <20180813163859.17964-1-cota@braap.org>
References: <20180813163859.17964-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 1/3] qom: use cpu->in_cpu_list instead of
 QTAILQ_IN_USE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

This paves the way for implementing the CPU list with an RCU QLIST.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus-common.c     | 3 ++-
 include/qom/cpu.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/cpus-common.c b/cpus-common.c
index 59f751ecf9..6eaedae60b 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -85,6 +85,7 @@ void cpu_list_add(CPUState *cpu)
         assert(!cpu_index_auto_assigned);
     }
     QTAILQ_INSERT_TAIL(&cpus, cpu, node);
+    cpu->in_cpu_list = true;
     qemu_mutex_unlock(&qemu_cpu_list_lock);
 
     finish_safe_work(cpu);
@@ -93,7 +94,7 @@ void cpu_list_add(CPUState *cpu)
 void cpu_list_remove(CPUState *cpu)
 {
     qemu_mutex_lock(&qemu_cpu_list_lock);
-    if (!QTAILQ_IN_USE(cpu, node)) {
+    if (!cpu->in_cpu_list) {
         /* there is nothing to undo since cpu_exec_init() hasn't been called */
         qemu_mutex_unlock(&qemu_cpu_list_lock);
         return;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index bd796579ee..aa555e27a7 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -411,6 +411,8 @@ struct CPUState {
 
     bool ignore_memory_transaction_failures;
 
+    bool in_cpu_list; /* protected by qemu_cpu_list_lock */
+
     /* Note that this is accessed at the start of every TB via a negative
        offset from AREG0.  Leave this field at the end so as to make the
        (absolute value) offset as small as possible.  This reduces code
-- 
2.17.1
