Received: from eggs.gnu.org ([209.51.188.92]:40951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gw7ol-00069F-KE
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:00:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gw7ok-0004AD-AF
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:00:23 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190212162806.GF5283@localhost.localdomain>
References: <cover.1547739122.git.berto@igalia.com>
	<f112a3019e4e1dfc2de6c275edadb5fc3a58ade0.1547739122.git.berto@igalia.com>
	<20190212162806.GF5283@localhost.localdomain>
Date: Tue, 19 Feb 2019 17:00:03 +0100
Message-ID: <w51va1fahvg.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/13] block: Handle child references in
 bdrv_reopen_queue()
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

On Tue 12 Feb 2019 05:28:06 PM CET, Kevin Wolf wrote:
>>    1) Set of child options: the options are removed from the parent's
>>       options QDict and are passed to the child with a recursive
>>       bdrv_reopen_queue() call. This case was already working fine.
>
> Small addition: This is only allowed if the child was implicitly
> created (i.e. it inherits from the parent we're coming from).

Ok, fixed.

>>    2) Child reference: there's two possibilites here.
>> 
>>       2a) Reference to the current child: the child is put in the
>>           reopen queue, keeping its current set of options (since this
>>           was a child reference there was no way to specify a
>>           different set of options).
>
> Why even put it in the reopen queue when nothing is going to change?
>
> Ah, it's because inherited options might change, right?
>
> But if the child did not inherit from this parent, we don't need to
> put it into the queue anyway. The operation should still be allowed.

I updated the comment to clarify that.

>>       2b) Reference to a different BDS: the current child is not put
>>           in the reopen queue at all. Passing a reference to a
>>           different BDS can be used to replace a child, although at
>>           the moment no driver implements this, so it results in an
>>           error. In any case, the current child is not going to be
>>           reopened (and might in fact disappear if it's replaced)
>
> Do we need to break a possible inheritance relationship between the
> parent and the old child node in this case?

Actually I think it makes sense (but not in this patch). I guess that
should be done in bdrv_set_backing_hd().

>>    4) Missing option: at the moment "backing" is the only case where
>>       this can happen. With "blockdev-add", leaving "backing" out
>>       means that the default backing file is opened. We don't want to
>>       open a new image during reopen, so we require that "backing" is
>>       always present. We'll relax this requirement a bit in the next
>>       patch.
>
> I think this is only for keep_old_opts == false; otherwise it should
> be treated the same as 2a to avoid breaking compatibility.

Ok, I clarified that too.

>>      QLIST_FOREACH(child, &bs->children, next) {
>> -        QDict *new_child_options;
>> -        char *child_key_dot;
>> +        QDict *new_child_options = NULL;
>> +        bool child_keep_old = keep_old_opts;
>>  
>>          /* reopen can only change the options of block devices that were
>>           * implicitly created and inherited options. For other (referenced)
>> @@ -3043,13 +3055,31 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
>>              continue;
>>          }
>
> The 'continue' in the context just skipped any children that don't
> inherit from this parent. Child options for those will stay unmodified
> in the options dict.
>
> For case 1, we'll later get an error because keys like 'child.foo'
> will still be present and can't be processed by the driver. Implements
> exactly what I commented above.
>
> For case 2, the child isn't put in the reopen queue, and the child
> reference can be used later. Matches my comment as well.
>
> Good.

That's correct.

>> -        child_key_dot = g_strdup_printf("%s.", child->name);
>> -        qdict_extract_subqdict(explicit_options, NULL, child_key_dot);
>> -        qdict_extract_subqdict(options, &new_child_options, child_key_dot);
>> -        g_free(child_key_dot);
>> +        /* Check if the options contain a child reference */
>> +        if (qdict_haskey(options, child->name)) {
>> +            const char *childref = qdict_get_try_str(options, child->name);
>> +            /*
>> +             * The current child must not be reopened if the child
>> +             * reference does not point to it.
>> +             */
>> +            if (g_strcmp0(childref, child->bs->node_name)) {
>
> This is where we would break the inheritance relationship.
>
> Is this the code path that a QNull should take as well? (case 3)

Yes, I updated the comment to mention the null case explicitly.

>> +    if (reopen_state->backing_missing) {
>> +        error_setg(errp, "backing is missing for '%s'",
>> +                   reopen_state->bs->node_name);
>> +        ret = -EINVAL;
>> +        goto error;
>> +    }
>
> What about drivers that don't even support backing files?

In practice this doesn't matter much because of the changes in patch 7,
but I think it's a good idea to make it explicit and set backing_missing
only when bs->drv->supports_backing is true (because it doesn't make
sense otherwise).

Berto
