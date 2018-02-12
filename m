Received: from eggs.gnu.org ([2001:4830:134:3::10]:52141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elEWn-0000d9-GK
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:52:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elEWm-0002ln-LS
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:52:17 -0500
Date: Mon, 12 Feb 2018 14:52:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180212135206.GG5103@localhost.localdomain>
References: <20180207163622.29935-1-pbonzini@redhat.com>
	<20180207163622.29935-3-pbonzini@redhat.com>
	<20180208013517.GB24289@lemon.usersys.redhat.com>
	<5ac0b76e-213a-60c3-c010-87512d3a564a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac0b76e-213a-60c3-c010-87512d3a564a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi: add block job opblockers for
 scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 08.02.2018 um 11:42 hat Paolo Bonzini geschrieben:
> On 08/02/2018 02:35, Fam Zheng wrote:
> > On Wed, 02/07 17:36, Paolo Bonzini wrote:
> >> @@ -2626,6 +2656,36 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
> >>  
> >>      scsi_realize(&s->qdev, errp);
> >>      scsi_generic_read_device_identification(&s->qdev);
> >> +
> >> +    /* For op blockers, due to lack of support for dirty bitmaps.  */
> >> +    error_setg(&sb->mirror_source,
> >> +               "scsi-block does not support acting as a mirroring source");
> >> +    error_setg(&sb->commit_source,
> >> +               "scsi-block does not support acting as an active commit source");
> > 
> > An alternative way would be adding BLOCK_OP_TYPE_DIRTY_BITMAP. The error message
> > will not be as nice but it can be useful for another (blockjob) operation that
> > requires dirty bitmap support, or another device that doesn't support dirty
> > bitmaps. Though there isn't one for now.
> 
> Yeah, I thought about it.  Another possibility is make BLOCK_OP_TYPE_* a
> bitmask.  Then you can easily add a single Error * for multiple
> blockers, and BLOCK_OP_TYPE_DIRTY_BITMAP can be defined as
> BLOCK_OP_TYPE_MIRROR_SOURCE|BLOCK_OP_TYPE_COMMIT_SOURCE; likewise for
> notifiers below.

We shouldn't be adding new instances of BLOCK_OP_* at all. I couldn't
find the time yet to remove the existing ones, but any new protections
should be using the permission system.

I propose a new BLK_PERM_BYPASS that allows its users to bypass the
block layer I/O functions. In other words, bdrv_aio_ioctl() would
require that you got this permission. A dirty bitmap would keep a
BdrvChild with perm=0, shared=BLK_PERM_ALL & ~BLK_PERM_BYPASS, so you
can never have a dirty bitmap and a device using ioctls attached to the
BDS at the same time.

Kevin
