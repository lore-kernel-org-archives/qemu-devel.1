Received: from eggs.gnu.org ([2001:4830:134:3::10]:39689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fze5F-0006Lb-7a
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fze5A-0002cQ-Hz
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:31:41 -0400
Date: Tue, 11 Sep 2018 16:31:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180911083119.GL19292@lemon.usersys.redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
	<20180907161520.26349-12-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907161520.26349-12-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/14] mirror: Fix potential use-after-free
 in active commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org

On Fri, 09/07 18:15, Kevin Wolf wrote:
> When starting an active commit job, other callbacks can run before
> mirror_start_job() calls bdrv_ref() where needed and cause the nodes to
> go away. Add another pair of bdrv_ref/unref() around it to protect
> against this case.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 6cc10df5c9..c42999eadf 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1679,6 +1679,11 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
>  
>      orig_base_flags = bdrv_get_flags(base);
>  
> +    /* bdrv_reopen() drains, which might make the BDSes go away before a
> +     * reference is taken in mirror_start_job(). */
> +    bdrv_ref(bs);
> +    bdrv_ref(base);
> +
>      if (bdrv_reopen(base, bs->open_flags, errp)) {

Doesn't it need bdrv_unref's in this branch?

>          return;
>      }
> @@ -1689,6 +1694,10 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
>                       &commit_active_job_driver, false, base, auto_complete,
>                       filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
>                       &local_err);
> +
> +    bdrv_unref(bs);
> +    bdrv_unref(base);
> +
>      if (local_err) {
>          error_propagate(errp, local_err);
>          goto error_restore_flags;
> -- 
> 2.13.6
> 
