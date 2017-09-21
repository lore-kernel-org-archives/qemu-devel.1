Received: from eggs.gnu.org ([2001:4830:134:3::10]:37184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiC-0004aI-M3
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiB-0003ws-Im
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:52 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiB-0003un-Bc
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:51 -0400
Received: by mail-wr0-x242.google.com with SMTP id n64so3848914wrb.2
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:16:51 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-246-117.clienti.tiscali.it.
	[78.12.246.117]) by smtp.gmail.com with ESMTPSA id
	u186sm2596278wmd.19.2017.09.21.16.16.48 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Sep 2017 16:16:49 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:13 +0200
Message-Id: <1506035800-30509-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/32] memory: avoid "resurrection" of dead
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
---
 docs/devel/atomics.txt |  1 +
 include/qemu/atomic.h  |  8 ++++++++
 memory.c               | 12 ++++++++----
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/docs/devel/atomics.txt b/docs/devel/atomics.txt
index 048e5f2..10c5fa3 100644
--- a/docs/devel/atomics.txt
+++ b/docs/devel/atomics.txt
@@ -64,6 +64,7 @@ operations:
     typeof(*ptr) atomic_fetch_and(ptr, val)
     typeof(*ptr) atomic_fetch_or(ptr, val)
     typeof(*ptr) atomic_fetch_xor(ptr, val)
+    typeof(*ptr) atomic_fetch_inc_nonzero(ptr)
     typeof(*ptr) atomic_xchg(ptr, val)
     typeof(*ptr) atomic_cmpxchg(ptr, old, new)
 
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index b6b62fb..d73c9e1 100644
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
index 2b90117..51f54ab 100644
--- a/memory.c
+++ b/memory.c
@@ -294,9 +294,9 @@ static void flatview_destroy(FlatView *view)
     g_free(view);
 }
 
-static void flatview_ref(FlatView *view)
+static bool flatview_ref(FlatView *view)
 {
-    atomic_inc(&view->ref);
+    return atomic_fetch_inc_nonzero(&view->ref) > 0;
 }
 
 static void flatview_unref(FlatView *view)
@@ -773,8 +773,12 @@ static FlatView *address_space_get_flatview(AddressSpace *as)
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
1.8.3.1
