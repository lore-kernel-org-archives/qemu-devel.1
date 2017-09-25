Received: from eggs.gnu.org ([2001:4830:134:3::10]:51222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwW2t-00032s-Ro
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwW2q-0006I6-Ez
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:15:47 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:46006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwW2p-0006Hh-Nn
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:15:44 -0400
Date: Mon, 25 Sep 2017 17:15:41 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170925161541.GD25986@perard.uk.xensource.com>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
	<1505498999-17427-4-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1505498999-17427-4-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH RFC 3/6] xen: restrict: use
 xentoolcore_restrict_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>

On Fri, Sep 15, 2017 at 07:09:56PM +0100, Ian Jackson wrote:
> And insist that it works.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
>  include/hw/xen/xen_common.h | 26 ++------------------------
>  1 file changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
> index 86c7f26..b6cb024 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -12,6 +12,7 @@
>  
>  #include <xenctrl.h>
>  #include <xenstore.h>
> +#include <xentoolcore.h>
>  #include <xen/io/xenbus.h>
>  
>  #include "hw/hw.h"
> @@ -289,30 +290,7 @@ static inline int xen_modified_memory(domid_t domid, uint64_t first_pfn,
>  
>  static inline int xen_restrict(domid_t domid)
>  {
> -    int rc;
> -
> -    /* Attempt to restrict devicemodel operations */
> -    rc = xendevicemodel_restrict(xen_dmod, domid);
> -    trace_xen_domid_restrict(rc ? errno : 0);
> -
> -    if (rc < 0) {
> -        /*
> -         * If errno is ENOTTY then restriction is not implemented so
> -         * there's no point in trying to restrict other types of
> -         * operation, but it should not be treated as a failure.
> -         */
> -        if (errno == ENOTTY) {
> -            return 0;
> -        }
> -
> -        return rc;
> -    }
> -
> -    /* Restrict foreignmemory operations */
> -    rc = xenforeignmemory_restrict(xen_fmem, domid);
> -    trace_xen_domid_restrict(rc ? errno : 0);
> -
> -    return rc;
> +    return xentoolcore_restrict_all(domid);

xentoolcore_restrict_all is going to need a compatibility stub, which
can be done in this same header (xen_common.h).

I think we can keep the call to trace_xen_domid_restrict(), that's just
a debug printf.

Also, we could remove the compatibility stub for xendevicemodel_restrict
and xenforeignmemory_restrict as there are not used anymore.


-- 
Anthony PERARD
