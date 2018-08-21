Received: from eggs.gnu.org ([2001:4830:134:3::10]:33706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4n-0002IG-RR
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4Y-0006se-Iq
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:11 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4X-0006p8-Lh
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:02 -0400
Received: by mail-wm0-x243.google.com with SMTP id s9-v6so3626333wmh.3
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:01 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-184-244.clienti.tiscali.it.
	[78.12.184.244]) by smtp.gmail.com with ESMTPSA id
	v6-v6sm2608955wmc.43.2018.08.21.10.03.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Aug 2018 10:03:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:25 +0200
Message-Id: <1534870966-9287-54-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 53/74] cpus: allow cpu_get_ticks out of BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Because of cpu_ticks_prev, we cannot use a seqlock.  But then the conversion
is even easier. :)

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/cpus.c b/cpus.c
index a810a95..8ee6e5d 100644
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
1.8.3.1
