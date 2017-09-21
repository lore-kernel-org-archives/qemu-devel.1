Received: from eggs.gnu.org ([2001:4830:134:3::10]:38504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv1wX-0001tR-HW
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv1wS-0001OY-KA
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:55:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10969)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dv1wS-0001OC-Ae
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:55:00 -0400
References: <20170921085110.25598-1-aik@ozlabs.ru>
	<20170921085110.25598-5-aik@ozlabs.ru>
	<a5b9c3ac-56fe-c29c-ed19-3eb5a5f159c2@redhat.com>
	<4d0450a8-00be-01d3-79d6-2c25a7081cf6@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f53a5e7-9d94-8c81-7d0c-7e65d9026d3c@redhat.com>
Date: Thu, 21 Sep 2017 15:54:56 +0200
MIME-Version: 1.0
In-Reply-To: <4d0450a8-00be-01d3-79d6-2c25a7081cf6@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v5 04/18] memory: Move
 AddressSpaceDispatch from AddressSpace to FlatView
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 21/09/2017 15:44, Alexey Kardashevskiy wrote:
> On 21/09/17 21:51, Paolo Bonzini wrote:
>> On 21/09/2017 10:50, Alexey Kardashevskiy wrote:
>>> * since FlatView::rcu is used now to dispose FV, call_rcu() in
>>> address_space_update_topology() is replaced with direct call to
>>> flatview_unref()
>>
>> Hmm, this is not correct, as you could have
>>
>>
>>    thread 1             thread 2             RCU thread
>>   -------------------------------------------------------------
>>    rcu_read_lock
>>    read as->current_map
>>                         set as->current_map
>>                         flatview_unref
>>                            '--> call_rcu
>>    flatview_ref
>>    rcu_read_unlock
>>                                              flatview_destroy
>>
>> I need to think a bit more about this (and possibly ask Paul...).
>>
>> Paolo
>>
> 
> Nah, you're right, it should be like this:
> 
> 
> diff --git a/memory.c b/memory.c
> index 35b2fc5f7f..689bf53866 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -317,7 +317,7 @@ static void flatview_ref(FlatView *view)
>  static void flatview_unref(FlatView *view)
>  {
>      if (atomic_fetch_dec(&view->ref) == 1) {
> -        call_rcu(view, flatview_destroy, rcu);
> +        flatview_destroy(view);
>      }
>  }
> 
> @@ -768,7 +768,7 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
>          flatview_simplify(view);
> 
>          if (!view->nr) {
> -            flatview_destroy(view);
> +            flatview_unref(view);
>              use_empty = true;
>          }
>      }
> @@ -1026,7 +1026,7 @@ static void address_space_set_flatview(AddressSpace *as)
>      /* Writes are protected by the BQL.  */
>      atomic_rcu_set(&as->current_map, new_view);
>      if (old_view) {
> -        flatview_unref(old_view);
> +        call_rcu(view, flatview_unref, rcu);
>      }

This still doesn't cover address_space_get_flatview, i.e. it is a 
pre-existing bug.

I found a similar case in Linux, here is how they solved it:

commit 358136532dd29e9ed96e0e523d2d510e71bda003
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu Sep 21 14:32:47 2017 +0200

    memory: avoid "resurrection" of dead FlatViews
    
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

diff --git a/docs/devel/atomics.txt b/docs/devel/atomics.txt
index 048e5f23cb..10c5fa37e8 100644
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
index b6b62fb771..44ad1e6c32 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -197,6 +197,15 @@
     atomic_cmpxchg__nocheck(ptr, old, new);                             \
 })
 
+#define atomic_fetch_inc_nonzero(ptr) ({                                \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);                  \
+    typeof_strip_qual(*ptr) _oldn = atomic_read(ptr);                   \
+    while (_oldn && atomic_cmpxchg(ptr, _oldn, _oldn + 1) != _oldn) {   \
+        _oldn = atomic_read(ptr);                                       \
+    }                                                                   \
+    _oldn;                                                              \
+})
+
 /* Provide shorter names for GCC atomic builtins, return old value */
 #define atomic_fetch_inc(ptr)  __atomic_fetch_add(ptr, 1, __ATOMIC_SEQ_CST)
 #define atomic_fetch_dec(ptr)  __atomic_fetch_sub(ptr, 1, __ATOMIC_SEQ_CST)
diff --git a/memory.c b/memory.c
index 2b90117c60..51f54ab430 100644
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
