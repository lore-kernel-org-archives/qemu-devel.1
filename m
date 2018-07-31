Received: from eggs.gnu.org ([2001:4830:134:3::10]:59041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fkPca-0007az-E6
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fkPcY-00019m-Fp
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:03:08 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fkPcY-00019T-8e
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:03:06 -0400
Received: by mail-wm0-x22e.google.com with SMTP id n11-v6so2064522wmc.2
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 01:03:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 31 Jul 2018 10:02:58 +0200
Message-Id: <20180731080259.15934-4-pbonzini@redhat.com>
In-Reply-To: <20180731080259.15934-1-pbonzini@redhat.com>
References: <20180731080259.15934-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] timer: remove replay clock probe in
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
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Ciro Santilli reported that commit a5ed352596a8b7eb2f9acce34371b944ac3056c4
breaks the execution replay. It happens due to the probing the clock
for the new instances of iothread.
However, this probing was made in replay mode for the timer lists that
are empty.
This patch removes clock probing in replay mode.
It is an artifact of the old version with another thread model.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Message-Id: <20180725121526.12867.17866.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-timer.c | 11 ++---------
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
-- 
1.8.3.1
