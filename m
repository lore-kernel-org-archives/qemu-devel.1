Received: from eggs.gnu.org ([2001:4830:134:3::10]:50097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cobtA-00062f-M3
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cobt6-000254-My
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:20:48 -0400
Received: from mail.kernel.org ([198.145.29.136]:48376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cobt6-00024a-Fs
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:20:44 -0400
Date: Thu, 16 Mar 2017 13:20:40 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170316141953.16161-3-jgross@suse.com>
Message-ID: <alpine.DEB.2.10.1703161306380.15430@sstabellini-ThinkPad-X260>
References: <20170316141953.16161-1-jgross@suse.com>
	<20170316141953.16161-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 2/2] configure: use pkg-config for
 obtaining xen version
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
> Instead of trying to guess the Xen version to use by compiling various
> test programs first just ask the system via pkg-config. Only if it
> can't return the version fall back to the test program scheme.

That's OK, but why did you remove the Xen unstable test?


> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  configure | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/configure b/configure
> index aabf098..b43fbd5 100755
> --- a/configure
> +++ b/configure
> @@ -1983,26 +1983,12 @@ EOF
>      fi
>      xen=no
>  
> -  # Xen unstable
> -  elif
> -      cat > $TMPC <<EOF &&
> -#undef XC_WANT_COMPAT_DEVICEMODEL_API
> -#define __XEN_TOOLS__
> -#include <xendevicemodel.h>
> -int main(void) {
> -  xendevicemodel_handle *xd;
> -
> -  xd = xendevicemodel_open(0, 0);
> -  xendevicemodel_close(xd);
> -
> -  return 0;
> -}
> -EOF
> -      compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
> -    then
> -    xen_stable_libs="$xen_stable_libs -lxendevicemodel"
> -    xen_ctrl_version=40900
> +  # Xen version via pkg-config (Xen 4.9.0 and newer)
> +  elif $pkg_config --exists xencontrol ; then
> +    xen_ctrl_version="$(printf '%d%02d%02d' \
> +      $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
>      xen=yes
> +
>    elif
>        cat > $TMPC <<EOF &&
>  /*
> @@ -2214,7 +2200,12 @@ EOF
>    fi
>  
>    if test "$xen" = yes; then
> -    if test $xen_ctrl_version -ge 40701  ; then
> +    if test $xen_ctrl_version -ge 40900 ; then
> +      xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab xenevtchn"
> +      xen_pc="$xen_pc xendevicemodel"
> +      xen_libs="$($pkg_config --libs $xen_pc)"
> +      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
> +    elif test $xen_ctrl_version -ge 40701 ; then
>        libs_softmmu="$xen_stable_libs $libs_softmmu"
>      fi
>      libs_softmmu="$xen_libs $libs_softmmu"
