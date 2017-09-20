Received: from eggs.gnu.org ([2001:4830:134:3::10]:36014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duoj6-00088I-38
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 19:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duoj3-0004vA-0z
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 19:48:20 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:32782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1duoj2-0004uE-N0
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 19:48:16 -0400
Received: by mail-pg0-x242.google.com with SMTP id i130so2455937pgc.0
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 16:48:16 -0700 (PDT)
References: <20170920114637.42004-1-aik@ozlabs.ru>
	<20170920114637.42004-16-aik@ozlabs.ru>
	<54984f46-f50b-8306-2229-15ea96cea7d6@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7a46de37-95dd-d662-3a4c-05421f5e8f1a@ozlabs.ru>
Date: Thu, 21 Sep 2017 09:48:10 +1000
MIME-Version: 1.0
In-Reply-To: <54984f46-f50b-8306-2229-15ea96cea7d6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 15/18] memory: Share special empty
 FlatView
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 21/09/17 03:13, Paolo Bonzini wrote:
> On 20/09/2017 13:46, Alexey Kardashevskiy wrote:
>> This shares an cached empty FlatView among address spaces. The empty
>> FV is used every time when a root MR renders into a FV without memory
>> sections which happens when MR or its children are not enabled or
>> zero-sized. The empty_view is not NULL to keep the rest of memory
>> API intact; it also has a dispatch tree for the same reason.
>>
>> On POWER8 with 255 CPUs, 255 virtio-net, 40 PCI bridges guest this halves
>> the amount of FlatView's in use (557 -> 260) and dispatch tables
>> (~800000 -> ~370000), however the total memory footprint is pretty much
>> the same as RCU is holding all these temporary FVs which are created
>> (and then released) to make sure that they are empty and can be replaced
>> with @empty_view.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  memory.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/memory.c b/memory.c
>> index 4add0fd030..92b1304a20 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -48,6 +48,7 @@ static QTAILQ_HEAD(, AddressSpace) address_spaces
>>      = QTAILQ_HEAD_INITIALIZER(address_spaces);
>>  
>>  static GHashTable *flat_views;
>> +static FlatView *empty_view;
>>  
>>  typedef struct AddrRange AddrRange;
>>  
>> @@ -755,6 +756,19 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
>>      }
>>      flatview_simplify(view);
>>  
>> +    if (!view->nr) {
>> +        flatview_unref(view);
> 
> This can be changed to flatview_destroy directly to avoid overloading
> RCU with all these temporary FlatViews.


Yeah, this or just allocate every new FlatView on the stack first, I
thought about this a second after I posted this.


> 
> Paolo
> 
>> +        if (!empty_view) {
>> +            empty_view = flatview_new(NULL);
>> +        }
>> +        view = empty_view;
>> +        flatview_ref(view);
>> +    }
>> +
>> +    if (view->dispatch) {
>> +        return view;
>> +    }
>> +
>>      view->dispatch = address_space_dispatch_new(view);
>>      for (i = 0; i < view->nr; i++) {
>>          MemoryRegionSection mrs =
>>
> 


-- 
Alexey
