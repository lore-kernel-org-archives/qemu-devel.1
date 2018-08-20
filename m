Received: from eggs.gnu.org ([2001:4830:134:3::10]:38166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frlnw-0006vf-R5
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frlnp-00068u-F1
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frlnn-00066Q-Cf
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:08 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 20 Aug 2018 17:09:01 +0200
Message-Id: <20180820150903.1224-3-pbonzini@redhat.com>
In-Reply-To: <20180820150903.1224-1-pbonzini@redhat.com>
References: <20180820150903.1224-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] seqlock: add QemuLockable support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>

A shortcut when the seqlock write is protected by a spinlock or any mutex
other than the BQL.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/seqlock.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/qemu/seqlock.h b/include/qemu/seqlock.h
index c367516708..fd408b7ec5 100644
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
2.17.1
