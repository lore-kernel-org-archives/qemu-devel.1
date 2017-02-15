Received: from eggs.gnu.org ([2001:4830:134:3::10]:47373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ce30R-0007dt-OR
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ce30Q-0004S3-TD
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:04:39 -0500
Date: Wed, 15 Feb 2017 12:04:30 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170215170430.GC19045@localhost.localdomain>
References: <1487170693-28224-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487170693-28224-1-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3] backup: allow target without
 .bdrv_get_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com

On Wed, Feb 15, 2017 at 05:58:13PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Currently backup to nbd target is broken, as nbd doesn't have
> .bdrv_get_info realization.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> v3: fix compilation (I feel like an idiot)
>     adjust wording (Fam)
>     
> v2: add WARNING
> 
> ===
> 
> Since commit
> 
> commit 4c9bca7e39a6e07ad02c1dcde3478363344ec60b
> Author: John Snow <jsnow@redhat.com>
> Date:   Thu Feb 25 15:58:30 2016 -0500
> 
>     block/backup: avoid copying less than full target clusters
> 
> backup to nbd target is broken, we have "Couldn't determine the cluster size of
> the target image".
> 
> Proposed NBD protocol extension - NBD_OPT_INFO should finally solve this problem.
> But until it is not realized, we need allow backup to nbd target due to backward
> compatibility.
> 
> Furthermore, is it entirely ok to disallow backup if bds lacks .bdrv_get_info?
> Which behavior should be default: to fail backup or to use default cluster size?
> 
> 
>  block/backup.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index ea38733..d800a24 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -638,7 +638,16 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>       * backup cluster size is smaller than the target cluster size. Even for
>       * targets with a backing file, try to avoid COW if possible. */
>      ret = bdrv_get_info(target, &bdi);
> -    if (ret < 0 && !target->backing) {
> +    if (ret == -ENOTSUP) {
> +        /* Cluster size is not defined */
> +        fprintf(stderr,
> +                "WARNING: Target block device doesn't provide information "
> +                "about block size and it doesn't have backing file. Default "
> +                "block size of %u bytes is used. If actual block size of "
> +                "target exceeds this default, backup may be unusable",
> +                BACKUP_CLUSTER_SIZE_DEFAULT);

You should use error_report, like in your v2 patch.  Just make sure to
include qemu/error-report.h.

> +        job->cluster_size = BACKUP_CLUSTER_SIZE_DEFAULT;
> +    } else if (ret < 0 && !target->backing) {
>          error_setg_errno(errp, -ret,
>              "Couldn't determine the cluster size of the target image, "
>              "which has no backing file");
> -- 
> 1.8.3.1
> 
