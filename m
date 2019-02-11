Received: from eggs.gnu.org ([209.51.188.92]:36687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gtCFm-0007vO-UO
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gtCFm-0006sH-3N
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:08:10 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <41e29129-196d-1b24-03ae-373b7d357725@virtuozzo.com>
References: <1548244464-633186-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w51o97m8ltv.fsf@maestria.local.igalia.com>
	<41e29129-196d-1b24-03ae-373b7d357725@virtuozzo.com>
Date: Mon, 11 Feb 2019 15:07:39 +0100
Message-ID: <w51sgwuv2ok.fsf@maestria.local.igalia.com>
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
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

On Fri 08 Feb 2019 04:29:48 PM CET, Andrey Shinkevich wrote:
> On 08/02/2019 16:13, Alberto Garcia wrote:
>> On Wed 23 Jan 2019 12:54:24 PM CET, Andrey Shinkevich wrote:
>>> +static BlockDriverState *insert_filter(BlockDriverState *bs, Error **errp)
>>> +{
>>> +    BlockDriverState *cor_filter_bs;
>>> +    Error *local_err = NULL;
>>> +
>>> +    cor_filter_bs = create_filter_node(bs, errp);
>>> +    if (cor_filter_bs == NULL) {
>>> +        error_prepend(errp, "Could not create filter node: ");
>>> +        return NULL;
>>> +    }
>>> +
>>> +    bdrv_set_aio_context(cor_filter_bs, bdrv_get_aio_context(bs));
>>> +
>>> +    bdrv_drained_begin(bs);
>>> +    bdrv_replace_node(bs, cor_filter_bs, &local_err);
>>> +    bdrv_drained_end(bs);
>> 
>> I think this was already discussed in the previous version of this
>> patch: if you insert a copy-on-read filter here then all guest reads
>> will copy the data from the backing chain, but you don't want to copy
>> anything below the 'base' node, so the copy-on-read filter needs a
>> 'base' parameter.
>> 
> Before that, we still have the unresolved issue with getting the
> filter as the 'base' input parameter. That happens sometimes because
> the base is being searched by the file name, which is the same to the
> one of the filter, rather than by the node name (!)

I'm not sure if I understand. block-stream has 'base' and 'base-node'
parameters, and in the first case you would convert the file name to a
node name.

stream_start() gets the BlockDriverState, not the file name, so why
can't you get the node name from there and pass it to the copy-on-read
filter?

Berto
