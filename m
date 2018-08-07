Received: from eggs.gnu.org ([2001:4830:134:3::10]:51573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fn7tz-0003zp-Ss
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fn7tv-0001nQ-28
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:44:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fn7tu-0001mz-Td
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:44:14 -0400
Date: Tue, 7 Aug 2018 22:44:11 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180807224339-mutt-send-email-mst@kernel.org>
References: <20180807193125.30378-1-alex.williamson@redhat.com>
	<20180807193125.30378-2-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807193125.30378-2-alex.williamson@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/4] balloon: Allow multiple inhibit
 users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, david@redhat.com

On Tue, Aug 07, 2018 at 01:31:22PM -0600, Alex Williamson wrote:
> A simple true/false internal state does not allow multiple users.  Fix
> this within the existing interface by converting to a counter, so long
> as the counter is elevated, ballooning is inhibited.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  balloon.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/balloon.c b/balloon.c
> index 6bf0a9681377..931987983858 100644
> --- a/balloon.c
> +++ b/balloon.c
> @@ -26,6 +26,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include "qemu/atomic.h"
>  #include "exec/cpu-common.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/balloon.h"
> @@ -37,16 +38,22 @@
>  static QEMUBalloonEvent *balloon_event_fn;
>  static QEMUBalloonStatus *balloon_stat_fn;
>  static void *balloon_opaque;
> -static bool balloon_inhibited;
> +static int balloon_inhibit_count;
>  
>  bool qemu_balloon_is_inhibited(void)
>  {
> -    return balloon_inhibited;
> +    return atomic_read(&balloon_inhibit_count) > 0;
>  }
>  
>  void qemu_balloon_inhibit(bool state)
>  {
> -    balloon_inhibited = state;
> +    if (state) {
> +        atomic_inc(&balloon_inhibit_count);
> +    } else {
> +        atomic_dec(&balloon_inhibit_count);
> +    }
> +
> +    assert(atomic_read(&balloon_inhibit_count) >= 0);
>  }
>  
>  static bool have_balloon(Error **errp)

This blocks QEMU_MADV_WONTNEED but it also blocks QEMU_MADV_WILLNEED.
Is this necessarily a good idea?

> -- 
> 2.18.0
