Received: from eggs.gnu.org ([2001:4830:134:3::10]:43148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ct0Bu-0003Os-SV
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 19:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ct0Bp-0004wW-SG
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 19:06:18 -0400
Received: from mail.kernel.org ([198.145.29.136]:43476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1ct0Bp-0004vt-Hg
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 19:06:13 -0400
Date: Tue, 28 Mar 2017 16:06:07 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1490716495-1685-1-git-send-email-paul.durrant@citrix.com>
Message-ID: <alpine.DEB.2.10.1703281606000.27589@sstabellini-ThinkPad-X260>
References: <1490716495-1685-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] xen: additionally restrict
 xenforeignmemory operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

On Tue, 28 Mar 2017, Paul Durrant wrote:
> Commit f0f272baf3a7 "xen: use libxendevice model to restrict operations"
> added a command-line option (-xen-domid-restrict) to limit operations
> using the libxendevicemodel API to a specified domid. The commit also
> noted that the restriction would be extended to cover operations issued
> via other xen libraries by subsequent patches.
> 
> My recent Xen patch [1] added a call to the xenforeignmemory API to allow
> it to be restricted. This patch now makes use of that new call when the
> -xen-domid-restrict option is passed.
> 
> [1] http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=5823d6eb
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> 
> v2:
>  - Use Stefano's re-arrangement
> ---
>  include/hw/xen/xen_common.h | 134 ++++++++++++++++++++++++++------------------
>  1 file changed, 78 insertions(+), 56 deletions(-)
> 
> diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
> index 4f3bd35..624fb86 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -27,6 +27,58 @@ extern xc_interface *xen_xc;
>   * We don't support Xen prior to 4.2.0.
>   */
>  
> +/* Xen 4.2 through 4.6 */
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40701
> +
> +typedef xc_interface xenforeignmemory_handle;
> +typedef xc_evtchn xenevtchn_handle;
> +typedef xc_gnttab xengnttab_handle;
> +
> +#define xenevtchn_open(l, f) xc_evtchn_open(l, f);
> +#define xenevtchn_close(h) xc_evtchn_close(h)
> +#define xenevtchn_fd(h) xc_evtchn_fd(h)
> +#define xenevtchn_pending(h) xc_evtchn_pending(h)
> +#define xenevtchn_notify(h, p) xc_evtchn_notify(h, p)
> +#define xenevtchn_bind_interdomain(h, d, p) xc_evtchn_bind_interdomain(h, d, p)
> +#define xenevtchn_unmask(h, p) xc_evtchn_unmask(h, p)
> +#define xenevtchn_unbind(h, p) xc_evtchn_unbind(h, p)
> +
> +#define xengnttab_open(l, f) xc_gnttab_open(l, f)
> +#define xengnttab_close(h) xc_gnttab_close(h)
> +#define xengnttab_set_max_grants(h, n) xc_gnttab_set_max_grants(h, n)
> +#define xengnttab_map_grant_ref(h, d, r, p) xc_gnttab_map_grant_ref(h, d, r, p)
> +#define xengnttab_unmap(h, a, n) xc_gnttab_munmap(h, a, n)
> +#define xengnttab_map_grant_refs(h, c, d, r, p) \
> +    xc_gnttab_map_grant_refs(h, c, d, r, p)
> +#define xengnttab_map_domain_grant_refs(h, c, d, r, p) \
> +    xc_gnttab_map_domain_grant_refs(h, c, d, r, p)
> +
> +#define xenforeignmemory_open(l, f) xen_xc
> +#define xenforeignmemory_close(h)
> +
> +static inline void *xenforeignmemory_map(xc_interface *h, uint32_t dom,
> +                                         int prot, size_t pages,
> +                                         const xen_pfn_t arr[/*pages*/],
> +                                         int err[/*pages*/])
> +{
> +    if (err)
> +        return xc_map_foreign_bulk(h, dom, prot, arr, err, pages);
> +    else
> +        return xc_map_foreign_pages(h, dom, prot, arr, pages);
> +}
> +
> +#define xenforeignmemory_unmap(h, p, s) munmap(p, s * XC_PAGE_SIZE)
> +
> +#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40701 */
> +
> +#include <xenevtchn.h>
> +#include <xengnttab.h>
> +#include <xenforeignmemory.h>
> +
> +#endif
> +
> +extern xenforeignmemory_handle *xen_fmem;
> +
>  #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
>  
>  typedef xc_interface xendevicemodel_handle;
> @@ -159,6 +211,13 @@ static inline int xendevicemodel_restrict(
>      return -1;
>  }
>  
> +static inline int xenforeignmemory_restrict(
> +    xenforeignmemory_handle *fmem, domid_t domid)
> +{
> +    errno = ENOTTY;
> +    return -1;
> +}
> +
>  #else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40900 */
>  
>  #include <xendevicemodel.h>
> @@ -215,69 +274,32 @@ static inline int xen_modified_memory(domid_t domid, uint64_t first_pfn,
>  
>  static inline int xen_restrict(domid_t domid)
>  {
> -    int rc = xendevicemodel_restrict(xen_dmod, domid);
> +    int rc;
>  
> -    trace_xen_domid_restrict(errno);
> +    /* Attempt to restrict devicemodel operations */
> +    rc = xendevicemodel_restrict(xen_dmod, domid);
> +    trace_xen_domid_restrict(rc ? errno : 0);
>  
> -    if (errno == ENOTTY) {
> -        return 0;
> +    if (rc < 0) {
> +        /*
> +         * If errno is ENOTTY then restriction is not implemented so
> +         * there's no point in trying to restrict other types of
> +         * operation, but it should not be treated as a failure.
> +         */
> +        if (errno == ENOTTY) {
> +            return 0;
> +        }
> +
> +        return rc;
>      }
>  
> -    return rc;
> -}
> -
> -/* Xen 4.2 through 4.6 */
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40701
> -
> -typedef xc_interface xenforeignmemory_handle;
> -typedef xc_evtchn xenevtchn_handle;
> -typedef xc_gnttab xengnttab_handle;
> -
> -#define xenevtchn_open(l, f) xc_evtchn_open(l, f);
> -#define xenevtchn_close(h) xc_evtchn_close(h)
> -#define xenevtchn_fd(h) xc_evtchn_fd(h)
> -#define xenevtchn_pending(h) xc_evtchn_pending(h)
> -#define xenevtchn_notify(h, p) xc_evtchn_notify(h, p)
> -#define xenevtchn_bind_interdomain(h, d, p) xc_evtchn_bind_interdomain(h, d, p)
> -#define xenevtchn_unmask(h, p) xc_evtchn_unmask(h, p)
> -#define xenevtchn_unbind(h, p) xc_evtchn_unbind(h, p)
> -
> -#define xengnttab_open(l, f) xc_gnttab_open(l, f)
> -#define xengnttab_close(h) xc_gnttab_close(h)
> -#define xengnttab_set_max_grants(h, n) xc_gnttab_set_max_grants(h, n)
> -#define xengnttab_map_grant_ref(h, d, r, p) xc_gnttab_map_grant_ref(h, d, r, p)
> -#define xengnttab_unmap(h, a, n) xc_gnttab_munmap(h, a, n)
> -#define xengnttab_map_grant_refs(h, c, d, r, p) \
> -    xc_gnttab_map_grant_refs(h, c, d, r, p)
> -#define xengnttab_map_domain_grant_refs(h, c, d, r, p) \
> -    xc_gnttab_map_domain_grant_refs(h, c, d, r, p)
> -
> -#define xenforeignmemory_open(l, f) xen_xc
> -#define xenforeignmemory_close(h)
> +    /* Restrict foreignmemory operations */
> +    rc = xenforeignmemory_restrict(xen_fmem, domid);
> +    trace_xen_domid_restrict(rc ? errno : 0);
>  
> -static inline void *xenforeignmemory_map(xc_interface *h, uint32_t dom,
> -                                         int prot, size_t pages,
> -                                         const xen_pfn_t arr[/*pages*/],
> -                                         int err[/*pages*/])
> -{
> -    if (err)
> -        return xc_map_foreign_bulk(h, dom, prot, arr, err, pages);
> -    else
> -        return xc_map_foreign_pages(h, dom, prot, arr, pages);
> +    return rc;
>  }
>  
> -#define xenforeignmemory_unmap(h, p, s) munmap(p, s * XC_PAGE_SIZE)
> -
> -#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40701 */
> -
> -#include <xenevtchn.h>
> -#include <xengnttab.h>
> -#include <xenforeignmemory.h>
> -
> -#endif
> -
> -extern xenforeignmemory_handle *xen_fmem;
> -
>  void destroy_hvm_domain(bool reboot);
>  
>  /* shutdown/destroy current domain because of an error */
> -- 
> 2.1.4
> 
