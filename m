Received: from eggs.gnu.org ([2001:4830:134:3::10]:36900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpzMS-0005mI-C7
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpzMR-0007Tk-Gt
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:36:44 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpzMR-0007TB-B0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:36:43 -0400
Received: by mail-wm0-x231.google.com with SMTP id t189so67801860wmt.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 08:36:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490018607-11838-1-git-send-email-kraxel@redhat.com>
References: <1490018607-11838-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 15:36:21 +0000
Message-ID: <CAFEAcA_nzcDmykyXXO3ybK6290Kx0HOwGyxsxvwVPJY8M2d-_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] add opengl_cflags to QEMU_CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2017 at 14:03, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure        | 2 +-
>  ui/Makefile.objs | 7 ++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)

Tested-by: Peter Maydell <peter.maydell@linaro.org>

This does fix the compile issue on OpenBSD.

> diff --git a/configure b/configure
> index 99d8bec..89f29c1 100755
> --- a/configure
> +++ b/configure
> @@ -3449,6 +3449,7 @@ if test "$opengl" != "no" ; then
>      if test "$gtk" = "yes" && $pkg_config --exists "$gtkpackage >= 3.16"; then
>          gtk_gl="yes"
>      fi
> +    QEMU_CFLAGS="$QEMU_CFLAGS $opengl_cflags"
>    else
>      if test "$opengl" = "yes" ; then
>        feature_not_found "opengl" "Please install opengl (mesa) devel pkgs: $opengl_pkgs"
> @@ -5503,7 +5504,6 @@ fi
>
>  if test "$opengl" = "yes" ; then
>    echo "CONFIG_OPENGL=y" >> $config_host_mak
> -  echo "OPENGL_CFLAGS=$opengl_cflags" >> $config_host_mak
>    echo "OPENGL_LIBS=$opengl_libs" >> $config_host_mak
>    if test "$opengl_dmabuf" = "yes" ; then
>      echo "CONFIG_OPENGL_DMABUF=y" >> $config_host_mak
> diff --git a/ui/Makefile.objs b/ui/Makefile.objs
> index dc936f1..27566b3 100644
> --- a/ui/Makefile.objs
> +++ b/ui/Makefile.objs
> @@ -41,11 +41,8 @@ endif
>  endif
>
>  gtk.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
> -gtk-egl.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS) $(OPENGL_CFLAGS)
> -gtk-gl-area.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS) $(OPENGL_CFLAGS)
> -shader.o-cflags += $(OPENGL_CFLAGS)
> -console-gl.o-cflags += $(OPENGL_CFLAGS)
> -egl-helpers.o-cflags += $(OPENGL_CFLAGS)
> +gtk-egl.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
> +gtk-gl-area.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
>
>  gtk-egl.o-libs += $(OPENGL_LIBS)
>  shader.o-libs += $(OPENGL_LIBS)

This isn't the only makefile that adds OPENGL_CFLAGS to things.
Shouldn't we also remove the reference in hw/display/Makefile.objs ?

thanks
-- PMM
