Received: from eggs.gnu.org ([2001:4830:134:3::10]:58801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f5t7q-0007og-L8
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f5t7m-0007Ch-GC
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:15:54 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45814)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f5t7m-0007Ap-7h
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:15:50 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 10 Apr 2018 16:15:50 +0300
Message-ID: <20180410131550.20064.30595.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] timer: fix record/replay timerlist probe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru

Ciro Santilli reported that commit a5ed352596a8b7eb2f9acce34371b944ac3056c4
breaks the execution replay. It happens due to the probing the clock
for the new instances of iothread. Probing of the timerlists' clock
instead of using them for the deadlines calculation is critical for the replay.
However, this probing was made for the timer lists that are empty.
In record mode such lists are not used for the deadlines and corresponding
clock does not queried.
Therefore this patch disables quering the clock for the empty timerlists
and disabled clocks.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 util/qemu-timer.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 2ed1bf2..e1c703c 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -587,7 +587,10 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup *tlg)
             } else {
                 /* Read clock from the replay file and
                    do not calculate the deadline, based on virtual clock. */
-                qemu_clock_get_ns(type);
+                if (atomic_read(&tlg->tl[type]->active_timers)
+                    && tlg->tl[type]->clock->enabled) {
+                    qemu_clock_get_ns(type);
+                }
             }
         }
     }
