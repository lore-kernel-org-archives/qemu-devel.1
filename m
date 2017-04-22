Received: from eggs.gnu.org ([2001:4830:134:3::10]:42221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1rHB-0004ta-63
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 05:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1rH7-0001Dr-24
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 05:24:21 -0400
References: <20170421204123.bdftoeuko6lwox3x@eukaryote>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58FB2125.7020603@huawei.com>
Date: Sat, 22 Apr 2017 17:23:49 +0800
MIME-Version: 1.0
In-Reply-To: <20170421204123.bdftoeuko6lwox3x@eukaryote>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU-2.8] Source QEMU crashes with:
 "bdrv_co_pwritev: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: xuquan8@huawei.com, qemu-block@nongnu.org

Hi,

I think the bellow patch can fix your problme.
[PATCH 2/4] qmp-cont: invalidate on RUN_STATE_PRELAUNCH
https://patchwork.kernel.org/patch/9591885/

Actually, we encounter the same problem in our test, we fix it with the follow patch:

      From 0e4d6d706afd9909b5fd71536b45c58af60892f8 Mon Sep 17 00:00:00 2001
      From: zhanghailiang<zhang.zhanghailiang@huawei.com>
      Date: Tue, 21 Mar 2017 09:44:36 +0800
      Subject: [PATCH] migration: Re-activate blocks whenever migration been
       cancelled

      In commit 1d2acc3162d9c7772510c973f446353fbdd1f9a8, we try to fix the bug
      'bdrv_co_do_pwritev: Assertion `!(bs->open_flags & 0x0800)' failed'
      which occured in migration cancelling process.

      But it seems that we didn't cover all the cases, we caught such a case which
      slipped from the old fixup in our test: if libvirtd cancelled the migration
      process for a shutting down VM, it will send 'system_reset' command first,
      and then 'cont' command behind, after VM resumes to run, it will trigger the above
      error reports, because we didn't regain the control of blocks for VM.

      Signed-off-by: zhanghailiang<zhang.zhanghailiang@huawei.com>
      Signed-off-by: Hongyang Yang<yanghongyang@huawei.com>
      ---
       block.c                       | 12 +++++++++++-
       include/block/block.h         |  1 +
       include/migration/migration.h |  3 ---
       migration/migration.c         |  7 +------
       qmp.c                         |  4 +---
       5 files changed, 14 insertions(+), 13 deletions(-)

      diff --git a/block.c b/block.c
      index 6e906ec..c2555b0 100644
      --- a/block.c
      +++ b/block.c
      @@ -3875,6 +3875,13 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
           }
       }

      +static bool is_inactivated;
      +
      +bool bdrv_is_inactivated(void)
      +{
      +    return is_inactivated;
      +}
      +
       void bdrv_invalidate_cache_all(Error **errp)
       {
           BlockDriverState *bs;
      @@ -3892,6 +3899,7 @@ void bdrv_invalidate_cache_all(Error **errp)
                   return;
               }
           }
      +    is_inactivated = false;
       }

       static int bdrv_inactivate_recurse(BlockDriverState *bs,
      @@ -3948,7 +3956,9 @@ out:
           for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
               aio_context_release(bdrv_get_aio_context(bs));
           }
      -
      +    if (!ret) {
      +        is_inactivated = true;
      +    }
           return ret;
       }

      diff --git a/include/block/block.h b/include/block/block.h
      index 5149260..f77b57f 100644
      --- a/include/block/block.h
      +++ b/include/block/block.h
      @@ -365,6 +365,7 @@ int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf);
       void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
       void bdrv_invalidate_cache_all(Error **errp);
       int bdrv_inactivate_all(void);
      +bool bdrv_is_inactivated(void);

       /* Ensure contents are flushed to disk.  */
       int bdrv_flush(BlockDriverState *bs);
      diff --git a/include/migration/migration.h b/include/migration/migration.h
      index 5720c88..a9a2071 100644
      --- a/include/migration/migration.h
      +++ b/include/migration/migration.h
      @@ -183,9 +183,6 @@ struct MigrationState
           /* Flag set once the migration thread is running (and needs joining) */
           bool migration_thread_running;

      -    /* Flag set once the migration thread called bdrv_inactivate_all */
      -    bool block_inactive;
      -
           /* Queue of outstanding page requests from the destination */
           QemuMutex src_page_req_mutex;
           QSIMPLEQ_HEAD(src_page_requests, MigrationSrcPageRequest) src_page_requests;
      diff --git a/migration/migration.c b/migration/migration.c
      index 54060f7..7c3d593 100644
      --- a/migration/migration.c
      +++ b/migration/migration.c
      @@ -1015,14 +1015,12 @@ static void migrate_fd_cancel(MigrationState *s)
           if (s->state == MIGRATION_STATUS_CANCELLING && f) {
               qemu_file_shutdown(f);
           }
      -    if (s->state == MIGRATION_STATUS_CANCELLING && s->block_inactive) {
      +    if (bdrv_is_inactivated()) {
               Error *local_err = NULL;

               bdrv_invalidate_cache_all(&local_err);
               if (local_err) {
                   error_report_err(local_err);
      -        } else {
      -            s->block_inactive = false;
               }
           }
       }
      @@ -1824,7 +1822,6 @@ static void migration_completion(MigrationState *s, int current_active_state,
                   if (ret >= 0) {
                       qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
                       qemu_savevm_state_complete_precopy(s->to_dst_file, false);
      -                s->block_inactive = true;
                   }
               }
               qemu_mutex_unlock_iothread();
      @@ -1879,8 +1876,6 @@ fail_invalidate:
               bdrv_invalidate_cache_all(&local_err);
               if (local_err) {
                   error_report_err(local_err);
      -        } else {
      -            s->block_inactive = false;
               }
               qemu_mutex_unlock_iothread();
           }
      diff --git a/qmp.c b/qmp.c
      index fa82b59..147923b 100644
      --- a/qmp.c
      +++ b/qmp.c
      @@ -197,9 +197,7 @@ void qmp_cont(Error **errp)

           /* Continuing after completed migration. Images have been inactivated to
            * allow the destination to take control. Need to get control back now. */
      -    if (runstate_check(RUN_STATE_FINISH_MIGRATE) ||
      -        runstate_check(RUN_STATE_POSTMIGRATE))
      -    {
      +    if (bdrv_is_inactivated()) {
               bdrv_invalidate_cache_all(&local_err);
               if (local_err) {
                   error_propagate(errp, local_err);
      --
      1.8.3.1


Is this help for you ?

Thanks,
Hailiang



On 2017/4/22 4:41, Kashyap Chamarthy wrote:
> I have seen a bunch of reports about this assertion error (on source
> QEMU).  [At least I recall Greg Kurz mentioning this a week or so ago on
> #qemu, OFTC.]
>
> I just noticed this crash in upstream OpenStack CI environment.  This
> seems to occur (only intermittently, though) during live migration
> without shared-storage.
>
> [I've attached the complete source and destination QEMU command-line in
> a separate plain text file.]
>
> But here are the errors from source and destination QEMU:
>
> Source QEMU:
> -----------------------------------------------------------------------
> [...]
> 2017-04-21 13:54:08.505+0000: initiating migration
> qemu-system-x86_64: /build/qemu-5OJ39u/qemu-2.8+dfsg/block/io.c:1514: bdrv_co_pwritev: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
> 2017-04-21 13:54:08.791+0000: shutting down, reason=crashed
> -----------------------------------------------------------------------
>
> Destination QEMU:
> -----------------------------------------------------------------------
> [...]
> /build/qemu-5OJ39u/qemu-2.8+dfsg/nbd/server.c:nbd_receive_request():L710: read failed
> 2017-04-21 13:54:08.792+0000: shutting down, reason=failed
> 2017-04-21T13:54:08.793259Z qemu-system-x86_64: terminating on signal 15 from pid 12160 (/usr/sbin/libvirtd)
> -----------------------------------------------------------------------
>
> Any hints as how to how to deal with this in QEMU 2.8?
>
> FWIW, the upstream OpenStack CI only very recently moved to QEMU 2.8, so
> it is unlikely that the CI env will move to the just-released 2.9
> anytime soon.  (But there's work in progress to create a CI job that
> tests with QEMU 2.9.)
>
