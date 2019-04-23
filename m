Received: from eggs.gnu.org ([209.51.188.92]:53782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darrick.wong@oracle.com>) id 1hJ3dC-0004wF-8c
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darrick.wong@oracle.com>) id 1hJ3d5-0003lN-DX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:11:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darrick.wong@oracle.com>)
	id 1hJ3d0-0003c1-Ps
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:11:03 -0400
Date: Tue, 23 Apr 2019 15:10:11 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Message-ID: <20190423221011.GD178290@magnolia>
References: <20190423080612.15361-1-pagupta@redhat.com>
	<20190423080612.15361-7-pagupta@redhat.com>
	<20190423220217.GA29573@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423220217.GA29573@dread.disaster.area>
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
Cc: Dave Chinner <david@fromorbit.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, dan.j.williams@intel.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com, jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, cohuck@redhat.com, xiaoguangrong.eric@gmail.com, pbonzini@redhat.com, yuval.shaia@oracle.com, kilobyte@angband.pl

On Wed, Apr 24, 2019 at 08:02:17AM +1000, Dave Chinner wrote:
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

    tab separation here ^^^                   ^^^^ and cut
                                                       down the indent
                                             while you're at
						    it, please:

	struct dax_device	*dax_dev;

	dax_dev = xfs_find_daxdev_for_inode(file_inode(filp));
	if (!dax_is_frobbed(dax))
		return -EMEWANTCOOKIE;

--D

> > +
> > +	/* We don't support synchronous mappings for non-DAX files and
> > +	 * for DAX files if underneath dax_device is not synchronous.
> >  	 */
> 
> 	/*
> 	 * This is the correct multi-line comment format. Please
> 	 * update the patch to maintain the existing comment format.
> 	 */
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
