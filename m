Received: from eggs.gnu.org ([2001:4830:134:3::10]:45534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dmcJE-0004p0-NA
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dmcJB-0001xG-DV
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:55:44 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:36410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dmcJA-0001vb-V9
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:55:41 -0400
Received: by mail-io0-x243.google.com with SMTP id v96so2909355ioi.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 01:55:39 -0700 (PDT)
References: <20170824123006.GK5379@umbus.fritz.box>
	<20170825083123.47432-1-aik@ozlabs.ru>
	<4608a2c1-5c74-efea-d901-3b5cfa0519e6@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <faf33daf-0207-c8c2-a260-434e621dcf87@ozlabs.ru>
Date: Tue, 29 Aug 2017 18:55:32 +1000
MIME-Version: 1.0
In-Reply-To: <4608a2c1-5c74-efea-d901-3b5cfa0519e6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>

On 25/08/17 18:53, Paolo Bonzini wrote:
> On 25/08/2017 10:31, Alexey Kardashevskiy wrote:
>> Otherwise old dispatch holds way too much memory before RCU gets
>> a chance to free old dispatches.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> This is a follow-up to the "Memory use with >100 virtio devices"
>> thread.
>>
>> I assume this is a dirty hack (which fixes the problem though)
> 
> This doesn't work.  AddressSpaceDispatch can be accessed outside the big
> QEMU lock, which is why it is destroyed via call_rcu.
> 
> The solution is to: 1) share the FlatView structures if they refer to
> the same root memory region; 2) have one AddressSpaceDispatch per
> FlatView instead of one per AddressSpace, so that FlatView reference
> counting takes care of clearing the AddressSpaceDispatch too.  Neither
> is particularly hard.  The second requires getting rid of the
> as->dispatch_listener and "hard coding" the creation of the
> AddressSpaceDispatch from the FlatView in memory.c.


While I am trying this approach, here is a cheap workaround -

diff --git a/vl.c b/vl.c
index 8e247cc2a2..4d95bc2a6a 100644
--- a/vl.c
+++ b/vl.c
@@ -4655,12 +4655,16 @@ int main(int argc, char **argv, char **envp)
     igd_gfx_passthru();

     /* init generic devices */
+    memory_region_transaction_begin();
+
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
     if (qemu_opts_foreach(qemu_find_opts("device"),
                           device_init_func, NULL, NULL)) {
         exit(1);
     }

+    memory_region_transaction_commit();
+
     cpu_synchronize_all_post_init();

     rom_reset_order_override();



Just for self-education - how dirty is this hack?

This effectively postpones all dispatch trees allocation/disposal till MR
transation depth is 0 (which happens in this
memory_region_transaction_commit()), for 500 virtio devices it reduces the
amount of resident RAM from 45GB to 11GB with 2GB guest, good for speed too
- time to build a machine is reduced from 4:00 to 1:20.




> 
> Paolo
> 
>> and I wonder what the proper solution would be. Thanks.
>>
>>
>> What happens here is that every virtio block device creates 2 address
>> spaces - for modern config space (called "virtio-pci-cfg-as") and
>> for busmaster (common pci thing, called after the device name,
>> in my case "virtio-blk-pci").
>>
>> Each address_space_init() updates topology for _every_ address space.
>> Every topology update (address_space_update_topology()) creates a new
>> dispatch tree - AddressSpaceDispatch with nodes (1KB) and
>> sections (48KB) and destroys the old one.
>>
>> However the dispatch destructor is postponed via RCU which does not
>> get a chance to execute until the machine is initialized but before
>> we get there, memory is not returned to the pool, and this is a lot
>> of memory which grows n^2.
>>
>>
>> Interestingly, mem_add() from exec.c is called twice:
>> as as->dispatch_listener.region_add() and
>> as as->dispatch_listener.region_nop() - I did not understand
>> the trick but it does not work if I remove the .region_nop() hook.
>> How does it work? :)
>>
>> ---
>>  exec.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/exec.c b/exec.c
>> index 01ac21e3cd..ea5f3eb209 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -2707,7 +2707,7 @@ static void mem_commit(MemoryListener *listener)
>>  
>>      atomic_rcu_set(&as->dispatch, next);
>>      if (cur) {
>> -        call_rcu(cur, address_space_dispatch_free, rcu);
>> +        address_space_dispatch_free(cur);
>>      }
>>  }
>>  
>>
> 


-- 
Alexey
