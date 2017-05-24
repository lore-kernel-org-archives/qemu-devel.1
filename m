Received: from eggs.gnu.org ([2001:4830:134:3::10]:58712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDZ6C-00052l-EK
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDZ69-0008Kx-64
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:25:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dDZ68-0008Kr-Vi
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:25:21 -0400
Date: Wed, 24 May 2017 17:25:12 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170524162512.GL18771@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
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
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, May 24, 2017 at 05:10:03PM +0100, Felipe Franciosi wrote:
> The commit message from 070afca25 suggests that dirty_rate_high_cnt
> should be used more aggressively to start throttling after two
> iterations instead of four. The code, however, only changes the auto
> convergence behaviour to throttle after three iterations. This makes the
> behaviour more aggressive by kicking off throttling after two iterations
> as originally intended.

This description looks suspect vs the code. You say it is changing
from "after four" to "after two", but you are merely switching a
post-increment to a pre-increment which can only reduce the boundary
condition by 1, not 2. So either you mean to write

"after two iterations instead of three" 

or

"after three iterations intead of four"

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
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
