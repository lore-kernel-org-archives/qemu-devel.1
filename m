Received: from eggs.gnu.org ([2001:4830:134:3::10]:60953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1du7yp-0003Va-1L
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1du7yk-0004Db-Q2
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:09:42 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1du7yk-0004Cy-Gr
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:09:38 -0400
Received: by mail-pg0-x242.google.com with SMTP id v5so1206468pgn.4
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 19:09:38 -0700 (PDT)
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-2-aik@ozlabs.ru>
	<c01622e7-3e6d-cf90-a28c-aa31b4857887@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2debed31-4c28-6dc3-b159-1fdc3fbf87f5@ozlabs.ru>
Date: Tue, 19 Sep 2017 12:09:32 +1000
MIME-Version: 1.0
In-Reply-To: <c01622e7-3e6d-cf90-a28c-aa31b4857887@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3 01/13] memory: Postpone flatview
 and dispatch tree building till all devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 19/09/17 00:54, Paolo Bonzini wrote:
> On 18/09/2017 12:16, Alexey Kardashevskiy wrote:
>> Most devices use at least one address space and every time a new address
>> space is added, flat views and dispatch trees are rebuild for all address
>> spaces. This is not a problem for a relatively small amount of devices but
>> even 50 virtio-pci devices use more than 8GB of RAM.
>>
>> What happens that on every flatview/dispatch rebuild, new arrays are
>> allocated and old ones release but the release is done via RCU so until
>> an entire machine is build, they are not released.
>>
>> This wraps devices creation into memory_region_transaction_begin/commit
>> to massively reduce amount of flat view/dispatch tree (re)allocations.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v2:
>> * wrapped qemu_run_machine_init_done_notifiers() as well
>> ---
>>  vl.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/vl.c b/vl.c
>> index 9e62e92aea..e4f2ece590 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4741,12 +4741,16 @@ int main(int argc, char **argv, char **envp)
>>      igd_gfx_passthru();
>>  
>>      /* init generic devices */
>> +    memory_region_transaction_begin();
>> +
>>      rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
>>      if (qemu_opts_foreach(qemu_find_opts("device"),
>>                            device_init_func, NULL, NULL)) {
>>          exit(1);
>>      }
>>  
>> +    memory_region_transaction_commit();
>> +
>>      cpu_synchronize_all_post_init();
>>  
>>      rom_reset_order_override();
>> @@ -4829,8 +4833,13 @@ int main(int argc, char **argv, char **envp)
>>      /* TODO: once all bus devices are qdevified, this should be done
>>       * when bus is created by qdev.c */
>>      qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
>> +
>> +    memory_region_transaction_begin();
>> +
>>      qemu_run_machine_init_done_notifiers();
>>  
>> +    memory_region_transaction_commit();
>> +
>>      if (rom_check_and_register_reset() != 0) {
>>          error_report("rom check and register reset failed");
>>          exit(1);
>>
> 
> This should not be necessary given the other patches; the PCI devices
> have an empty address space at the beginning, so there are other less
> intrusive optimizations to do instead with the same effect:
> 
> 1) as a start, the "|= root->enabled" can resolve aliases.  This should
> be enough for the PCI device case.
> 
> 2) also, after patch 2 you know that the address space has no listeners
> here, so the begin/commit isn't really needed.  Instead you can use the
> open-coded loop to directly generate the FlatView.  This avoids touching
> _all_ address spaces, which is already an improvement from O(n^2) to
> O(n) rebuilds on device startup.
> 
> 3) you can consult the list (or hash table :)) of live FlatViews (which
> means you keep it live after memory_region_transaction_commit ends, and
> only clear it on the next call), and reuse an existing FlatView.  Note
> that the number of distinct FlatViews should be very few, 


I keep missing this bit - why few? Each virtio-pci device creates 2 AS,
with proxy->modern_bar and pci_dev->bus_master_container_region which are
unique and not aliases. Remember, 500 virtio devices is my test case ;)


> so feel free
> to revert from hash table to list in v4 if you prefer.
>> 4) you can skip address_space_update_topology_pass if
> QTAILQ_EMPTY(&as->listeners).  This can provide some startup speed
> improvements.
> 
> Optimizations 2/3/4 should be moved to the end of the series, or even in
> a separate post.  The first can be done in the beginning too, as you prefer.




-- 
Alexey
