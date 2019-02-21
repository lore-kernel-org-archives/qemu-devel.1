Received: from eggs.gnu.org ([209.51.188.92]:52600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gwpil-0000oK-Dp
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gwpik-0005MD-8e
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:53:07 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190212172756.GI5283@localhost.localdomain>
References: <cover.1547739122.git.berto@igalia.com>
	<dc004f69efb6631e17d4934635be21e3bf2cc9a3.1547739122.git.berto@igalia.com>
	<20190212172756.GI5283@localhost.localdomain>
Date: Thu, 21 Feb 2019 15:53:03 +0100
Message-ID: <w51y3696vn4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/13] block: Allow changing the backing
 file on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

(sorry I accidentally sent an incomplete reply a few minutes ago)

On Tue 12 Feb 2019 06:27:56 PM CET, Kevin Wolf wrote:
>>  - In bdrv_reopen_commit(): perform the actual node replacement by
>>    calling bdrv_set_backing_hd(). It may happen that there are
>>    temporary implicit nodes between the BDS that we are reopening and
>>    the backing file that we want to replace (e.g. a commit fiter node),
>>    so we must skip them.
>
> Hmm... I really dislike getting into the business of dealing with
> implicit nodes here. If you want to manage the block graph at the node
> level, you should manage all of it and just avoid getting implicit
> nodes in the first place. Otherwise, we'd have to guess where in the
> implicit chain you really want to add or remove nodes, and we're bound
> to guess wrong for some users.
>
> There is one problem with not skipping implicit nodes, though: Even if
> you don't want to manage things at the node level, we already force
> you to specify 'backing'. If there are implicit nodes, you don't knwo
> the real node name of the first backing child.
>
> So I suggest that we allow skipping implicit nodes for the purpose of
> leaving the backing link unchanged; but we return an error if you want
> to change the backing link and there are implicit nodes in the way.

That sounds good to me, and it doesn't really affect any of the test
cases that I had written.

>> +    if (new_backing_bs) {
>> +        if (bdrv_get_aio_context(new_backing_bs) != bdrv_get_aio_context(bs)) {
>> +            error_setg(errp, "Cannot use a new backing file "
>> +                       "with a different AioContext");
>> +            return -EINVAL;
>> +        }
>> +    }
>
> This is okay for a first version, but in reality, you'd usually want
> to just move the backing file into the right AioContext. Of course,
> this is only correct if the backing file doesn't have other users in
> different AioContexts. To get a good implementation for this, we'd
> probably need to store the AioContext in BdrvChild, like we already
> concluded for other use cases.
>
> Maybe document this as one of the problems to be solved before we can
> remove the x- prefix.

I agree, but I didn't want to mess with that yet. I added a comment
explaining that.

>> +    /*
>> +     * Skip all links that point to an implicit node, if any
>> +     * (e.g. a commit filter node). We don't want to change those.
>> +     */
>> +    overlay_bs = bs;
>> +    while (backing_bs(overlay_bs) && backing_bs(overlay_bs)->implicit) {
>> +        overlay_bs = backing_bs(overlay_bs);
>> +    }
>> +
>> +    if (new_backing_bs != backing_bs(overlay_bs)) {
>> +        if (bdrv_is_backing_chain_frozen(overlay_bs, backing_bs(overlay_bs),
>> +                                         errp)) {
>> +            return -EPERM;
>> +        }
>> +    }
>
> Should this function check new_backing_bs->drv->supports_backing, too?

I don't think the new backing file needs to support backing files
itself, one could e.g. replace a backing file (or even a longer chain)
with a raw file containing the same data.

>> +    /*
>> +     * Change the backing file if a new one was specified. We do this
>> +     * after updating bs->options, so bdrv_refresh_filename() (called
>> +     * from bdrv_set_backing_hd()) has the new values.
>> +     */
>> +    if (change_backing_bs) {
>> +        BlockDriverState *overlay = bs;
>> +        /*
>> +         * Skip all links that point to an implicit node, if any
>> +         * (e.g. a commit filter node). We don't want to change those.
>> +         */
>> +        while (backing_bs(overlay) && backing_bs(overlay)->implicit) {
>> +            overlay = backing_bs(overlay);
>> +        }
>> +        if (new_backing_bs != backing_bs(overlay)) {
>> +            bdrv_set_backing_hd(overlay, new_backing_bs, &error_abort);
>
> I'm afraid we can't use &error_abort here because bdrv_attach_child()
> could still fail due to permission conflicts.

But those permissions should have been checked already in
bdrv_reopen_prepare(). This function cannot return an error.

>>      bdrv_set_perm(reopen_state->bs, reopen_state->perm,
>
> Hm... Does bdrv_set_perm() work correctly when between
> bdrv_check_perm() and here the graph was changed?

I think you're right, bdrv_check_perm() might have been called on the
old backing file and it's not followed by set or abort if we change it.

I'll have a look at this.

Berto
