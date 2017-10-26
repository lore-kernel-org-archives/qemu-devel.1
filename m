Received: from eggs.gnu.org ([2001:4830:134:3::10]:41491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7r4F-0000yi-LH
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7r4C-0007Fc-Hv
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1e7r4C-0007Dk-Av
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:56:00 -0400
Date: Thu, 26 Oct 2017 15:55:57 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1508506702-17704-5-git-send-email-ian.jackson@eu.citrix.com>
Message-ID: <alpine.DEB.2.10.1710261541390.3086@sstabellini-ThinkPad-X260>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
	<1508506702-17704-5-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v5.1 5/8] xen: move xc_interface
 compatibility fallback further up the file
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
> We are going to want to use the dummy xendevicemodel_handle type in
> new stub functions in the CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
> section.  So we need to provide that definition, or (as applicable)
> include the appropriate header, earlier in the file.
> 
> (Ideally the newer compatibility layers would be at the bottom of the
> file, so that they can naturally benefit from the compatibility layers
> for earlier version.  But that's rather too much for this series.)
> 
> No functional change.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> v2: New patch in v2 of the series
> ---
>  include/hw/xen/xen_common.h | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
> index 3f44a63..8efdb8a 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -78,6 +78,17 @@ static inline void *xenforeignmemory_map(xc_interface *h, uint32_t dom,
>  
>  extern xenforeignmemory_handle *xen_fmem;
>  
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
> +
> +typedef xc_interface xendevicemodel_handle;
> +
> +#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40900 */
> +
> +#undef XC_WANT_COMPAT_DEVICEMODEL_API
> +#include <xendevicemodel.h>
> +
> +#endif
> +
>  #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
>  
>  #define XEN_COMPAT_PHYSMAP
> @@ -105,8 +116,6 @@ static inline int xentoolcore_restrict_all(domid_t domid)
>  
>  #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
>  
> -typedef xc_interface xendevicemodel_handle;
> -
>  static inline xendevicemodel_handle *xendevicemodel_open(
>      struct xentoollog_logger *logger, unsigned int open_flags)
>  {
> @@ -228,11 +237,6 @@ static inline int xendevicemodel_set_mem_type(
>      return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
>  }
>  
> -#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40900 */
> -
> -#undef XC_WANT_COMPAT_DEVICEMODEL_API
> -#include <xendevicemodel.h>
> -
>  #endif
>  
>  extern xendevicemodel_handle *xen_dmod;
> -- 
> 2.1.4
> 
