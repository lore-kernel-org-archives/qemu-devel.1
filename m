Received: from eggs.gnu.org ([2001:4830:134:3::10]:53368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=347e3a6fc=anthony.perard@citrix.com>)
	id 1dQyAC-0006lD-VS
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 11:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=347e3a6fc=anthony.perard@citrix.com>)
	id 1dQyA9-0008Jm-TM
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 11:48:57 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:10019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=347e3a6fc=anthony.perard@citrix.com>)
	id 1dQyA9-0008JB-MW
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 11:48:53 -0400
Date: Fri, 30 Jun 2017 16:48:14 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170630154814.GF1598@perard.uk.xensource.com>
References: <1498715394-16402-1-git-send-email-tianyu.lan@intel.com>
	<1498715394-16402-3-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1498715394-16402-3-git-send-email-tianyu.lan@intel.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] xen-pt: bind/unbind interrupt
 remapping format MSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xensource.com, Chao Gao <chao.gao@intel.com>, mst@redhat.com, marcel@redhat.com, sstabellini@kernel.org, kevin.tian@intel.com

On Thu, Jun 29, 2017 at 01:49:53AM -0400, Lan Tianyu wrote:
> From: Chao Gao <chao.gao@intel.com>
> 
> If a vIOMMU is exposed to guest, guest will configure the msi to remapping
> format. The original code isn't suitable to the new format. A new pair
> bind/unbind interfaces are added for this usage. This patch recognizes
> this case and uses new interfaces to bind/unbind msi.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Hi,

The patch series is going to need to be rebased on top of QEMU upstream.
For starter, configure have changed a bit.

> ---
>  configure                     | 54 +++++++++++++++++++++++++++++++++++++++++++
>  hw/xen/xen_pt_msi.c           | 50 ++++++++++++++++++++++++++++-----------
>  include/hw/i386/apic-msidef.h |  1 +
>  include/hw/xen/xen_common.h   | 25 ++++++++++++++++++++
>  4 files changed, 117 insertions(+), 13 deletions(-)
> 
> diff --git a/configure b/configure
> index 476210b..b3ac49f 100755
> --- a/configure
> +++ b/configure
> @@ -1982,6 +1982,60 @@ EOF
>  /*
>   * If we have stable libs the we don't want the libxc compat
>   * layers, regardless of what CFLAGS we may have been given.
> + */
> +#undef XC_WANT_COMPAT_EVTCHN_API
> +#undef XC_WANT_COMPAT_GNTTAB_API
> +#undef XC_WANT_COMPAT_MAP_FOREIGN_API
> +#include <xenctrl.h>
> +#include <xenstore.h>
> +#include <xenevtchn.h>
> +#include <xengnttab.h>
> +#include <xenforeignmemory.h>
> +#include <stdint.h>
> +#include <xen/hvm/hvm_info_table.h>
> +#if !defined(HVM_MAX_VCPUS)
> +# error HVM_MAX_VCPUS not defined
> +#endif
> +int main(void) {
> +  xc_interface *xc = NULL;
> +  xenforeignmemory_handle *xfmem;
> +  xenevtchn_handle *xe;
> +  xengnttab_handle *xg;
> +  xen_domain_handle_t handle;
> +  xengnttab_grant_copy_segment_t* seg = NULL;
> +
> +  xs_daemon_open();
> +
> +  xc = xc_interface_open(0, 0, 0);
> +  xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);
> +  xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
> +  xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
> +  xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);
> +  xc_domain_create(xc, 0, handle, 0, NULL, NULL);
> +
> +  xfmem = xenforeignmemory_open(0, 0);
> +  xenforeignmemory_map(xfmem, 0, 0, 0, 0, 0);
> +
> +  xe = xenevtchn_open(0, 0);
> +  xenevtchn_fd(xe);
> +
> +  xg = xengnttab_open(0, 0);
> +  xengnttab_grant_copy(xg, 0, seg);
> +
> +  xc_domain_update_msi_irq_remapping(xc, 0, 0, 0, 0, 0 ,0);
> +
> +  return 0;
> +}
> +EOF
> +      compile_prog "" "$xen_libs $xen_stable_libs"
> +    then
> +    xen_ctrl_version=4100
> +    xen=yes

There have been some change/refactoring in configure, so this won't
work. The xen_ctrl_version got one more digit.

Can you try with this patch? Which is also simpler.
diff --git a/configure b/configure
index c571ad14e5..a06f2c0b92 100755
--- a/configure
+++ b/configure
@@ -2021,6 +2021,24 @@ EOF
     # Xen unstable
     elif
         cat > $TMPC <<EOF &&
+#include <xenctrl.h>
+int main(void) {
+  xc_interface *xc = NULL;
+
+  xc_domain_update_msi_irq_remapping(xc, 0, 0, 0, 0, 0 ,0);
+
+  return 0;
+}
+EOF
+        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
+      then
+      xen_stable_libs="-lxendevicemodel $xen_stable_libs"
+      xen_ctrl_version=41000
+      xen=yes
+
+    # Xen 4.9
+    elif
+        cat > $TMPC <<EOF &&
 #undef XC_WANT_COMPAT_DEVICEMODEL_API
 #define __XEN_TOOLS__
 #include <xendevicemodel.h>


> index 8e1580d..4ba43a8 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -438,4 +438,29 @@ static inline int xengnttab_grant_copy(xengnttab_handle *xgt, uint32_t count,
>  }
>  #endif
>  
> +/* Xen before 4.10 */
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 4100

This will needs to be
CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000

The rest of the patch is good, Thanks,

-- 
Anthony PERARD
