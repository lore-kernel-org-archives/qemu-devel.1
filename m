Received: from eggs.gnu.org ([2001:4830:134:3::10]:56652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gBhox-0008LX-8h
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gBhot-0002MU-4m
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:56:43 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gBhos-0002BB-RD
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:56:39 -0400
Received: by mail-lj1-x243.google.com with SMTP id r8-v6so15208521ljc.10
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 07:56:38 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Sun, 14 Oct 2018 20:55:07 +0600
Message-Id: <9b0f2ac8f5579c34806276315e32c465c06c5c8e.1539528213.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
References: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
References: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] Revert some patches from recent series
 [PATCH v6] "Fixing record/replay and adding reverse debugging",
 which introduced new virtual clock type for use in external subsystems.
 These changes breaks desired behavior in non-record/replay usage scenarios.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Gerd Hoffmann <kraxel@redhat.com>

This reverts commit 87f4fe7653baf55b5c2f2753fe6003f473c07342.
This reverts commit 775a412bf83f6bc0c5c02091ee06cf649b34c593.
This reverts commit 9888091404a702d7ec79d51b088d994b9fc121bd.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---
 include/qemu/timer.h | 9 ---------
 slirp/ip6_icmp.c     | 7 +++----
 ui/input.c           | 8 ++++----
 util/qemu-timer.c    | 2 --
 4 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index a005ed2..39ea907 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -42,14 +42,6 @@
  * In icount mode, this clock counts nanoseconds while the virtual
  * machine is running.  It is used to increase @QEMU_CLOCK_VIRTUAL
  * while the CPUs are sleeping and thus not executing instructions.
- *
- * @QEMU_CLOCK_VIRTUAL_EXT: virtual clock for external subsystems
- *
- * The virtual clock only runs during the emulation. It stops
- * when the virtual machine is stopped. The timers for this clock
- * do not recorded in rr mode, therefore this clock could be used
- * for the subsystems that operate outside the guest core.
- *
  */
 
 typedef enum {
@@ -57,7 +49,6 @@ typedef enum {
     QEMU_CLOCK_VIRTUAL = 1,
     QEMU_CLOCK_HOST = 2,
     QEMU_CLOCK_VIRTUAL_RT = 3,
-    QEMU_CLOCK_VIRTUAL_EXT = 4,
     QEMU_CLOCK_MAX
 } QEMUClockType;
 
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 3f41187..ee333d0 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -17,7 +17,7 @@ static void ra_timer_handler(void *opaque)
 {
     Slirp *slirp = opaque;
     timer_mod(slirp->ra_timer,
-              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_EXT) + NDP_Interval);
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
     ndp_send_ra(slirp);
 }
 
@@ -27,10 +27,9 @@ void icmp6_init(Slirp *slirp)
         return;
     }
 
-    slirp->ra_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL_EXT,
-                                   ra_timer_handler, slirp);
+    slirp->ra_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, ra_timer_handler, slirp);
     timer_mod(slirp->ra_timer,
-              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_EXT) + NDP_Interval);
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
 }
 
 void icmp6_cleanup(Slirp *slirp)
diff --git a/ui/input.c b/ui/input.c
index dd7f6d7..51b1019 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -271,7 +271,7 @@ static void qemu_input_queue_process(void *opaque)
         item = QTAILQ_FIRST(queue);
         switch (item->type) {
         case QEMU_INPUT_QUEUE_DELAY:
-            timer_mod(item->timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_EXT)
+            timer_mod(item->timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL)
                       + item->delay_ms);
             return;
         case QEMU_INPUT_QUEUE_EVENT:
@@ -301,7 +301,7 @@ static void qemu_input_queue_delay(struct QemuInputEventQueueHead *queue,
     queue_count++;
 
     if (start_timer) {
-        timer_mod(item->timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_EXT)
+        timer_mod(item->timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL)
                   + item->delay_ms);
     }
 }
@@ -448,8 +448,8 @@ void qemu_input_event_send_key_delay(uint32_t delay_ms)
     }
 
     if (!kbd_timer) {
-        kbd_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL_EXT,
-                                 qemu_input_queue_process, &kbd_queue);
+        kbd_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, qemu_input_queue_process,
+                                 &kbd_queue);
     }
     if (queue_count < queue_limit) {
         qemu_input_queue_delay(&kbd_queue, kbd_timer,
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index eb60d8f..86bfe84 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -496,7 +496,6 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
 
     switch (timer_list->clock->type) {
     case QEMU_CLOCK_REALTIME:
-    case QEMU_CLOCK_VIRTUAL_EXT:
         break;
     default:
     case QEMU_CLOCK_VIRTUAL:
@@ -598,7 +597,6 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
         return get_clock();
     default:
     case QEMU_CLOCK_VIRTUAL:
-    case QEMU_CLOCK_VIRTUAL_EXT:
         if (use_icount) {
             return cpu_get_icount();
         } else {
-- 
2.7.4
