Received: from eggs.gnu.org ([209.51.188.92]:51431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDs2y-0007K3-36
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDs2x-0002e6-9O
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:48:24 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <e27a15f8-c299-7a08-3594-680aa1342b2b@virtuozzo.com>
References: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w517ec345zb.fsf@maestria.local.igalia.com>
	<e27a15f8-c299-7a08-3594-680aa1342b2b@virtuozzo.com>
Date: Tue, 09 Apr 2019 16:48:18 +0200
Message-ID: <w514l7744lp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 1/3] block: include base when checking
 image chain for block allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>

On Tue 09 Apr 2019 04:43:12 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>> -    while (intermediate && intermediate != base) {
>>> +    while (include_base || intermediate != base) {
>>>           int64_t pnum_inter;
>>>           int64_t size_inter;
>>>   
>>> @@ -2360,6 +2364,10 @@ int bdrv_is_allocated_above(BlockDriverState *top,
>>>               n = pnum_inter;
>>>           }
>>>   
>>> +        if (intermediate == base) {
>>> +            break;
>>> +        }
>>> +
>>>           intermediate = backing_bs(intermediate);
>> 
>> I find that the new condition + the break make things a bit less
>> readable. I think it would be simpler with something like this:
>> 
>>     BlockDriverState *stop_at = include_base ? backing_bs(base) : base;
>> 
>>     while (intermediate != stop_at) {
>>        ...
>>     }
>> 
>
> But in this way you return back dependence on base, which we don't
> freeze and which may disappear on some iteration. We should not touch
> backing_bs(base) in any way.

Ok, I see.

Reviewed-by: Alberto Garcia <berto@igalia.com>

(feel free to edit the comment with my suggestion, or leave it as it is
if you prefer)

Berto
