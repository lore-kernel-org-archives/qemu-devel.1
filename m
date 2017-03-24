Received: from eggs.gnu.org ([2001:4830:134:3::10]:53497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1crUC0-0005mQ-0o
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1crUBy-0006Pi-0L
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:44:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:41418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1crUBx-0006Oz-PT
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:44:05 -0400
References: <1490376002-1223-1-git-send-email-paul.durrant@citrix.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <671b281d-4536-0117-b9a2-b6b72242d3f5@suse.com>
Date: Fri, 24 Mar 2017 19:44:03 +0100
MIME-Version: 1.0
In-Reply-To: <1490376002-1223-1-git-send-email-paul.durrant@citrix.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND] xen: limit pkg-config to
 PKG_CONFIG_PATH for xen libraries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>

On 24/03/17 18:20, Paul Durrant wrote:
> The Xen tools Makefile has been modified to set PKG_CONFIG_PATH such that
> use of pkg-config in QEMU configure finds the newly built Xen libraries.
> However, because older versions of Xen do not set PKG_CONFIG_PATH in the
> Makefile, the QEMU configure script will pick up any Xen libraries that may
> be installed in the build system rather than the newly built ones. Thus,
> if Xen 4.9 is built and installed it becomes impossible to build tools for
> an older version of Xen on the same system (without manual de-installtion).
> 
> This patch modifies configure to set PKG_CONFIG_LIBDIR to empty when
> looking for Xen libraries to ensure the search is limited only to
> PKG_CONFIG_PATH. This makes sure that, for versions of Xen prior to 4.9,
> pkg-config fails to find the Xen libraries an approriately falls back to
> previous methods of probing.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

NAK. You are breaking normal qemu build with installed Xen pkg-config
files.


Juergen

> ---
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Juergen Gross <jgross@suse.com>
> ---
>  configure | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/configure b/configure
> index fdf47e4..6ef5980 100755
> --- a/configure
> +++ b/configure
> @@ -1974,6 +1974,10 @@ fi
>  ##########################################
>  # xen probe
>  
> +xen_query_pkg_config() {
> +    PKG_CONFIG_LIBDIR= ${pkg_config_exe} "$@"
> +}
> +
>  if test "$xen" != "no" ; then
>    xen_libs="-lxenstore -lxenctrl -lxenguest"
>    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
> @@ -1997,9 +2001,9 @@ EOF
>      xen=no
>  
>    # Xen version via pkg-config (Xen 4.9.0 and newer)
> -  elif $pkg_config --exists xencontrol ; then
> +  elif xen_query_pkg_config --exists xencontrol; then
>      xen_ctrl_version="$(printf '%d%02d%02d' \
> -      $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
> +      $(xen_query_pkg_config --modversion xencontrol | sed 's/\./ /g') )"
>      xen=yes
>  
>    elif
> @@ -2216,8 +2220,8 @@ EOF
>      if test $xen_ctrl_version -ge 40900 ; then
>        xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab xenevtchn"
>        xen_pc="$xen_pc xendevicemodel"
> -      xen_libs="$($pkg_config --libs $xen_pc)"
> -      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
> +      xen_libs="$(xen_query_pkg_config --libs $xen_pc)"
> +      QEMU_CFLAGS="$QEMU_CFLAGS $(xen_query_pkg_config --cflags $xen_pc)"
>      elif test $xen_ctrl_version -ge 40701 ; then
>        libs_softmmu="$xen_stable_libs $libs_softmmu"
>      fi
> 
