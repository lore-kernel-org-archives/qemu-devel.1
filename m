Received: from eggs.gnu.org ([2001:4830:134:3::10]:37607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duonu-0000kh-S6
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 19:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duonr-0000TS-GB
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 19:53:18 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:46785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1duonr-0000T3-A5
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 19:53:15 -0400
Received: by mail-pg0-x235.google.com with SMTP id i130so2562617pgc.3
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 16:53:15 -0700 (PDT)
References: <20170920114637.42004-1-aik@ozlabs.ru>
	<20170920114637.42004-13-aik@ozlabs.ru>
	<c8660368-ffec-9051-7dcb-97d13c6ba850@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <826915f8-da16-0313-5b8c-301bb7db01d3@ozlabs.ru>
Date: Thu, 21 Sep 2017 09:53:10 +1000
MIME-Version: 1.0
In-Reply-To: <c8660368-ffec-9051-7dcb-97d13c6ba850@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 12/18] memory: Share FlatView's and
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

On 21/09/17 03:18, Paolo Bonzini wrote:
> On 20/09/2017 13:46, Alexey Kardashevskiy wrote:
>> +    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>> +        MemoryRegion *physmr = memory_region_get_flatview_root(as->root);
>> +        FlatView *new_view = g_hash_table_lookup(flat_views, physmr);
>> +
>> +        if (new_view) {
>> +            continue;
>> +        }
>> +
>> +        new_view = generate_memory_topology(physmr);
>> +        g_hash_table_insert(flat_views, physmr, new_view);
> 
> generate_memory_topology can do the g_hash_table_lookup + insert I think?

Yeah, I suppose. But rather g_hash_table_replace() if we decide to proceed
with 18/18 (or even if we do not - _replace() simply inserts if there was
no such element).


>>  static void flatview_set_to_address_space(AddressSpace *as)
>>  {
>> -    FlatView *old_view = address_space_get_flatview(as);
>> +    FlatView *old_view = address_space_to_flatview(as);
>>      MemoryRegion *physmr = memory_region_get_flatview_root(as->root);
>>      FlatView *new_view = g_hash_table_lookup(flat_views, physmr);
> 
> Rename to address_space_set_flatview?

Sure, why not :)


-- 
Alexey
