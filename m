Received: from eggs.gnu.org ([2001:4830:134:3::10]:41369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dlIO9-0003K6-5c
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 13:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dlIO6-00021n-17
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 13:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dlIO5-00021T-Rp
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 13:27:17 -0400
Date: Fri, 25 Aug 2017 10:27:15 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170823132505.1505-1-ross.lagerwall@citrix.com>
Message-ID: <alpine.DEB.2.10.1708251026580.30718@sstabellini-ThinkPad-X260>
References: <20170823132505.1505-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] xen: Emit RTC_CHANGE upon TIMEOFFSET
 ioreq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

On Wed, 23 Aug 2017, Ross Lagerwall wrote:
> When the guest writes to the RTC, Xen emulates it and broadcasts a
> TIMEOFFSET ioreq. Emit an RTC_CHANGE QMP event to all QMP monitors when
> this happens rather than ignoring it so that something useful can be
> done with the information. This is the same event that QEMU generates
> when it emulates the RTC.
> 
> This patch by itself doesn't affect any of the toolstacks that I
> checked; the libxl toolstack doesn't currently handle this event nor
> does the XAPI toolstack. If nothing handles the event, it is simply
> ignored. We plan on modifying XAPI to handle it.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

I queued it up.

> ---
> 
> Changed in v2:
> * Expanded commit message.
> 
>  hw/i386/xen/xen-hvm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index d9ccd5d..ffd20dc 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -16,6 +16,7 @@
>  #include "hw/i386/apic-msidef.h"
>  #include "hw/xen/xen_common.h"
>  #include "hw/xen/xen_backend.h"
> +#include "qapi-event.h"
>  #include "qmp-commands.h"
>  
>  #include "qemu/error-report.h"
> @@ -967,6 +968,7 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
>              handle_vmport_ioreq(state, req);
>              break;
>          case IOREQ_TYPE_TIMEOFFSET:
> +            qapi_event_send_rtc_change((int64_t)req->data, &error_abort);
>              break;
>          case IOREQ_TYPE_INVALIDATE:
>              xen_invalidate_map_cache();
> -- 
> 2.9.5
> 
