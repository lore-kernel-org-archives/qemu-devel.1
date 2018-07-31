Received: from eggs.gnu.org ([2001:4830:134:3::10]:34427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkPym-0005SQ-Mk
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkPyl-0002sW-Ru
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:26:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60012 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fkPyl-0002rz-Kw
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:26:03 -0400
References: <153299204130.14411.11438396195753743913.stgit@gimli.home>
	<153299242656.14411.14216251294160965283.stgit@gimli.home>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9e7101c8-0019-0fd4-7195-b5cd150e103a@redhat.com>
Date: Tue, 31 Jul 2018 10:25:55 +0200
MIME-Version: 1.0
In-Reply-To: <153299242656.14411.14216251294160965283.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] balloon: Allow nested inhibits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, peterx@redhat.com, cohuck@redhat.com, mst@redhat.com

On 31.07.2018 01:13, Alex Williamson wrote:
> A simple true/false internal state does not allow multiple users.  Fix
> this within the existing interface by converting to a counter, so long
> as the counter is elevated, ballooning is inhibited.
> 

Not sure if "nested" is really the right term here. It is really
multiple users. anyhow

Reviewed-by: David Hildenbrand <david@redhat.com>

> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  balloon.c |   13 ++++++++++---
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
> 


-- 

Thanks,

David / dhildenb
