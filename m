Received: from eggs.gnu.org ([2001:4830:134:3::10]:53018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fZxef-00062U-Jg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fZxeZ-0003c9-Qq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:10:05 -0400
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-3-vsementsov@virtuozzo.com>
	<32ad25bf-0427-e286-94f1-0566af2ea8ed@redhat.com>
	<920ef7dd-67c3-fd93-b1b3-ea3bd31577f2@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e97fb1f7-a864-a413-0ea4-f3e1dc29bc9f@virtuozzo.com>
Date: Mon, 2 Jul 2018 15:09:45 +0300
MIME-Version: 1.0
In-Reply-To: <920ef7dd-67c3-fd93-b1b3-ea3bd31577f2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, den@openvz.org

29.06.2018 20:40, Eric Blake wrote:
> On 06/29/2018 12:30 PM, John Snow wrote:
>>
>>
>> On 06/29/2018 11:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> We need to synchronize backup job with reading from fleecing image
>>> like it was done in block/replication.c.
>>>
>>> Otherwise, the following situation is theoretically possible:
>>>
>>> 1. client start reading
>>> 2. client understand, that there is no corresponding cluster in
>>> =C2=A0=C2=A0=C2=A0 fleecing image
>>
>> I don't think the client refocuses the read, but QEMU does. (the client
>> has no idea if it is reading from the fleecing node or the backing=20
>> file.)
>>
>> ... but understood:
>>
>>> 3. client is going to read from backing file (i.e. active image)
>>> 4. guest writes to active image
>>
>> My question here is if QEMU will allow reads and writes to interleave in
>> general. If the client is reading from the backing file, the active
>> image, will QEMU allow a write to modify that data before we're done
>> getting that data?
>>
>>> 5. this write is stopped by backup(sync=3Dnone) and cluster is copied t=
o
>>> =C2=A0=C2=A0=C2=A0 fleecing image
>>> 6. guest write continues...
>>> 7. and client reads _new_ (or partly new) date from active image
>>>
>>
>> I can't answer this for myself one way or the other right now, but I
>> imagine you observed a failure in practice in your test setups, which
>> motivated this patch?
>>
>> A test or some proof would help justification for this patch. It would
>> also help prove that it solves what it claims to!
>
> In fact, do we really need a new filter, or do we just need to make=20
> the "sync":"none" blockdev-backup job take the appropriate=20
> synchronization locks?
>

How? We'll need additional mechanism like serializing requests.. Or a=20
way to reuse serializing requests. Using backup internal synchronization=20
looks simpler, and it is already used in block replication.
On the other hand, I think the best thing is instead refuse=20
backup(sync=3Dnone), and do the whole functionality for external backup in=
=20
the special filter driver, but for now I'd prefer to start with already=20
existing staff.

--=20
Best regards,
Vladimir
