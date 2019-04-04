Received: from eggs.gnu.org ([209.51.188.92]:47850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kilobyte@angband.pl>) id 1hBz7M-0006Gg-Jh
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kilobyte@angband.pl>) id 1hBz7L-0000Tk-FB
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:57:08 -0400
Received: from tartarus.angband.pl ([2001:41d0:602:dbe::8]:41440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kilobyte@angband.pl>) id 1hBz7L-0000R5-4A
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:57:07 -0400
Date: Thu, 4 Apr 2019 11:56:49 +0200
From: Adam Borowski <kilobyte@angband.pl>
Message-ID: <20190404095649.GB8738@angband.pl>
References: <20190403104018.23947-1-pagupta@redhat.com>
	<20190403104018.23947-6-pagupta@redhat.com>
	<20190403220912.GB26298@dastard>
	<1518295599.17367903.1554358350929.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518295599.17367903.1554358350929.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/5] xfs: disable map_sync for async
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
Cc: Dave Chinner <david@fromorbit.com>, darrick wong <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, dan j williams <dan.j.williams@intel.com>, zwisler@kernel.org, vishal l verma <vishal.l.verma@intel.com>, dave jiang <dave.jiang@intel.com>, mst@redhat.com, jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu, adilger kernel <adilger.kernel@dilger.ca>, lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, cohuck@redhat.com, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>

On Thu, Apr 04, 2019 at 02:12:30AM -0400, Pankaj Gupta wrote:
> > All this ad hoc IS_DAX conditional logic is getting pretty nasty.
> > 
> > xfs_file_mmap(
> > ....
> > {
> > 	struct inode	*inode = file_inode(filp);
> > 
> > 	if (vma->vm_flags & VM_SYNC) {
> > 		if (!IS_DAX(inode))
> > 			return -EOPNOTSUPP;
> > 		if (!dax_synchronous(xfs_find_daxdev_for_inode(inode))
> > 			return -EOPNOTSUPP;
> > 	}
> > 
> > 	file_accessed(filp);
> > 	vma->vm_ops = &xfs_file_vm_ops;
> > 	if (IS_DAX(inode))
> > 		vma->vm_flags |= VM_HUGEPAGE;
> > 	return 0;
> > }
> 
> Sure, this is better.

> > Even better, factor out all the "MAP_SYNC supported" checks into a
> > helper so that the filesystem code just doesn't have to care about
> > the details of checking for DAX+MAP_SYNC support....
> 
> o.k. Will add one common helper function for both ext4 & xfs filesystems.

Note this pending patch for Goldwyn Rodrigues' patchset for btrfs:

https://lore.kernel.org/linux-btrfs/20190328102418.5466-1-kilobyte@angband.pl/

We might want to coordinate.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Did ya know that typing "test -j8" instead of "ctest -j8"
⢿⡄⠘⠷⠚⠋⠀ will make your testsuite pass much faster, and fix bugs?
⠈⠳⣄⠀⠀⠀⠀
