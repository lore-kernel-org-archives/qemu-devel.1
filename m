Received: from eggs.gnu.org ([2001:4830:134:3::10]:53228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duDPe-0007sR-05
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duDPa-00075Z-Km
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:57:46 -0400
Received: from mail-it0-x234.google.com ([2607:f8b0:4001:c0b::234]:45807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1duDPa-000751-B3
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:57:42 -0400
Received: by mail-it0-x234.google.com with SMTP id v19so1086295ite.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 00:57:42 -0700 (PDT)
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-2-aik@ozlabs.ru>
	<c01622e7-3e6d-cf90-a28c-aa31b4857887@redhat.com>
	<2debed31-4c28-6dc3-b159-1fdc3fbf87f5@ozlabs.ru>
	<a85cbaf9-d7c7-403b-2dfc-886f9ddc0920@ozlabs.ru>
	<11f3ee38-7c70-41d8-0df1-774fbe95cfcb@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ad3f6254-ca71-aa98-9d70-d8131511a397@ozlabs.ru>
Date: Tue, 19 Sep 2017 17:57:36 +1000
MIME-Version: 1.0
In-Reply-To: <11f3ee38-7c70-41d8-0df1-774fbe95cfcb@redhat.com>
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

On 19/09/17 17:40, Paolo Bonzini wrote:
> On 19/09/2017 08:57, Alexey Kardashevskiy wrote:
>>>> 3) you can consult the list (or hash table :)) of live FlatViews (which
>>>> means you keep it live after memory_region_transaction_commit ends, and
>>>> only clear it on the next call), and reuse an existing FlatView.  Note
>>>> that the number of distinct FlatViews should be very few, 
>>>
>>> I keep missing this bit - why few? Each virtio-pci device creates 2 AS,
>>> with proxy->modern_bar and pci_dev->bus_master_container_region which are
>>> unique and not aliases. Remember, 500 virtio devices is my test case ;)
> 
> Argh, no, it's me who keeps missing the bit.
> 
>> More details: pci_dev->bus_master_container_region is a root and it is
>> enabled but its only child pci_dev->bus_master_enable_region is not. Ok, in
>> flatview_topology_update() I can render a FV, see that it is empty
>> (view->nr==0) and share an empty FV in this case too, this halves the
>> number of FVs (from ~1000 to ~500 for 500 virtio devices).
> 
> We can also resolve "fake" aliases, obtained through a region with only
> one subregion.

I just do this now (will post soon):


empty_view = generate_memory_topology(NULL);
[...]

new_view = generate_memory_topology(physmr);

if (!new_view->nr) {
    flatview_ref(empty_view);
    flatview_unref(new_view);
    new_view = empty_view;

[...]

g_hash_table_insert(views, physmr, new_view);

and that's it. For non empty FVs I need to render FVs anyway and for
all-disabled/empty FVs it is really cheap so no big loss here.


> 
>> But proxy->modern_bar (which has an modern_cfg alias which is a root of an
>> AS) is enabled since it is created and I could disable it and enable
>> afterwards but since a PCI device enablement is done by writing to the
>> config space, I kind of stuck here.
>>
>> I can do something like this and it helps a lot (now with -S I end up
>> having 4 FVs and much better start time) but it is kinda hacky and "memory:
>> Postpone flatview and dispatch tree building till all devices are added"
>> solves this better imho, no?
> 
> I think modern_bar (actually modern_cfg) shouldn't have its own address
> space, it's a pretty wasteful way to compute the dispatch tree where a
> simple linked list or array would be enough:

Why would we need an array there anyway? This AS is only used for
virtio_address_space_write() and virtio_address_space_read() so we only
need here s/virtio_address_space_write/memory_region_dispatch_write/ (and
the same for reading), no?

>
> memory-region: virtio-pci
>   00000000fe000000-00000000fe003fff (prio 1, i/o): virtio-pci
>     00000000fe000000-00000000fe000fff (prio 0, i/o): virtio-pci-common
>     00000000fe001000-00000000fe001fff (prio 0, i/o): virtio-pci-isr
>     00000000fe002000-00000000fe002fff (prio 0, i/o): virtio-pci-device
>     00000000fe003000-00000000fe003fff (prio 0, i/o): virtio-pci-notify





-- 
Alexey
