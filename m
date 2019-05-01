Received: from eggs.gnu.org ([209.51.188.92]:53149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLs9K-0001od-Ha
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLs9H-0004VG-GM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:32:02 -0400
References: <20181116184324.8093-1-jsnow@redhat.com>
	<4bc81482-fab6-80dd-f684-4ffde4241dce@virtuozzo.com>
	<cb6469ca-9ba3-1ac7-7c3e-9e6c8c53e55f@redhat.com>
	<fb05bc7d-7632-f72c-1c32-ba16d21a7fcb@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <596c4cc2-88d0-e34c-d104-11ede3e98164@redhat.com>
Date: Wed, 1 May 2019 12:31:37 -0400
MIME-Version: 1.0
In-Reply-To: <fb05bc7d-7632-f72c-1c32-ba16d21a7fcb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: Silence
 coverity CID 1390625
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>



On 5/1/19 11:24 AM, Eric Blake wrote:
> On 4/30/19 6:08 PM, John Snow wrote:
>>
>>
>> On 11/20/18 10:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 16.11.2018 21:43, John Snow wrote:
>>>> Coverity warns that backing_bs() could give us a NULL pointer, which
>>>> we then use without checking that it isn't.
>>>>
>>>> In our loop condition, we check bs && bs->drv as a point of habit, but
>>>> by nature of the block graph, we cannot have null bs pointers here.
>>>>
>>>> This loop skips only implicit nodes, which always have children, so
>>>> this loop should never encounter a null value.
>>>
>>
>> I let this drop again :)
>>
>>> You mean, always have backing (not file for ex.)? Should we at least add a comment
>>> near "bool implicit;" that the node must have backing..
>>>
>>> Do we have filters, using 'file' child instead of backing, will we want to auto insert them, and therefore mark them with implicit=true?
>>>
>>
>> I actually have no idea. I guess this is the sort of thing we actually
>> really want a dedicated kind of API for. "Find first non-filter" seems
>> like a common use case that we'd want.
>>
>> [But maybe I'll avoid this problem.]
> 
> Max has already tried to tackle that problem:
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01713.html
> 

OK, that's great!

>>
>>> And one more thing:
>>> So, it's looks like a wrong way to search for all block-nodes, instead of looping through backing chain to the first not-implicit bds, we must recursively explore the whole block graph, to find _all_ the bitmaps.
>>>
>>
>> Looking at this again after not having done so for so long -- I guess
>> that bdrv_first/bdrv_next only iterate over *top level* BDSes and not
>> any children thereof. You're right, even the method here isn't quite
>> correct. We want to find ALL nodes, wherever they are.
>>
>> query_named_block_nodes uses an implementation in block.c to accomplish
>> this because the API is not public.... or, it wasn't, but it looks like
>> we have bdrv_next_all_states now, and we could use this to just find ALL
>> of the bdrv nodes.
>>
>> Ehm.... let me send something a little more RFC-caliber that should
>> address your concern (as well as Peter's) here.
> 
> Max's series also tries to improve how we visit nodes when determining
> which bitmaps to find.
> 

2/11 adds the "skip filters" helper I mentioned wanting, but the idea of
visiting *every* node for bitmap migration is not addressed in that series.

Therefore, I believe these series conflict, but that this one takes
precedence for this particular issue.

--js
