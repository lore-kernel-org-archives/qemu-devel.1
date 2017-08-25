Received: from eggs.gnu.org ([2001:4830:134:3::10]:34919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlAUw-00051L-9q
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlAUs-00016R-Hb
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:01:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dlAUs-00016D-B9
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:01:46 -0400
References: <20170824123006.GK5379@umbus.fritz.box>
	<20170825083123.47432-1-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <256c5d79-d940-3a7c-89e2-19a6140f5ccd@redhat.com>
Date: Fri, 25 Aug 2017 11:01:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170825083123.47432-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] exec: Destroy dispatch immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

On 25/08/2017 10:31, Alexey Kardashevskiy wrote:
> Each address_space_init() updates topology for _every_ address space.

And finally, does this patch help with the above?

diff --git a/memory.c b/memory.c
index c0adc35..97c16cc 100644
--- a/memory.c
+++ b/memory.c
@@ -2607,10 +2607,16 @@ void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
                           RUN_ON_CPU_HOST_PTR(invalidate_data));
 }
 
+static void address_space_rebuild(AddressSpace *as)
+{
+    MEMORY_LISTENER_CALL(as, begin, Forward);
+    address_space_update_topology(as);
+    MEMORY_LISTENER_CALL(as, commit, Forward);
+}
+
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
     memory_region_ref(root);
-    memory_region_transaction_begin();
     as->ref_count = 1;
     as->root = root;
     as->malloced = false;
@@ -2622,8 +2628,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
     as->name = g_strdup(name ? name : "anonymous");
     address_space_init_dispatch(as);
-    memory_region_update_pending |= root->enabled;
-    memory_region_transaction_commit();
+    address_space_rebuild(as);
 }
 
 static void do_address_space_destroy(AddressSpace *as)


Completely untested because vacation is coming.

Thanks,

Paolo
