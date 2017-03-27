Received: from eggs.gnu.org ([2001:4830:134:3::10]:46420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=252db12a3=Paul.Durrant@citrix.com>)
	id 1csQcF-0003ht-Ae
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=252db12a3=Paul.Durrant@citrix.com>)
	id 1csQcB-0002Wo-By
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:07:07 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:40106
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=252db12a3=Paul.Durrant@citrix.com>)
	id 1csQcB-0002WS-0D
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:07:03 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 27 Mar 2017 09:07:00 +0000
Message-ID: <1330e0a0d9814073b39b52bd6e08a6a8@AMSPEX02CL03.citrite.net>
References: <20170327074245.3821-1-jgross@suse.com>
In-Reply-To: <20170327074245.3821-1-jgross@suse.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] configure: use pkg-config for obtaining
 xen version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Juergen Gross' <jgross@suse.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>

> -----Original Message-----
> From: Juergen Gross [mailto:jgross@suse.com]
> Sent: 27 March 2017 08:43
> To: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org
> Cc: Anthony Perard <anthony.perard@citrix.com>; kraxel@redhat.com;
> sstabellini@kernel.org; Paul Durrant <Paul.Durrant@citrix.com>; Juergen
> Gross <jgross@suse.com>
> Subject: [PATCH v2] configure: use pkg-config for obtaining xen version
>=20
> Instead of trying to guess the Xen version to use by compiling various
> test programs first just ask the system via pkg-config. Only if it
> can't return the version fall back to the test program scheme.
>=20
> If configure is being called with dedicated flags for the Xen libraries
> use those instead of the pkg-config output. This will avoid breaking
> an in-tree Xen build of an old Xen version while a new Xen version is
> installed on the build machine: pkg-config would pick up the installed
> Xen config files as the Xen tree wouldn't contain any of them.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2: - use pkg-config only if no Xen library paths have been specified via
>       --extra-ldflags
>     - keep test program for detecting Xen 4.9

This all looks plausible but it doesn't seem to be working for me when tryi=
ng to build 4.8. I'm still getting a xen ctrl version of 40900... still try=
ing to figure out why.

Also, the whitespace changes later on in the patch should probably be split=
 out.

  Paul

> ---
>  configure | 155 ++++++++++++++++++++++++++++++++++--------------------
> --------
>  1 file changed, 86 insertions(+), 69 deletions(-)
>=20
> diff --git a/configure b/configure
> index aabf098..c34b025 100755
> --- a/configure
> +++ b/configure
> @@ -1962,30 +1962,46 @@ fi
>  # xen probe
>=20
>  if test "$xen" !=3D "no" ; then
> -  xen_libs=3D"-lxenstore -lxenctrl -lxenguest"
> -  xen_stable_libs=3D"-lxenforeignmemory -lxengnttab -lxenevtchn"
> +  # Check whether Xen library path is specified via --extra-ldflags to a=
void
> +  # overriding this setting with pkg-config output. If not, try pkg-conf=
ig
> +  # to obtain all needed flags.
>=20
> -  # First we test whether Xen headers and libraries are available.
> -  # If no, we are done and there is no Xen support.
> -  # If yes, more tests are run to detect the Xen version.
> +  if ! echo $EXTRA_LDFLAGS | grep tools/libxc > /dev/null && \
> +     $pkg_config --exists xencontrol ; then
> +    xen_ctrl_version=3D"$(printf '%d%02d%02d' \
> +      $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
> +    xen=3Dyes
> +    xen_pc=3D"xencontrol xenstore xenguest xenforeignmemory xengnttab"
> +    xen_pc=3D"$xen_pc xenevtchn xendevicemodel"
> +    QEMU_CFLAGS=3D"$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
> +    libs_softmmu=3D"$($pkg_config --libs $xen_pc) $libs_softmmu"
> +    LDFLAGS=3D"$($pkg_config --libs $xen_pc) $LDFLAGS"
> +  else
>=20
> -  # Xen (any)
> -  cat > $TMPC <<EOF
> +    xen_libs=3D"-lxenstore -lxenctrl -lxenguest"
> +    xen_stable_libs=3D"-lxenforeignmemory -lxengnttab -lxenevtchn"
> +
> +    # First we test whether Xen headers and libraries are available.
> +    # If no, we are done and there is no Xen support.
> +    # If yes, more tests are run to detect the Xen version.
> +
> +    # Xen (any)
> +    cat > $TMPC <<EOF
>  #include <xenctrl.h>
>  int main(void) {
>    return 0;
>  }
>  EOF
> -  if ! compile_prog "" "$xen_libs" ; then
> -    # Xen not found
> -    if test "$xen" =3D "yes" ; then
> -      feature_not_found "xen" "Install xen devel"
> -    fi
> -    xen=3Dno
> +    if ! compile_prog "" "$xen_libs" ; then
> +      # Xen not found
> +      if test "$xen" =3D "yes" ; then
> +        feature_not_found "xen" "Install xen devel"
> +      fi
> +      xen=3Dno
>=20
> -  # Xen unstable
> -  elif
> -      cat > $TMPC <<EOF &&
> +    # Xen unstable
> +    elif
> +        cat > $TMPC <<EOF &&
>  #undef XC_WANT_COMPAT_DEVICEMODEL_API
>  #define __XEN_TOOLS__
>  #include <xendevicemodel.h>
> @@ -1998,13 +2014,13 @@ int main(void) {
>    return 0;
>  }
>  EOF
> -      compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
> -    then
> -    xen_stable_libs=3D"$xen_stable_libs -lxendevicemodel"
> -    xen_ctrl_version=3D40900
> -    xen=3Dyes
> -  elif
> -      cat > $TMPC <<EOF &&
> +        compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
> +      then
> +      xen_stable_libs=3D"$xen_stable_libs -lxendevicemodel"
> +      xen_ctrl_version=3D40900
> +      xen=3Dyes
> +    elif
> +        cat > $TMPC <<EOF &&
>  /*
>   * If we have stable libs the we don't want the libxc compat
>   * layers, regardless of what CFLAGS we may have been given.
> @@ -2054,12 +2070,12 @@ int main(void) {
>    return 0;
>  }
>  EOF
> -      compile_prog "" "$xen_libs $xen_stable_libs"
> -    then
> -    xen_ctrl_version=3D40800
> -    xen=3Dyes
> -  elif
> -      cat > $TMPC <<EOF &&
> +        compile_prog "" "$xen_libs $xen_stable_libs"
> +      then
> +      xen_ctrl_version=3D40800
> +      xen=3Dyes
> +    elif
> +        cat > $TMPC <<EOF &&
>  /*
>   * If we have stable libs the we don't want the libxc compat
>   * layers, regardless of what CFLAGS we may have been given.
> @@ -2105,12 +2121,12 @@ int main(void) {
>    return 0;
>  }
>  EOF
> -      compile_prog "" "$xen_libs $xen_stable_libs"
> -    then
> -    xen_ctrl_version=3D40701
> -    xen=3Dyes
> -  elif
> -      cat > $TMPC <<EOF &&
> +        compile_prog "" "$xen_libs $xen_stable_libs"
> +      then
> +      xen_ctrl_version=3D40701
> +      xen=3Dyes
> +    elif
> +        cat > $TMPC <<EOF &&
>  #include <xenctrl.h>
>  #include <stdint.h>
>  int main(void) {
> @@ -2120,14 +2136,14 @@ int main(void) {
>    return 0;
>  }
>  EOF
> -      compile_prog "" "$xen_libs"
> -    then
> -    xen_ctrl_version=3D40700
> -    xen=3Dyes
> +        compile_prog "" "$xen_libs"
> +      then
> +      xen_ctrl_version=3D40700
> +      xen=3Dyes
>=20
> -  # Xen 4.6
> -  elif
> -      cat > $TMPC <<EOF &&
> +    # Xen 4.6
> +    elif
> +        cat > $TMPC <<EOF &&
>  #include <xenctrl.h>
>  #include <xenstore.h>
>  #include <stdint.h>
> @@ -2148,14 +2164,14 @@ int main(void) {
>    return 0;
>  }
>  EOF
> -      compile_prog "" "$xen_libs"
> -    then
> -    xen_ctrl_version=3D40600
> -    xen=3Dyes
> +        compile_prog "" "$xen_libs"
> +      then
> +      xen_ctrl_version=3D40600
> +      xen=3Dyes
>=20
> -  # Xen 4.5
> -  elif
> -      cat > $TMPC <<EOF &&
> +    # Xen 4.5
> +    elif
> +        cat > $TMPC <<EOF &&
>  #include <xenctrl.h>
>  #include <xenstore.h>
>  #include <stdint.h>
> @@ -2175,13 +2191,13 @@ int main(void) {
>    return 0;
>  }
>  EOF
> -      compile_prog "" "$xen_libs"
> -    then
> -    xen_ctrl_version=3D40500
> -    xen=3Dyes
> +        compile_prog "" "$xen_libs"
> +      then
> +      xen_ctrl_version=3D40500
> +      xen=3Dyes
>=20
> -  elif
> -      cat > $TMPC <<EOF &&
> +    elif
> +        cat > $TMPC <<EOF &&
>  #include <xenctrl.h>
>  #include <xenstore.h>
>  #include <stdint.h>
> @@ -2200,24 +2216,25 @@ int main(void) {
>    return 0;
>  }
>  EOF
> -      compile_prog "" "$xen_libs"
> -    then
> -    xen_ctrl_version=3D40200
> -    xen=3Dyes
> +        compile_prog "" "$xen_libs"
> +      then
> +      xen_ctrl_version=3D40200
> +      xen=3Dyes
>=20
> -  else
> -    if test "$xen" =3D "yes" ; then
> -      feature_not_found "xen (unsupported version)" \
> -                        "Install a supported xen (xen 4.2 or newer)"
> +    else
> +      if test "$xen" =3D "yes" ; then
> +        feature_not_found "xen (unsupported version)" \
> +                          "Install a supported xen (xen 4.2 or newer)"
> +      fi
> +      xen=3Dno
>      fi
> -    xen=3Dno
> -  fi
>=20
> -  if test "$xen" =3D yes; then
> -    if test $xen_ctrl_version -ge 40701  ; then
> -      libs_softmmu=3D"$xen_stable_libs $libs_softmmu"
> +    if test "$xen" =3D yes; then
> +      if test $xen_ctrl_version -ge 40701  ; then
> +        libs_softmmu=3D"$xen_stable_libs $libs_softmmu"
> +      fi
> +      libs_softmmu=3D"$xen_libs $libs_softmmu"
>      fi
> -    libs_softmmu=3D"$xen_libs $libs_softmmu"
>    fi
>  fi
>=20
> --
> 2.10.2
