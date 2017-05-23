Received: from eggs.gnu.org ([2001:4830:134:3::10]:40195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dD1Pc-0002Nv-PC
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dD1PZ-0002mD-L5
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:27:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dD1PZ-0002lZ-C9
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:27:09 -0400
Date: Tue, 23 May 2017 12:27:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170523042702.GC3873@pxdev.xzpeter.org>
References: <1495231142-19055-1-git-send-email-felipe@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1495231142-19055-1-git-send-email-felipe@nutanix.com>
Subject: Re: [Qemu-devel] [PATCH] migration: keep bytes_xfer_prev init'd to
 zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Juan Quintela <quintela@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, May 19, 2017 at 10:59:02PM +0100, Felipe Franciosi wrote:
> The first time migration_bitmap_sync() is called, bytes_xfer_prev is set
> to ram_state.bytes_transferred which is, at this point, zero. The next
> time migration_bitmap_sync() is called, an iteration has happened and
> bytes_xfer_prev is set to 'x' bytes. Most likely, more than one second
> has passed, so the auto converge logic will be triggered and
> bytes_xfer_now will also be set to 'x' bytes.
> 
> This condition is currently masked by dirty_rate_high_cnt, which will
> wait for a few iterations before throttling. It would otherwise always
> assume zero bytes have been copied and therefore throttle the guest
> (possibly) prematurely.
> 
> Given bytes_xfer_prev is only used by the auto convergence logic, it
> makes sense to only set its value after a check has been made against
> bytes_xfer_now.
> 
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ~
> ---
>  migration/ram.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index f59fdd4..793af39 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -670,10 +670,6 @@ static void migration_bitmap_sync(RAMState *rs)
>  
>      rs->bitmap_sync_count++;
>  
> -    if (!rs->bytes_xfer_prev) {
> -        rs->bytes_xfer_prev = ram_bytes_transferred();
> -    }
> -
>      if (!rs->time_last_bitmap_sync) {
>          rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      }
> -- 
> 1.9.5
> 
> 

I feel like this patch wants to correctly initialize bytes_xfer_prev,
however I still see problem. E.g., when user specify auto-convergence
during migration, and in the first iteration we'll always have a very
small bytes_xfer_prev (with this patch, it'll be zero) with a very big
bytes_xfer_now (which is the ram_bytes_transferred() value). If so, do
you think squash below change together with current one would be more
accurate?

diff --git a/migration/ram.c b/migration/ram.c
index f59fdd4..e01a218 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -703,7 +703,8 @@ static void migration_bitmap_sync(RAMState *rs)
                throttling */
             bytes_xfer_now = ram_bytes_transferred();
 
-            if (rs->dirty_pages_rate &&
+            /* Skip first iteration when bytes_xfer_prev not inited */
+            if (rs->bytes_xfer_prev && rs->dirty_pages_rate &&
                (rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
                    (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
                (rs->dirty_rate_high_cnt++ >= 2)) {

Even I am not sure whether we can move bytes_xfer_prev out of RAMState
since it's only used by migration_bitmap_sync().

Thanks,

-- 
Peter Xu
