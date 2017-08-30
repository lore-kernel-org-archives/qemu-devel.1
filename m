Received: from eggs.gnu.org ([2001:4830:134:3::10]:60089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn6Nj-00021F-G8
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn6Nf-0000TE-KD
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:02:23 -0400
Date: Wed, 30 Aug 2017 18:02:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830170216.GA24565@stefanha-x1.localdomain>
References: <20170821135530.32344-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170821135530.32344-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qcow2: allocate
 cluster_cache/cluster_data on demand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon, Aug 21, 2017 at 02:55:30PM +0100, Stefan Hajnoczi wrote:
> Most qcow2 files are uncompressed so it is wasteful to allocate (32 + 1)
> * cluster_size + 512 bytes upfront.  Allocate s->cluster_cache and
> s->cluster_data when the first read operation is performance on a
> compressed cluster.
> 
> The buffers are freed in .bdrv_close().  .bdrv_open() no longer has any
> code paths that can allocate these buffers, so remove the free functions
> in the error code path.
> 
> This patch can result in significant memory savings when many qcow2
> disks are attached or backing file chains are long:
> 
> Before 12.81% (1,023,193,088B)
> After   5.36% (393,893,888B)
> 
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Changed EIO to ENOMEM [Eric]
>  * Added Alexey's Tested-by
> ---
>  block/qcow2-cluster.c | 17 +++++++++++++++++
>  block/qcow2.c         | 12 ------------
>  2 files changed, 17 insertions(+), 12 deletions(-)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan
