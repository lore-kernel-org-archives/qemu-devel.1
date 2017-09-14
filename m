Received: from eggs.gnu.org ([2001:4830:134:3::10]:35084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dsWWX-0003vz-6B
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dsWWW-0008Ow-2r
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:57:53 -0400
Date: Thu, 14 Sep 2017 16:57:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170914155738.GE7370@stefanha-x1.localdomain>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-16-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913181910.29688-16-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/18] block/mirror: Add active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, Sep 13, 2017 at 08:19:07PM +0200, Max Reitz wrote:
> This patch implements active synchronous mirroring.  In active mode, the
> passive mechanism will still be in place and is used to copy all
> initially dirty clusters off the source disk; but every write request
> will write data both to the source and the target disk, so the source
> cannot be dirtied faster than data is mirrored to the target.  Also,
> once the block job has converged (BLOCK_JOB_READY sent), source and
> target are guaranteed to stay in sync (unless an error occurs).
> 
> Optionally, dirty data can be copied to the target disk on read
> operations, too.
> 
> Active mode is completely optional and currently disabled at runtime.  A
> later patch will add a way for users to enable it.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json |  23 +++++++
>  block/mirror.c       | 187 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 205 insertions(+), 5 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index bb11815608..e072cfa67c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -938,6 +938,29 @@
>    'data': ['top', 'full', 'none', 'incremental'] }
>  
>  ##
> +# @MirrorCopyMode:
> +#
> +# An enumeration whose values tell the mirror block job when to
> +# trigger writes to the target.
> +#
> +# @passive: copy data in background only.
> +#
> +# @active-write: when data is written to the source, write it
> +#                (synchronously) to the target as well.  In addition,
> +#                data is copied in background just like in @passive
> +#                mode.
> +#
> +# @active-read-write: write data to the target (synchronously) both
> +#                     when it is read from and written to the source.
> +#                     In addition, data is copied in background just
> +#                     like in @passive mode.

I'm not sure the terms "active"/"passive" are helpful.  "Active commit"
means committing the top-most BDS while the guest is accessing it.  The
"passive" mirror block still works on the top-most BDS while the guest
is accessing it.

Calling it "asynchronous" and "synchronous" is clearer to me.  It's also
the terminology used in disk replication (e.g. DRBD).

Ideally the user wouldn't have to worry about async vs sync because QEMU
would switch modes as appropriate in order to converge.  That way
libvirt also doesn't have to worry about this.

>  static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
>      uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
>  {
> -    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
> +    MirrorOp *op = NULL;
> +    MirrorBDSOpaque *s = bs->opaque;
> +    int ret = 0;
> +    bool copy_to_target;
> +
> +    copy_to_target = s->job->ret >= 0 &&
> +                     s->job->copy_mode == MIRROR_COPY_MODE_ACTIVE_READ_WRITE;
> +
> +    if (copy_to_target) {
> +        op = active_write_prepare(s->job, offset, bytes);
> +    }
> +
> +    ret = bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    if (copy_to_target) {
> +        do_sync_target_write(s->job, offset, bytes, qiov, 0);
> +    }

This mode is dangerous.  See bdrv_co_do_copy_on_readv():

  /* Perform I/O through a temporary buffer so that users who scribble over
   * their read buffer while the operation is in progress do not end up
   * modifying the image file.  This is critical for zero-copy guest I/O
   * where anything might happen inside guest memory.
   */
  void *bounce_buffer;

Stefan
