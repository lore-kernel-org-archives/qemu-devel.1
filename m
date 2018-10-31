Received: from eggs.gnu.org ([2001:4830:134:3::10]:35464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gHu5Q-0001gv-1r
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gHu5K-0006do-KP
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:15:17 -0400
Date: Wed, 31 Oct 2018 18:14:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181031171453.GA4715@localhost.localdomain>
References: <20181019163013.11787-1-kwolf@redhat.com>
	<20181019163013.11787-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019163013.11787-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/11] block: Add auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

Am 19.10.2018 um 18:30 hat Kevin Wolf geschrieben:
> If a management application builds the block graph node by node, the
> protocol layer doesn't inherit its read-only option from the format
> layer any more, so it must be set explicitly.
> 
> Backing files should work on read-only storage, but at the same time, a
> block job like commit should be able to reopen them read-write if they
> are on read-write storage. However, without option inheritance, reopen
> only changes the read-only option for the root node (typically the
> format layer), but not the protocol layer, so reopening fails (the
> format layer wants to get write permissions, but the protocol layer is
> still read-only).
> 
> A simple workaround for the problem in the management tool would be to
> open the protocol layer always read-write and to make only the format
> layer read-only for backing files. However, sometimes the file is
> actually stored on read-only storage and we don't know whether the image
> can be opened read-write (for example, for NBD it depends on the server
> we're trying to connect to). This adds an option that makes QEMU try to
> open the image read-write, but allows it to degrade to a read-only mode
> without returning an error.
> 
> The documentation for this option is consciously phrased in a way that
> allows QEMU to switch to a better model eventually: Instead of trying
> when the image is first opened, making the read-only flag dynamic and
> changing it automatically whenever the first BLK_PERM_WRITE user is
> attached or the last one is detached would be much more useful
> behaviour.
> 
> Unfortunately, this more useful behaviour is also a lot harder to
> implement, and libvirt needs a solution now before it can switch to
> -blockdev, so let's start with this easier approach for now.
> 
> Instead of adding a new auto-read-only option, turning the existing
> read-only into an enum (with a bool alternate for compatibility) was
> considered, but it complicated the implementation to the point that it
> didn't seem to be worth it.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

I'm squashing in the following hunk to fix qemu-iotests 118 (not
resetting the flag during blockdev-change-medium could result in an
image opened read-only and then failing when attaching it to a
read-write device - this was already an error case, but with the fix it
keeps the nicer error mode that the old image stays inserted instead of
ejecting it but failing to insert the replacement):

diff --git a/blockdev.c b/blockdev.c
index c30495d035..fc8794862f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2651,7 +2651,7 @@ void qmp_blockdev_change_medium(bool has_device, const char *device,

     bdrv_flags = blk_get_open_flags_from_root_state(blk);
     bdrv_flags &= ~(BDRV_O_TEMPORARY | BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING |
-        BDRV_O_PROTOCOL);
+        BDRV_O_PROTOCOL | BDRV_O_AUTO_RDONLY);

     if (!has_read_only) {
         read_only = BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN;
