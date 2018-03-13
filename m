Received: from eggs.gnu.org ([2001:4830:134:3::10]:58841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evpKA-0006LS-Ne
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evpK9-00075J-Q3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:11:02 -0400
References: <cover.1520952419.git.berto@igalia.com>
	<0b8f83b4f26071753dc409645ad8c6f6e215468a.1520952419.git.berto@igalia.com>
	<979d86bf-f1fa-4049-a811-94d6d8b9c667@redhat.com>
	<w51muzb4xs7.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <31c00205-3c65-4274-8201-3453b2904491@redhat.com>
Date: Tue, 13 Mar 2018 14:10:40 -0500
MIME-Version: 1.0
In-Reply-To: <w51muzb4xs7.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: Give the refcount cache the
 minimum possible size by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 03/13/2018 01:48 PM, Alberto Garcia wrote:
> On Tue 13 Mar 2018 07:23:36 PM CET, Eric Blake wrote:
>>> +                *refcount_cache_size =
>>> +                    MIN(combined_cache_size, min_refcount_cache);
>>
>> but here, if combined_cache_size is smaller than min_refcount_cache,
>>
>>> +                *l2_cache_size = combined_cache_size - *refcount_cache_size;
>>
>> then l2_cache_size is set to a negative value.
> 
> No, it's set to 0.
> 
> If combined == 4k and min_refcount == 256, then
> 
>     refcount_cache_size = MIN(4k, 256k) // 4k
>     l2_cache_size = 4k - 4k; // 0

Ah. Mental breakdown on my part in trying to compute (x - MIN()).

> 
> Then the caller ensures that it's always set to the minimum (as it did
> with the previous code).

So the caller will use larger than the requested limits if the requested 
limits are too small, and we are okay with calculations resulting in 0 
here.  All right, thanks for stepping me through my error; you're good 
to go with:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
