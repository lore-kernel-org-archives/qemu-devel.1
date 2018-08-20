Received: from eggs.gnu.org ([2001:4830:134:3::10]:38179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frlnx-0006vj-5f
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frlnt-0006BH-2g
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frlnp-00067q-9O
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:10 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 20 Aug 2018 17:09:03 +0200
Message-Id: <20180820150903.1224-5-pbonzini@redhat.com>
In-Reply-To: <20180820150903.1224-1-pbonzini@redhat.com>
References: <20180820150903.1224-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] cpus: allow cpu_get_ticks out of BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>

Because of cpu_ticks_prev, we cannot use a seqlock.  But then the conversion
is even easier. :)

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/cpus.c b/cpus.c
index 63ddd4fd21..7786439362 100644
--- a/cpus.c
+++ b/cpus.c
@@ -316,11 +316,26 @@ int64_t cpu_icount_to_ns(int64_t icount)
     return icount << atomic_read(&timers_state.icount_time_shift);
 }
 
+static int64_t cpu_get_ticks_locked(void)
+{
+    int64_t ticks = timers_state.cpu_ticks_offset;
+    if (timers_state.cpu_ticks_enabled) {
+        ticks += cpu_get_host_ticks();
+    }
+
+    if (timers_state.cpu_ticks_prev > ticks) {
+        /* Non increasing ticks may happen if the host uses software suspend.  */
+        timers_state.cpu_ticks_offset += timers_state.cpu_ticks_prev - ticks;
+        ticks = timers_state.cpu_ticks_prev;
+    }
+
+    timers_state.cpu_ticks_prev = ticks;
+    return ticks;
+}
+
 /* return the time elapsed in VM between vm_start and vm_stop.  Unless
  * icount is active, cpu_get_ticks() uses units of the host CPU cycle
  * counter.
- *
- * Caller must hold the BQL
  */
 int64_t cpu_get_ticks(void)
 {
@@ -330,19 +345,9 @@ int64_t cpu_get_ticks(void)
         return cpu_get_icount();
     }
 
-    ticks = timers_state.cpu_ticks_offset;
-    if (timers_state.cpu_ticks_enabled) {
-        ticks += cpu_get_host_ticks();
-    }
-
-    if (timers_state.cpu_ticks_prev > ticks) {
-        /* Note: non increasing ticks may happen if the host uses
-           software suspend */
-        timers_state.cpu_ticks_offset += timers_state.cpu_ticks_prev - ticks;
-        ticks = timers_state.cpu_ticks_prev;
-    }
-
-    timers_state.cpu_ticks_prev = ticks;
+    qemu_spin_lock(&timers_state.vm_clock_lock);
+    ticks = cpu_get_ticks_locked();
+    qemu_spin_unlock(&timers_state.vm_clock_lock);
     return ticks;
 }
 
-- 
2.17.1
