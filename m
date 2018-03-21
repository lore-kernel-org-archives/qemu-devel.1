Received: from eggs.gnu.org ([2001:4830:134:3::10]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyeAY-0008Si-VN
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyeAX-0000TS-S3
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:52:47 -0400
Date: Wed, 21 Mar 2018 14:52:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180321135238.GA3898@localhost.localdomain>
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

So if I understand correctly, this is what we get:

0x20000: free
0x20200: refcount block
0x20400: data cluster
0x20600: potential next data cluster

> What this patch does is reset s->free_cluster_index to its previous
> value when alloc_refcount_block() returns -EAGAIN. This way the caller
> will try to allocate again the original clusters if they are still
> free.

This is an improvement, because now we should avoid the unused cluster:

0x20000: data cluster
0x20200: refcount block
0x20400: potential next data cluster

But now the data clusters are fragmented. Should we try to change the
logic so that already the refcount block allocation can make use of the
free space? That is:

0x20000: refcount block
0x20200: data cluster
0x20400: contiguous potential next data cluster

Kevin
