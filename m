Received: from eggs.gnu.org ([2001:4830:134:3::10]:60982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgs9h-0007ow-PH
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgrxX-0004mY-Gf
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:53:20 -0500
Date: Thu, 23 Feb 2017 19:53:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170223115312.GF14175@lemon.lan>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-13-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487689130-30373-13-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/54] block: Add op blocker permission
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On Tue, 02/21 15:58, Kevin Wolf wrote:
> This patch defines the permission categories that will be used by the
> new op blocker system.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index bde5ebd..ac40c8d 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -187,6 +187,41 @@ typedef enum BlockOpType {
>      BLOCK_OP_TYPE_MAX,
>  } BlockOpType;
>  
> +/* Block node permission constants */
> +enum {
> +    /**
> +     * A user that has the "permission" of consistent reads is guaranteed that
> +     * their view of the contents of the block device is complete and
> +     * self-consistent, repesenting the contents of a disk at a specific point.

*representing

> +     *
> +     * For most block devices (including their backing files) this is true, but
> +     * the property cannot be maintained in a few situations like for
> +     * intermediate nodes of a commit block job.
> +     */
> +    BLK_PERM_CONSISTENT_READ    = 0x01,
> +
> +    /** This permission is required to change the visible disk contents. */
> +    BLK_PERM_WRITE              = 0x02,
> +
> +    /**
> +     * This permission (which is weaker than BLK_PERM_WRITE) is both enough and
> +     * required for writes to the block node when the caller promises that
> +     * this visible disk contents doesn't change.

"contents doesn't" sounds weird to me, but I'm not very sure.

> +     */
> +    BLK_PERM_WRITE_UNCHANGED    = 0x04,
> +
> +    /** This permission is required to change the size of a block node. */
> +    BLK_PERM_RESIZE             = 0x08,
> +
> +    /**
> +     * This permission is required to change the node that this BdrvChild
> +     * points to.
> +     */
> +    BLK_PERM_GRAPH_MOD          = 0x10,
> +
> +    BLK_PERM_ALL                = 0x1f,
> +};
> +
>  /* disk I/O throttling */
>  void bdrv_init(void);
>  void bdrv_init_with_whitelist(void);
> -- 
> 1.8.3.1
> 

Fam
