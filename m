Received: from eggs.gnu.org ([2001:4830:134:3::10]:57706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLSq-0007e6-0R
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLSo-000410-Rk
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:54:24 -0400
References: <20180320135515.16823-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <665e0ccd-4440-4e0e-30f9-e38537795325@redhat.com>
Date: Tue, 20 Mar 2018 12:54:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180320135515.16823-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] qcow2: Reset free_cluster_index
 when allocating a new refcount block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 03/20/2018 08:55 AM, Alberto Garcia wrote:
> When we try to allocate new clusters we first look for available ones
> starting from s->free_cluster_index and once we find them we increase
> their reference counts. Before we get to call update_refcount() to do
> this last step s->free_cluster_index is already pointing to the next
> cluster after the ones we are trying to allocate.
> 
 > During update_refcount() it may happen however that we also need to
 > allocate a new refcount block in order to store the refcounts of these
 > new clusters

Your changes to test 121 covers this...

 > (and to complicate things further that may also require
 > us to grow the refcount table).

...but not this.  Is it worth also trying to cover this case in the 
testsuite as well?  Probably made easier if you use a refcount_order of 
6 instead of the default of 4, so that it is easier to make the refcount 
table spill into a second cluster because refcount blocks have fewer 
entries.

> This can be reproduced easily:
> 
>       qemu-img create -f qcow2 -o cluster_size=512 hd.qcow2 1M
>       qemu-io -c 'write 0 124k' hd.qcow2
> 
> After this the image has 132608 bytes (256 clusters), and the refcount
> block is full. If we write 512 more bytes it should allocate two new
> clusters: the data cluster itself and a new refcount block.
> 
>       qemu-io -c 'write 124k 512' hd.qcow2

Nice test case!  And yes, 512-byte clusters are easier for proving when 
we have inefficient allocation strategies.

> What this patch does is reset s->free_cluster_index to its previous
> value when alloc_refcount_block() returns -EAGAIN. This way the caller
> will try to allocate again the original clusters if they are still
> free.
> 
> The output of iotest 026 also needs to be updated because now that
> images have no holes some tests fail at a different point and the
> number of leaked clusters is different.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-refcount.c     |  7 +++++++
>   tests/qemu-iotests/026.out |  6 +++---
>   tests/qemu-iotests/121     | 20 ++++++++++++++++++++
>   tests/qemu-iotests/121.out | 10 ++++++++++
>   4 files changed, 40 insertions(+), 3 deletions(-)

Long-standing bug, but it IS a bug fix, so I think it is safe for 2.12.

> 
> +            /* If the caller needs to restart the search for free clusters,
> +             * try the same ones first to see if they're still free. */
> +            if (ret == -EAGAIN) {
> +                if (s->free_cluster_index > (start >> s->cluster_bits)) {
> +                    s->free_cluster_index = (start >> s->cluster_bits);
> +                }

Is there any harm in making this assignment unconditional, instead of 
only doing it when free_cluster_index has grown larger than start?  [And 
unrelated, but it might be nice to do a followup cleanup to track 
free_cluster_offset by bytes instead of having to shift 
free_cluster_index everywhere]

At any rate, my comments can be deferred to later if desired, so

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
