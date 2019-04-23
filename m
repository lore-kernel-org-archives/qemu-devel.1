Received: from eggs.gnu.org ([209.51.188.92]:47446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@fromorbit.com>) id 1hJ3Uy-0001q3-WE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@fromorbit.com>) id 1hJ3Uu-00024I-7I
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:02:43 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38844)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@fromorbit.com>) id 1hJ3Ul-0001tw-DM
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:02:33 -0400
Date: Wed, 24 Apr 2019 08:02:17 +1000
From: Dave Chinner <david@fromorbit.com>
Message-ID: <20190423220217.GA29573@dread.disaster.area>
References: <20190423080612.15361-1-pagupta@redhat.com>
	<20190423080612.15361-7-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423080612.15361-7-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 6/6] xfs: disable map_sync for async
 flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, dan.j.williams@intel.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com, jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com, lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, cohuck@redhat.com, xiaoguangrong.eric@gmail.com, pbonzini@redhat.com, yuval.shaia@oracle.com, kilobyte@angband.pl

On Tue, Apr 23, 2019 at 01:36:12PM +0530, Pankaj Gupta wrote:
> Dont support 'MAP_SYNC' with non-DAX files and DAX files
> with asynchronous dax_device. Virtio pmem provides
> asynchronous host page cache flush mechanism. We don't
> support 'MAP_SYNC' with virtio pmem and xfs.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 1f2e2845eb76..0e59be018511 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1196,11 +1196,13 @@ xfs_file_mmap(
>  	struct file	*filp,
>  	struct vm_area_struct *vma)
>  {
> -	/*
> -	 * We don't support synchronous mappings for non-DAX files. At least
> -	 * until someone comes with a sensible use case.
> +	struct dax_device *dax_dev = xfs_find_daxdev_for_inode
> +						(file_inode(filp));
> +
> +	/* We don't support synchronous mappings for non-DAX files and
> +	 * for DAX files if underneath dax_device is not synchronous.
>  	 */

	/*
	 * This is the correct multi-line comment format. Please
	 * update the patch to maintain the existing comment format.
	 */

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
