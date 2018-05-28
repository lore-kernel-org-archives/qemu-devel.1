Received: from eggs.gnu.org ([2001:4830:134:3::10]:34585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fNCMe-0005FR-Sn
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fNCMb-0007oY-L4
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:14:44 -0400
Received: from mail.ispras.ru ([83.149.199.45]:46884)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fNCMb-0007nf-Ce
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:14:41 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Mon, 28 May 2018 10:14:41 +0300
Message-ID: <20180528071441.9424.35501.stgit@pasha-VirtualBox>
In-Reply-To: <20180528071332.9424.27343.stgit@pasha-VirtualBox>
References: <20180528071332.9424.27343.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 12/19] timer: remove replay clock probe in
 deadline calculation
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

Ciro Santilli reported that commit a5ed352596a8b7eb2f9acce34371b944ac3056c4
breaks the execution replay. It happens due to the probing the clock
for the new instances of iothread.
However, this probing was made in replay mode for the timer lists that
are empty.
This patch removes clock probing in replay mode.
It is an artifact of the old version with another thread model.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 util/qemu-timer.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 2ed1bf2..86bfe84 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -578,17 +578,10 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup *tlg)
 {
     int64_t deadline = -1;
     QEMUClockType type;
-    bool play = replay_mode == REPLAY_MODE_PLAY;
     for (type = 0; type < QEMU_CLOCK_MAX; type++) {
         if (qemu_clock_use_for_deadline(type)) {
-            if (!play || type == QEMU_CLOCK_REALTIME) {
-                deadline = qemu_soonest_timeout(deadline,
-                                                timerlist_deadline_ns(tlg->tl[type]));
-            } else {
-                /* Read clock from the replay file and
-                   do not calculate the deadline, based on virtual clock. */
-                qemu_clock_get_ns(type);
-            }
+            deadline = qemu_soonest_timeout(deadline,
+                                            timerlist_deadline_ns(tlg->tl[type]));
         }
     }
     return deadline;
