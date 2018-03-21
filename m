Received: from eggs.gnu.org ([2001:4830:134:3::10]:58370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eyeRu-0006SB-NK
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eyeRr-0002NQ-I0
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:10:42 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180321135238.GA3898@localhost.localdomain>
References: <20180321133852.3560-1-berto@igalia.com>
	<20180321135238.GA3898@localhost.localdomain>
Date: Wed, 21 Mar 2018 15:10:01 +0100
Message-ID: <w51k1u5ikp2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed 21 Mar 2018 02:52:38 PM CET, Kevin Wolf wrote:

>>      qemu-img create -f qcow2 -o cluster_size=512 hd.qcow2 1M
>>      qemu-io -c 'write 0 124k' hd.qcow2
>>      qemu-io -c 'write 124k 512' hd.qcow2
>
> So if I understand correctly, this is what we get:
>
> 0x20000: free
> 0x20200: refcount block
> 0x20400: data cluster
> 0x20600: potential next data cluster

Yes.

>> What this patch does is reset s->free_cluster_index to its previous
>> value when alloc_refcount_block() returns -EAGAIN. This way the caller
>> will try to allocate again the original clusters if they are still
>> free.
>
> This is an improvement, because now we should avoid the unused cluster:
>
> 0x20000: data cluster
> 0x20200: refcount block
> 0x20400: potential next data cluster

That's correct.

> But now the data clusters are fragmented. Should we try to change the
> logic so that already the refcount block allocation can make use of
> the free space? That is:
>
> 0x20000: refcount block
> 0x20200: data cluster
> 0x20400: contiguous potential next data cluster

Well, the clusters before 0x20000 are also data clusters so there's
going to be fragmentation anyway. Also, if you're writing more than 1
data cluster in a single request when the refcount block allocation
happens all those new data clusters are still going to be contiguous
(before the new refcount block).

Another possibility that I considered was to make alloc_clusters_noref()
return the offset but let free_cluster_index untouched until the
refcounts are correct, but this requires more code and I fear that
keeping free_cluster_index pointing to the clusters we're trying to
allocate can lead to unexpected surprises.

The solution I chose is -I think- the simplest and easiest to audit.

On a related note, I'm using a script that I wrote myself to debug qcow2
images. It prints the contents of the header and lists all host
clusters, indicating the type of each one. I find it useful to debug
problems like this one. If there's nothing similar already existing I
can post it and we could put it in the scripts/ directory.

Berto
