Received: from eggs.gnu.org ([209.51.188.92]:42457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDW6y-0006bK-0k
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDW6w-0000he-S6
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:23:03 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <3e489e51-79c7-54ec-7018-e7424d2c6f40@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w517ec4y1wv.fsf@maestria.local.igalia.com>
	<3e489e51-79c7-54ec-7018-e7424d2c6f40@virtuozzo.com>
Date: Mon, 08 Apr 2019 17:22:58 +0200
Message-ID: <w514l78y10t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/3] block: include base when checking
 image chain for block allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Mon 08 Apr 2019 05:16:22 PM CEST, Andrey Shinkevich wrote:
> On 08/04/2019 18:03, Alberto Garcia wrote:
>> On Fri 05 Apr 2019 06:56:17 PM CEST, Andrey Shinkevich wrote:
>>> +int bdrv_is_allocated_above(BlockDriverState *top,
>>> +                            BlockDriverState *base,
>>> +                            int64_t offset, int64_t bytes, int64_t *pnum)
>>> +{
>>> +    return bdrv_do_is_allocated_above(top, base, false, offset, bytes, pnum);
>>> +}
>>> +
>>> +int bdrv_is_allocated_above_inclusive(BlockDriverState *top,
>>> +                                      BlockDriverState *base,
>>> +                                      int64_t offset, int64_t bytes,
>>> +                                      int64_t *pnum)
>>> +{
>>> +    return bdrv_do_is_allocated_above(top, base, true, offset, bytes, pnum);
>>> +}
>> 
>> Instead of having these two, isn't it simpler to add an 'include_base'
>> parameter to the original function?
>> 
>> Another alternative (I haven't checked this one so it could be more
>> cumbersome): change the semantics of the function to always include the
>> base and modify the callers.
>
> The idea behind those two functions was to keep the rest of the code
> unmodified. Currently, we have the issue with the block-stream
> parallel jobs. What if we manage this case first and then, when proved
> to be robust, take care of the rest?

Sure, that makes sense if you need to do significant changes to the
other callers, but if you just need to pass an extra 'false'
parameter...

It's not a big deal, I just think you'd have a simpler patch.

Berto
