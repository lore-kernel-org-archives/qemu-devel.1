Received: from eggs.gnu.org ([209.51.188.92]:44467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darrick.wong@oracle.com>) id 1ghGhT-0007on-Ap
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darrick.wong@oracle.com>) id 1ghGhR-0006hB-K7
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:27:27 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darrick.wong@oracle.com>)
	id 1ghGhR-0006fn-7b
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:27:25 -0500
Date: Wed, 9 Jan 2019 08:26:54 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Message-ID: <20190109162654.GW12689@magnolia>
References: <20190109144736.17452-1-pagupta@redhat.com>
	<20190109144736.17452-6-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109144736.17452-6-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] xfs: disable map_sync for virtio
 pmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, david@redhat.com, jmoyer@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com, jasowang@redhat.com, lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com, willy@infradead.org, tytso@mit.edu, adilger.kernel@dilger.ca, rjw@rjwysocki.net

On Wed, Jan 09, 2019 at 08:17:36PM +0530, Pankaj Gupta wrote:
> Virtio pmem provides asynchronous host page cache flush
> mechanism. we don't support 'MAP_SYNC' with virtio pmem 
> and xfs.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index e474250..eae4aa4 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1190,6 +1190,14 @@ xfs_file_mmap(
>  	if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
>  		return -EOPNOTSUPP;
>  
> +	/* We don't support synchronous mappings with guest direct access
> +	 * and virtio based host page cache mechanism.
> +	 */
> +	if (IS_DAX(file_inode(filp)) && virtio_pmem_host_cache_enabled(

Echoing what Jan said, this ought to be some sort of generic function
that tells us whether or not memory mapped from the dax device will
always still be accessible even after a crash (i.e. supports MAP_SYNC).

What if the underlying file on the host is itself on pmem and can be
MAP_SYNC'd?  Shouldn't the guest be able to use MAP_SYNC as well?

--D

> +		xfs_find_daxdev_for_inode(file_inode(filp))) &&
> +					(vma->vm_flags & VM_SYNC))
> +		return -EOPNOTSUPP;
> +
>  	file_accessed(filp);
>  	vma->vm_ops = &xfs_file_vm_ops;
>  	if (IS_DAX(file_inode(filp)))
> -- 
> 2.9.3
> 
