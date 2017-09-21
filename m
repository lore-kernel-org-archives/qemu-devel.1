Received: from eggs.gnu.org ([2001:4830:134:3::10]:35703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dv1mw-0004ku-KM
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dv1mr-0003ki-8l
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:45:10 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:37062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dv1mr-0003kH-1r
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:45:05 -0400
Received: by mail-pg0-x244.google.com with SMTP id v5so3453085pgn.4
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 06:45:04 -0700 (PDT)
References: <20170921085110.25598-1-aik@ozlabs.ru>
	<20170921085110.25598-5-aik@ozlabs.ru>
	<a5b9c3ac-56fe-c29c-ed19-3eb5a5f159c2@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4d0450a8-00be-01d3-79d6-2c25a7081cf6@ozlabs.ru>
Date: Thu, 21 Sep 2017 23:44:59 +1000
MIME-Version: 1.0
In-Reply-To: <a5b9c3ac-56fe-c29c-ed19-3eb5a5f159c2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 21/09/17 21:51, Paolo Bonzini wrote:
> On 21/09/2017 10:50, Alexey Kardashevskiy wrote:
>> * since FlatView::rcu is used now to dispose FV, call_rcu() in
>> address_space_update_topology() is replaced with direct call to
>> flatview_unref()
> 
> Hmm, this is not correct, as you could have
> 
> 
>    thread 1             thread 2             RCU thread
>   -------------------------------------------------------------
>    rcu_read_lock
>    read as->current_map
>                         set as->current_map
>                         flatview_unref
>                            '--> call_rcu
>    flatview_ref
>    rcu_read_unlock
>                                              flatview_destroy
> 
> I need to think a bit more about this (and possibly ask Paul...).
> 
> Paolo
> 

Nah, you're right, it should be like this:


diff --git a/memory.c b/memory.c
index 35b2fc5f7f..689bf53866 100644
--- a/memory.c
+++ b/memory.c
@@ -317,7 +317,7 @@ static void flatview_ref(FlatView *view)
 static void flatview_unref(FlatView *view)
 {
     if (atomic_fetch_dec(&view->ref) == 1) {
-        call_rcu(view, flatview_destroy, rcu);
+        flatview_destroy(view);
     }
 }

@@ -768,7 +768,7 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
         flatview_simplify(view);

         if (!view->nr) {
-            flatview_destroy(view);
+            flatview_unref(view);
             use_empty = true;
         }
     }
@@ -1026,7 +1026,7 @@ static void address_space_set_flatview(AddressSpace *as)
     /* Writes are protected by the BQL.  */
     atomic_rcu_set(&as->current_map, new_view);
     if (old_view) {
-        flatview_unref(old_view);
+        call_rcu(view, flatview_unref, rcu);
     }



-- 
Alexey
