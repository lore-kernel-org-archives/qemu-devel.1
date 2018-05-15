Received: from eggs.gnu.org ([2001:4830:134:3::10]:37837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66614e27e=anthony.perard@citrix.com>)
	id 1fIc22-0004hU-04
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66614e27e=anthony.perard@citrix.com>)
	id 1fIc1x-00082a-2m
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:38:29 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:17819)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=66614e27e=anthony.perard@citrix.com>)
	id 1fIc1w-0007zm-Pw
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:38:24 -0400
Date: Tue, 15 May 2018 16:38:21 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180515153821.GD2057@perard.uk.xensource.com>
References: <20180510091518.28199-1-paul.durrant@citrix.com>
	<20180510091518.28199-4-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180510091518.28199-4-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] xen-hvm: try to use
 xenforeignmemory_map_resource() to map ioreq pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>

On Thu, May 10, 2018 at 10:15:18AM +0100, Paul Durrant wrote:
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -1239,13 +1239,41 @@ static void xen_wakeup_notifier(Notifier *notifier, void *data)
>  
>  static int xen_map_ioreq_server(XenIOState *state)
>  {
> +    void *addr = NULL;
> +    xenforeignmemory_resource_handle *fres;
>      xen_pfn_t ioreq_pfn;
>      xen_pfn_t bufioreq_pfn;
>      evtchn_port_t bufioreq_evtchn;
>      int rc;
>  
> +    /*
> +     * Attempt to map using the resource API and fall back to normal
> +     * foreign mapping if this is not supported.
> +     */
> +    QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_bufioreq != 0);
> +    QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_ioreq(0) != 1);
> +    fres = xenforeignmemory_map_resource(xen_fmem, xen_domid,
> +                                         XENMEM_resource_ioreq_server,

XENMEM_resource_ioreq_server undeclared with Xen 4.10

> +                                         state->ioservid, 0, 2,
> +                                         &addr,
> +                                         PROT_READ | PROT_WRITE, 0);
> +    if (fres != NULL) {
> +        trace_xen_map_resource_ioreq(state->ioservid, addr);
> +        state->buffered_io_page = addr;
> +        state->shared_page = addr + TARGET_PAGE_SIZE;
> +    } else {
> +        error_report("failed to map ioreq server resources: error %d handle=%p",
> +                     errno, xen_xc);

Maybe printing the error message only when xenforeignmemory_map_resource
fails, would be better? i.e. after checking errno value.

> +        if (errno != EOPNOTSUPP) {
> +            return -1;
> +        }
> +    }
> +
>      rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
> -                                   &ioreq_pfn, &bufioreq_pfn,
> +                                   (state->shared_page == NULL) ?
> +                                   &ioreq_pfn : NULL,
> +                                   (state->buffered_io_page == NULL) ?
> +                                   &bufioreq_pfn : NULL,
>                                     &bufioreq_evtchn);
>      if (rc < 0) {
>          error_report("failed to get ioreq server info: error %d handle=%p",
> diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
> index 5f1402b494..d925751040 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -119,6 +119,20 @@ static inline int xendevicemodel_pin_memory_cacheattr(
>      return xc_domain_pin_memory_cacheattr(xen_xc, domid, start, end, type);
>  }
>  
> +typedef void xenforeignmemory_resource_handle;
> +
> +#define XENMEM_resource_ioreq_server_frame_bufioreq 0
> +#define XENMEM_resource_ioreq_server_frame_ioreq(n) (1 + (n))
> +
> +static inline xenforeignmemory_resource_handle *xenforeignmemory_map_resource(
> +    xenforeignmemory_handle *fmem, domid_t domid, unsigned int type,
> +    unsigned int id, unsigned long frame, unsigned long nr_frames,
> +    void **paddr, int prot, int flags)
> +{
> +    errno = EOPNOTSUPP;

I think ENOSYS would be better. EOPNOTSUPP seems to be for sockets.


> +    return -1;

Should this return NULL instead?  That doesn't build on Xen 4.10 and earlier.

> +}
> +
>  #endif /* CONFIG_XEN_CTRL_INTERFACE_VERSION < 41100 */
>  
>  #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000

Thanks,

-- 
Anthony PERARD
