Received: from eggs.gnu.org ([2001:4830:134:3::10]:46226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephane.chazelas@gmail.com>) id 1cbSta-0000DG-S0
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephane.chazelas@gmail.com>) id 1cbStX-0007ag-MM
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:06:54 -0500
Date: Wed, 8 Feb 2017 14:06:46 +0000
From: Stephane Chazelas <stephane.chazelas@gmail.com>
Message-ID: <20170208140646.GA19518@chaz.gmail.com>
References: <20170202123045.GA24714@chaz.gmail.com>
	<f8a93c01-682e-fbcb-7b81-012f6df97465@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8a93c01-682e-fbcb-7b81-012f6df97465@redhat.com>
Subject: Re: [Qemu-devel] [qcow2] how to avoid qemu doing
 lseek(SEEK_DATA/SEEK_HOLE)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

2017-02-08 00:43:18 +0100, Max Reitz:
[...]
> OTOH, it may make sense to offer a way for the user to disable
> lseek(SEEK_{DATA,HOLE}) in our "file" block driver. That way your issue
> would be solved, too, I guess. I'll look into it.
[...]

Thanks Max,

Yes, that would work for me and other users of ZFS. What I do
for now is recompile with those lseek(SEEK_{DATA,HOLE}) disabled
in the code and it's working fine.

As I already hinted, something that would also possibly work for
me and could benefit everyone (well at least Linux users on
filesystems supporting hole punching), is instead of checking
beforehand if the file is allocated, do a
fallocate(FALLOC_FL_PUNCH_HOLE), or IOW, tell the underlying
layer to deallocate the data.

That would be those two lseek() replaced by a fallocate(), and
some extra disk space being saved.

One may argue that's what one would expect would be done when
using detect-zeroes=unmap. 

I suppose that would be quite significant work as that would
imply a framework to pass those "deallocates" down and you'd
probably have to differenciate "deallocates" that zero (like
hole punching in a reguar file), and those that don't (like
BLKDISCARD on a SSD)

I also suppose that could cause fragmentation that  would be
unwanted in some contexts, so maybe it should be tunable as
well.

-- 
Stephane
