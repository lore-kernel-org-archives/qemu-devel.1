Received: from eggs.gnu.org ([2001:4830:134:3::10]:56598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cwEyP-00049b-Qc
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cwEyO-0000wM-9f
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:29:45 -0400
Date: Thu, 6 Apr 2017 22:29:36 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170406212936.GA28793@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
	<1488314205-16264-44-git-send-email-kwolf@redhat.com>
	<20170406205939.GA28584@redhat.com>
	<a010df05-e986-2142-3196-31f549558511@redhat.com>
	<20170406211537.GR30620@redhat.com>
	<616fdb8b-2c41-9718-d5b3-e335e78745e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <616fdb8b-2c41-9718-d5b3-e335e78745e4@redhat.com>
Subject: Re: [Qemu-devel] [PULL 43/46] block: Assertions for write
 permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, Apr 06, 2017 at 04:23:19PM -0500, Eric Blake wrote:
> On 04/06/2017 04:15 PM, Richard W.M. Jones wrote:
> 
> >>>> +++ b/block/io.c
> >>>> @@ -945,6 +945,8 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
> >>>>      size_t skip_bytes;
> >>>>      int ret;
> >>>>  
> >>>> +    assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
> >>>
> 
> > https://bugzilla.redhat.com/show_bug.cgi?id=1439922
> > 
> > There is also a minimal reproducer in comment 2.
> 
> If it helps, backtrace shows:
> 
> #4  0x0000555555c09f10 in bdrv_co_do_copy_on_readv
> (child=0x555556990180, offset=0, bytes=512, qiov=0x7fffffffd0c0) at
> block/io.c:948
> #5  0x0000555555c0a33d in bdrv_aligned_preadv (child=0x555556990180,
> req=0x7fffb6dffec0, offset=0, bytes=512, align=1, qiov=0x7fffffffd0c0,
> flags=1)
>     at block/io.c:1058
> #6  0x0000555555c0a8c3 in bdrv_co_preadv (child=0x555556990180,
> offset=0, bytes=512, qiov=0x7fffffffd0c0, flags=BDRV_REQ_COPY_ON_READ)
> at block/io.c:1166
> #7  0x0000555555bf7ccf in blk_co_preadv (blk=0x555556a2bc20, offset=0,
> bytes=512, qiov=0x7fffffffd0c0, flags=0) at block/block-backend.c:927
> #8  0x0000555555bf7e19 in blk_read_entry (opaque=0x7fffffffd0e0)
>     at block/block-backend.c:974
> #9  0x0000555555cc3015 in coroutine_trampoline (i0=1485566720, i1=21845)
>     at util/coroutine-ucontext.c:79

The patch that fixes this is simply:

diff --git a/block/io.c b/block/io.c
index 2709a7007f..4f1a730e45 100644
--- a/block/io.c
+++ b/block/io.c
@@ -945,8 +945,6 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     size_t skip_bytes;
     int ret;
 
-    assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
-
     /* Cover entire cluster so no additional backing file I/O is required when
      * allocating cluster in the image file.
      */

It has no ill effects that I can see, and fixes the libguestfs test
suite, but I'm assuming the assert was added for a reason so I'm not
proposing this as a patch.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
