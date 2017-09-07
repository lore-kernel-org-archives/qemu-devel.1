Received: from eggs.gnu.org ([2001:4830:134:3::10]:55286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0rm-00039D-Sz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0rh-0004eq-Te
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:45:26 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0rh-0004ed-Oa
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:45:21 -0400
Received: by mail-qt0-x243.google.com with SMTP id h21so236195qth.4
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 10:45:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170907082918.7299-1-famz@redhat.com>
	<20170907082918.7299-2-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8025c01d-fde7-0031-2360-503bdbe3a21a@amsat.org>
Date: Thu, 7 Sep 2017 14:45:13 -0300
MIME-Version: 1.0
In-Reply-To: <20170907082918.7299-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/9] buildsys: Move gtk/vte cflags/libs to
 per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>



On 09/07/2017 05:29 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   configure        | 3 +--
>   ui/Makefile.objs | 4 ++++
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index b37cd54bda..e27a4bd683 100755
> --- a/configure
> +++ b/configure
> @@ -2437,7 +2437,6 @@ if test "$gtk" != "no"; then
>               gtk_cflags="$gtk_cflags $x11_cflags"
>               gtk_libs="$gtk_libs $x11_libs"
>           fi
> -        libs_softmmu="$gtk_libs $libs_softmmu"
>           gtk="yes"
>       elif test "$gtk" = "yes"; then
>           feature_not_found "gtk" "Install gtk3-devel"
> @@ -2678,7 +2677,6 @@ if test "$vte" != "no"; then
>           vte_cflags=$($pkg_config --cflags $vtepackage)
>           vte_libs=$($pkg_config --libs $vtepackage)
>           vteversion=$($pkg_config --modversion $vtepackage)
> -        libs_softmmu="$vte_libs $libs_softmmu"
>           vte="yes"
>       elif test "$vte" = "yes"; then
>           if test "$gtkabi" = "3.0"; then
> @@ -5750,6 +5748,7 @@ fi
>   if test "$vte" = "yes" ; then
>     echo "CONFIG_VTE=y" >> $config_host_mak
>     echo "VTE_CFLAGS=$vte_cflags" >> $config_host_mak
> +  echo "VTE_LIBS=$vte_libs" >> $config_host_mak
>   fi
>   if test "$virglrenderer" = "yes" ; then
>     echo "CONFIG_VIRGL=y" >> $config_host_mak
> diff --git a/ui/Makefile.objs b/ui/Makefile.objs
> index 3369451285..146a8ce062 100644
> --- a/ui/Makefile.objs
> +++ b/ui/Makefile.objs
> @@ -45,6 +45,10 @@ gtk.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
>   gtk-egl.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
>   gtk-gl-area.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
>   
> +gtk.o-libs := $(GTK_LIBS) $(VTE_LIBS)
> +gtk-egl.o-libs := $(GTK_LIBS) $(VTE_LIBS)
> +gtk-gl-area.o-libs := $(GTK_LIBS) $(VTE_LIBS)

$(foreach x, gtk gtk-egl gtk-gl-area, \
     $(eval $x.o-libs += $(GTK_LIBS) $(VTE_LIBS)) \
     $(eval $x.o-cflags += $(GTK_CFLAGS) $(VTE_CFLAGS)) \
)

> +
>   gtk-egl.o-libs += $(OPENGL_LIBS)
>   shader.o-libs += $(OPENGL_LIBS)
>   console-gl.o-libs += $(OPENGL_LIBS)
> 
