Received: from eggs.gnu.org ([2001:4830:134:3::10]:37298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d2eDR-00058l-Ar
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d2eDQ-0000aO-Fc
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:39:45 -0400
Date: Mon, 24 Apr 2017 15:39:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170424133933.GF4739@noname.redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
	<20170421035606.448-20-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170421035606.448-20-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v14 19/20] file-posix: Add image locking in
 perm operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 21.04.2017 um 05:56 hat Fam Zheng geschrieben:
> virtlockd in libvirt locks the first byte, so we start looking at the
> file bytes from 0x10.
> 
> The complication is in the transactional interface.  To make the reopen
> logic managable, and allow better reuse, the code is internally
> organized with a table from old mode to the new one.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 739 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 736 insertions(+), 3 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 2114720..c307493 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -129,8 +129,54 @@ do { \
>  
>  #define MAX_BLOCKSIZE	4096
>  
> +/* Posix file locking bytes. Libvirt takes byte 0, we start from byte 0x10,
> + * leaving a few more bytes for its future use. */
> +#define RAW_LOCK_BYTE_MIN             0x10
> +#define RAW_LOCK_BYTE_NO_OTHER_WRITER 0x10
> +#define RAW_LOCK_BYTE_WRITE           0x11
> +#ifdef F_OFD_SETLK
> +#define RAW_LOCK_SUPPORTED 1
> +#else
> +#define RAW_LOCK_SUPPORTED 0
> +#endif
> +
> +/*
> + ** reader that can tolerate writers: Don't do anything
> + *
> + ** reader that can't tolerate writers: Take shared lock on byte 0x10. Test
> + *  byte 0x11 is unlocked.
> + *
> + ** shared writer: Take shared lock on byte 0x11. Test byte 0x10 is unlocked.
> + *
> + ** exclusive writer: Take exclusive locks on both bytes.
> + */

There are few things that made this patch basically degenerate into a
ton of special cases, the most important of them being that we thought
that we'd need acquire exclusive locks to avoid races and that read-only
file descriptors can't take an exclusive lock and therefore can't test
whether anyone else is holding a shared lock on the file descriptor.

After looking a bit more into this and discussing it on IRC with Fam who
found the last missing puzzle piece, it turned out that while it's true
that F_OFD_SETLK for an exclusive lock doesn't work for read-only FDs,
in fact F_OFD_GETLK (which tests if a lock could be set) does work, so
we can use it to check whether anyone else is holding a shared lock.

We also never need to actually acquire any exclusive locks, just
acquiring shared locks everywhere and testing whether we could set
exclusive locks is enough for our needs. Both of these operations work
fine with read-only FDs.

With these observations, it should be easy to even map _all_ 64 bits of
perm and ~shared to file locks. I think the algorithm looks roughly like
this:

1. Acquire shared @perm locks for (old_perm | new_perm)
2. Acquire shared @~shared locks for (~old_shared | ~new_shared)
3. Test that nobody else holds @perm locks for ~new_shared
4. Test that nobody else holds @~shared locks for new_perm
5. Drop @perm locks for (old_perm & ~new_perm)
6. Drop @~shared locks for (~old_shared & new_shared)

Having one universal algorithm for all state transitions allows us to
greatly simplify the code in this patch.

Kevin
