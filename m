Received: from eggs.gnu.org ([209.51.188.92]:34557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hJ9xI-0006fZ-1I
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hJ9wh-0007YA-0n
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:55:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hJ9wg-0007Vl-R3
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:55:46 -0400
Date: Wed, 24 Apr 2019 00:55:40 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <476344290.23160847.1556081740211.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190423220217.GA29573@dread.disaster.area>
References: <20190423080612.15361-1-pagupta@redhat.com>
	<20190423080612.15361-7-pagupta@redhat.com>
	<20190423220217.GA29573@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Dave Chinner <david@fromorbit.com>
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, dan j williams <dan.j.williams@intel.com>, zwisler@kernel.org, vishal l verma <vishal.l.verma@intel.com>, dave jiang <dave.jiang@intel.com>, mst@redhat.com, jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu, adilger kernel <adilger.kernel@dilger.ca>, darrick wong <darrick.wong@oracle.com>, lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, cohuck@redhat.com, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, pbonzini@redhat.com, yuval shaia <yuval.shaia@oracle.com>, kilobyte@angband.pl


> 
> On Tue, Apr 23, 2019 at 01:36:12PM +0530, Pankaj Gupta wrote:
> > Dont support 'MAP_SYNC' with non-DAX files and DAX files
> > with asynchronous dax_device. Virtio pmem provides
> > asynchronous host page cache flush mechanism. We don't
> > support 'MAP_SYNC' with virtio pmem and xfs.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  fs/xfs/xfs_file.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 1f2e2845eb76..0e59be018511 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -1196,11 +1196,13 @@ xfs_file_mmap(
> >  	struct file	*filp,
> >  	struct vm_area_struct *vma)
> >  {
> > -	/*
> > -	 * We don't support synchronous mappings for non-DAX files. At least
> > -	 * until someone comes with a sensible use case.
> > +	struct dax_device *dax_dev = xfs_find_daxdev_for_inode
> > +						(file_inode(filp));
> > +
> > +	/* We don't support synchronous mappings for non-DAX files and
> > +	 * for DAX files if underneath dax_device is not synchronous.
> >  	 */
> 
> 	/*
> 	 * This is the correct multi-line comment format. Please
> 	 * update the patch to maintain the existing comment format.
> 	 */

Sure. Will correct this for both xfs & ext4.

Thanks,
Pankaj

> 
> Cheers,
> 
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
> 
