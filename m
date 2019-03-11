Received: from eggs.gnu.org ([209.51.188.92]:49647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h3PQ1-0001V7-FV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h3PQ0-0002fe-Hl
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:12:57 -0400
References: <20190305234337.18353-1-jsnow@redhat.com>
	<3a8ed35f-e50b-c411-2004-38917d2164c6@redhat.com>
	<d6458782-9335-e3f4-f8cb-51e46b790aad@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e472a0f9-3664-30bc-88aa-1fb1d4f5fbaa@redhat.com>
Date: Mon, 11 Mar 2019 14:05:22 -0400
MIME-Version: 1.0
In-Reply-To: <d6458782-9335-e3f4-f8cb-51e46b790aad@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] block/qcow2-bitmap: Enable resize with
 persistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 3/11/19 1:36 PM, Vladimir Sementsov-Ogievskiy wrote:
> 11.03.2019 19:18, Eric Blake wrote:
>> On 3/5/19 5:43 PM, John Snow wrote:
>>> This series aims to enable block resizes when persistent bitmaps are
>>> in use. The basic approach here is to recognize that we now load all
>>> persistent bitmaps in memory, and so we can rely on in-memory resizes
>>> and then flush the changed metadata back to disk.
>>>
>>> One part that is potentially now quite strange is that bitmap resizes
>>> may happen twice: once during the qcow2 resize event only if persistent
>>> bitmaps are found, and then again as part of the generic resize callback
>>> event whether or not we have any persistent bitmaps.
>>>
>>> The second round is required if we are not using qcow2 or we have only
>>> transient bitmaps. The first round is required as we wish to flush the
>>> bitmaps back to disk atomically with the qcow2 resize to avoid violating
>>> our invariants for the bitmap metadata which is checked in many places.
>>>
>>> This is harmless; hbitmap_truncate will recognize the second round as
>>> a no-op.
>>
>> FWIW - I have not yet reviewed this series closely, but I think it would
>> be wise to get this initial cut in before softfreeze (we can make
>> further tweaks to fix bugs in assumptions during rc1 and rc2, but it's a
>> lot harder to add the series at all if it misses softfreeze).
>>
> 
> I still not convinced that we need bitmap flushing. I think (and Den supports
> me) that it's a bad idea. It makes things more difficult without a reason,
> except improving debugging with --force-share which should never be used in
> production.
> 

I know you don't want it in the general case, but I think resizing
represents a genuine case for exactly when we want it.

Set aside your concerns about general case flushing for now -- this is a
distraction -- and let us consider ONLY resize events.

If QEMU crashes after a resize event, we will be unable to even open
qcow2 images if we don't resize the metadata information and write it
back out to disk.

It is far simpler -- logically and technically -- to just write this
data out to disk during a resize event. It won't happen often, shouldn't
incur much of an IO penalty, and (I think) is algorithmically
straightforward.

If it's really that much of a problem, we can revise it during the RC
period to eliminate the flush.

> Bitmaps are stored in qcow2_inactivate() which is true place for flushing caches.
> 
