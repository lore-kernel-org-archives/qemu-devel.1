Received: from eggs.gnu.org ([2001:4830:134:3::10]:59182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fMB24-0008HL-LY
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fMB23-0001KB-Qj
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:37:16 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 25 May 2018 13:37:03 +0200
Message-Id: <20180525113708.29856-3-david@redhat.com>
In-Reply-To: <20180525113708.29856-1-david@redhat.com>
References: <20180525113708.29856-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/7] s390x/tcg: drop tod_basetime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, "Collin L . Walling" <walling@linux.ibm.com>, david@redhat.com

Never set to anything but 0.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c         | 1 -
 target/s390x/cpu.h         | 1 -
 target/s390x/misc_helper.c | 4 ++--
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 167d089722..557074165a 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -290,7 +290,6 @@ static void s390_cpu_initfn(Object *obj)
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
index 1f834f35ef..044ffc64c4 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -142,7 +142,7 @@ uint64_t HELPER(stck)(CPUS390XState *env)
     uint64_t time;
 
     time = env->tod_offset +
-        time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - env->tod_basetime);
+        time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
 
     return time;
 }
@@ -162,7 +162,7 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
     /* nanoseconds */
     time = tod2time(time);
 
-    timer_mod(env->tod_timer, env->tod_basetime + time);
+    timer_mod(env->tod_timer, time);
 }
 
 /* Set Tod Programmable Field */
-- 
2.17.0
