Received: from eggs.gnu.org ([2001:4830:134:3::10]:46677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYxNl-00025s-BQ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYxNk-0003Lj-Gh
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:40:29 -0400
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-3-vsementsov@virtuozzo.com>
	<32ad25bf-0427-e286-94f1-0566af2ea8ed@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <920ef7dd-67c3-fd93-b1b3-ea3bd31577f2@redhat.com>
Date: Fri, 29 Jun 2018 12:40:21 -0500
MIME-Version: 1.0
In-Reply-To: <32ad25bf-0427-e286-94f1-0566af2ea8ed@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, den@openvz.org

On 06/29/2018 12:30 PM, John Snow wrote:
> 
> 
> On 06/29/2018 11:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We need to synchronize backup job with reading from fleecing image
>> like it was done in block/replication.c.
>>
>> Otherwise, the following situation is theoretically possible:
>>
>> 1. client start reading
>> 2. client understand, that there is no corresponding cluster in
>>     fleecing image
> 
> I don't think the client refocuses the read, but QEMU does. (the client
> has no idea if it is reading from the fleecing node or the backing file.)
> 
> ... but understood:
> 
>> 3. client is going to read from backing file (i.e. active image)
>> 4. guest writes to active image
> 
> My question here is if QEMU will allow reads and writes to interleave in
> general. If the client is reading from the backing file, the active
> image, will QEMU allow a write to modify that data before we're done
> getting that data?
> 
>> 5. this write is stopped by backup(sync=none) and cluster is copied to
>>     fleecing image
>> 6. guest write continues...
>> 7. and client reads _new_ (or partly new) date from active image
>>
> 
> I can't answer this for myself one way or the other right now, but I
> imagine you observed a failure in practice in your test setups, which
> motivated this patch?
> 
> A test or some proof would help justification for this patch. It would
> also help prove that it solves what it claims to!

In fact, do we really need a new filter, or do we just need to make the 
"sync":"none" blockdev-backup job take the appropriate synchronization 
locks?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
