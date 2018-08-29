Received: from eggs.gnu.org ([2001:4830:134:3::10]:44738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fv1pZ-0005Fq-Ca
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 10:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fv1pW-0003oj-6v
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 10:52:25 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <26c1da0d-5076-0fd3-e761-4c0d61e4856e@redhat.com>
References: <cover.1535291602.git.berto@igalia.com>
	<054195c8f83f524ee1f4d117407ac507dd18b0d8.1535291602.git.berto@igalia.com>
	<af713c19-bc70-c581-aa9c-58aa08ab5e55@redhat.com>
	<w51tvnd2xt6.fsf@maestria.local.igalia.com>
	<26c1da0d-5076-0fd3-e761-4c0d61e4856e@redhat.com>
Date: Wed, 29 Aug 2018 16:52:18 +0200
Message-ID: <w51lg8p2pjx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/9] block: Remove child references from
 bs->{options, explicit_options}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed 29 Aug 2018 02:18:45 PM CEST, Max Reitz wrote:
>>>> @@ -3313,6 +3317,12 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
>>>>      bs->open_flags         = reopen_state->flags;
>>>>      bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
>>>>  
>>>> +    /* Remove child references from bs->options and bs->explicit_options */
>>>> +    QLIST_FOREACH(child, &bs->children, next) {
>>>> +        qdict_del(bs->explicit_options, child->name);
>>>> +        qdict_del(bs->options, child->name);
>>>> +    }
>>>> +
>>>
>>> Why don't you remove the child options as well?
>> 
>> Because there's no child options here at this point. They are removed
>> from the parent QDict in bdrv_reopen_queue_child():
>> 
>>   QLIST_FOREACH(child, &bs->children, next) {
>>       /* ... */
>>       child_key_dot = g_strdup_printf("%s.", child->name);
>>       qdict_extract_subqdict(explicit_options, NULL, child_key_dot);
>>       qdict_extract_subqdict(options, &new_child_options, child_key_dot);
>>       g_free(child_key_dot);
>> 
>>       bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options, 0,
>>                               child->role, options, flags);
>>   }
>
> Hm.  It's a bit weird to split child options and child references into
> two parts, but I suppose it makes sense.

The child references have to remain in the parent until at least
bdrv_reopen_prepare() because we need them if we want to allow replacing
a child.

The child options are removed in bdrv_reopen_queue_child() because we
need to pass them to the children. We could also make a copy and remove
them later in bdrv_reopen_commit() if that makes things more clear, but
I don't know...

> What do you think of adding a note to make it more clear?
> (e.g. "(The inline child options have been handled in
> bdrv_reopen_queue_child() already)")

Sure, why not.

> [1] On second thought, we do probably want to check the references
> there, at least.  If you attach a new child, there is no need to reopen
> the current child, so we should skip the bdrv_reopen_queue_child()

Yes, that's done in a subsequent patch (not part of this series yet).

Berto
