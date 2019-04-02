Received: from eggs.gnu.org ([209.51.188.92]:35077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hBKcb-0002L9-4R
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hBKca-0007vA-1f
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:42:41 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1c21c139-a98d-1510-a1ec-1f9131c219bc@virtuozzo.com>
References: <1553866154-257311-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1553866154-257311-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w51sgv54qaz.fsf@maestria.local.igalia.com>
	<85b426d8-0d8a-1180-fe80-46450b83582b@virtuozzo.com>
	<w51y34t4to4.fsf@maestria.local.igalia.com>
	<1c21c139-a98d-1510-a1ec-1f9131c219bc@virtuozzo.com>
Date: Tue, 02 Apr 2019 16:42:32 +0200
Message-ID: <w51r2ako4dj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/3] block/stream: introduce a bottom node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>

On Tue 02 Apr 2019 10:51:06 AM CEST, Andrey Shinkevich wrote:
>>>>> @@ -3237,7 +3238,14 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>>>>>            job_flags |= JOB_MANUAL_DISMISS;
>>>>>        }
>>>>>    
>>>>> -    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
>>>>> +    /* Find the bottom node that has the base as its backing image */
>>>>> +    bottom_node = bs;
>>>>> +    while ((iter = backing_bs(bottom_node)) != base_bs) {
>>>>> +        bottom_node = iter;
>>>>> +    }
>>>>> +    assert(bottom_node);
>>>>> +
>>>>> +    stream_start(has_job_id ? job_id : NULL, bs, bottom_node, base_name,
>>>>>                     job_flags, has_speed ? speed : 0, on_error, &local_err);
>>>>
>>>> Isn't it simpler to pass 'base' to stream_start() and find the
>>>> bottom node there? (with bdrv_find_overlay()).
>>>>
>>>> I think bottom should be an internal implementation detail of the
>>>> block-stream driver, callers don't need to know about it, or do
>>>> they?
>>>>
>>> My idea is that we should get rid of base before any yield, and
>>> better do it as soon as possible.
>> 
>> But you can do it at the beginning of stream_start() without exposing
>> 'bottom' to the callers which, again, is an implementation detail.
>
> We have got a latent trouble with the base involved into the process.
> For instance, if we encounter a filter while searching for the base,
> we will want to manage it somehow. If the base is identified by the
> node name rather than by file name, it would be easier. So, we would
> assign the node name to the base earliest as possible.

There's already the 'base-node' parameter, and converting 'base' into
'base-node' is already done early on by qmp_block_stream() so it doesn't
make much difference whether the user passed the former or the latter.

> Another approach suggested by Vladimir supposed to eliminate the base
> from the interface.  It is a sensitive change and we all need to come
> to an agreement.

Well, replacing 'base' with 'bottom' on the public API is a completely
different thing and I'm not sure if it's a good idea.

'base' is used to decide the new backing image after block-stream
completes, and its semantics are quite clear. But that does not mean
that 'base' must be used throughout the implementation of block-stream.

If it turns out that block-stream is best implemented using a 'bottom'
node istead of 'base' then the first thing that stream_start() can do is
calculate 'bottom' and discard 'base'.

Whether you do that at the beginning of stream_start() or at the end of
qmp_block_stream() does not make any difference in practice, the end
result is going to be the same.

The only reason why I'm proposing this is because I don't think 'base'
needs to be removed from the public API and therefore I see 'bottom' as
simply an implementation detail that doesn't need to be exposed outside
stream.c

Berto
