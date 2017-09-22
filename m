Received: from eggs.gnu.org ([2001:4830:134:3::10]:37931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dvFqj-0006T9-Mn
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 00:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dvFqg-0003hj-K3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 00:46:01 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dvFqg-0003dT-AX
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 00:45:58 -0400
Received: by mail-pg0-x242.google.com with SMTP id m30so9946pgn.5
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 21:45:56 -0700 (PDT)
References: <20170921120751.3027-1-pbonzini@redhat.com>
	<20170921120751.3027-3-pbonzini@redhat.com>
	<1d5f2bb4-c330-98b9-bf1a-6024a9f9093d@ozlabs.ru>
	<d29597cd-773d-3268-4d27-a2f68c895d14@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a7cbb7ee-a3a7-7775-f146-4fca9960327a@ozlabs.ru>
Date: Fri, 22 Sep 2017 14:45:50 +1000
MIME-Version: 1.0
In-Reply-To: <d29597cd-773d-3268-4d27-a2f68c895d14@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] memory: seek FlatView sharing
 candidates among children subregions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 21/09/17 23:57, Paolo Bonzini wrote:
> On 21/09/2017 15:39, Alexey Kardashevskiy wrote:
>> On 21/09/17 22:07, Paolo Bonzini wrote:
>>> A container can be used instead of an alias to allow switching between
>>> multiple subregions.  In this case we cannot directly share the
>>> subregions (since they only belong to a single parent), but if the
>>> subregions are aliases we can in turn walk those.
>>>
>>> While this does not reduce much the number of FlatViews that are created,
>>> it makes it possible to share the PCI bus master FlatViews and their
>>> AddressSpaceDispatch structures.  For 112 virtio-net-pci devices, boot time
>>> is reduced from 25 to 10 seconds and memory consumption from 1.4 to 1 G.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  memory.c | 41 +++++++++++++++++++++++++++++++++++------
>>>  1 file changed, 35 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/memory.c b/memory.c
>>> index 4952cc5d84..3207ae55e2 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -733,12 +733,41 @@ static void render_memory_region(FlatView *view,
>>>  
>>>  static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
>>>  {
>>> -    while (mr->alias && !mr->alias_offset &&
>>> -           int128_ge(mr->size, mr->alias->size)) {
>>> -        /* The alias is included in its entirety.  Use it as
>>> -         * the "real" root, so that we can share more FlatViews.
>>> -         */
>>> -        mr = mr->alias;
>>> +    while (mr->enabled) {
>>> +        if (mr->alias && !mr->alias_offset &&
>>> +            int128_ge(mr->size, mr->alias->size)) {
>>> +            /* The alias is included in its entirety.  Use it as
>>> +             * the "real" root, so that we can share more FlatViews.
>>> +             */
>>> +            mr = mr->alias;
>>> +            continue;
>>> +        }
>>> +
>>> +        if (!mr->terminates) {
>>
>> Can an MR have terminates==true and children by the same time? If so, what for?
> 
> Yes, children override the parent. > But more important, !mr->terminates
> means that patch 3 doesn't think that MR produces an empty FlatView.


I see, after some debugging only MRs with @terminates==true appear in the
dispatch tree which makes sense. But I am still struggling to understand
what @terminates really means here in plain english.



-- 
Alexey
