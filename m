Received: from eggs.gnu.org ([2001:4830:134:3::10]:39466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7pon-00021m-5d
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 17:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7poi-0001r3-9k
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 17:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1e7poi-0001pV-18
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 17:35:56 -0400
Date: Thu, 26 Oct 2017 14:35:53 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1508506702-17704-2-git-send-email-ian.jackson@eu.citrix.com>
Message-ID: <alpine.DEB.2.10.1710261433490.3086@sstabellini-ThinkPad-X260>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
	<1508506702-17704-2-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v5.1 2/8] xen: restrict: use
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
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Fri, 20 Oct 2017, Ian Jackson wrote:
> And insist that it works.
> 
> Drop individual use of xendevicemodel_restrict and
> xenforeignmemory_restrict.  These are not actually effective in this
> version of qemu, because qemu has a large number of fds open onto
> various Xen control devices.
> 
> The restriction arrangements are still not right, because the
> restriction needs to be done very late - after qemu has opened all of
> its control fds.
> 
> xentoolcore_restrict_all and xentoolcore.h are available in Xen 4.10
> and later, only.  Provide a compatibility stub.  And drop the
> compatibility stubs for the old functions.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
> v2: Modify the compatibility code, too.
>     Bump this patch ahead of "defer call to xen_restrict until running"
>     Retain call to xentoolcore_restrict_all
> ---
>  include/hw/xen/xen_common.h | 46 +++++++++++----------------------------------
>  1 file changed, 11 insertions(+), 35 deletions(-)
> 
> diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
> index 86c7f26..3f44a63 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -91,6 +91,16 @@ static inline void *xenforeignmemory_map2(xenforeignmemory_handle *h,
>      return xenforeignmemory_map(h, dom, prot, pages, arr, err);
>  }
>  
> +static inline int xentoolcore_restrict_all(domid_t domid)
> +{
> +    errno = ENOTTY;
> +    return -1;

Wait, if the compat stub returns error, and this patch removed the code
to check for ENOTTY, doesn't it prevent any QEMU compiled against older
Xen from working?

Or am I missing something?


> +}
> +
> +#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 41000 */
> +
> +#include <xentoolcore.h>
> +
>  #endif
>  
>  #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
> @@ -218,20 +228,6 @@ static inline int xendevicemodel_set_mem_type(
>      return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
>  }
>  
> -static inline int xendevicemodel_restrict(
> -    xendevicemodel_handle *dmod, domid_t domid)
> -{
> -    errno = ENOTTY;
> -    return -1;
> -}
> -
> -static inline int xenforeignmemory_restrict(
> -    xenforeignmemory_handle *fmem, domid_t domid)
> -{
> -    errno = ENOTTY;
> -    return -1;
> -}
> -
>  #else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40900 */
>  
>  #undef XC_WANT_COMPAT_DEVICEMODEL_API
> @@ -290,28 +286,8 @@ static inline int xen_modified_memory(domid_t domid, uint64_t first_pfn,
>  static inline int xen_restrict(domid_t domid)
>  {
>      int rc;
> -
> -    /* Attempt to restrict devicemodel operations */
> -    rc = xendevicemodel_restrict(xen_dmod, domid);
> +    rc = xentoolcore_restrict_all(domid);
>      trace_xen_domid_restrict(rc ? errno : 0);
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
>      return rc;
>  }
>  
> -- 
> 2.1.4
> 
