Received: from eggs.gnu.org ([2001:4830:134:3::10]:36272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhvH-00022A-0U
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhvG-0007CW-1o
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:53:15 -0400
Date: Wed, 21 Mar 2018 18:52:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180321175247.GI3898@localhost.localdomain>
References: <20180321133852.3560-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321133852.3560-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] qcow2: Reset
 free_cluster_index when allocating a new refcount block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 21.03.2018 um 14:38 hat Alberto Garcia geschrieben:
> When we try to allocate new clusters we first look for available ones
> starting from s->free_cluster_index and once we find them we increase
> their reference counts. Before we get to call update_refcount() to do
> this last step s->free_cluster_index is already pointing to the next
> cluster after the ones we are trying to allocate.
> 
> During update_refcount() it may happen however that we also need to
> allocate a new refcount block in order to store the refcounts of these
> new clusters (and to complicate things further that may also require
> us to grow the refcount table). After all this we don't know if the
> clusters that we originally tried to allocate are still available, so
> we return -EAGAIN to ask the caller to restart the search for free
> clusters.
> 
> This is what can happen in a common scenario:
> 
>   1) We want to allocate a new cluster and we see that cluster N is
>      free.
> 
>   2) We try to increase N's refcount but all refcount blocks are full,
>      so we allocate a new one at N+1 (where s->free_cluster_index was
>      pointing at).
> 
>   3) Once we're done we return -EAGAIN to look again for a free
>      cluster, but now s->free_cluster_index points at N+2, so that's
>      the one we allocate. Cluster N remains unallocated and we have a
>      hole in the qcow2 file.
> 
> This can be reproduced easily:
> 
>      qemu-img create -f qcow2 -o cluster_size=512 hd.qcow2 1M
>      qemu-io -c 'write 0 124k' hd.qcow2
> 
> After this the image has 132608 bytes (256 clusters), and the refcount
> block is full. If we write 512 more bytes it should allocate two new
> clusters: the data cluster itself and a new refcount block.
> 
>      qemu-io -c 'write 124k 512' hd.qcow2
> 
> However the image has now three new clusters (259 in total), and the
> first one of them is empty (and unallocated):
> 
>      dd if=hd.qcow2 bs=512c skip=256 count=1 | hexdump -C
> 
> If we write larger amounts of data in the last step instead of the 512
> bytes used in this example we can create larger holes in the qcow2
> file.
> 
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
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block branch.

Kevin
