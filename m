Received: from eggs.gnu.org ([2001:4830:134:3::10]:52193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2261f5a76=anthony.perard@citrix.com>)
	id 1cj7sk-0006Rk-5E
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2261f5a76=anthony.perard@citrix.com>)
	id 1cj7sf-0003oI-DY
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:17:42 -0500
Received: from smtp.citrix.com ([66.165.176.89]:46471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2261f5a76=anthony.perard@citrix.com>)
	id 1cj7sf-0003nT-7m
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:17:37 -0500
Date: Wed, 1 Mar 2017 17:17:35 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170301171735.GE1760@perard.uk.xensource.com>
References: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
	<1487861635-17560-5-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1487861635-17560-5-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] configure: detect presence of
 libxendevicemodel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Feb 23, 2017 at 02:53:54PM +0000, Paul Durrant wrote:
> This patch adds code in configure to set CONFIG_XEN_CTRL_INTERFACE_VERSION
> to a new value of 490 if libxendevicemodel is present in the build
> environment.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> ---
>  configure | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/configure b/configure
> index 8e8f18d..fc1e12b 100755
> --- a/configure
> +++ b/configure
> @@ -1980,6 +1980,25 @@ EOF
>    # Xen unstable
>    elif
>        cat > $TMPC <<EOF &&
> +#undef XC_WANT_COMPAT_DEVICEMODEL_API
> +#define __XEN_TOOLS__

Isn't __XEN_TOOLS__ supposed to be reserved for some to tools inside
xen.git?

Also it seems to be the only time this define is used in your patch
series.

> +#include <xendevicemodel.h>
> +int main(void) {
> +  xendevicemodel_handle *xd;
> +
> +  xd = xendevicemodel_open(0, 0);
> +  xendevicemodel_close(xd);
> +
> +  return 0;
> +}
> +EOF
> +      compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
> +    then
> +    xen_stable_libs="$xen_stable_libs -lxendevicemodel"
> +    xen_ctrl_version=490
> +    xen=yes
> +  elif
> +      cat > $TMPC <<EOF &&
>  /*
>   * If we have stable libs the we don't want the libxc compat
>   * layers, regardless of what CFLAGS we may have been given.
> -- 
> 2.1.4
> 

-- 
Anthony PERARD
