Received: from eggs.gnu.org ([2001:4830:134:3::10]:45593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fZwzG-0000qF-FU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fZwzF-0006aY-FC
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:27:18 -0400
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-3-vsementsov@virtuozzo.com>
	<8ecd1901-4148-6dc5-667d-d3c13260f534@redhat.com>
	<20180702063515.GE26002@lemon.usersys.redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <69b94665-eb03-c8fb-dfae-b66c06abe97b@virtuozzo.com>
Date: Mon, 2 Jul 2018 14:27:01 +0300
MIME-Version: 1.0
In-Reply-To: <20180702063515.GE26002@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/fleecing-filter: new filter
 driver for fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org

02.07.2018 09:35, Fam Zheng wrote:
> On Fri, 06/29 12:24, Eric Blake wrote:
>> On 06/29/2018 10:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> We need to synchronize backup job with reading from fleecing image
>>> like it was done in block/replication.c.
>>>
>>> Otherwise, the following situation is theoretically possible:
>>>
>> Grammar suggestions:
>>
>>> 1. client start reading
>> client starts reading
>>
>>> 2. client understand, that there is no corresponding cluster in
>>>      fleecing image
>>> 3. client is going to read from backing file (i.e. active image)
>> client sees that no corresponding cluster has been allocated in the fleecing
>> image, so the request is forwarded to the backing file
>>
>>> 4. guest writes to active image
>>> 5. this write is stopped by backup(sync=none) and cluster is copied to
>>>      fleecing image
>>> 6. guest write continues...
>>> 7. and client reads _new_ (or partly new) date from active image
>> Interesting race. Can it actually happen, or does our read code already
>> serialize writes to the same area while a read is underway?
> Yes, I wonder why wait_serialising_requests() is not enough. If it's possible,
> can we have a test case (with help of blkdebug, for example)?

Hmm, only unaligned and COPY_ON_READ requests are marked serializing.. 
So If I understand correctly, nothing special prevents intersection, 
it's a problem of the guest. But in backup case, it's our problem.

>
>> In short, I see what problem you are claiming exists: the moment the client
>> starts reading from the backing file, that portion of the backing file must
>> remain unchanged until after the client is done reading.  But I don't know
>> enough details of the block layer to know if this is actually a problem, or
>> if adding the new filter is just overhead.
> Fam


-- 
Best regards,
Vladimir
