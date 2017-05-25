Received: from eggs.gnu.org ([2001:4830:134:3::10]:56497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDgz2-0001Is-WF
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDgyz-0008EG-Ua
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:50:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dDgyz-0008E7-OK
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:50:29 -0400
Date: Thu, 25 May 2017 08:50:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170525005020.GR3873@pxdev.xzpeter.org>
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
	<1495642203-12702-2-git-send-email-felipe@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1495642203-12702-2-git-send-email-felipe@nutanix.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] migration: keep bytes_xfer_prev init'd
 to zero
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

On Wed, May 24, 2017 at 05:10:00PM +0100, Felipe Franciosi wrote:
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

Yes, with patch 3, I think it should be accurate.

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/ram.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index c07a9c0..36bf720 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -673,10 +673,6 @@ static void migration_bitmap_sync(RAMState *rs)
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

-- 
Peter Xu
