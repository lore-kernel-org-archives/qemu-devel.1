Received: from eggs.gnu.org ([2001:4830:134:3::10]:38606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drKfe-00060P-Sn
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drKfZ-0000kr-O1
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:06:22 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:32981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1drKfZ-0000kd-FR
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:06:17 -0400
Received: by mail-it0-x243.google.com with SMTP id f64so3827141itf.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 02:06:17 -0700 (PDT)
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907092010.3605-4-aik@ozlabs.ru>
	<984ae4a4-3045-e880-b39e-da846b1e2821@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b0ddd613-701c-4814-8241-d15d6917643f@ozlabs.ru>
Date: Mon, 11 Sep 2017 19:06:10 +1000
MIME-Version: 1.0
In-Reply-To: <984ae4a4-3045-e880-b39e-da846b1e2821@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 3/4] memory: Share flat views and
 dispatch trees between address spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 11/09/17 17:40, Paolo Bonzini wrote:
> On 07/09/2017 11:20, Alexey Kardashevskiy wrote:
>>  
>>      /* Accessed via RCU.  */
>>      struct FlatView *current_map;
>>  
>>      int ioeventfd_nb;
>>      struct MemoryRegionIoeventfd *ioeventfds;
>> -    struct AddressSpaceDispatch *dispatch;
>> -    struct AddressSpaceDispatch *next_dispatch;
>> +
> 
> The rough idea of the patch matches my suggestion indeed.  However, I am
> not sure why all of the changes in patch 2 are needed.

For this:

 struct MemoryRegionSection {
     MemoryRegion *mr;
-    AddressSpace *address_space;
+    AddressSpaceDispatch *dispatch;

as there are many ASes attached to the same flatview/dispatch.

And because of that, there is also:

 struct IOMMUTLBEntry {
-    AddressSpace    *target_as;
+    AddressSpaceDispatch *target_dispatch;

as the "section" in address_space_get_iotlb_entry() does not have
address_space any more, even though the only user of it -
vhost_device_iotlb_miss() - only checks if (iotlb.target_dispatch != NULL).


> Once you have built the FlatView and the dispatch within it, you can
> still cache its dispatch tree in as->dispatch, and free it with RCU from
> flatview_destroy.  This removes the need to use call_rcu from
> flatview_unref.

Ok, I will do that.

> In addition, you could change the computation of FlatView's root to
> resolve 2^64-sized aliases;

Here we reached the boundary of my english :)

Roots are given when AS/Flatview is created, and aliases are resolved already.

> also set it to NULL if the AddressSpace's
> root is disabled or the alias it resolves to is disabled (and so on
> recursively until a non-alias is found).  This should remove the need
> for address_space_root() and the change to pci_init_bus_master.




-- 
Alexey
