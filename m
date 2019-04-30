Received: from eggs.gnu.org ([209.51.188.92]:60662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLbwM-0000RJ-Rg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLbwL-0000rN-Nn
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:13:34 -0400
References: <20181116184324.8093-1-jsnow@redhat.com>
	<4bc81482-fab6-80dd-f684-4ffde4241dce@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cb6469ca-9ba3-1ac7-7c3e-9e6c8c53e55f@redhat.com>
Date: Tue, 30 Apr 2019 19:08:24 -0400
MIME-Version: 1.0
In-Reply-To: <4bc81482-fab6-80dd-f684-4ffde4241dce@virtuozzo.com>
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>



On 11/20/18 10:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> 16.11.2018 21:43, John Snow wrote:
>> Coverity warns that backing_bs() could give us a NULL pointer, which
>> we then use without checking that it isn't.
>>
>> In our loop condition, we check bs && bs->drv as a point of habit, but
>> by nature of the block graph, we cannot have null bs pointers here.
>>
>> This loop skips only implicit nodes, which always have children, so
>> this loop should never encounter a null value.
> 

I let this drop again :)

> You mean, always have backing (not file for ex.)? Should we at least add a comment
> near "bool implicit;" that the node must have backing..
> 
> Do we have filters, using 'file' child instead of backing, will we want to auto insert them, and therefore mark them with implicit=true?
> 

I actually have no idea. I guess this is the sort of thing we actually
really want a dedicated kind of API for. "Find first non-filter" seems
like a common use case that we'd want.

[But maybe I'll avoid this problem.]

> And one more thing:
> So, it's looks like a wrong way to search for all block-nodes, instead of looping through backing chain to the first not-implicit bds, we must recursively explore the whole block graph, to find _all_ the bitmaps.
> 

Looking at this again after not having done so for so long -- I guess
that bdrv_first/bdrv_next only iterate over *top level* BDSes and not
any children thereof. You're right, even the method here isn't quite
correct. We want to find ALL nodes, wherever they are.

query_named_block_nodes uses an implementation in block.c to accomplish
this because the API is not public.... or, it wasn't, but it looks like
we have bdrv_next_all_states now, and we could use this to just find ALL
of the bdrv nodes.

Ehm.... let me send something a little more RFC-caliber that should
address your concern (as well as Peter's) here.

--js
