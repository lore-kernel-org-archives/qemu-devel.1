Received: from eggs.gnu.org ([2001:4830:134:3::10]:36351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7qq6-0007GZ-AH
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7qq0-0004dj-Lt
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1e7qq0-0004c9-FQ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:41:20 -0400
Date: Thu, 26 Oct 2017 15:41:18 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
Message-ID: <alpine.DEB.2.10.1710261539420.3086@sstabellini-ThinkPad-X260>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v5.1 1/8] xen: link against xentoolcore
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
> From: Anthony PERARD <anthony.perard@citrix.com>
> 
> Xen libraries in 4.10 include a new xentoolcore library.  This
> contains the xentoolcore_restrict_all function which we are about to
> want to use.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
> v5: More truthful commit message.
> ---
>  configure | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index fd7e3a5..6f691df 100755
> --- a/configure
> +++ b/configure
> @@ -2072,7 +2072,7 @@ if test "$xen" != "no" ; then
>        $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
>      xen=yes
>      xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
> -    xen_pc="$xen_pc xenevtchn xendevicemodel"
> +    xen_pc="$xen_pc xenevtchn xendevicemodel xentoolcore"
>      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
>      libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
>      LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
> @@ -2104,18 +2104,20 @@ EOF
>          cat > $TMPC <<EOF &&
>  #undef XC_WANT_COMPAT_MAP_FOREIGN_API
>  #include <xenforeignmemory.h>
> +#include <xentoolcore.h>
>  int main(void) {
>    xenforeignmemory_handle *xfmem;
>  
>    xfmem = xenforeignmemory_open(0, 0);
>    xenforeignmemory_map2(xfmem, 0, 0, 0, 0, 0, 0, 0);
> +  xentoolcore_restrict_all(0);
>  
>    return 0;
>  }
>  EOF
> -        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
> +        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs -lxentoolcore"
>        then
> -      xen_stable_libs="-lxendevicemodel $xen_stable_libs"
> +      xen_stable_libs="-lxendevicemodel $xen_stable_libs -lxentoolcore"

Is it on purpose that -lxentoolcore is at the end of this string rather
than before $xen_stable_libs?

In any case

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


>        xen_ctrl_version=41000
>        xen=yes
>      elif
> -- 
> 2.1.4
> 
