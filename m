Received: from eggs.gnu.org ([2001:4830:134:3::10]:33742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1djvCy-0008HH-Uw
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 18:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1djvCt-0002qE-TD
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 18:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1djvCt-0002ps-Ne
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 18:30:03 -0400
Date: Mon, 21 Aug 2017 15:30:01 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170821140138.27421-1-ross.lagerwall@citrix.com>
Message-ID: <alpine.DEB.2.10.1708211528350.12143@sstabellini-ThinkPad-X260>
References: <20170821140138.27421-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] xen: Emit RTC_CHANGE upon TIMEOFFSET ioreq
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

On Mon, 21 Aug 2017, Ross Lagerwall wrote:
> When the guest writes to the RTC, Xen emulates it and broadcasts a
> TIMEOFFSET ioreq. Emit an RTC_CHANGE QMP message when this happens
> rather than ignoring it so that something useful can be done with the
> information.

Are there any handlers of the RTC_CHANGE QMP message today? What happens
if there are no handlers?

In other words, does this patch change the existing behavior? If so,
please describe, otherwise, please state that there are no behavioral
changes.


> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
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
