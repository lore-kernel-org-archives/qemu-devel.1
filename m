Received: from eggs.gnu.org ([2001:4830:134:3::10]:48635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fmhIo-00055f-Cn
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fmhIk-0003Km-W4
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:20:10 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180806150541.GE4631@localhost.localdomain>
References: <20180806141322.14427-1-berto@igalia.com>
	<20180806150541.GE4631@localhost.localdomain>
Date: Mon, 06 Aug 2018 17:20:03 +0200
Message-ID: <w51mutzo730.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qcow2: Release dirty entries with
 cache-clean-interval
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

On Mon 06 Aug 2018 05:05:41 PM CEST, Kevin Wolf wrote:
> Am 06.08.2018 um 16:13 hat Alberto Garcia geschrieben:
>> -static inline bool can_clean_entry(Qcow2Cache *c, int i)
>> +static inline bool can_clean_entry(BlockDriverState *bs, Qcow2Cache *c, int i)
>>  {
>>      Qcow2CachedTable *t = &c->entries[i];
>> -    return t->ref == 0 && !t->dirty && t->offset != 0 &&
>> -        t->lru_counter <= c->cache_clean_lru_counter;
>> +    if (t->ref || !t->offset || t->lru_counter > c->cache_clean_lru_counter) {
>> +        return false;
>> +    }
>> +
>> +    if (qcow2_cache_entry_flush(bs, c, i) < 0) {
>> +        return false;
>> +    }
>
> We're not in coroutine context here, so qcow2_cache_entry_flush() will
> be blocking. I don't think that's acceptable in a timer callback.
>
> On the other hand, if we made it non-blocking by moving it into a
> coroutine that could yield, we would have to consider races with other
> parts of the code and at least take s->lock and implement
> .bdrv_co_drain_begin/end callbacks.

Oh, I see... it's probably not worth complicating the code for this then.

Berto
