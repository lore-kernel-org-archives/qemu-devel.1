Received: from eggs.gnu.org ([2001:4830:134:3::10]:60808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBT8D-0003b9-05
	for qemu-devel@nongnu.org; Thu, 18 May 2017 17:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBT89-0001cK-1j
	for qemu-devel@nongnu.org; Thu, 18 May 2017 17:38:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBT88-0001c3-Nr
	for qemu-devel@nongnu.org; Thu, 18 May 2017 17:38:44 -0400
References: <1494972923-31756-1-git-send-email-anthony.xu@intel.com>
	<20170517112756.74cf6e47@nial.brq.redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1ACB970@ORSMSX112.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6eff688c-b62e-8796-f852-a855079f3175@redhat.com>
Date: Thu, 18 May 2017 23:38:40 +0200
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1ACB970@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Memory: use memory address space for
 cpu-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 17/05/2017 19:01, Xu, Anthony wrote:
>>> -        AddressSpace *as = address_space_init_shareable(cpu->memory,
>>> -                                                        "cpu-memory");
>>> +        AddressSpace *as;
>>> +        if (cpu->memory == address_space_memory.root) {
>>> +            address_space_memory.ref_count++;
>> probably this would cause reference leak when vcpu is destroyed
> I thought address_space_destroy is called when vcpu is unplugged,
> seems that's not the case, then ref_count++ is not needed.

It should be called.  Alternatively you could try adding a new function
to mark address_space_memory as a never-destroyed AddressSpace:

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 99e0f54d86..b27b288c8f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -290,6 +290,7 @@ struct AddressSpace {
     MemoryRegion *root;
     int ref_count;
     bool malloced;
+    bool shared;
 
     /* Accessed via RCU.  */
     struct FlatView *current_map;
diff --git a/memory.c b/memory.c
index b727f5ec0e..190cd3d5ce 100644
--- a/memory.c
+++ b/memory.c
@@ -2432,6 +2432,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ref_count = 1;
     as->root = root;
     as->malloced = false;
+    as->shared = false;
     as->current_map = g_new(FlatView, 1);
     flatview_init(as->current_map);
     as->ioeventfd_nb = 0;
@@ -2460,12 +2461,18 @@ static void do_address_space_destroy(AddressSpace *as)
     }
 }
 
+void address_space_init_static(AddressSpace *as, MemoryRegion *root, const char *name)
+{
+    address_space_init(as, root, name);
+    as->shared = true;
+}
+
 AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
 {
     AddressSpace *as;
 
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        if (root == as->root && as->malloced) {
+        if (root == as->root && as->shared) {
             as->ref_count++;
             return as;
         }
@@ -2474,6 +2481,7 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
     as = g_malloc0(sizeof *as);
     address_space_init(as, root, name);
     as->malloced = true;
+    as->shared = true;
     return as;
 }
 
@@ -2485,6 +2493,8 @@ void address_space_destroy(AddressSpace *as)
     if (as->ref_count) {
         return;
     }
+    assert(!as->shared || as->malloced);
+
     /* Flush out anything from MemoryListeners listening in on this */
     memory_region_transaction_begin();
     as->root = NULL;


then CPUs can keep using address_space_init_shareable.

Paolo
