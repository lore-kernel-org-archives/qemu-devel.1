Received: from eggs.gnu.org ([2001:4830:134:3::10]:54976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fW3Vn-0000rN-KS
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fW3Vm-0004O1-Oc
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:36:47 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:34434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fW3Vm-0004NE-8g
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:36:46 -0400
Received: by mail-pf0-x22f.google.com with SMTP id a63-v6so1881541pfl.1
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 10:36:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 21 Jun 2018 07:36:35 -1000
Message-Id: <20180621173635.21537-3-richard.henderson@linaro.org>
In-Reply-To: <20180621173635.21537-1-richard.henderson@linaro.org>
References: <20180621173635.21537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] linux-user: Use pthread_rwlock_t for
 mmap_rd/wrlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, cota@braap.org, qemu-arm@nongnu.org

Change the implementation of these functions to use an actual
reader/writer lock, allowing multiple simultaneous readers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 52 ++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 71b6bed5e2..2dc133515a 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -24,52 +24,62 @@
 
 //#define DEBUG_MMAP
 
-static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
-static __thread int mmap_lock_count;
-
-static void mmap_lock_internal(void)
-{
-    if (mmap_lock_count++ == 0) {
-        pthread_mutex_lock(&mmap_mutex);
-    }
-}
+static pthread_rwlock_t mmap_rwlock = PTHREAD_RWLOCK_INITIALIZER;
+/* Bit 0 indicates reading; bit 1 indicates writing; bits 2+ are count-1.  */
+static __thread int mmap_lock_held;
 
 void mmap_rdlock(void)
 {
-    mmap_lock_internal();
+    if (likely(mmap_lock_held == 0)) {
+        pthread_rwlock_rdlock(&mmap_rwlock);
+        mmap_lock_held = 1;
+    } else {
+        /* can read-lock when write-lock held */
+        mmap_lock_held += 4;
+    }
 }
 
 void mmap_wrlock(void)
 {
-    mmap_lock_internal();
+    if (likely(mmap_lock_held == 0)) {
+        pthread_rwlock_rdlock(&mmap_rwlock);
+        mmap_lock_held = 2;
+    } else {
+        /* cannot upgrade a read-lock to a write-lock */
+        assert((mmap_lock_held & 1) == 0);
+        mmap_lock_held += 4;
+    }
 }
 
 void mmap_unlock(void)
 {
-    if (--mmap_lock_count == 0) {
-        pthread_mutex_unlock(&mmap_mutex);
+    assert(mmap_lock_held > 0);
+    mmap_lock_held -= 4;
+    if (mmap_lock_held < 0) {
+        mmap_lock_held = 0;
+        pthread_rwlock_unlock(&mmap_rwlock);
     }
 }
 
 bool have_mmap_lock(void)
 {
-    return mmap_lock_count > 0 ? true : false;
+    return mmap_lock_held != 0;
 }
 
 /* Grab lock to make sure things are in a consistent state after fork().  */
 void mmap_fork_start(void)
 {
-    if (mmap_lock_count)
-        abort();
-    pthread_mutex_lock(&mmap_mutex);
+    assert(mmap_lock_held == 0);
+    pthread_rwlock_wrlock(&mmap_rwlock);
 }
 
 void mmap_fork_end(int child)
 {
-    if (child)
-        pthread_mutex_init(&mmap_mutex, NULL);
-    else
-        pthread_mutex_unlock(&mmap_mutex);
+    if (child) {
+        pthread_rwlock_init(&mmap_rwlock, NULL);
+    } else {
+        pthread_rwlock_unlock(&mmap_rwlock);
+    }
 }
 
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
-- 
2.17.1
