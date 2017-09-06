Received: from eggs.gnu.org ([2001:4830:134:3::10]:38277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=415137b24=anthony.perard@citrix.com>)
	id 1dpbYg-0002wM-8c
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=415137b24=anthony.perard@citrix.com>)
	id 1dpbYd-0005EN-1P
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:44:02 -0400
Received: from smtp.citrix.com ([66.165.176.89]:15542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=415137b24=anthony.perard@citrix.com>)
	id 1dpbYc-0005Ct-PO
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:43:58 -0400
Date: Wed, 6 Sep 2017 15:43:55 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170906144355.GC1655@perard.uk.xensource.com>
References: <20170823132505.1505-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170823132505.1505-1-ross.lagerwall@citrix.com>
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
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Aug 23, 2017 at 02:25:05PM +0100, Ross Lagerwall wrote:
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

Is this the right value?

>From qapi-schema.json: "offset between base RTC clock (as specified by
-rtc base), and new RTC clock value". But with this patch, the offset
sent via QMP seems to be between the previous value of the guest rtc and
the new one. Other calls to qapi_event_send_rtc_change send the offset
between the new guest RTC and qemu_time().

-- 
Anthony PERARD
