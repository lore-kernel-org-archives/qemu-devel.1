Received: from eggs.gnu.org ([2001:4830:134:3::10]:35428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evMX1-0001gY-Pe
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evMX0-00013Y-Pq
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:26:23 -0400
References: <20180306204819.11266-1-stefanha@redhat.com>
	<20180306204819.11266-2-stefanha@redhat.com>
	<f3e7a178-0002-fd12-caf2-585171de1b04@redhat.com>
	<20180312112741.GC5681@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e719736e-c2f1-4315-53e4-e3b073ffc0a7@redhat.com>
Date: Mon, 12 Mar 2018 07:26:07 -0500
MIME-Version: 1.0
In-Reply-To: <20180312112741.GC5681@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] block: let
 blk_add/remove_aio_context_notifier() tolerate BDS changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefano Panella <spanella@gmail.com>

On 03/12/2018 06:27 AM, Stefan Hajnoczi wrote:
> On Fri, Mar 09, 2018 at 09:56:44AM -0600, Eric Blake wrote:
>> On 03/06/2018 02:48 PM, Stefan Hajnoczi wrote:
>>> Commit 2019ba0a0197 ("block: Add AioContextNotifier functions to BB")
>>> added blk_add/remove_aio_context_notifier() and implemented them by
>>> passing through the bdrv_*() equivalent.
>>>
>>> This doesn't work across bdrv_append(), which detaches child->bs and
>>> re-attaches it to a new BlockDriverState.  When
>>> blk_remove_aio_context_notifier() is called we will access the new BDS
>>> instead of the one where the notifier was added!
>>>
>>>>  From the point of view of the blk_*() API user, changes to the root BDS
>>> should be transparent.
>>>
>>> This patch maintains a list of AioContext notifiers in BlockBackend and
>>> adds/removes them from the BlockDriverState as needed.
>>>

>>> +typedef struct BlockBackendAioNotifier {
>>> +    void (*attached_aio_context)(AioContext *new_context, void *opaque);
>>> +    void (*detach_aio_context)(void *opaque);
>>
>> Why the difference in tense (past 'attached' vs. present 'detach')?
> 
> The naming comes from the bdrv_add_aio_context_notifier() API:
> 
>    void bdrv_add_aio_context_notifier(BlockDriverState *bs,
>          void (*attached_aio_context)(AioContext *new_context, void *opaque),
>          void (*detach_aio_context)(void *opaque), void *opaque)
> 
> It's "attached" because bs->aio_context has already been assigned before
> the callback is invoked.
> 
> It's "detach" because the callback is invoked before bs->aio_context is
> cleared.
> 
> Not great naming and I found it weird when I looked at the code too, but
> at least this patch keeps the BlockBackend naming consistent with the
> BlockDriverState naming.

Odd, but consistent, so I can live with it.


>>> +
>>> +    QLIST_FOREACH(notifier, &blk->aio_notifiers, list) {
>>> +        if (notifier->attached_aio_context == attached_aio_context &&
>>> +            notifier->detach_aio_context == detach_aio_context &&
>>> +            notifier->opaque == opaque) {
>>> +            QLIST_REMOVE(notifier, list);
>>
>> Don't you need to use QLIST_FOREACH_SAFE if you are going to modify the list
>> during traversal?
> 
> It doesn't matter since we return right away:
> 
>    g_free(notifier);
>    return;

Okay, makes sense (a safe iteration is required if you keep iterating 
after action; but if you quit, the action has no impact on subsequent 
iteration since there is no further iteration).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
