Received: from eggs.gnu.org ([2001:4830:134:3::10]:60722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ds6eV-0002X6-Fv
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ds6eS-0000Mg-9R
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:20:23 -0400
Date: Wed, 13 Sep 2017 14:20:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170913122005.GB5319@localhost.localdomain>
References: <59B91B00.20208@oracle.com>
 <59B91DCA.5080405@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59B91DCA.5080405@oracle.com>
Subject: Re: [Qemu-devel] [Qemu-block] Q: Report of leaked clusters with
 qcow2 when disk is resized with a live VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Darren Kenny <darren.kenny@oracle.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 13.09.2017 um 14:00 hat Darren Kenny geschrieben:
> [Cross-posted from qemu-devel, meant to send here first]

Just keep both lists in the CC for the same email.

> Hi,
> 
> It was observed during some testing of Qemu 2.9 that it appeared that if you
> resized a qcow2 block device while the VM is running, that an qemu-img check
> would report that there were leaked clusters.
> 
> The steps to reproduce are:
> 
> - First create the test image:
>   [...]
> 
> - Now run a VM based here on Oracle Linux 7, but the disto really isn't
>   important here, since the test disk is not even mounted in the VM at this
>   point in time:
>   [...]
> 
> - Resize the img size to 15g from qemu monitor (on stdio after above
> command)
> 
>     QEMU 2.5.0 monitor - type 'help' for more information
>     (qemu) block_resize drive_test 15360
> 
> - Now, in a separate terminal, while leaving the VM running, check the img
>   again from host side:
> 
>     # qemu-img check ./test.qcow2
>     Leaked cluster 3 refcount=1 reference=0
> 
>     1 leaked clusters were found on the image.
>     This means waste of disk space, but no harm to data.
>     Image end offset: 327680
> 
> As it suggests above, this is not really corruption, but it is a bit
> misleading, and could make people think there is an issue here
> (hence the reason I've been asked to find a fix).

There is an issue here, which is that you are accessing the image at the
same time from two separate processes. qemu is using writeback caches in
order to improve performance, so only after the guest has issued a flush
command to its disk or after you shut down or at least pause qemu, the
changes are fully written to the image file.

In qemu 2.10, you would probably see this instead:

$ qemu-img check ./test.qcow2
qemu-img: Could not open './test.qcow2': Failed to get shared "write" lock
Is another process using the image?

This lock can be overridden, but at least it shows clearly that you are
doing something that you probably shouldn't be doing.

> What I observed, then was that if I powered down the VM, or even just
> quit the VM, that the subsequent check of the disk would say that
> everything was just fine, and there no longer were leaked clusters.

Yes, quitting the VM writes out all of the cached data, so the on-disk
state and the in-memory state become fully consistent again.

> In looking at the code in qcow2_truncate() it would appear that in the case
> where prealloc has the value PREALLOC_MODE_OFF, that we don't flush the
> metadata to disk - which seems to be the case here.
> 
> If I ignore the if test, and always execute the block in block/qcow2.c,
> lines 3250 to 3258:
> 
>   if (prealloc != PREALLOC_MODE_OFF) {
>       /* Flush metadata before actually changing the image size */
>       ret = bdrv_flush(bs);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret,
>                            "Failed to flush the preallocated area to disk");
>           return ret;
>       }
>   }
> 
> causing the flush to always be done, then the check will succeed when
> the VM is still running.
> 
> While I know that this resolves the issue, I can only imagine that
> there was some reason that this check for !PREALLOC_MODE_OFF was being
> done in the first place.
> 
> So, I'm hoping that someone here might be able to explain to me why
> that check is needed, but also why it might be wrong to do the flush
> regardless of the value of prealloc here.

Doing a flush here wouldn't be wrong, but it's also unnecessary and
would slow down the operation a bit.

For the preallocation case, the goal that is achieved with the flush is
that the header update with the new image size is only written if the
preallocation succeeded, so that in error cases you don't end up with an
image that seems to be resized, but isn't actually preallocated as
requested.

> If it is wrong to do that flush here, then would anyone have
> suggestions as to an alternative solution to this issue?

Don't call 'qemu-img check' (or basically any other operation on the
image) while a VM is using the image.

Kevin
