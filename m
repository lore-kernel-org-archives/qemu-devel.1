Received: from eggs.gnu.org ([2001:4830:134:3::10]:46421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fuz30-0007QC-24
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fuz2v-0003gk-Bz
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:54:05 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <af713c19-bc70-c581-aa9c-58aa08ab5e55@redhat.com>
References: <cover.1535291602.git.berto@igalia.com>
	<054195c8f83f524ee1f4d117407ac507dd18b0d8.1535291602.git.berto@igalia.com>
	<af713c19-bc70-c581-aa9c-58aa08ab5e55@redhat.com>
Date: Wed, 29 Aug 2018 13:53:57 +0200
Message-ID: <w51tvnd2xt6.fsf@maestria.local.igalia.com>
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

On Wed 29 Aug 2018 12:43:06 PM CEST, Max Reitz wrote:
> On 2018-08-26 16:09, Alberto Garcia wrote:
>> Block drivers allow opening their children using a reference to an
>> existing BlockDriverState. These references remain stored in the
>> 'options' and 'explicit_options' QDicts, but we don't need to keep
>> them once everything is open.
>> 
>> What is more important, these values can become wrong if the children
>> change:
>> 
>>     $ qemu-img create -f qcow2 hd0.qcow2 10M
>>     $ qemu-img create -f qcow2 hd1.qcow2 10M
>>     $ qemu-img create -f qcow2 hd2.qcow2 10M
>>     $ $QEMU -drive if=none,file=hd0.qcow2,node-name=hd0 \
>>             -drive if=none,file=hd1.qcow2,node-name=hd1,backing=hd0 \
>>             -drive file=hd2.qcow2,node-name=hd2,backing=hd1
>> 
>> After this hd2 has hd1 as its backing file. Now let's remove it using
>> block_stream:
>> 
>>     (qemu) block_stream hd2 0 hd0.qcow2
>> 
>> Now hd0 is the backing file of hd2, but hd2's options QDicts still
>> contain backing=hd1.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> Also, the question is, why would we discard the child options, but
> keep the references (which we do not add, so we only have the ones
> specified by the user).

We discussed this a couple of weeks ago: 

https://lists.gnu.org/archive/html/qemu-block/2018-08/msg00478.html

In the end I got convinced that we didn't need to keep the child
references.

>> @@ -3313,6 +3317,12 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
>>      bs->open_flags         = reopen_state->flags;
>>      bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
>>  
>> +    /* Remove child references from bs->options and bs->explicit_options */
>> +    QLIST_FOREACH(child, &bs->children, next) {
>> +        qdict_del(bs->explicit_options, child->name);
>> +        qdict_del(bs->options, child->name);
>> +    }
>> +
>
> Why don't you remove the child options as well?

Because there's no child options here at this point. They are removed
from the parent QDict in bdrv_reopen_queue_child():

  QLIST_FOREACH(child, &bs->children, next) {
      /* ... */
      child_key_dot = g_strdup_printf("%s.", child->name);
      qdict_extract_subqdict(explicit_options, NULL, child_key_dot);
      qdict_extract_subqdict(options, &new_child_options, child_key_dot);
      g_free(child_key_dot);

      bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options, 0,
                              child->role, options, flags);
  }

Berto
