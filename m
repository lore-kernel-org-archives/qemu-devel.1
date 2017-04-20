Received: from eggs.gnu.org ([2001:4830:134:3::10]:56328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d18bW-0002OE-Br
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d18bV-0002nw-Dp
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:42:22 -0400
Date: Thu, 20 Apr 2017 17:42:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420094212.GI24486@lemon.lan>
References: <20170420075237.18219-1-famz@redhat.com>
	<20170420075237.18219-20-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420075237.18219-20-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 19/20] file-posix: Add image locking in
 perm operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, 04/20 15:52, Fam Zheng wrote:
> virtlockd in libvirt locks the first byte, so we start looking at the
> file bytes from 0x10.
> 
> The complication is in the transactional interface.  To make the reopen
> logic managable, and allow better reuse, the code is internally
> organized with a table from old mode to the new one.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 744 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 741 insertions(+), 3 deletions(-)

Need to squash this in to fix the patchew make check error on centos 6:

diff --git a/block/file-posix.c b/block/file-posix.c
index b85ac9c..f1563ae 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1069,7 +1069,7 @@ static int raw_handle_lock_update(BlockDriverState *bs,
     int lock_fd;
 
     if (!RAW_LOCK_SUPPORTED) {
-        return 0;
+        goto cleanup;
     }
 
     if (bdrv_get_flags(bs) & BDRV_O_INACTIVE) {
