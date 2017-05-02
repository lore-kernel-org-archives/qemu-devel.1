Received: from eggs.gnu.org ([2001:4830:134:3::10]:59371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOB-0001dY-BY
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOA-0001Uo-D9
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:11 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOA-0001UI-8v
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:10 -0400
Received: by mail-qk0-x241.google.com with SMTP id u68so7538399qkd.2
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:38 -0700
Message-Id: <20170502192300.2124-4-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 03/25] qemu/atomic: Loosen restrictions for
 64-bit ILP32 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

We need to coordinate with the TCG_OVERSIZED_GUEST test in cputlb.c,
and allow 64-bit atomics even though sizeof(void *) == 4.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/qemu/atomic.h | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index 878fa07..e07c797 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -88,6 +88,24 @@
 #define smp_read_barrier_depends()   barrier()
 #endif
 
+/* Sanity check that the size of an atomic operation isn't "overly large".
+ * Despite the fact that e.g. i686 has 64-bit atomic operations, we do not
+ * want to use them because we ought not need them, and this lets us do a
+ * bit of sanity checking that other 32-bit hosts might build.
+ *
+ * That said, we have a problem on 64-bit ILP32 hosts in that in order to
+ * sync with TCG_OVERSIZED_GUEST, this must match TCG_TARGET_REG_BITS.
+ * We'd prefer not want to pull in everything else TCG related, so handle
+ * those few cases by hand.
+ *
+ * Note that x32 is fully detected with __x64_64__ + _ILP32, and that for
+ * Sparc we always force the use of sparcv9 in configure.
+ */
+#if defined(__x86_64__) || defined(__sparc__)
+# define ATOMIC_REG_SIZE  8
+#else
+# define ATOMIC_REG_SIZE  sizeof(void *)
+#endif
 
 /* Weak atomic operations prevent the compiler moving other
  * loads/stores past the atomic operation load/store. However there is
@@ -104,7 +122,7 @@
 
 #define atomic_read(ptr)                              \
     ({                                                \
-    QEMU_BUILD_BUG_ON(sizeof(*ptr) > sizeof(void *)); \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
     atomic_read__nocheck(ptr);                        \
     })
 
@@ -112,7 +130,7 @@
     __atomic_store_n(ptr, i, __ATOMIC_RELAXED)
 
 #define atomic_set(ptr, i)  do {                      \
-    QEMU_BUILD_BUG_ON(sizeof(*ptr) > sizeof(void *)); \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
     atomic_set__nocheck(ptr, i);                      \
 } while(0)
 
@@ -130,27 +148,27 @@
 
 #define atomic_rcu_read(ptr)                          \
     ({                                                \
-    QEMU_BUILD_BUG_ON(sizeof(*ptr) > sizeof(void *)); \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
     typeof_strip_qual(*ptr) _val;                     \
     atomic_rcu_read__nocheck(ptr, &_val);             \
     _val;                                             \
     })
 
 #define atomic_rcu_set(ptr, i) do {                   \
-    QEMU_BUILD_BUG_ON(sizeof(*ptr) > sizeof(void *)); \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
     __atomic_store_n(ptr, i, __ATOMIC_RELEASE);       \
 } while(0)
 
 #define atomic_load_acquire(ptr)                        \
     ({                                                  \
-    QEMU_BUILD_BUG_ON(sizeof(*ptr) > sizeof(void *));   \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);  \
     typeof_strip_qual(*ptr) _val;                       \
     __atomic_load(ptr, &_val, __ATOMIC_ACQUIRE);        \
     _val;                                               \
     })
 
 #define atomic_store_release(ptr, i)  do {              \
-    QEMU_BUILD_BUG_ON(sizeof(*ptr) > sizeof(void *));   \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);  \
     __atomic_store_n(ptr, i, __ATOMIC_RELEASE);         \
 } while(0)
 
@@ -162,7 +180,7 @@
 })
 
 #define atomic_xchg(ptr, i)    ({                           \
-    QEMU_BUILD_BUG_ON(sizeof(*ptr) > sizeof(void *));       \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);      \
     atomic_xchg__nocheck(ptr, i);                           \
 })
 
@@ -175,7 +193,7 @@
 })
 
 #define atomic_cmpxchg(ptr, old, new)    ({                             \
-    QEMU_BUILD_BUG_ON(sizeof(*ptr) > sizeof(void *));                   \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);                  \
     atomic_cmpxchg__nocheck(ptr, old, new);                             \
 })
 
-- 
2.9.3
