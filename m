Received: from eggs.gnu.org ([2001:4830:134:3::10]:33236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4u0-0000Pv-RE
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4tv-0004wA-Tr
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:08 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4tv-0004rO-Gw
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:03 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:14 -0500
Message-Id: <20181209193749.12277-4-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC v2 03/38] cpu: introduce
 cpu_in_exclusive_work_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 13 +++++++++++++
 cpus-common.c     |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 772cc960fe..fab18089db 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -349,6 +349,7 @@ struct CPUState {
     bool thread_kicked;
     bool crash_occurred;
     bool exit_request;
+    bool in_exclusive_work_context;
     uint32_t cflags_next_tb;
     /* updates protected by BQL */
     uint32_t interrupt_request;
@@ -913,6 +914,18 @@ void async_run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
  */
 void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
 
+/**
+ * cpu_in_exclusive_work_context()
+ * @cpu: The vCPU to check
+ *
+ * Returns true if @cpu is an exclusive work context, which has
+ * previously been queued via async_safe_run_on_cpu().
+ */
+static inline bool cpu_in_exclusive_work_context(const CPUState *cpu)
+{
+    return cpu->in_exclusive_work_context;
+}
+
 /**
  * qemu_get_cpu:
  * @index: The CPUState@cpu_index value of the CPU to obtain.
diff --git a/cpus-common.c b/cpus-common.c
index 232cb12c46..d6ea42c80c 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -370,7 +370,9 @@ static void process_queued_cpu_work_locked(CPUState *cpu)
                 qemu_mutex_unlock_iothread();
             }
             start_exclusive();
+            cpu->in_exclusive_work_context = true;
             wi->func(cpu, wi->data);
+            cpu->in_exclusive_work_context = false;
             end_exclusive();
             if (has_bql) {
                 qemu_mutex_lock_iothread();
-- 
2.17.1
