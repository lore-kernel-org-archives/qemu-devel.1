Received: from eggs.gnu.org ([2001:4830:134:3::10]:54593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjmzO-0002Cs-RA
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjmzM-0007aj-KH
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:11:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjmzM-0007a3-Do
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:11:16 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  3 Mar 2017 14:11:09 +0100
Message-Id: <20170303131113.25898-2-pbonzini@redhat.com>
In-Reply-To: <20170303131113.25898-1-pbonzini@redhat.com>
References: <20170303131113.25898-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] qemu-timer: fix off-by-one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

If the first timer is exactly at the current value of the clock, the
deadline is met and the timer should fire.  This fixes itself without icount,
but with icount execution of instructions will stop exactly at the deadline.

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
2.9.3
