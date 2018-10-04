Received: from eggs.gnu.org ([2001:4830:134:3::10]:48492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g840e-0005G5-F2
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g840b-0005TV-8M
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:49:44 -0400
References: <20181004100313.4253-1-den@openvz.org>
	<df8c34a4-fef5-a5b5-1e7d-41c638588b5e@redhat.com>
	<558261af-914a-1ea4-ef21-c7654a50284e@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c6223557-2ff7-4d2a-2d7b-1daf3372c34b@redhat.com>
Date: Thu, 4 Oct 2018 08:49:37 -0500
MIME-Version: 1.0
In-Reply-To: <558261af-914a-1ea4-ef21-c7654a50284e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: fix NBD_CMD_CACHE negitiation
 according to the NBD specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, Valery Vdovin <valery.vdovin@acronis.com>, Paolo Bonzini <pbonzini@redhat.com>

On 10/4/18 7:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> 04.10.2018 15:27, Eric Blake wrote:
>> On 10/4/18 5:03 AM, Denis V. Lunev wrote:
>>> Commit bc37b06a5 was made very bad thing, it has been added
>>> NBD_FLAG_SEND_CACHE flag for negotiation.
>>
>> Oof. Probably my fault for not doing a careful review against the
>> upstream spec.
> 
> mostly my, to introduce this =(. really too bad
> 
>>
>>> The problem is that the value
>>> of the flag was taken wrong and directly violates NBD specification.
>>> This value (bit 8) is used at least in the Linux kernel as a part of
>>> stable userspace-kernel API since 4.10 as NBD_FLAG_CAN_MULTI_CONN
>>> as defined in the specification:
>>
>> And a kernel that honors that bit can cause qemu to misbehave. Yeah,
>> that's definitely undesirable.
> 
> As I understand opposite: kernel client will assume support for
> multi_conn feature which declares some guarantees about FLUSH, but qemu
> don't give these guarantees.

Yeah, that's my biggest worry - data corruption when the kernel assumes 
it can make multiple connections with consistent caching, but the 
caching is not consistent, leading to data corruption when connected to 
an unpatched qemu 3.0 server.  I'm rewording the commit message along 
those lines.


>> I'll probably amend this to list all NBD_FLAG_ values in the spec
>> (even if qemu doesn't implement them yet), just to make it easier to
>> avoid making this mistake in the future.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Will queue through my NBD tree.
>>
> 
> I vote for adding all values at least as a comment
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
