Received: from eggs.gnu.org ([2001:4830:134:3::10]:36733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9i-0003XY-RR
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9h-0006fm-FN
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:38 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9h-0006es-84
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:37 -0400
Received: by mail-wm0-x243.google.com with SMTP id v190so583324wme.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:37 -0700 (PDT)
Received: from 640k.lan (94-39-132-181.adsl-ull.clienti.tiscali.it.
	[94.39.132.181])
	by smtp.gmail.com with ESMTPSA id k195sm408197wmd.7.2017.03.14.09.18.35
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 Mar 2017 09:18:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:14 +0100
Message-Id: <1489508300-48184-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/18] qemu-timer: fix off-by-one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If the first timer is exactly at the current value of the clock, the
deadline is met and the timer should fire.  This fixes itself on the next
iteration of the loop without icount; with icount, however, execution
of instructions will stop exactly at the deadline and won't proceed.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 6cf70b9..2f20151 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -199,7 +199,7 @@ bool timerlist_expired(QEMUTimerList *timer_list)
     expire_time = timer_list->active_timers->expire_time;
     qemu_mutex_unlock(&timer_list->active_timers_lock);
 
-    return expire_time < qemu_clock_get_ns(timer_list->clock->type);
+    return expire_time <= qemu_clock_get_ns(timer_list->clock->type);
 }
 
 bool qemu_clock_expired(QEMUClockType type)
-- 
1.8.3.1
