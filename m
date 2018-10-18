Received: from eggs.gnu.org ([2001:4830:134:3::10]:47962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEy8-00075y-OQ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEy5-0006Ak-HM
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:31 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEy3-00065J-1d
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id y11-v6so1570674wma.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:29 +0200
Message-Id: <1539894735-14232-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/48] Revert some patches from recent [PATCH
 v6] "Fixing record/replay and adding reverse debugging"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>

From: Artem Pisarenko <artem.k.pisarenko@gmail.com>

That patch series introduced new virtual clock type for use in external
subsystems. It breaks desired behavior in non-record/replay usage
scenarios due to a small change to existing behavior.  Processing of
virtual timers belonging to new clock type is kicked off to the main
loop, which makes these timers asynchronous with vCPU thread and,
in icount mode, with whole guest execution. This breaks expected
determinism in non-record/replay icount mode of emulation where these
"external subsystems" are isolated from the host (i.e. they are
external only to guest core, not to the entire emulation environment).

Example for slirp ("user" backend for network device):
User runs qemu in icount mode with rtc clock=vm without any external
communication interfaces but with "-netdev user,restrict=on". It expects
deterministic execution, because network services are emulated inside
qemu and isolated from host. There are no reasons to get reply from DHCP
server with different delay or something like that.

The next patches revert reimplements the same changes in a better way.
This reverts commit 87f4fe7653baf55b5c2f2753fe6003f473c07342.
This reverts commit 775a412bf83f6bc0c5c02091ee06cf649b34c593.
This reverts commit 9888091404a702d7ec79d51b088d994b9fc121bd.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Message-Id: <18b1e7c8f155fe26976f91be06bde98eef6f8751.1539764043.git.artem.k.pisarenko@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
