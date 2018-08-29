Received: from eggs.gnu.org ([2001:4830:134:3::10]:32783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fuzpr-0006wU-TM
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fuzc3-0005tW-PG
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:30:25 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <c9cb16fe-8e23-50c4-67c0-3c5952163099@redhat.com>
References: <cover.1535291602.git.berto@igalia.com>
	<d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
	<c9cb16fe-8e23-50c4-67c0-3c5952163099@redhat.com>
Date: Wed, 29 Aug 2018 14:29:41 +0200
Message-ID: <w51r2ih2w5m.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/9] block: Allow child references on reopen
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

On Wed 29 Aug 2018 01:26:46 PM CEST, Max Reitz wrote:
> On 2018-08-26 16:09, Alberto Garcia wrote:
>> In the previous patches we removed all child references from
>> bs->{options,explicit_options} because keeping them is useless and
>> wrong.
>> 
>> Because of this, any attempt to reopen a BlockDriverState using a
>> child reference as one of its options would result in a failure,
>> because bdrv_reopen_prepare() would detect that there's a new option
>> (the child reference) that wasn't present in bs->options.
>> 
>> But passing child references on reopen can be useful. It's a way to
>> specify a BDS's child without having to pass recursively all of the
>> child's options, and if the reference points to a different BDS then
>> this can allow us to replace the child.
>> 
>> However, replacing the child is something that needs to be implemented
>> case by case and only when it makes sense. For now, this patch allows
>> passing a child reference as long as it points to the current child of
>> the BlockDriverState.
>
> "For now"?  If you intend it to be case-by-case, won't it be handled by
> the driver's bdrv_reopen_prepare() implementation?

Yes, it will (except the "backing" reference which is handled by the
main bdrv_reopen_prepare() function).

What I meant with "For now" is that this patch doesn't add support for
any other case.

>> @@ -3241,6 +3241,25 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
>>              QObject *new = entry->value;
>>              QObject *old = qdict_get(reopen_state->bs->options, entry->key);
>>  
>> +            /* We allow child references 'child_name'='value'
>> +             * if 'child_name' is an existing child of the BDS
>> +             * and 'value' is the child's node name (a string). */
>> +            if (qobject_type(new) == QTYPE_QSTRING) {
>> +                BdrvChild *child;
>> +                QLIST_FOREACH(child, &reopen_state->bs->children, next) {
>> +                    if (!strcmp(child->name, entry->key)) {
>> +                        break;
>> +                    }
>> +                }
>> +
>> +                if (child) {
>> +                    const char *str = qobject_get_try_str(new);
>> +                    if (!strcmp(child->bs->node_name, str)) {
>> +                        continue; /* Found child with this name, skip option */
>> +                    }
>> +                }
>> +            }
>> +
>
> Looks good, but I think the comment looks a bit convoluted.  Maybe add
> a note like "(so the child has to stay the same)"?

Ok, I can think of making it shorter.

> Third...  Hm.  This is just a general question.  So as far as I
> understand we decided that when you don't specify an option for
> reopen, it means that the default is used, and that we don't want to
> retain the old value.

Correct.

> Specifically, that means when you don't specify @backing, the default
> chain will be opened and may replace the current one.

At the moment "backing" is the only child option that can be omitted,
all others must be specified. So if you leave "backing" out on reopen()
we have the following possibilities:

  a) We open the default backing file from disk. I don't think we want
     to open a new image on reopen(). Plus, what happens if the current
     backing image is the default one? Do we need to detect that? And
     what if it's the default image but has non-default options? The
     whole thing looks like a can of worms.

  b) We leave the current backing file untouched.

  c) We forbid it, and the user has to pass an explicit child, or NULL.

I chose (b) in this series. I suppose (c) could also be an option. But
(a) doesn't looke like a good idea.

It it inconsistent with the way blockdev-reopen is supposed to work?
Maybe it is, but I think we have to make an exception in this case.

> So why isn't it mandatory to re-specify all children for now?

It is, but "backing" is optional. As I said, we can make it mandatory on
reopen(). Perhaps it's the most consistent choice after all.

Berto
