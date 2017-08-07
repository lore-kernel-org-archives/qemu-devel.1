Received: from eggs.gnu.org ([2001:4830:134:3::10]:45918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1degti-0002np-HW
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1degtd-00082x-JE
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:12:38 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <63b22cb5-9753-85cc-283e-1b0b7710bcbf@redhat.com>
References: <20170804140848.880-1-berto@igalia.com>
	<0c382c84-1135-56b6-d90f-1c44e33f1f00@redhat.com>
	<w51y3qvn4y4.fsf@maestria.local.igalia.com>
	<63b22cb5-9753-85cc-283e-1b0b7710bcbf@redhat.com>
Date: Mon, 07 Aug 2017 14:12:30 +0200
Message-ID: <w51poc7mv9t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10] quorum: Handle bdrv_getlength()
 failures in quorum_co_flush()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org

On Mon 07 Aug 2017 01:29:09 PM CEST, Eric Blake wrote:
> On 08/07/2017 03:43 AM, Alberto Garcia wrote:
>> On Fri 04 Aug 2017 05:44:00 PM CEST, Eric Blake wrote:
>>>> --- a/block/quorum.c
>>>> +++ b/block/quorum.c
>>>> @@ -785,8 +785,9 @@ static coroutine_fn int quorum_co_flush(BlockDriverState *bs)
>>>>      for (i = 0; i < s->num_children; i++) {
>>>>          result = bdrv_co_flush(s->children[i]->bs);
>>>>          if (result) {
>>>> +            int64_t length = bdrv_getlength(s->children[i]->bs);
>>>>              quorum_report_bad(QUORUM_OP_TYPE_FLUSH, 0,
>>>> -                              bdrv_getlength(s->children[i]->bs),
>>>> +                              length > 0 ? length : 0,
>>>
>>> In the fallback case, is always picking 0 good enough?  Then again,
>>> this is in the error path, so it is unlikely in practice, and I don't
>>> see any better way to handle it.
>> 
>> I don't see any better way to handle it either, and I'm not sure that it
>> matters much: this is a flush error event, the 'sectors-count' field
>> doesn't even mean anything, but we have to put something there.
>
> If that's the case, can we ALWAYS report 0, instead of usually the
> length and sometimes 0?

That's actually not a bad idea, I'll send the patch now.

Berto
