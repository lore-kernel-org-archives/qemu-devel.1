Received: from eggs.gnu.org ([2001:4830:134:3::10]:43761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqO-00025p-2p
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqM-00068C-Vq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:18:08 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  2 Jul 2018 13:17:29 +0200
Message-Id: <20180702111737.18970-8-cohuck@redhat.com>
In-Reply-To: <20180702111737.18970-1-cohuck@redhat.com>
References: <20180702111737.18970-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 07/15] s390x/tcg: drop tod_basetime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Never set to anything but 0.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180627134410.4901-5-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c         | 1 -
 target/s390x/cpu.h         | 1 -
 target/s390x/misc_helper.c | 4 ++--
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 03ea6eafa7..a41b3f34ab 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -289,7 +289,6 @@ static void s390_cpu_initfn(Object *obj)
     qemu_get_timedate(&tm, 0);
     env->tod_offset = TOD_UNIX_EPOCH +
                       (time2tod(mktimegm(&tm)) * 1000000000ULL);
-    env->tod_basetime = 0;
     env->tod_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
     env->cpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index ac51c17fb4..4abfe88a3d 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -131,7 +131,6 @@ struct CPUS390XState {
 #endif
 
     uint64_t tod_offset;
-    uint64_t tod_basetime;
     QEMUTimer *tod_timer;
 
     QEMUTimer *cpu_timer;
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index de1ced2082..dd5273949b 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -141,7 +141,7 @@ uint64_t HELPER(stck)(CPUS390XState *env)
     uint64_t time;
 
     time = env->tod_offset +
-        time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - env->tod_basetime);
+        time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
 
     return time;
 }
@@ -161,7 +161,7 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
     /* nanoseconds */
     time = tod2time(time);
 
-    timer_mod(env->tod_timer, env->tod_basetime + time);
+    timer_mod(env->tod_timer, time);
 }
 
 /* Set Tod Programmable Field */
-- 
2.14.4
