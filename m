Received: from eggs.gnu.org ([2001:4830:134:3::10]:59825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvbG-0002Ix-0o
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvbF-0005Lh-BA
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:35:06 -0500
Date: Mon, 6 Mar 2017 17:34:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170306163456.GF5750@noname.redhat.com>
References: <20170303133816.30303-1-famz@redhat.com>
	<20170303133816.30303-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303133816.30303-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] commit: Don't use error_abort in
 commit_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 03.03.2017 um 14:38 hat Fam Zheng geschrieben:
> bdrv_set_backing_hd failure needn't be abort. Since we already have
> error parameter, use it.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/commit.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/block/commit.c b/block/commit.c
> index 22a0a4d..1be19e1 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -316,8 +316,16 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>          goto fail;
>      }
>  
> -    bdrv_set_backing_hd(commit_top_bs, top, &error_abort);
> -    bdrv_set_backing_hd(overlay_bs, commit_top_bs, &error_abort);
> +    bdrv_set_backing_hd(commit_top_bs, top, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto fail;
> +    }
> +    bdrv_set_backing_hd(overlay_bs, commit_top_bs, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto fail;
> +    }

In these error paths, bdrv_unref(commit_top_bs) seems to missing.

Kevin
