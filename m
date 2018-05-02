Received: from eggs.gnu.org ([2001:4830:134:3::10]:35910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDtGD-0004Vi-GY
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDtG7-0000Zi-Jl
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:01:37 -0400
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
	<44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <69c3123f-4ef2-7bdc-6042-1271fc8689e6@redhat.com>
Date: Wed, 2 May 2018 10:01:23 -0500
MIME-Version: 1.0
In-Reply-To: <44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Ivan Ren <renyime@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

On 05/02/2018 09:37 AM, Max Reitz wrote:
> On 2018-05-02 15:34, Ivan Ren wrote:
>> qemu-img info with a block device which has a qcow2 format always
>> return 0 for disk size, and this can not reflect the qcow2 size
>> and the used space of the block device. This patch return the
>> allocated size of qcow2 as the disk size.
> 
> I'm not quite sure whether you really need this information for block
> devices (I tend to agree with Eric that wr_highest_cluster is the more
> important information there), but I can imagine it just being nice to have.

Hmm, so in an extreme case, if you create an internal snapshot, then the 
guest makes edits, then you remove the internal snapshot, we have a 
wr_highest_offset that has advanced (because the guest changes had to 
allocate new clusters due to COW of refcount=2 clusters); but the 
deleted snapshot now means we have a lot of unused clusters earlier in 
the image (deleting the snapshot took refcount=2 clusters back to 1, and 
any COW'd clusters edited after the internal snapshot means the snapshot 
version is now back to refcount=0, whether or not we also try to punch a 
hole in the protocol layer for those freed clusters).  Thus, reporting 
the highest written cluster is a larger number than the number of 
clusters that are actually in use, and both numbers might be useful to 
know (how big do I have to size my block device, and how utilized is my 
block device), especially if we add code for online compaction or 
defragmentation of a qcow2 image so that we can move higher offsets into 
holes left earlier in the image.

If you don't use internal snapshots, the only way to get holes of 
unallocated clusters earlier in the image is if the guest uses TRIM 
operations, and I'm not sure if that's easier or harder to trigger, nor 
which approach (internal snapshots vs. guest TRIM operations) is likely 
to leave more holes of unallocated clusters.

> 
> The whole implementation reminds me a lot of qcow2's check function,
> which basically just recalculates the refcounts.  So I'm wondering
> whether you could just count how many clusters with non-0 refcount there
> are and thus simplify the implementation dramatically.

We also recently added 'qemu-img measure', which DOES report how many 
clusters are in use.  Is any of that reusable here?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
