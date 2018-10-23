Received: from eggs.gnu.org ([2001:4830:134:3::10]:60691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gEyN4-00007a-R9
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gEyMv-0007oU-9q
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:13:25 -0400
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-6-david@gibson.dropbear.id.au>
	<f21b8a98-3401-cf82-749d-2101fbe69a33@redhat.com>
	<20181013064009.GG16167@umbus.fritz.box>
	<d26f9429-1da8-20d2-e43b-bee1141fb62f@redhat.com>
	<20181017032859.GB30180@umbus.fritz.box>
	<cee1e2e9-b10c-e8f3-c2a0-37555e03a6cf@redhat.com>
	<20181023080244.GA12127@umbus.hotspot.internet-for-guests.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d17bdce0-153e-87b3-74a8-63a02e4fc17c@redhat.com>
Date: Tue, 23 Oct 2018 17:13:05 +0200
MIME-Version: 1.0
In-Reply-To: <20181023080244.GA12127@umbus.hotspot.internet-for-guests.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 5/5] virtio-balloon: Safely handle
 BALLOON_PAGE_SIZE < host page size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


>>>>> I can see why, but I really can't see what else to do without breaking
>>>>> existing, supported, working (albeit by accident) setups.
>>>>
>>>> Is there any reason to use this more complicated "allow random freeing"
>>>> approach over a simplistic sequential freeing I propose? Then we can
>>>> simply migrate the last freed page and should be fine.
>>>
>>> Well.. your approach is probably simpler in terms of the calculations
>>> that need to be done, though only very slightly.  I think my approach
>>> is conceptually clearer though, since we're explicitly checking for
>>> exactly the condition we need, rather than something we thing should
>>> match up with that condition.
>>
>> I prefer to keep it simple where possible. We expect sequential freeing,
>> so it's easy to implement with only one additional uint64_t that can be
>> easily migrated. Having to use bitmaps + alloc/free is not really needed.
>>
>> If you insist, at least try to get rid of the malloc to e.g. simplify
>> migration.
> 
> I don't think there's really anything to do for migration; we already
> effectively lose the state of the balloon across migration.  I think
> it's fine to lose a little extra transitional state.

Yeah, I guess it would only make sense when trying to avoid misleading
warnings (depending on which approach you'll use for when to report
warnings).

-- 

Thanks,

David / dhildenb
