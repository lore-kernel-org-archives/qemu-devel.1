Received: from eggs.gnu.org ([2001:4830:134:3::10]:53974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqgI4-0007t8-9K
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqgI3-00059q-C7
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:31:36 -0500
References: <20180222155922.9833-1-eblake@redhat.com>
	<20180222155922.9833-3-eblake@redhat.com>
	<20180227114702.GA5269@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9264d585-dc54-b116-b96c-190ec1bf2562@redhat.com>
Date: Tue, 27 Feb 2018 08:31:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180227114702.GA5269@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berto@igalia.com, Max Reitz <mreitz@redhat.com>

On 02/27/2018 05:47 AM, Kevin Wolf wrote:
> Am 22.02.2018 um 16:59 hat Eric Blake geschrieben:
>> Although off_t permits up to 63 bits (8EB) of file offsets, in
>> practice, we're going to hit other limits first.  Document some
>> of those limits in the qcow2 spec, and how choice of cluster size
>> can influence some of the limits.
>>
>> While at it, notice that since we cannot map any virtual cluster
>> to any address higher than 64 PB (56 bits) (due to the L1/L2 field
>> encoding), it makes little sense to require the refcount table to
>> access host offsets beyond that point.  Mark the upper bits of
>> the refcount table entries as reserved, with no ill effects, since
>> it is unlikely that there are any existing images larger than 64PB
>> in the first place, and thus all existing images already have those
>> bits as 0.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> I think it would be good to mention the exact reason for the 56 bits in
> the spec. Even this commit message is rather vague ('L1/L2 field
> encoding'), so if at some point someone wonders, if we couldn't simply
> extend the allowed range, they won't easily see that it's related to
> compressed clusters.

Note that L1 and L2 fields both stop at bit 55 currently, but do have 
room for expansion up to bit 61; so all three limits (if we include 
refcount table in the set capped at bit 55 for now) could be raised 
simultaneously if we find 64P too small in the future.

Compressed clusters are also related, but there, the limit is even 
smaller - with 2M clusters, a compressed cluster must reside within the 
first 512T of host offsets, and there are no free bits available for 
allowing additional compressed cluster storage without making an 
incompatible change of how compressed clusters are represented.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
