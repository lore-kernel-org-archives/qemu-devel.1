Received: from eggs.gnu.org ([209.51.188.92]:34980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2NiN-0001r3-KP
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2NiM-0002p5-SO
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:11:39 -0500
References: <20190305234337.18353-1-jsnow@redhat.com>
	<20190305234337.18353-3-jsnow@redhat.com>
	<28d6183a-f654-de55-36ed-ee0bafb47739@redhat.com>
	<fe8ae9ab-068d-cc24-76de-e2a99215ea5f@redhat.com>
	<d362b81a-1e9c-0761-3cbe-65739a051ce7@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <73ddcaa9-97dc-238b-2949-ac73bc863abe@redhat.com>
Date: Fri, 8 Mar 2019 17:11:35 -0500
MIME-Version: 1.0
In-Reply-To: <d362b81a-1e9c-0761-3cbe-65739a051ce7@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] block/qcow2-bitmap: Allow bitmap
 flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 3/6/19 11:12 AM, Vladimir Sementsov-Ogievskiy wrote:
> 06.03.2019 18:59, John Snow wrote:
>>
>>
>> On 3/6/19 7:58 AM, Eric Blake wrote:
>>> On 3/5/19 5:43 PM, John Snow wrote:
>>>> Usually, we only write out bitmaps when we're about to close out the file,
>>>> so we always remove the bitmaps after to make it easier to determine the
>>>> source of truth for migration purposes.
>>>>
>>>> However, there may be times we want to flush bitmap data more aggressively,
>>>> like after a truncate event where we need to make the metadata consistent
>>>> again.
>>>
>>> Or, as I've mentioned in other threads, after every
>>> bitmap-add/bitmap-delete operation, so that 'qemu-img info -U' can see
>>> which persistent bitmaps exist. But that's one step further than this
>>> series, so I won't insist on it today.
>>>
>>
>> Yes, I was keeping that in mind as I wrote this. I think it extends to
>> those cases trivially, so long as Vladimir is OK with what I'm trying to do.
>>
> 
> I still don't see the point of flushing bitmaps, the only thing is optimizing
> qemu-img info --force-share, which should never used except for debugging.
> 
> So, at least, if we'll have it, I'd prefer bitmap flushing to be optional,
> and other code should not rely on it.
> 

I don't have plans to add more uses of it personally, but I do think
that resize represents a genuine case of wanting the feature.
