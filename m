Received: from eggs.gnu.org ([2001:4830:134:3::10]:54600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDglH-00042p-Pr
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDglE-0002j9-Kl
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:36:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dDglE-0002it-BY
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:36:16 -0400
Date: Thu, 25 May 2017 08:36:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170525003609.GO3873@pxdev.xzpeter.org>
References: <1495231142-19055-1-git-send-email-felipe@nutanix.com>
	<20170523042702.GC3873@pxdev.xzpeter.org>
	<140B898B-D9A0-4123-B3C0-1A3C7BA48584@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <140B898B-D9A0-4123-B3C0-1A3C7BA48584@nutanix.com>
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

On Wed, May 24, 2017 at 01:02:25PM +0000, Felipe Franciosi wrote:
> 
> > On 23 May 2017, at 05:27, Peter Xu <peterx@redhat.com> wrote:
> > 
> > On Fri, May 19, 2017 at 10:59:02PM +0100, Felipe Franciosi wrote:
> >> The first time migration_bitmap_sync() is called, bytes_xfer_prev is set
> >> to ram_state.bytes_transferred which is, at this point, zero. The next
> >> time migration_bitmap_sync() is called, an iteration has happened and
> >> bytes_xfer_prev is set to 'x' bytes. Most likely, more than one second
> >> has passed, so the auto converge logic will be triggered and
> >> bytes_xfer_now will also be set to 'x' bytes.
> >> 
> >> This condition is currently masked by dirty_rate_high_cnt, which will
> >> wait for a few iterations before throttling. It would otherwise always
> >> assume zero bytes have been copied and therefore throttle the guest
> >> (possibly) prematurely.
> >> 
> >> Given bytes_xfer_prev is only used by the auto convergence logic, it
> >> makes sense to only set its value after a check has been made against
> >> bytes_xfer_now.
> >> 
> >> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> >> ~
> >> ---
> >> migration/ram.c | 4 ----
> >> 1 file changed, 4 deletions(-)
> >> 
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index f59fdd4..793af39 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -670,10 +670,6 @@ static void migration_bitmap_sync(RAMState *rs)
> >> 
> >>     rs->bitmap_sync_count++;
> >> 
> >> -    if (!rs->bytes_xfer_prev) {
> >> -        rs->bytes_xfer_prev = ram_bytes_transferred();
> >> -    }
> >> -
> >>     if (!rs->time_last_bitmap_sync) {
> >>         rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >>     }
> >> -- 
> >> 1.9.5
> >> 
> >> 
> > 
> > I feel like this patch wants to correctly initialize bytes_xfer_prev,
> > however I still see problem. E.g., when user specify auto-convergence
> > during migration, and in the first iteration we'll always have a very
> > small bytes_xfer_prev (with this patch, it'll be zero) with a very big
> > bytes_xfer_now (which is the ram_bytes_transferred() value).
> 
> Interesting point. Worth noting, that's no different than what happens today anyway (bytes_xfer_prev would be initialised to the first non-zero bytes_transferred). I therefore don't think it should stop or slow this patch's acceptance.
> 
> > If so, do
> > you think squash below change together with current one would be more
> > accurate?
> 
> As a matter of fact I had a different idea (below) to fix what you are describing. I was still experimenting with this code, so haven't sent a patch yet. But I'm going to send a series soon for comments. Basically, I think some other changes are required to make sure these numbers are correct:

I agree on most points.

> 
> 1) dirty_rate_high_cnt++ >= 2 should be ++dirty_rate_high_cnt >= 2
> - The original commit msg from 070afca25 (Jason J. Herne) says that convergence should be triggered after two passes. Current code does it after three passes (and four passes the first time around; see number 2 below).
> - I personally feel this counter should go away altogether. If the migration is not converging and the VM is going to be throttled, there's no point stressing the network any further; just start throttling straight away.
> 
> 2) dirty_pages_rate should be updated before the autoconverge logic.
> - Right now, we delay throttling by a further iteration, as dirty_pages_rate is set after the first pass through the autoconverge logic (it is zero the first time around).
> - The "if (rs->dirty_pages_rate &&..." part of the conditional can then be removed, as it won't ever be zero.

For this one: why dirty_pages_rate cannot be zero? But I agree with
you that it can be removed since even if it's zero, then the next
check would fail as well (rs->num_dirty_pages_period *
TARGET_PAGE_SIZE > (bytes_xfer_now - rs->bytes_xfer_prev) / 2).

> 
> 3) bytes_xfer counters should be updated alongside dirty_pages counters (for the same period).
> - This fixes the issue you described, as bytes_xfer_* will correspond to the period.
> 
> I'll send the series shortly. Thoughts in the meantime?

I'll reply to that patchset then. Thanks.

-- 
Peter Xu
