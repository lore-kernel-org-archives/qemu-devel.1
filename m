Received: from eggs.gnu.org ([2001:4830:134:3::10]:58155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnyi-0001xr-2t
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnx6-0004FV-6c
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:15:51 -0500
References: <20171130164401.29221-1-kwolf@redhat.com>
	<ce174622-1df0-bf86-452e-280dd3f7e068@redhat.com>
	<20171130182746.GF4039@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cb98da75-ca77-edce-6384-d612380e4e3c@redhat.com>
Date: Thu, 30 Nov 2017 13:05:55 -0600
MIME-Version: 1.0
In-Reply-To: <20171130182746.GF4039@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Formats don't need CONSISTENT_READ
 with NO_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

On 11/30/2017 12:27 PM, Kevin Wolf wrote:
>>> @@ -1936,7 +1938,9 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
>>>            /* bs->file always needs to be consistent because of the metadata. We
>>>             * can never allow other users to resize or write to it. */
>>> -        perm |= BLK_PERM_CONSISTENT_READ;
>>> +        if (!(flags & BDRV_O_NO_IO)) {
>>> +            perm |= BLK_PERM_CONSISTENT_READ;
>>
>> I thought BDRV_O_NO_IO only means we aren't doing I/O on guest-visible data,
>> but doesn't stop us from reading the metadata.  The comment is telling: if
>> we can read metadata, then we depend on CONSISTENT_READ for the metadata to
>> be stable (even if we don't care about guest data consistency).
> 
> Yes and no. The trouble is that at the file system level we have only a
> single bit to describe the consistency of the whole image throughout the
> whole block driver tree.
> 
> We forbid shared BLK_PERM_CONSISTENT_READ for mirror targets (which
> aren't fully populated yet) and intermediate nodes for commit (which
> expose corrupted data). Both scenarios are really about the data exposed
> at the format layer, the metadata stays completely consistent.

I guess it is the block of writes/resizes that prevents metadata from 
getting inconsistent; CONSISTENT_READ does indeed make more sense if 
interpreted solely in light of will the guest read consistent data (and 
not will the format layer see consistent contents from the protocol layer).

> 
> The question is what we do with this as we propagate permissions down to
> the protocol layer. Strictly speaking, the file at the protocol layer is
> perfectly consistent, so we might not forbid BLK_PERM_CONSISTENT_READ
> there. But I think it's more useful to do it anyway so that image
> locking can prevent the typical case of another process that uses qcow2
> over file-posix again, where the file-posix node could in theory be
> considered consistent, but the qcow2 one wouldn't.

Does that mean we need two separate permission bits, one for whether the 
guest-visible data is consistent, and one for whether the metadata is 
consistent? But as I mentioned above, blocking writes should mean that 
no one else is messing with metadata.

> 
> In the end, this is just a pragmatic way to let 'qemu-img info' work
> while the image is a mirror target or intermediate node for commit, but
> to forbid cases where corrupted data is used.
> 
> Or would you argue that either 'qemu-img info' shouldn't be working or
> reading corrupted data should be allowed in other processes?

Having qemu-img info work on a mirror target makes sense; as you pointed 
out, the metadata flushed to disk is consistent (may have leaked 
clusters, but not broken image) at any given point by the writer (it has 
to be, since the writer has to be able to recover the image if there is 
an abrupt restart).  And a second reader can still manage to see 
inconsistent data when reading two separate clusters if the timing is 
just right, regardless of whether the first writer is always able to see 
consistent data.  So to some extent, it's a measure of how risky is the 
action? qemu-img info is read-only, and most of the time will just work; 
it is very hard to get to the rare race condition where two consecutive 
reads raced with a parallel writer combine to result in incorrect 
interpretation of the data by the reader.

I'm not opposed to your patch, but am trying to make sure that I'm not 
overlooking any problem before giving R-b.  Maybe it's just that the 
comment needs updating in v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
