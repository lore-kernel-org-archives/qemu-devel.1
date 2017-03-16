Received: from eggs.gnu.org ([2001:4830:134:3::10]:49831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cobsP-0005XZ-5A
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cobsL-0001Xt-4K
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:20:01 -0400
Received: from mail.kernel.org ([198.145.29.136]:48224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cobsK-0001Xl-QM
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:19:57 -0400
Date: Thu, 16 Mar 2017 13:19:51 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170316141953.16161-2-jgross@suse.com>
Message-ID: <alpine.DEB.2.10.1703161312390.15430@sstabellini-ThinkPad-X260>
References: <20170316141953.16161-1-jgross@suse.com>
	<20170316141953.16161-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 1/2] xen: use 5 digit xen versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, kraxel@redhat.com, sstabellini@kernel.org, paul.durrant@citrix.com

On Thu, 16 Mar 2017, Juergen Gross wrote:
> Today qemu is using e.g. the value 480 for Xen version 4.8.0. As some
> Xen version tests are using ">" relations this scheme will lead to
> problems when Xen version 4.10.0 is being reached.
> 
> Instead of the 3 digit schem use a 5 digit scheme (e.g. 40800 for
> version 4.8.0).
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  configure                   | 16 ++++++++--------
>  hw/block/xen_disk.c         |  2 +-
>  include/hw/xen/xen_common.h | 22 +++++++++++-----------
>  3 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/configure b/configure
> index b187222..aabf098 100755
> --- a/configure
> +++ b/configure
> @@ -2001,7 +2001,7 @@ EOF
>        compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
>      then
>      xen_stable_libs="$xen_stable_libs -lxendevicemodel"
> -    xen_ctrl_version=490
> +    xen_ctrl_version=40900
>      xen=yes
>    elif
>        cat > $TMPC <<EOF &&
> @@ -2056,7 +2056,7 @@ int main(void) {
>  EOF
>        compile_prog "" "$xen_libs $xen_stable_libs"
>      then
> -    xen_ctrl_version=480
> +    xen_ctrl_version=40800
>      xen=yes
>    elif
>        cat > $TMPC <<EOF &&
> @@ -2107,7 +2107,7 @@ int main(void) {
>  EOF
>        compile_prog "" "$xen_libs $xen_stable_libs"
>      then
> -    xen_ctrl_version=471
> +    xen_ctrl_version=40701
>      xen=yes
>    elif
>        cat > $TMPC <<EOF &&
> @@ -2122,7 +2122,7 @@ int main(void) {
>  EOF
>        compile_prog "" "$xen_libs"
>      then
> -    xen_ctrl_version=470
> +    xen_ctrl_version=40700
>      xen=yes
>  
>    # Xen 4.6
> @@ -2150,7 +2150,7 @@ int main(void) {
>  EOF
>        compile_prog "" "$xen_libs"
>      then
> -    xen_ctrl_version=460
> +    xen_ctrl_version=40600
>      xen=yes
>  
>    # Xen 4.5
> @@ -2177,7 +2177,7 @@ int main(void) {
>  EOF
>        compile_prog "" "$xen_libs"
>      then
> -    xen_ctrl_version=450
> +    xen_ctrl_version=40500
>      xen=yes
>  
>    elif
> @@ -2202,7 +2202,7 @@ int main(void) {
>  EOF
>        compile_prog "" "$xen_libs"
>      then
> -    xen_ctrl_version=420
> +    xen_ctrl_version=40200
>      xen=yes
>  
>    else
> @@ -2214,7 +2214,7 @@ EOF
>    fi
>  
>    if test "$xen" = yes; then
> -    if test $xen_ctrl_version -ge 471  ; then
> +    if test $xen_ctrl_version -ge 40701  ; then
>        libs_softmmu="$xen_stable_libs $libs_softmmu"
>      fi
>      libs_softmmu="$xen_libs $libs_softmmu"
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index 456a2d5..27df048 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -492,7 +492,7 @@ static int ioreq_map(struct ioreq *ioreq)
>      return 0;
>  }
>  
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 480
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40800
>  
>  static void ioreq_free_copy_buffers(struct ioreq *ioreq)
>  {
> diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
> index 274accc..df098c7 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -27,7 +27,7 @@ extern xc_interface *xen_xc;
>   * We don't support Xen prior to 4.2.0.
>   */
>  
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 490
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
>  
>  typedef xc_interface xendevicemodel_handle;
>  
> @@ -37,7 +37,7 @@ static inline xendevicemodel_handle *xendevicemodel_open(
>      return xen_xc;
>  }
>  
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 450
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40500
>  
>  static inline int xendevicemodel_create_ioreq_server(
>      xendevicemodel_handle *dmod, domid_t domid, int handle_bufioreq,
> @@ -100,7 +100,7 @@ static inline int xendevicemodel_set_ioreq_server_state(
>      return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
>  }
>  
> -#endif /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 450 */
> +#endif /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40500 */
>  
>  static inline int xendevicemodel_set_pci_intx_level(
>      xendevicemodel_handle *dmod, domid_t domid, uint16_t segment,
> @@ -152,7 +152,7 @@ static inline int xendevicemodel_set_mem_type(
>      return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
>  }
>  
> -#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 490 */
> +#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40900 */
>  
>  #include <xendevicemodel.h>
>  
> @@ -207,7 +207,7 @@ static inline int xen_modified_memory(domid_t domid, uint64_t first_pfn,
>  }
>  
>  /* Xen 4.2 through 4.6 */
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 471
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40701
>  
>  typedef xc_interface xenforeignmemory_handle;
>  typedef xc_evtchn xenevtchn_handle;
> @@ -248,7 +248,7 @@ static inline void *xenforeignmemory_map(xc_interface *h, uint32_t dom,
>  
>  #define xenforeignmemory_unmap(h, p, s) munmap(p, s * XC_PAGE_SIZE)
>  
> -#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 471 */
> +#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40701 */
>  
>  #include <xenevtchn.h>
>  #include <xengnttab.h>
> @@ -284,7 +284,7 @@ static inline int xen_get_vmport_regs_pfn(xc_interface *xc, domid_t dom,
>  #endif
>  
>  /* Xen before 4.6 */
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 460
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40600
>  
>  #ifndef HVM_IOREQSRV_BUFIOREQ_ATOMIC
>  #define HVM_IOREQSRV_BUFIOREQ_ATOMIC 2
> @@ -330,7 +330,7 @@ static inline int xen_get_default_ioreq_server_info(domid_t dom,
>  }
>  
>  /* Xen before 4.5 */
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 450
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40500
>  
>  #ifndef HVM_PARAM_BUFIOREQ_EVTCHN
>  #define HVM_PARAM_BUFIOREQ_EVTCHN 26
> @@ -569,7 +569,7 @@ static inline int xen_set_ioreq_server_state(domid_t dom,
>  
>  #endif
>  
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 460
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40600
>  static inline int xen_xc_domain_add_to_physmap(xc_interface *xch, uint32_t domid,
>                                                 unsigned int space,
>                                                 unsigned long idx,
> @@ -592,7 +592,7 @@ static inline int xen_xc_domain_add_to_physmap(xc_interface *xch, uint32_t domid
>  #endif
>  
>  #ifdef CONFIG_XEN_PV_DOMAIN_BUILD
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 470
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40700
>  static inline int xen_domain_create(xc_interface *xc, uint32_t ssidref,
>                                      xen_domain_handle_t handle, uint32_t flags,
>                                      uint32_t *pdomid)
> @@ -611,7 +611,7 @@ static inline int xen_domain_create(xc_interface *xc, uint32_t ssidref,
>  
>  /* Xen before 4.8 */
>  
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 480
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40800
>  
>  
>  typedef void *xengnttab_grant_copy_segment_t;
> -- 
> 2.10.2
> 
