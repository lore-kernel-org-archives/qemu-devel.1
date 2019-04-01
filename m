Received: from eggs.gnu.org ([209.51.188.92]:38919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hAz6w-00055v-OF
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hAz6v-0005Mp-Ox
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:44:34 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <85b426d8-0d8a-1180-fe80-46450b83582b@virtuozzo.com>
References: <1553866154-257311-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1553866154-257311-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w51sgv54qaz.fsf@maestria.local.igalia.com>
	<85b426d8-0d8a-1180-fe80-46450b83582b@virtuozzo.com>
Date: Mon, 01 Apr 2019 17:44:11 +0200
Message-ID: <w51y34t4to4.fsf@maestria.local.igalia.com>
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>

On Fri 29 Mar 2019 05:15:43 PM CET, Vladimir Sementsov-Ogievskiy wrote:
>>> @@ -3237,7 +3238,14 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>>>           job_flags |= JOB_MANUAL_DISMISS;
>>>       }
>>>   
>>> -    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
>>> +    /* Find the bottom node that has the base as its backing image */
>>> +    bottom_node = bs;
>>> +    while ((iter = backing_bs(bottom_node)) != base_bs) {
>>> +        bottom_node = iter;
>>> +    }
>>> +    assert(bottom_node);
>>> +
>>> +    stream_start(has_job_id ? job_id : NULL, bs, bottom_node, base_name,
>>>                    job_flags, has_speed ? speed : 0, on_error, &local_err);
>> 
>> Isn't it simpler to pass 'base' to stream_start() and find the bottom
>> node there? (with bdrv_find_overlay()).
>> 
>> I think bottom should be an internal implementation detail of the
>> block-stream driver, callers don't need to know about it, or do they?
>> 
> My idea is that we should get rid of base before any yield, and better
> do it as soon as possible.

But you can do it at the beginning of stream_start() without exposing
'bottom' to the callers which, again, is an implementation detail.

Berto
