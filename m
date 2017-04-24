Received: from eggs.gnu.org ([2001:4830:134:3::10]:50304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d2ezM-0007Es-7x
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d2ezJ-0001v6-Hk
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:29:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45755
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1d2ezJ-0001u2-BM
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:29:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3OET4M0139345
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 10:29:11 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a1g8qb1fg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 10:29:10 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 24 Apr 2017 11:29:09 -0300
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v3OET5Y426214558
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 11:29:06 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
	by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v3OET6qr015628
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 11:29:06 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 24 Apr 2017 11:28:46 -0300
Message-Id: <1493044126-21488-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] trace: add qemu mutex lock and unlock trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com

These trace events were very useful to help me to understand and find a
reordering issue in vfio, for example:

qemu_mutex_lock locked mutex 0x10905ad8
  vfio_region_write  (0001:03:00.0:region1+0xc0, 0x2020c, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8
qemu_mutex_lock locked mutex 0x10905ad8
  vfio_region_write  (0001:03:00.0:region1+0xc4, 0xa0000, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8

that also helped to see desired result after the fix:

qemu_mutex_lock locked mutex 0x10905ad8
  vfio_region_write  (0001:03:00.0:region1+0xc0, 0x2000c, 4)
  vfio_region_write  (0001:03:00.0:region1+0xc4, 0xb0000, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8

So it could be a good idea to have these traces implemented. It's worth
mentioning that they should be surgically enabled during the debugging,
otherwise it'd flood the trace logs with lock/unlock messages.

How to use it:
trace-event qemu_mutex_lock on|off
trace-event qemu_mutex_unlock on|off
or
trace-event qemu_mutex* on|off

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 util/qemu-thread-posix.c | 5 +++++
 util/trace-events        | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 73e3a0e..909c2ac 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -14,6 +14,7 @@
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
+#include "trace.h"
 
 static bool name_threads;
 
@@ -60,6 +61,8 @@ void qemu_mutex_lock(QemuMutex *mutex)
     err = pthread_mutex_lock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
+
+    trace_qemu_mutex_lock((void *)&mutex->lock);
 }
 
 int qemu_mutex_trylock(QemuMutex *mutex)
@@ -74,6 +77,8 @@ void qemu_mutex_unlock(QemuMutex *mutex)
     err = pthread_mutex_unlock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
+
+    trace_qemu_mutex_unlock((void *)&mutex->lock);
 }
 
 void qemu_rec_mutex_init(QemuRecMutex *mutex)
diff --git a/util/trace-events b/util/trace-events
index b44ef4f..65c33fe 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -55,3 +55,7 @@ lockcnt_futex_wait_prepare(const void *lockcnt, int expected, int new) "lockcnt
 lockcnt_futex_wait(const void *lockcnt, int val) "lockcnt %p waiting on %d"
 lockcnt_futex_wait_resume(const void *lockcnt, int new) "lockcnt %p after wait: %d"
 lockcnt_futex_wake(const void *lockcnt) "lockcnt %p waking up one waiter"
+
+# util/qemu-thread-posix.c
+qemu_mutex_lock(void *qemu_global_mutex) "locked mutex %p"
+qemu_mutex_unlock(void *qemu_global_mutex) "unlocked mutex %p"
-- 
2.7.4
