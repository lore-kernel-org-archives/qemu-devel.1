Received: from eggs.gnu.org ([2001:4830:134:3::10]:57686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIXYB-0000mT-Ih
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIXYA-0008Vu-N8
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:46:51 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1496468917-7489-1-git-send-email-sochin.jiang@huawei.com>
References: <1496468917-7489-1-git-send-email-sochin.jiang@huawei.com>
Date: Wed, 07 Jun 2017 11:46:33 +0200
Message-ID: <w51wp8oxh8m.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockjob: cancel blockjobs
 before stopping all iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin.jiang@huawei.com>, kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, mreitz@redhat.com
Cc: lina.lulina@huawei.com, lizhengui@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, zhangshuai13@huawei.com, qemu-devel@nongnu.org

On Sat 03 Jun 2017 07:48:37 AM CEST, sochin.jiang wrote:

> --- a/block.c
> +++ b/block.c
> @@ -3084,9 +3084,16 @@ static void bdrv_close(BlockDriverState *bs)
>      bdrv_drained_end(bs);
>  }
>  
> +void bdrv_cancel_all(void)
> +{
> +    if (!block_jobs_is_empty()) {
> +        block_job_cancel_sync_all();
> +    }
> +}

Why do you need this function at all? block_job_cancel_sync_all() is
already doing nothing when the block_jobs list is empty.

Berto
