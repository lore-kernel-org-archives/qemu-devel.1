Received: from eggs.gnu.org ([2001:4830:134:3::10]:48698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC2-000869-Kh
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC0-00008m-EU
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfC0-00007P-5c
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:16 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JFWBZ043798
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:13 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epnw5sruw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:13 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:12 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:04 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-12-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 11/55] memory: avoid "resurrection" of dead
 FlatViews
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

It's possible for address_space_get_flatview() as it currently stands
to cause a use-after-free for the returned FlatView, if the reference
count is incremented after the FlatView has been replaced by a writer:

   thread 1             thread 2             RCU thread
  -------------------------------------------------------------
   rcu_read_lock
   read as->current_map
                        set as->current_map
                        flatview_unref
                           '--> call_rcu
   flatview_ref
     [ref=1]
   rcu_read_unlock
                                             flatview_destroy
   <badness>

Since FlatViews are not updated very often, we can just detect the
situation using a new atomic op atomic_fetch_inc_nonzero, similar to
Linux's atomic_inc_not_zero, which performs the refcount increment only if
it hasn't already hit zero.  This is similar to Linux commit de09a9771a53
("CRED: Fix get_task_cred() and task_state() to not resurrect dead
credentials", 2010-07-29).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 447b0d0b9ee8a0ac216c3186e0f3c427a1001f0c)
 Conflicts:
	docs/devel/atomics.txt
* drop documentation ref to atomic_fetch_xor
* prereq for 166206845f
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 docs/devel/atomics.txt |  1 +
 include/qemu/atomic.h  |  8 ++++++++
 memory.c               | 12 ++++++++----
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/docs/devel/atomics.txt b/docs/devel/atomics.txt
index 3ef5d85b1b..3fbaf52140 100644
--- a/docs/devel/atomics.txt
+++ b/docs/devel/atomics.txt
@@ -63,6 +63,7 @@ operations:
     typeof(*ptr) atomic_fetch_sub(ptr, val)
     typeof(*ptr) atomic_fetch_and(ptr, val)
     typeof(*ptr) atomic_fetch_or(ptr, val)
+    typeof(*ptr) atomic_fetch_inc_nonzero(ptr)
     typeof(*ptr) atomic_xchg(ptr, val)
     typeof(*ptr) atomic_cmpxchg(ptr, old, new)
 
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index b6b62fb771..d73c9e14d7 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -442,4 +442,12 @@
 } while(0)
 #endif
 
+#define atomic_fetch_inc_nonzero(ptr) ({                                \
+    typeof_strip_qual(*ptr) _oldn = atomic_read(ptr);                   \
+    while (_oldn && atomic_cmpxchg(ptr, _oldn, _oldn + 1) != _oldn) {   \
+        _oldn = atomic_read(ptr);                                       \
+    }                                                                   \
+    _oldn;                                                              \
+})
+
 #endif /* QEMU_ATOMIC_H */
diff --git a/memory.c b/memory.c
index de57a16ece..41e2e67301 100644
--- a/memory.c
+++ b/memory.c
@@ -300,9 +300,9 @@ static void flatview_destroy(FlatView *view)
     g_free(view);
 }
 
-static void flatview_ref(FlatView *view)
+static bool flatview_ref(FlatView *view)
 {
-    atomic_inc(&view->ref);
+    return atomic_fetch_inc_nonzero(&view->ref) > 0;
 }
 
 static void flatview_unref(FlatView *view)
@@ -792,8 +792,12 @@ static FlatView *address_space_get_flatview(AddressSpace *as)
     FlatView *view;
 
     rcu_read_lock();
-    view = atomic_rcu_read(&as->current_map);
-    flatview_ref(view);
+    do {
+        view = atomic_rcu_read(&as->current_map);
+        /* If somebody has replaced as->current_map concurrently,
+         * flatview_ref returns false.
+         */
+    } while (!flatview_ref(view));
     rcu_read_unlock();
     return view;
 }
-- 
2.11.0
