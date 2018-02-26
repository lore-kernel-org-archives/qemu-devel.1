Received: from eggs.gnu.org ([2001:4830:134:3::10]:34578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqLqj-0005cU-Vt
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqLqj-000263-1Q
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:42:01 -0500
References: <20180222155922.9833-1-eblake@redhat.com>
	<20180222155922.9833-3-eblake@redhat.com>
	<w51bmgbd8fh.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09a1d661-14ce-3fe0-e3b6-2ce6d4e34348@redhat.com>
Date: Mon, 26 Feb 2018 10:41:54 -0600
MIME-Version: 1.0
In-Reply-To: <w51bmgbd8fh.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/4] qcow2: Document some maximum size
 constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 02/26/2018 10:25 AM, Alberto Garcia wrote:
> On Thu 22 Feb 2018 04:59:20 PM CET, Eric Blake wrote:
>> While at it, notice that since we cannot map any virtual cluster to
>> any address higher than 64 PB (56 bits) (due to the L1/L2 field
>> encoding), it makes little sense to require the refcount table to
>> access host offsets beyond that point.
> 
> But refcount blocks are not addressed by L2 tables, so in principle it
> should be possible to have refcount blocks after the first 64PB.

But (if we don't make this change) that's about all you can usefully 
have (and it would be a self-referencing refcount block).

> 
> But I agree that it's a good idea to set that as a maximum possible
> physical size of the qcow2 image.
> 
>> @@ -341,7 +355,7 @@ Refcount table entry:
>>
>>       Bit  0 -  8:    Reserved (set to 0)
>>
>> -         9 - 63:    Bits 9-63 of the offset into the image file at which the
>> +         9 - 55:    Bits 9-55 of the offset into the image file at which the
>>                       refcount block starts. Must be aligned to a cluster
>>                       boundary.
>>
>> @@ -349,6 +363,8 @@ Refcount table entry:
>>                       been allocated. All refcounts managed by this refcount block
>>                       are 0.
>>
>> +        56 - 63:    Reserved (set to 0)
> 
> Are we not updating REFT_OFFSET_MASK as well?

We could, but that should be a separate patch from the spec change.  We 
could also add some validation that any offsets in the header point to 
less than the 64PB limit.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
