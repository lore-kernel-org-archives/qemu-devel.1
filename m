Received: from eggs.gnu.org ([2001:4830:134:3::10]:47859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00NY-0001ls-V4
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00NY-00011s-5V
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:20:04 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56178)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00NX-00011P-Sx
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:20:04 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 12 Sep 2018 11:20:02 +0300
Message-ID: <20180912082002.3228.82417.stgit@pasha-VirtualBox>
In-Reply-To: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 23/25] timer: introduce new virtual clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

Slirp and VNC modules use virtual clock for processing some events that
are related to the guest execution speed.
But virtual clock-related events are consideres to be deterministic and
are recorded/replayed by icount mechanism. But slirp and VNC lie outside
the recorded guest core (which includes CPU and peripherals).
Therefore slirp and VNC are external for the guest, but should work at
guest speed.
This patch introduces new virtual clock which can be used for external
subsystems for running timers that are synchronized with the guest.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 include/qemu/timer.h |    9 +++++++++
 util/qemu-timer.c    |    2 ++
 2 files changed, 11 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 39ea907..a005ed2 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -42,6 +42,14 @@
  * In icount mode, this clock counts nanoseconds while the virtual
  * machine is running.  It is used to increase @QEMU_CLOCK_VIRTUAL
  * while the CPUs are sleeping and thus not executing instructions.
+ *
+ * @QEMU_CLOCK_VIRTUAL_EXT: virtual clock for external subsystems
+ *
+ * The virtual clock only runs during the emulation. It stops
+ * when the virtual machine is stopped. The timers for this clock
+ * do not recorded in rr mode, therefore this clock could be used
+ * for the subsystems that operate outside the guest core.
+ *
  */
 
 typedef enum {
@@ -49,6 +57,7 @@ typedef enum {
     QEMU_CLOCK_VIRTUAL = 1,
     QEMU_CLOCK_HOST = 2,
     QEMU_CLOCK_VIRTUAL_RT = 3,
+    QEMU_CLOCK_VIRTUAL_EXT = 4,
     QEMU_CLOCK_MAX
 } QEMUClockType;
 
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 86bfe84..eb60d8f 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -496,6 +496,7 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
 
     switch (timer_list->clock->type) {
     case QEMU_CLOCK_REALTIME:
+    case QEMU_CLOCK_VIRTUAL_EXT:
         break;
     default:
     case QEMU_CLOCK_VIRTUAL:
@@ -597,6 +598,7 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
         return get_clock();
     default:
     case QEMU_CLOCK_VIRTUAL:
+    case QEMU_CLOCK_VIRTUAL_EXT:
         if (use_icount) {
             return cpu_get_icount();
         } else {
