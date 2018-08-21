Received: from eggs.gnu.org ([2001:4830:134:3::10]:33565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4b-00025J-Fg
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4W-0006pJ-RE
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:05 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4V-0006kh-On
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:00 -0400
Received: by mail-wm0-x241.google.com with SMTP id n11-v6so3496334wmc.2
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:59 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-184-244.clienti.tiscali.it.
	[78.12.184.244]) by smtp.gmail.com with ESMTPSA id
	v6-v6sm2608955wmc.43.2018.08.21.10.03.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Aug 2018 10:03:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:23 +0200
Message-Id: <1534870966-9287-52-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 51/74] seqlock: add QemuLockable support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A shortcut when the seqlock write is protected by a spinlock or any mutex
other than the BQL.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/seqlock.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/qemu/seqlock.h b/include/qemu/seqlock.h
index c367516..fd408b7 100644
--- a/include/qemu/seqlock.h
+++ b/include/qemu/seqlock.h
@@ -16,6 +16,7 @@
 
 #include "qemu/atomic.h"
 #include "qemu/thread.h"
+#include "qemu/lockable.h"
 
 typedef struct QemuSeqLock QemuSeqLock;
 
@@ -45,6 +46,25 @@ static inline void seqlock_write_end(QemuSeqLock *sl)
     atomic_set(&sl->sequence, sl->sequence + 1);
 }
 
+/* Lock out other writers and update the count.  */
+static inline void seqlock_write_lock_impl(QemuSeqLock *sl, QemuLockable *lock)
+{
+    qemu_lockable_lock(lock);
+    seqlock_write_begin(sl);
+}
+#define seqlock_write_lock(sl, lock) \
+    seqlock_write_lock_impl(sl, QEMU_MAKE_LOCKABLE(lock))
+
+/* Lock out other writers and update the count.  */
+static inline void seqlock_write_unlock_impl(QemuSeqLock *sl, QemuLockable *lock)
+{
+    qemu_lockable_unlock(lock);
+    seqlock_write_begin(sl);
+}
+#define seqlock_write_unlock(sl, lock) \
+    seqlock_write_unlock_impl(sl, QEMU_MAKE_LOCKABLE(lock))
+
+
 static inline unsigned seqlock_read_begin(const QemuSeqLock *sl)
 {
     /* Always fail if a write is in progress.  */
-- 
1.8.3.1
