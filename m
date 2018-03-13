Received: from eggs.gnu.org ([2001:4830:134:3::10]:58059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsi0-0005je-OD
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshz-0003GJ-LD
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:52 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshz-0003FE-CY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:51 -0400
Received: by mail-wm0-x241.google.com with SMTP id 139so879359wmn.2
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:51 -0700 (PDT)
Received: from donizetti.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	x107sm1557951wrb.97.2018.03.13.15.47.48 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 13 Mar 2018 15:47:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:33 +0100
Message-Id: <20180313224719.4954-24-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/69] docs: document atomic_load_acquire and
 atomic_store_release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We will use them in the next patch, document what they do.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/atomics.txt | 57 ++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/docs/devel/atomics.txt b/docs/devel/atomics.txt
index 10c5fa37e8..a4db3a4aaa 100644
--- a/docs/devel/atomics.txt
+++ b/docs/devel/atomics.txt
@@ -122,20 +122,30 @@ In general, if the algorithm you are writing includes both writes
 and reads on the same side, it is generally simpler to use sequentially
 consistent primitives.
 
-When using this model, variables are accessed with atomic_read() and
-atomic_set(), and restrictions to the ordering of accesses is enforced
+When using this model, variables are accessed with:
+
+- atomic_read() and atomic_set(); these prevent the compiler from
+  optimizing accesses out of existence and creating unsolicited
+  accesses, but do not otherwise impose any ordering on loads and
+  stores: both the compiler and the processor are free to reorder
+  them.
+
+- atomic_load_acquire(), which guarantees the LOAD to appear to
+  happen, with respect to the other components of the system,
+  before all the LOAD or STORE operations specified afterwards.
+  Operations coming before atomic_load_acquire() can still be
+  reordered after it.
+
+- atomic_store_release(), which guarantees the STORE to appear to
+  happen, with respect to the other components of the system,
+  after all the LOAD or STORE operations specified afterwards.
+  Operations coming after atomic_store_release() can still be
+  reordered after it.
+
+Restrictions to the ordering of accesses can also be specified
 using the memory barrier macros: smp_rmb(), smp_wmb(), smp_mb(),
 smp_mb_acquire(), smp_mb_release(), smp_read_barrier_depends().
 
-atomic_read() and atomic_set() prevents the compiler from using
-optimizations that might otherwise optimize accesses out of existence
-on the one hand, or that might create unsolicited accesses on the other.
-In general this should not have any effect, because the same compiler
-barriers are already implied by memory barriers.  However, it is useful
-to do so, because it tells readers which variables are shared with
-other threads, and which are local to the current thread or protected
-by other, more mundane means.
-
 Memory barriers control the order of references to shared memory.
 They come in six kinds:
 
@@ -232,7 +242,7 @@ make atomic_mb_set() the more expensive operation.
 
 There are two common cases in which atomic_mb_read and atomic_mb_set
 generate too many memory barriers, and thus it can be useful to manually
-place barriers instead:
+place barriers, or use atomic_load_acquire/atomic_store_release instead:
 
 - when a data structure has one thread that is always a writer
   and one thread that is always a reader, manual placement of
@@ -243,18 +253,15 @@ place barriers instead:
      thread 1                                thread 1
      -------------------------               ------------------------
      (other writes)
-                                             smp_mb_release()
-     atomic_mb_set(&a, x)                    atomic_set(&a, x)
-                                             smp_wmb()
-     atomic_mb_set(&b, y)                    atomic_set(&b, y)
+     atomic_mb_set(&a, x)                    atomic_store_release(&a, x)
+     atomic_mb_set(&b, y)                    atomic_store_release(&b, y)
 
                                        =>
      thread 2                                thread 2
      -------------------------               ------------------------
-     y = atomic_mb_read(&b)                  y = atomic_read(&b)
-                                             smp_rmb()
-     x = atomic_mb_read(&a)                  x = atomic_read(&a)
-                                             smp_mb_acquire()
+     y = atomic_mb_read(&b)                  y = atomic_load_acquire(&b)
+     x = atomic_mb_read(&a)                  x = atomic_load_acquire(&a)
+     (other reads)
 
   Note that the barrier between the stores in thread 1, and between
   the loads in thread 2, has been optimized here to a write or a
@@ -276,7 +283,6 @@ place barriers instead:
                                              smp_mb_acquire();
 
   Similarly, atomic_mb_set() can be transformed as follows:
-  smp_mb():
 
                                              smp_mb_release();
      for (i = 0; i < 10; i++)          =>    for (i = 0; i < 10; i++)
@@ -284,6 +290,8 @@ place barriers instead:
                                              smp_mb();
 
 
+  The other thread can still use atomic_mb_read()/atomic_mb_set().
+
 The two tricks can be combined.  In this case, splitting a loop in
 two lets you hoist the barriers out of the loops _and_ eliminate the
 expensive smp_mb():
@@ -296,8 +304,6 @@ expensive smp_mb():
                                                atomic_set(&a[i], false);
                                              smp_mb();
 
-  The other thread can still use atomic_mb_read()/atomic_mb_set()
-
 
 Memory barrier pairing
 ----------------------
@@ -386,10 +392,7 @@ and memory barriers, and the equivalents in QEMU:
   note that smp_store_mb() is a little weaker than atomic_mb_set().
   atomic_mb_read() compiles to the same instructions as Linux's
   smp_load_acquire(), but this should be treated as an implementation
-  detail.  QEMU does have atomic_load_acquire() and atomic_store_release()
-  macros, but for now they are only used within atomic.h.  This may
-  change in the future.
-
+  detail.
 
 SOURCES
 =======
-- 
2.14.3
