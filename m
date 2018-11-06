Received: from eggs.gnu.org ([2001:4830:134:3::10]:49702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK5IA-0001cW-0s
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK5HP-0002tS-Pn
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:36:49 -0500
Date: Tue, 6 Nov 2018 18:35:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181106173559.GH4758@linux.fritz.box>
References: <20181015160633.63130-1-vsementsov@virtuozzo.com>
	<20181015160633.63130-12-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015160633.63130-12-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/11] block/backup: use backup-top
 instead of write notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, den@openvz.org, eblake@redhat.com

Am 15.10.2018 um 18:06 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Drop write notifiers and use filter node instead. Changes:
> 
> 1. copy-before-writes now handled by filter node, so, drop all
>    is_write_notifier arguments.
> 
> 2. we don't have intersecting requests, so their handling is dropped.
> Instead, synchronization works as follows:
> when backup or backup-top starts copying of some area it firstly
> clears copy-bitmap bits, and nobody touches areas, not marked with
> dirty bits in copy-bitmap, so there is no intersection. Also, backup
> job copy operations are surrounded by bdrv region lock, which is
> actually serializing request, to not interfer with guest writes and
> not read changed data from source (before reading we clear
> corresponding bit in copy-bitmap, so, this area is not more handled by
> backup-top).
> 
> 3. To sync with in-flight requests we now just drain hook node, we
> don't need rw-lock.
> 
> 4. After the whole backup loop (top, full, incremental modes), we need
> to check for not copied clusters, which were under backup-top operation
> and we skipped them, but backup-top operation failed, error returned to
> the guest and dirty bits set back.
> 
> 5. Don't create additional blk, use backup-top children for copy
> operations.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Haven't reviewed it yet, but gcc complains correctly here:

block/backup.c: In function 'backup_job_create':
block/backup.c:717:9: error: 'backup_top' may be used uninitialized in this function [-Werror=maybe-uninitialized]
         bdrv_backup_top_drop(backup_top);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

> @@ -653,24 +648,29 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>  
>      copy_bitmap = hbitmap_alloc(len, ctz32(cluster_size));
>  
> +    /* bdrv_get_device_name will not help to find device name starting from
> +     * @bs after backup-top append, so let's calculate job_id before. Do
> +     * it in the same way like block_job_create
> +     */
> +    if (job_id == NULL && !(creation_flags & JOB_INTERNAL)) {
> +        job_id = bdrv_get_device_name(bs);
> +    }
> +
> +    backup_top = bdrv_backup_top_append(bs, target, copy_bitmap, errp);
> +    if (!backup_top) {
> +        return NULL;

This needs to be goto error, just like in the bdrv_getlength() failure a
few lines above (which is where the uninitialised backup_top warning
comes from).

Kevin
