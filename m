Received: from eggs.gnu.org ([209.51.188.92]:35279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gtDt3-0005gA-Mm
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gtDt1-0004fT-JL
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:52:49 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <6b3c82fb-b4a2-7802-1737-a34e22130114@virtuozzo.com>
References: <1548244464-633186-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w51o97m8ltv.fsf@maestria.local.igalia.com>
	<41e29129-196d-1b24-03ae-373b7d357725@virtuozzo.com>
	<w51sgwuv2ok.fsf@maestria.local.igalia.com>
	<6b3c82fb-b4a2-7802-1737-a34e22130114@virtuozzo.com>
Date: Mon, 11 Feb 2019 16:52:31 +0100
Message-ID: <w51mun2uxts.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 1/1] Stream block job
 involves copy-on-read filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

On Mon 11 Feb 2019 03:51:33 PM CET, Vladimir Sementsov-Ogievskiy wrote:
>>>> I think this was already discussed in the previous version of this
>>>> patch: if you insert a copy-on-read filter here then all guest
>>>> reads will copy the data from the backing chain, but you don't want
>>>> to copy anything below the 'base' node, so the copy-on-read filter
>>>> needs a 'base' parameter.
>>>>
>>> Before that, we still have the unresolved issue with getting the
>>> filter as the 'base' input parameter. That happens sometimes because
>>> the base is being searched by the file name, which is the same to
>>> the one of the filter, rather than by the node name (!)
>> 
>> I'm not sure if I understand. block-stream has 'base' and 'base-node'
>> parameters, and in the first case you would convert the file name to
>> a node name.
>> 
>> stream_start() gets the BlockDriverState, not the file name, so why
>> can't you get the node name from there and pass it to the
>> copy-on-read filter?
>
> The problem is in the concept of "base" node. The code written in
> manner that base is not changed during block job. However, job don't
> own base and there is no guarantee that it will not change during the
> job.

But if that's the case then we have a problem already, because 'base' is
a member of StreamBlockJob and is used in the existing stream_run()
code.

So if there's a way to make 'base' disappear during the job (how?) then
we could protect it with block_job_add_bdrv().

Berto
