Received: from eggs.gnu.org ([2001:4830:134:3::10]:43847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAd2Z-0002Vt-7x
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAd2U-0007l4-CW
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:06:03 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:24522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAd2U-0007kO-2B
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:05:58 -0400
Date: Mon, 23 Apr 2018 16:05:53 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180423150553.GC1980@perard>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-4-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1524156319-11465-4-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 03/16] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Thu, Apr 19, 2018 at 05:45:06PM +0100, Ian Jackson wrote:
> From: Anthony PERARD <anthony.perard@citrix.com>
> 
> Xen libraries in 4.10 include a new xentoolcore library.  This
> contains the xentoolcore_restrict_all function which we are about to
> want to use.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> Acked-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
> v5: More truthful commit message.
> ---
>  configure | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 0a19b03..f580255 100755
> --- a/configure
> +++ b/configure
> @@ -2188,7 +2188,7 @@ if test "$xen" != "no" ; then
>        $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
>      xen=yes
>      xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
> -    xen_pc="$xen_pc xenevtchn xendevicemodel"
> +    xen_pc="$xen_pc xenevtchn xendevicemodel xentoolcore"

I think we want to check if "xentoolcore" pkg_config exist before trying
to use it. Otherwith, that is not going to work with Xen older than
4.10.

`pkg-config --libs` will throw an error without printing anything if
one of the library doesn't exist.

Instead, we could do this:
if $pkg_config --exists xentoolcore; then
  xen_pc+=" xentoolcore"
fi

>      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
>      libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
>      LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"


-- 
Anthony PERARD
