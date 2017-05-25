Received: from eggs.gnu.org ([2001:4830:134:3::10]:58633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDhBx-0007sR-50
	for qemu-devel@nongnu.org; Wed, 24 May 2017 21:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDhBw-00040X-6x
	for qemu-devel@nongnu.org; Wed, 24 May 2017 21:03:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dDhBw-00040P-12
	for qemu-devel@nongnu.org; Wed, 24 May 2017 21:03:52 -0400
Date: Thu, 25 May 2017 09:03:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170525010343.GS3873@pxdev.xzpeter.org>
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
	<1495642203-12702-5-git-send-email-felipe@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1495642203-12702-5-git-send-email-felipe@nutanix.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] migration: use dirty_rate_high_cnt
 more aggressively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Juan Quintela <quintela@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, May 24, 2017 at 05:10:03PM +0100, Felipe Franciosi wrote:
> The commit message from 070afca25 suggests that dirty_rate_high_cnt
> should be used more aggressively to start throttling after two
> iterations instead of four. The code, however, only changes the auto
> convergence behaviour to throttle after three iterations. This makes the
> behaviour more aggressive by kicking off throttling after two iterations
> as originally intended.

For this one, I don't think fixing the code to match the commit
message is that important. Instead, for me this patch looks more like
something "changed iteration loops from 3 to 2". So the point is, what
would be the best practical number for it. And when we change an
existing value, we should have some reason, since it'll change
behavior of existing user (though I'm not sure whether this one will
affect much).

I believe with higher dirty_rate_high_cnt, we have more smooth
throttling, but it'll be slower in responding; While if lower or even
remove it, we'll get very fast throttling response speed but I guess
it may be more possible to report a false positive? IMHO here 3 is
okay since after all we are solving the problem of unconverged
migration, so as long as we can converge, I think it'll be fine.

Thanks,

> 
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 1a3d9e6..26e03a5 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -708,7 +708,7 @@ static void migration_bitmap_sync(RAMState *rs)
>  
>              if ((rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
>                     (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
> -                (rs->dirty_rate_high_cnt++ >= 2)) {
> +                (++rs->dirty_rate_high_cnt >= 2)) {
>                      trace_migration_throttle();
>                      rs->dirty_rate_high_cnt = 0;
>                      mig_throttle_guest_down();
> -- 
> 1.9.5
> 

-- 
Peter Xu
