Received: from eggs.gnu.org ([2001:4830:134:3::10]:60730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dvINz-0008WI-Te
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dvINw-0005Zp-Ko
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:28:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dvINw-0005Zf-BF
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:28:28 -0400
References: <20170921120751.3027-1-pbonzini@redhat.com>
	<20170921120751.3027-3-pbonzini@redhat.com>
	<1d5f2bb4-c330-98b9-bf1a-6024a9f9093d@ozlabs.ru>
	<d29597cd-773d-3268-4d27-a2f68c895d14@redhat.com>
	<a7cbb7ee-a3a7-7775-f146-4fca9960327a@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cea99470-0eab-53d3-30dc-213ef14cd9aa@redhat.com>
Date: Fri, 22 Sep 2017 09:28:25 +0200
MIME-Version: 1.0
In-Reply-To: <a7cbb7ee-a3a7-7775-f146-4fca9960327a@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 22/09/2017 06:45, Alexey Kardashevskiy wrote:
> On 21/09/17 23:57, Paolo Bonzini wrote:
>> On 21/09/2017 15:39, Alexey Kardashevskiy wrote:
>>> On 21/09/17 22:07, Paolo Bonzini wrote:
>>>> A container can be used instead of an alias to allow switching between
>>>> multiple subregions.  In this case we cannot directly share the
>>>> subregions (since they only belong to a single parent), but if the
>>>> subregions are aliases we can in turn walk those.
>>>>
>>>> While this does not reduce much the number of FlatViews that are created,
>>>> it makes it possible to share the PCI bus master FlatViews and their
>>>> AddressSpaceDispatch structures.  For 112 virtio-net-pci devices, boot time
>>>> is reduced from 25 to 10 seconds and memory consumption from 1.4 to 1 G.
>>>>
>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> ---
>>>>  memory.c | 41 +++++++++++++++++++++++++++++++++++------
>>>>  1 file changed, 35 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/memory.c b/memory.c
>>>> index 4952cc5d84..3207ae55e2 100644
>>>> --- a/memory.c
>>>> +++ b/memory.c
>>>> @@ -733,12 +733,41 @@ static void render_memory_region(FlatView *view,
>>>>  
>>>>  static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
>>>>  {
>>>> -    while (mr->alias && !mr->alias_offset &&
>>>> -           int128_ge(mr->size, mr->alias->size)) {
>>>> -        /* The alias is included in its entirety.  Use it as
>>>> -         * the "real" root, so that we can share more FlatViews.
>>>> -         */
>>>> -        mr = mr->alias;
>>>> +    while (mr->enabled) {
>>>> +        if (mr->alias && !mr->alias_offset &&
>>>> +            int128_ge(mr->size, mr->alias->size)) {
>>>> +            /* The alias is included in its entirety.  Use it as
>>>> +             * the "real" root, so that we can share more FlatViews.
>>>> +             */
>>>> +            mr = mr->alias;
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        if (!mr->terminates) {
>>>
>>> Can an MR have terminates==true and children by the same time? If so, what for?
>>
>> Yes, children override the parent. > But more important, !mr->terminates
>> means that patch 3 doesn't think that MR produces an empty FlatView.
> 
> 
> I see, after some debugging only MRs with @terminates==true appear in the
> dispatch tree which makes sense. But I am still struggling to understand
> what @terminates really means here in plain english.

As you found out, perhaps "dispatched" would be a better name than
"terminates".  A MR can be "alias", "terminates" or "!terminates".
Aliases are resolved early.  If a range is allocated to a "terminates"
region A (and not to any other "terminates" region in A's subtree), it
dispatches to A.

If a range is allocated to a "!terminates" region B (and to any other
"terminates" region in B's subtree, QEMU doesn't add it to the FlatView
and it will be dispatched to another memory region: B's parent, another
region in B's parent's subtree, B's grandparent, another region in B's
grandparent's subtree, and so on---if nobody accepts it, it goes to
unassigned_mem_ops.

Paolo
