Received: from eggs.gnu.org ([2001:4830:134:3::10]:39210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv1ym-0003UB-UK
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv1yi-0002bt-1c
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:57:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dv1yh-0002bZ-QR
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:57:19 -0400
References: <20170921120751.3027-1-pbonzini@redhat.com>
	<20170921120751.3027-3-pbonzini@redhat.com>
	<1d5f2bb4-c330-98b9-bf1a-6024a9f9093d@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d29597cd-773d-3268-4d27-a2f68c895d14@redhat.com>
Date: Thu, 21 Sep 2017 15:57:15 +0200
MIME-Version: 1.0
In-Reply-To: <1d5f2bb4-c330-98b9-bf1a-6024a9f9093d@ozlabs.ru>
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

On 21/09/2017 15:39, Alexey Kardashevskiy wrote:
> On 21/09/17 22:07, Paolo Bonzini wrote:
>> A container can be used instead of an alias to allow switching between
>> multiple subregions.  In this case we cannot directly share the
>> subregions (since they only belong to a single parent), but if the
>> subregions are aliases we can in turn walk those.
>>
>> While this does not reduce much the number of FlatViews that are created,
>> it makes it possible to share the PCI bus master FlatViews and their
>> AddressSpaceDispatch structures.  For 112 virtio-net-pci devices, boot time
>> is reduced from 25 to 10 seconds and memory consumption from 1.4 to 1 G.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  memory.c | 41 +++++++++++++++++++++++++++++++++++------
>>  1 file changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/memory.c b/memory.c
>> index 4952cc5d84..3207ae55e2 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -733,12 +733,41 @@ static void render_memory_region(FlatView *view,
>>  
>>  static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
>>  {
>> -    while (mr->alias && !mr->alias_offset &&
>> -           int128_ge(mr->size, mr->alias->size)) {
>> -        /* The alias is included in its entirety.  Use it as
>> -         * the "real" root, so that we can share more FlatViews.
>> -         */
>> -        mr = mr->alias;
>> +    while (mr->enabled) {
>> +        if (mr->alias && !mr->alias_offset &&
>> +            int128_ge(mr->size, mr->alias->size)) {
>> +            /* The alias is included in its entirety.  Use it as
>> +             * the "real" root, so that we can share more FlatViews.
>> +             */
>> +            mr = mr->alias;
>> +            continue;
>> +        }
>> +
>> +        if (!mr->terminates) {
> 
> Can an MR have terminates==true and children by the same time? If so, what for?

Yes, children override the parent.  But more important, !mr->terminates
means that patch 3 doesn't think that MR produces an empty FlatView.

> 
>> +            unsigned int found = 0;
>> +            MemoryRegion *child, *next = NULL;
>> +            QTAILQ_FOREACH(child, &mr->subregions, subregions_link) {
>> +                if (child->enabled) {
>> +                    if (++found > 1) {
>> +                        next = NULL;
>> +                        break;
>> +                    }
>> +                    if (!child->addr && int128_ge(mr->size, child->size)) {
> 
> 
> Ah, I tried this one but in v4's 18/18 (that hinting thing), did not work
> out but for a different reason.

Yeah, I did take some inspiration from your code, but we were thinking
of different scenarios (I wanted to cover the child->enabled == true).

Paolo

> 
>> +                        /* A child is included in its entirety.  If it's the only
>> +                         * enabled one, use it in the hope of finding an alias down the
>> +                         * way. This will also let us share FlatViews.
>> +                         */
>> +                        next = child;
>> +                    }
>> +                }
>> +            }
>> +            if (next) {
>> +                mr = next;
>> +                continue;
>> +            }
>> +        }
>> +
>> +        break;
>>      }
>>  
>>      return mr;
>>
> 
> 
